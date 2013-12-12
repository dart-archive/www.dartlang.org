---
layout: default
title: "Put the Page Title here"
description: "This should be exciting! Attention grabbing! Life changing!"
has-permalinks: true
tutorial:
  id: this-should-be-unique
next: path-to-next-target
next-title: "Title of next target"
prev: path-to-prev-target
prev-title: "Title of previous target"
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
<h3> <i class="fa fa-wrench"> </i> Under construction </h3>

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


Target Order
-----------------------
Get Started
Connect Dart & HTML
Add Elements to the DOM
Remove DOM Elements
Install Shared Packages
Get Started with Web UI
Use Templates
Define a Custom DOM Tag
**Polymer
Fetch Data Dynamically
Get Input from a Form
Use IndexedDB
**Write for Mobie Devices

{% endcapture %}

{% include tutorial.html %}
