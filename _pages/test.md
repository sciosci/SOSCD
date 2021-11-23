---
layout: publications
permalink: /test/
author_profile: false
toc: false
title: "Test"
---

<style>
    /*!* Show one image on devices under 540px *!*/
    /*@media screen and (max-width: 540px) { */
    /*   ol li{*/
    /*    width: 100%;*/
    /*    float:left;*/
    /*   }*/
    /*}*/
    
    /*!* Show three images on devices between 550 and 800px wide *!  */
    /*@media screen and (min-width: 540px) and (max-width: 800px) {*/
    /*   ol li{*/
    /*    width: 33.333%;*/
    /*    float:left;*/
    /*   }*/
    /*}*/
    
    /*!* Show five images on devices between 800px and 1180pxwide *!  */
    /*@media screen and (min-width: 800px) and (max-width: 1180px) {*/
    /*   ol li{*/
    /*    width: 20%;*/
    /*    float:left;*/
    /*   }*/
    /*}*/
li {
  display: inline-block;
}
ol {
  /*list-style-type: none;*/
  padding-inline-start: 0;
}

li img {
    vertical-align: middle;
    float: left;
    margin-right: 20px;
    width:100%;
    max-width:200px;
}
</style>
This is a test {% cite ioannidis2015meta %}

{% bibliography %}
