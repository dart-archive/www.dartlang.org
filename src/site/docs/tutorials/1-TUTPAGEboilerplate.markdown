---
layout: default
title: "Put the Page Title here"
description: "This should be exciting! Attention grabbing! Life changing!"
has-permalinks: true
tutorial:
  id: this-should-be-unique
---

{% capture whats_the_point %}

* This text gets captured 
* ...and used in the left column above the TOC.
* It should be a list of factoids

{% endcapture %}

{% capture sample_links %}

This section provides links to sources on github.

{% endcapture %}

{% capture content %}

<div id="under-construction" markdown="1">
<h3> <i class="icon-wrench"> </i> Under construction </h3>

This is a draft under construction.
Your kindly worded
<a
 href="http://code.google.com/p/dart/issues/entry?template=Tutorial%20feedback"
 target="_blank">
comments and suggestions
</a>
are appreciated.
Thank you for your patience.
</div>

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
