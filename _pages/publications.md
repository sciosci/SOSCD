---
layout: publications
permalink: /publications/
author_profile: false
toc: true
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
    /*li {*/
    /*  display: inline-block;*/
    /*  padding-left: 30px;*/
    /*  text-indent: -30px;*/
    /*}*/
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
        /*padding-left: 15px;*/
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
      text-indent: -1em;
    }
    .bibliography li:before {
      content: "•";
      padding-right: 5px;
    }
}
@media only screen and (max-width: 740px) {
    .bibliography li {
      display: inline-block;
      padding-left: 1em;
      text-indent: -1em;
    }
    .bibliography li:before {
      content: "•";
      padding-right: 5px;
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
## Under review
{% bibliography --query @*[year=2050]%}
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
