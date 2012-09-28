---
layout: default
title: Put the Page Title here
description: This should be exciting! Attention grabbing! Life changing!
tutorial:
  id: this-should-be-unique
---

{% capture whats_the_point %}

* This text gets captured and used in the left column above the TOC.
* It should be a list of salient facts.
  
{% endcapture %}

{% capture content %}

# {{ page.title }}

  This is the page's content

{% endcapture %}

{% include tutorial.html %}