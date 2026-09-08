"""Fetch public primary metadata for the selected research pages; never used at build time."""
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
from urllib.request import Request, urlopen
from urllib.parse import quote
import json
import gzip
import sys
import hashlib

OUT = Path('.impeccable/research/seo-sources')
OUT.mkdir(parents=True, exist_ok=True)

if '--pdfs' in sys.argv:
    # Editorially reviewed, redistributable originals only. Keep files unchanged.
    inputs = list(json.loads(Path('_data/paper_pdf_sources.yml').read_text()).values())
    def mirror(item):
        target = Path(item['path'].lstrip('/'))
        result = dict(item)
        try:
            if target.exists():
                body = target.read_bytes()
            elif item['key'] == 'zengacuna2020':
                body = Path('assets/pdf/ic2s2-author_name_disambiguation_zeng_and_acuna.pdf').read_bytes()
            else:
                request = Request(item['source_url'], headers={'User-Agent': 'SOSCD-metadata-review/1.0 (https://scienceofscience.org)'})
                with urlopen(request, timeout=45) as response:
                    body = response.read(5_000_001)
            if not body.startswith(b'%PDF-'):
                raise ValueError('Source did not return a PDF')
            if len(body) > 5_000_000:
                raise ValueError('PDF exceeds 5 MB; retain publisher link')
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_bytes(body)
            result.update(status='mirrored', bytes=len(body), sha256=hashlib.sha256(body).hexdigest())
        except Exception as error:
            result.update(status='external', note=str(error))
        print(json.dumps(result), flush=True)
        return result
    with ThreadPoolExecutor(max_workers=4) as pool:
        results = list(pool.map(mirror, inputs))
    Path('_data/paper_pdf_sources.yml').write_text(json.dumps({r['key']: r for r in results}, indent=2) + '\n')
    sys.exit(0)

if '--verify-quickstart' in sys.argv:
    # Verify the documented relationship join using the complete two small core tables.
    import csv
    import collections
    for name in ['mentorship.csv.gz', 'researcher.csv.gz']:
        target = OUT / name
        if not target.exists():
            url = 'https://zenodo.org/api/records/4917086/files/' + name + '/content'
            with urlopen(Request(url, headers={'User-Agent': 'SOSCD-metadata-review/1.0'}), timeout=60) as response:
                target.write_bytes(response.read())
    researchers = {}
    duplicate_ids = 0
    with gzip.open(OUT / 'researcher.csv.gz', 'rt', encoding='utf-8-sig') as source:
        for row in csv.DictReader(source):
            duplicate_ids += row['PID'] in researchers
            researchers[row['PID']] = row['ResearchArea']
    counts = collections.Counter()
    rows = matched = 0
    with gzip.open(OUT / 'mentorship.csv.gz', 'rt', encoding='utf-8-sig') as source:
        for row in csv.DictReader(source):
            rows += 1
            assert all(key in row for key in ['CID', 'MenteeID', 'MentorID', 'MentorshipType'])
            matched += row['MenteeID'] in researchers
            counts[researchers.get(row['MenteeID']) or '(missing)'] += 1
    assert duplicate_ids == 0, 'Researcher PID must be unique for many-to-one join'
    result = dict(researchers=len(researchers), relationships=rows, matched=matched, duplicate_ids=duplicate_ids, top_research_areas=counts.most_common(5))
    (OUT / 'quickstart-verification.json').write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result))
    sys.exit(0)
DOIS = {
    'acuna2010structure': '10.1371/journal.pcbi.1001003',
    'lienard2018intellectual': '10.1038/s41467-018-07034-y',
    'zhuangacuna2021': '10.1371/journal.pcbi.1009650',
    'acuna2022': '10.1371/journal.pone.0273994',
    'keacuna2022': '10.1038/s41597-022-01578-x',
    'zhuang2024costs': '10.1162/qss_a_00332',
    'taechoyotin2024misti': '10.18653/v1/2024.sdp-1.15',
    'acuna2022predicting': '10.1057/s41599-025-04716-z',
    'zhuang2025estimating': '10.1126/sciadv.adt2792',
}
ARXIV = {
    'acuna2020nullmodel': '2003.00878',
    'xiang2020tampering': '2001.07799',
    'taechoyotin2025remor': '2505.11718',
    'taechoyotin2026remctx': '2604.00248',
    'meguimtsop2026sciintbench': '2605.29468',
}

def get(url):
    request = Request(url, headers={'User-Agent': 'SOSCD-metadata-review/1.0 (https://scienceofscience.org)'})
    with urlopen(request, timeout=45) as response:
        return response.read()

def fetch(item):
    key, url, suffix = item
    path = OUT / (key + suffix)
    try:
        body = path.read_bytes() if path.exists() else get(url)
        if not path.exists():
            path.write_bytes(body)
        return {'key': key, 'url': url, 'file': str(path), 'bytes': len(body)}
    except Exception as error:
        return {'key': key, 'url': url, 'error': str(error)}

tasks = [(key + '-crossref', 'https://api.crossref.org/works/' + quote(doi, safe=''), '.json') for key, doi in DOIS.items()]
tasks += [(key + '-europepmc', 'https://www.ebi.ac.uk/europepmc/webservices/rest/search?query=' + quote('DOI:' + doi) + '&resultType=core&format=json', '.json') for key, doi in DOIS.items()]
tasks += [(key + '-arxiv', 'https://arxiv.org/abs/' + identifier, '.html') for key, identifier in ARXIV.items()]
tasks += [('mentorship-zenodo', 'https://zenodo.org/api/records/4917086', '.json'), ('disambiguation-zenodo', 'https://zenodo.org/api/records/4403705', '.json')]
tasks += [('misti-publisher', 'https://aclanthology.org/2024.sdp-1.15/', '.html')]
tasks += [('structure-publisher', 'https://journals.plos.org/ploscompbiol/article/file?id=10.1371/journal.pcbi.1001003&type=manuscript', '.xml')]
for path in OUT.glob('*europepmc.json'):
    for record in json.loads(path.read_text()).get('resultList', {}).get('result', []):
        if record.get('pmcid') and record.get('isOpenAccess') == 'Y':
            tasks.append((path.stem.replace('-europepmc', '-fulltext'), 'https://www.ebi.ac.uk/europepmc/webservices/rest/' + record['pmcid'] + '/fullTextXML', '.xml'))
with ThreadPoolExecutor(max_workers=4) as pool:
    results = list(pool.map(fetch, tasks))
    for result in results:
        print(json.dumps(result))
OUT.joinpath('manifest.json').write_text(json.dumps(results, indent=2) + '\n')

# Inspect headers only; do not download the large embedding matrices or researcher rows.
header_path = OUT / 'mentorship-columns.json'
if not header_path.exists():
    headers = {}
    for filename in ['mentorship.csv.gz', 'researcher.csv.gz', 'authorship.csv.gz', 'paper.csv.gz']:
        url = 'https://zenodo.org/api/records/4917086/files/' + filename + '/content'
        try:
            with urlopen(Request(url, headers={'User-Agent': 'SOSCD-metadata-review/1.0'}), timeout=45) as response:
                with gzip.GzipFile(fileobj=response) as source:
                    headers[filename] = source.readline().decode('utf-8-sig').strip()
        except Exception as error:
            headers[filename] = {'error': str(error)}
    header_path.write_text(json.dumps(headers, indent=2) + '\n')
    print(json.dumps(headers))
