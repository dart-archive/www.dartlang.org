---
layout: default
title: Put the Page Title here
description: This should be exciting! Attention grabbing! Life changing!
tutorial:
  id: this-should-be-unique
---

{% capture whats_the_point %}

* This text gets captured 
* ...and used in the left column above the TOC.
* It should be a list of factoids

{% endcapture %}

{% capture content %}

This is the page's content

Questions and problems:

* why is the list in whats_the_point not a list?
* figure out the TOC to the left. it should be linked
  it would be nice if it were also auto-generated
  and the page titles were variables that were set in
  one place and then used in other places 
  also, maybe the pages have long names and short names?
  I am giving each page a unique id.
* Should we have a path indicator at the top? like:
   Dartboard-> Getting Started-> Command Line App
* some artwork: Dartboard logo, Dartboard Targets

{% endcapture %}

{% include tutorial.html %}
