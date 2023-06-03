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




<script type="text/javascript">

var waitForLoad = function () {
    if (typeof $ != "undefined") {
        $(document).ready(function() {
            var filter = function() {
                $(".bib_entry").each(function() {
                    var entry_type_article = $(this).hasClass("entry_type_article");
                    var entry_type_conference = $(this).hasClass("entry_type_inproceedings");                    
                    // check for code, demo, dataset
                    var code_exists = $(this).hasClass("code_exists_true");
                    var demo_exists = $(this).hasClass("demo_exists_true");
                    var dataset_exists = $(this).hasClass("dataset_exists_true");
                    
                    var show_based_on_entry_type = (entry_type_article && $("#entry_type_article").is(":checked")) || (entry_type_conference && $("#entry_type_conference").is(":checked")) || (dataset_exists && $("#entry_type_dataset").is(":checked")) || (code_exists && $("#entry_type_code").is(":checked")) || (demo_exists && $("#entry_type_demo").is(":checked"));

                    if (show_based_on_entry_type) {
                        $(this).show();
                    } else {
                        $(this).hide();
                    }
                });
            };
            filter();
            $("input").change(function() {
                filter();
            });
        });
    } else {
        setTimeout(waitForLoad, 100);
    }
};
waitForLoad();

</script>

## Under review

{% bibliography --query @*[year=2050]%}

## 2023

{% bibliography --query @*[year=2023]%}

## 2022

{% bibliography --query @*[year=2022]%}

## 2021

{% bibliography --query @*[year=2021]%}

## 2020

{% bibliography --query @*[year=2020]%}

## 2019

{% bibliography --query @*[year=2019]%}

## 2018

{% bibliography --query @*[year=2018]%}

## 2017

{% bibliography --query @*[year=2017]%}

## 2016

{% bibliography --query @*[year=2016]%}

## 2008 - 2015

{% bibliography --query @*[year<=2015]%}
