---
layout: single
permalink: /deadlines
author_profile: false
title: "Deadlines"
toc: false
---

<!-- Display the countdown timer in an element -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/countdown/2.6.0/countdown.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


<div id="0"></div>
<div id="1"></div>
<div id="2"></div>
<div id="3"></div>
<div id="4"></div>
<div id="5"></div>
<div id="6"></div>

<script>
    $("countdown").ready(function () {

        function create_countdown(name, date, id) {
            countdown(date,
                function (ts) {
                    $(id).html(
                    "<h4>" + name + "</h4>" + ts.toHTML()
                    );
                },
                countdown.MONTHS|countdown.DAYS | countdown.HOURS | countdown.MINUTES | countdown.SECONDS);
        }
        
        var events = [
        {'name': "(Tong) Grant recommendation final manuscript", 'date': new Date("June 15, 2020 17:00:00 GMT-04:00")},
        {'name': "(Tong) ASIS&T 2020 conference submission", 'date': new Date("June 15, 2020 23:59:59 GMT-04:00")},
        {'name': "(Tong) IC2S2 2020 video presentation", 'date': new Date("June 19, 2020 23:59:59 GMT-04:00")},
        {'name': "(Lizhen) CHI 2021", 'date': new Date("September 10, 2020 23:59:59 GMT-04:00")},
        {'name': "(Daniel & Alan) ORI 2021", 'date': new Date("July 28, 2020 17:00:00 GMT-04:00")},
        {'name': "(Daniel) NSF CAREER", 'date': new Date("July 27, 2020 17:00:00 GMT-04:00")},
        {'name': "(Han) Submit Novelty and CBS papers", 'date': new Date("July 31, 2020 23:59:59 GMT-04:00")},
        {'name': "(Han) Submit misleading graph detection", 'date': new Date("August 31, 2020 23:59:59 GMT-04:00")},  
        ];
        
        var sorted_events = events.sort(function (a, b) { return a.date - b.date }); 
        
        for (i=0; i < sorted_events.length; i++) {
            create_countdown(sorted_events[i].name, sorted_events[i].date, "#" + String(i));
        }
        
    });
</script>

