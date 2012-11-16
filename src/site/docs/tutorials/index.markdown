---
layout: default
title: "A Game of Darts&mdash;Tutorials"
description: "Learn how to build great web apps using Dart."
has-permalinks: true
tutorial:
  id: tut-home
---

{% capture whats_the_point %}

* This blue box shows page highlights.
* Learn Dart here: No web experience required.
* Dart is an open-source platform for building structured HTML5 web apps.

{% endcapture %}

{% capture content %}

Welcome to 
your guide to building great web apps using Dart.

<div id="under-construction" markdown="1">
<h3> <i class="icon-wrench"> </i> Under construction </h3>

This is a draft.
Your kindly worded
<a
 href="http://code.google.com/p/dart/issues/entry?template=Tutorial%20feedback"
 target="_blank">
comments and suggestions
</a>
are appreciated.
Thank you for your patience.

</div>

*A Game of Darts* is a collection of tutorials, _targets_,
that teaches you how to build web programs
using the Dart language, tools, and APIs.
You can either follow the targets in order,
building your knowledge of Dart and web programming
from the ground up,
or customize your learning experience by
choosing just the targets you need.

You should already know how to program in a structured language
like C or Java.
It helps to be familiar with object-oriented programming.

You don't need to know JavaScript or the DOM
(Document Object Model) to use these tutorials.
The DOM is key to web programming
and you will learn about it here,
starting with the basic concepts in Target 2.

<img src="/imgs/Dart_Logo_21.png" width="21" height="21" alt="Dart"> [Target 1: Get Started](get-started/)
: Download the Dart software bundle,
discover which tools and libraries come with the Dart software,
and use Dart Editor to run two apps.

<img src="/imgs/Dart_Logo_21.png" width="21" height="21" alt="Dart"> [Target 2: Connect Dart &amp; HTML](connect-dart-html/)
: Use Dart Editor to create
a stripped-down Dart program
that simply puts text on a browser page.
Though simple,
this tiny program
shows you how to host a Dart program on a web page
and one way to manipulate the DOM.
You will also begin learning about the Dart language,
Dart Editor, HTML, and CSS.

<img src="/imgs/Dart_Logo_21.png" width="21" height="21" alt="Dart"> [Target 3: Add an Element to the DOM](add-elements/)
: The small app in this target
responds to a user-generated event
by adding an Element to the DOM.

<img src="new-icon.png" width="48" height="48"> [Target 4: Remove Elements from the DOM](remove-elements/)
: In this target,
you will modify the little todo app from Target 3
to remove elements from the DOM.

<div>
  <hr>
  <div class="row">
    <div class="span1">
    <font size="24">
    <i class="icon-bullhorn"> </i>
    </font>
    </div>
    <div class="span8">
...more targets coming...
    </div>
  </div>
<hr>
</div>

<div class="row">
  <div class="span3">
  <p style="font-size:7px">Version: 16 Nov 2012</p>
  </div>
  <div class="span3">
<a href="http://code.google.com/p/dart/issues/entry?template=Tutorial%20feedback"
 target="_blank">
<i class="icon-comment"> </i>
Send feedback
</a>
  </div>
  <div class="span3">
  <a href="/docs/tutorials/get-started/" class="pull-right">Get Started <i class="icon-chevron-right"> </i></a>
  </div>
</div>

{% endcapture %}

{% include tutorial.html %}
