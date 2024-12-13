---
title: Termine
show_pageimage: true
image_width: 1000
image_height: 300
content:
    items:
        0: '@self.children'
        '@taxonomy':
            type: event
            event_freq: none
    order:
        by: date
        dir: asc
    dateRange:
        start: today
        field: header.event.start
    limit: '20'
    pagination: true
show_sidebar: true
---

