#!/usr/bin/env python3
"""Audit public deployed pages. No Google account, credentials, or private analytics."""
import argparse
import concurrent.futures
import datetime as dt
from html.parser import HTMLParser
import json
from pathlib import Path
import sys
import urllib.parse
import urllib.request
import urllib.robotparser
import xml.etree.ElementTree as ET

ORIGIN = 'https://scienceofscience.org'

class Page(HTMLParser):
    def __init__(self):
        super().__init__(); self.h1 = 0; self.canonical = None; self.description = None
        self.robots = ''; self.schemas = []; self.json_buffer = None; self.title = False; self.title_text = ''
    def handle_starttag(self, tag, attrs):
        a = dict(attrs)
        if tag == 'h1': self.h1 += 1
        if tag == 'title': self.title = True
        if tag == 'link' and a.get('rel') == 'canonical': self.canonical = a.get('href')
        if tag == 'meta' and a.get('name') == 'description': self.description = a.get('content')
        if tag == 'meta' and a.get('name') == 'robots': self.robots = a.get('content', '')
        if tag == 'script' and a.get('type') == 'application/ld+json': self.json_buffer = ''
    def handle_data(self, data):
        if self.title: self.title_text += data
        if self.json_buffer is not None: self.json_buffer += data
    def handle_endtag(self, tag):
        if tag == 'title': self.title = False
        if tag == 'script' and self.json_buffer is not None:
            self.schemas.append(json.loads(self.json_buffer)); self.json_buffer = None

def fetch(url):
    request = urllib.request.Request(url, headers={'User-Agent': 'SOSCD-Public-Site-Audit/1.0'})
    with urllib.request.urlopen(request, timeout=30) as response:
        if urllib.parse.urlparse(response.url).netloc != 'scienceofscience.org':
            raise ValueError('Unexpected redirect outside lab host: ' + response.url)
        return response.read().decode('utf-8'), response.status

def audit_page(url):
    result = {'url': url, 'errors': []}
    try:
        html, result['status'] = fetch(url); page = Page(); page.feed(html)
        result['title'] = page.title_text.strip()
        checks = [(page.h1 == 1, 'Expected one H1'), (page.canonical == url, 'Canonical mismatch'),
                  (bool(page.description), 'Missing description'), (bool(result['title']), 'Missing title'),
                  ('noindex' not in page.robots.lower(), 'Sitemapped page is noindex'),
                  (bool(page.schemas), 'Missing JSON-LD'), ('G-P91ZSLM4VH' in html, 'Missing GA4 tag')]
        result['errors'].extend(message for ok, message in checks if not ok)
    except Exception as error:
        result['errors'].append(str(error))
    return result

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', default='tmp/live-seo')
    args = parser.parse_args()
    output = Path(args.output); output.mkdir(parents=True, exist_ok=True)
    today = dt.date.today(); report = {'checked_at': dt.datetime.now(dt.timezone.utc).isoformat(), 'origin': ORIGIN, 'errors': [], 'pages': []}
    try:
        sitemap, _ = fetch(ORIGIN + '/sitemap.xml')
        urls = [node.text for node in ET.fromstring(sitemap).iter() if node.tag.endswith('}loc')]
        if len(urls) != len(set(urls)): report['errors'].append('Duplicate sitemap URLs')
        if any(not url.startswith(ORIGIN + '/') for url in urls): raise ValueError('Unexpected host in sitemap')
        html_urls = [url for url in urls if not urllib.parse.urlparse(url).path.endswith('.pdf')]
        if not html_urls: raise ValueError('No HTML pages in sitemap')
        with concurrent.futures.ThreadPoolExecutor(max_workers=4) as pool:
            report['pages'] = list(pool.map(audit_page, html_urls))
        robots, _ = fetch(ORIGIN + '/robots.txt')
        rules = urllib.robotparser.RobotFileParser(); rules.parse(robots.splitlines())
        for bot in ['Googlebot', 'OAI-SearchBot', 'ChatGPT-User']:
            for url in html_urls:
                if not rules.can_fetch(bot, url): report['errors'].append(f'{bot} blocked: {url}')
        catalog, _ = fetch(ORIGIN + '/publications.json'); records = json.loads(catalog)
        # The export is a versioned object containing the publications list.
        records = records['publications'] if isinstance(records, dict) else records
        report['publication_count'] = len(records)
        if any(int(row['year']) < 2008 for row in records): report['errors'].append('Publication older than 2008')
    except Exception as error:
        report['errors'].append(str(error))
    failures = len(report['errors']) + sum(len(page['errors']) for page in report['pages'])
    report['failure_count'] = failures
    (output / 'audit.json').write_text(json.dumps(report, indent=2) + '\n')
    lines = [f'# Public site audit — {today}', '', f"Checked {len(report['pages'])} HTML pages; {failures} issues.", '',
             'This is a public deployment check. It does not measure search rankings, private analytics, or AI citations.', '']
    for error in report['errors']: lines.append('- ' + error)
    for page in report['pages']:
        for error in page['errors']: lines.append(f"- {page['url']}: {error}")
    end = today - dt.timedelta(days=3)
    lines += ['', '## Monthly account review', '',
              'Use the newest complete Search Console date, then the same dates in GA4. Suggested windows allowing three days for processing:', '']
    for days in (28, 90):
        start = end - dt.timedelta(days=days - 1)
        previous_end = start - dt.timedelta(days=1); previous_start = previous_end - dt.timedelta(days=days - 1)
        lines.append(f'- {days} days: {start}–{end}; previous period: {previous_start}–{previous_end}.')
    lines += ['', 'GA4 began 2026-09-07; periods crossing that date are incomplete. Exclude launch testing from conclusions.',
              'Follow docs/visibility-review.md and store account exports locally in .impeccable/research/analytics/ (gitignored).']
    (output / 'report.md').write_text('\n'.join(lines) + '\n')
    print('\n'.join(lines[:5])); return 1 if failures else 0

if __name__ == '__main__':
    sys.exit(main())
