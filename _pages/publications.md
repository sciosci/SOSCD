---
layout: publications
permalink: /publications/
header:
  image: /assets/images/splash_images/papers.png
author_profile: false
toc: true
toc_label: "Publication year"
title: "Publications"
---

<script type="text/javascript" src="https://d1bxh8uas1mnw7.cloudfront.net/assets/embed.js"></script>
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
View on [Google Scholar](https://scholar.google.com/citations?hl=en&user=GAi23ssAAAAJ&view_op=list_works&sortby=pubdate)
<style>
.skip-links {
    height: 0;    
}
@media only screen and (min-width: 740px) {    
    li img {
        vertical-align: middle;
        float: right;
        margin-right: 20px;
        width:100%;
        max-width:200px;
        border-radius: 5%;
        transition: transform .1s;
        box-shadow: 1px 2px 3px #3e3d3c59;
    }
    li img:hover {    
        transform: scale(1.5);
        box-shadow: 2px 2px 18px #D44500;
    }
    ol ol li {
        margin-bottom: 0;
    }
    ol ol {
        padding-left: 1em;
    }
    ol {
        padding-left: 0.5em;
    }
    ul {
      list-style: none;
      margin-left: 0;
      padding-left: 0;
    }
    .bibliography li {
      display: inline-block;
      padding-left: 1em;
    }
    .bibliography li:before {
      content: "•";
      padding-right: 5px;
    }
}
@media only screen and (max-width: 740px) {
    .bibliography li {
      display: inline-block;
    }
    h2 {
        margin-top: 0;
    }
    ol {
        margin-left: 0;
        padding-left: 0;
    }
    ol ol {
        margin-top: 0;
        margin-bottom: 30px;
        text-indent: 0;
        padding-left: 0;
    }
    li img {
            /*vertical-align: middle;*/
            display: block;
            /*margin-right: 20px;*/
            height:100%;
            max-height:200px;
            border-radius: 5%;
            /*transition: transform .1s;*/
            box-shadow: 1px 2px 3px #3e3d3c59;
        }
}
</style>

[//]: # (<form>)

[//]: # (    <input type="checkbox" id="entry_type_article" name="entry_type_article" value="article" checked>)

[//]: # (    <label for="entry_type_article">Article</label>)

[//]: # (    <input type="checkbox" id="entry_type_conference" name="entry_type_conference" value="conference" checked>)

[//]: # (    <label for="entry_type_conference">Conference</label>    )

[//]: # (    <input type="checkbox" id="entry_type_dataset" name="entry_type_dataset" value="press" checked>)

[//]: # (    <label for="entry_type_dataset">Dataset</label>)

[//]: # (    <input type="checkbox" id="entry_type_code" name="entry_type_code" value="code" checked>)

[//]: # (    <label for="entry_type_code">Code</label>)

[//]: # (    <input type="checkbox" id="entry_type_demo" name="entry_type_demo" value="demo" checked>)

[//]: # (    <label for="entry_type_demo">Demo</label>)

[//]: # (</form>)
<form class="form-inline">
<strong>Filter by type &nbsp;</strong>
    <span class="form-check form-switch">
        <input class="form-check-input" type="checkbox" id="entry_type_article" name="entry_type_article" value="article" checked>
        <label class="form-check-label" for="entry_type_article"><i class="fas fa-newspaper"></i> Journal</label>
    </span>

    <span class="form-check form-switch">
        <input class="form-check-input" type="checkbox" id="entry_type_conference" name="entry_type_conference" value="conference" checked>
        <label class="form-check-label" for="entry_type_conference"><i class="fas fa-calendar-alt"></i> Conference</label>
    </span>

    <span class="form-check form-switch">
        <input class="form-check-input" type="checkbox" id="entry_type_dataset" name="entry_type_dataset" value="press" checked>
        <label class="form-check-label" for="entry_type_dataset"><i class="fas fa-database"></i> Dataset</label>
    </span>

    <span class="form-check form-switch">
        <input class="form-check-input" type="checkbox" id="entry_type_code" name="entry_type_code" value="code" checked>
        <label class="form-check-label" for="entry_type_code"><i class="fas fa-code"></i> Code</label>
    </span>

    <span class="form-check form-switch">
        <input class="form-check-input" type="checkbox" id="entry_type_demo" name="entry_type_demo" value="demo" checked>
        <label class="form-check-label" for="entry_type_demo"><i class="fas fa-desktop"></i> Demo</label>
    </span>
</form>

<!-- DO NOT REMOVE THIS LINE : BEGIN -->

<script type="text/javascript">

var waitForLoad = function () {
    if (typeof $ != "undefined") {
        $(document).ready(function() {
            var filter = function() {
                var doc_id_value = "";
                var map_data = set_year_paper_id_map();
                $(".bib_entry").each(function() {
                    var entry_type_article = $(this).hasClass("entry_type_article");
                    var entry_type_conference = $(this).hasClass("entry_type_inproceedings");                    
                    var code_exists = $(this).hasClass("code_exists_true");
                    var demo_exists = $(this).hasClass("demo_exists_true");
                    var dataset_exists = $(this).hasClass("dataset_exists_true");
                    
                    var show_based_on_entry_type = (entry_type_article && $("#entry_type_article").is(":checked")) || 
                                                   (entry_type_conference && $("#entry_type_conference").is(":checked")) || 
                                                   (dataset_exists && $("#entry_type_dataset").is(":checked")) || 
                                                   (code_exists && $("#entry_type_code").is(":checked")) || 
                                                   (demo_exists && $("#entry_type_demo").is(":checked"));

                    if (show_based_on_entry_type) {
                        $(this).closest('li').show();
                        $.each(this.attributes, function() {
                            if (this.name === "id") {
                                doc_id_value = this.value
                            }
                        });
                        for (var year in map_data) {
                            if (map_data.hasOwnProperty(year)) {
                                map_data[year].forEach(function(item) {
                                    if (doc_id_value === item) {
                                        document.getElementById(year).style.display = "block";
                                        document.getElementById(year + '-hr').style.display = "block";
                                    }
                                });
                            }
                        }
                    } else {
                        $(this).closest('li').hide();
                    }
                });

            };
            set_display_status();
            filter();
            $("input").change(function() {
                set_display_status();
                filter();
            });
        });
    } else {
        setTimeout(waitForLoad, 100);
    }
};

function set_display_status() {
    // For every new header added to represent new year, set the display attribute to "none" in this function.

        document.getElementById('2016').style.display = "none";
        document.getElementById('2016-hr').style.display = "none";
        document.getElementById('2017').style.display = "none";
        document.getElementById('2017-hr').style.display = "none";
        document.getElementById('2018').style.display = "none";
        document.getElementById('2018-hr').style.display = "none";
        document.getElementById('2019').style.display = "none";
        document.getElementById('2019-hr').style.display = "none";
        document.getElementById('2020').style.display = "none";
        document.getElementById('2020-hr').style.display = "none";
        document.getElementById('2021').style.display = "none";
        document.getElementById('2021-hr').style.display = "none";
        document.getElementById('2022').style.display = "none";
        document.getElementById('2022-hr').style.display = "none";
        document.getElementById('2023').style.display = "none";
        document.getElementById('2023-hr').style.display = "none";
        document.getElementById('2024').style.display = "none";
        document.getElementById('2024-hr').style.display = "none";
        document.getElementById('2050').style.display = "none";
        document.getElementById('2050-hr').style.display = "none";
        document.getElementById('2008-2015').style.display = "none";
        document.getElementById('2008-2015-hr').style.display = "none";
}

function set_year_paper_id_map() {
    // Update the below object with the year and paper id of every new paper added in references.bib
    return  {
            '2016': ["ramkumar2016chunking", "ethier2016adaptive", "achakulvisut2016science"],
            '2017': ["shema2017show"],
            '2018': ["acuna2018bioscience", "teplitskiy2018sociology", "lienard2018intellectual"],
            '2019': ["lee2019limiting", "zeng2019dead"],
            '2020': ["zeng2020finding", "liang2020artificial", "zeng2020assigning", "achakulvisut2020pubmed", "jas2020pyglmnet", "zeng2020modeling", "zhuangacuna2020", "liangacuna2020", "liang2020don", "zengacuna2020", "zeng2020gotfunding"],
            '2021': ["10.1145/3461702.3462616", "acunaiconference2022", "zhuangacuna2021"],
            '2022': ["acuna2022", "keacuna2022"],
            '2023': ["zhuang2023computational"],
            '2024': ["XU2024103542", "Bibal2024"],
            '2050': ["liang2024complementary", "zhou2022paraphrase", "zhuangacuna2022", "acuna2022predicting"],
            '2008-2015': ["acuna2008bayesian", "acuna2008structure","acuna2009improving","acuna2010people", "acuna2010structure","acuna2011rational","avraham2012toward", "acuna2012predicting","acuna2013future","acuna2014multifaceted","acuna2015using",""],
    }
}
waitForLoad();

</script>


<h1  id='2050'> Under Review </h1>
<hr id='2050-hr'>


{% bibliography --query @*[year>2024]%}

<h1  id='2024'> 2024 </h1>
<hr  id='2024-hr'>
{% bibliography --query @*[year=2024]%}

<h1  id='2023'> 2023 </h1>
<hr  id='2023-hr'>
{% bibliography --query @*[year=2023]%}

<h1  id='2022'> 2022 </h1>
<hr  id='2022-hr'>
{% bibliography --query @*[year=2022]%}

<h1  id='2021'> 2021 </h1>
<hr  id='2021-hr'>
{% bibliography --query @*[year=2021]%}

<h1  id='2020'> 2020 </h1>
<hr  id='2020-hr'>
{% bibliography --query @*[year=2020]%}

<h1  id='2019'> 2019 </h1>
<hr  id='2019-hr'>
{% bibliography --query @*[year=2019]%}

<h1  id='2018'> 2018 </h1>
<hr  id='2018-hr'>
{% bibliography --query @*[year=2018]%}

<h1  id='2017'> 2017 </h1>
<hr  id='2017-hr'>
{% bibliography --query @*[year=2017]%}

<h1  id='2016'> 2016 </h1>
<hr  id='2016-hr'>
{% bibliography --query @*[year=2016]%}

<h1  id='2008-2015'> 2008-2015 </h1>
<hr  id='2008-2015-hr'>
{% bibliography --query @*[year<=2015]%}

<!-- DO NOT REMOVE THIS LINE : END -->
