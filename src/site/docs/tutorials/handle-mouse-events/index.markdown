---
layout: default
title: Handle Mouse Clicks
description: Shows you how to register event handlers
tutorial:
  id: handle-mouse-clicks
---

{% capture whats-the-point %}

* This text gets captured 
* ...and used in the left column above the TOC.
* It should be a list of factoids

{% endcapture %}

{% capture content %}

This is the page's content

Questions and problems:

* how to CSSify the "What's the point?" list
* figure out the TOC to the left.
  - it should be linked
  - it would be nice if it were also auto-generated
    and the page titles were variables that were set in
    one place and then used in other places 
  - also, maybe the pages have long names
    for the actual page titles and short names for the TOC?
* a path indicator at the top might be nice. like:
   Dartboard-> Get Started-> Run Command Line App
* some artwork: Dartboard logo, Dartboard Targets, darts for what's the point.
* each page has a unique id ... how best to make use of this?

{% endcapture %}

{% include tutorial.html %}
