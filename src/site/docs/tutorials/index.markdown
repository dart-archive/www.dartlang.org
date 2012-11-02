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
<a href="http://code.google.com/p/dart/issues/entry?template=Tutorial%20feedback">
comments and suggestions
</a>
are appreciated.
Thank you for your patience.

</div>

{% comment %}

Dart is a general-purpose,
object-oriented language
with support for files, directories,
sockets and even web-servers.
You can use Dart for full end-to-end applications,
such as server-side scripts,
stand-alone applications and servers.

* the Dart programming language,
  an object-oriented structured language
  with lexical scoping, closures and optional static typing
* Dart Editor, a light-weight, open source editor with
  code completion, API lookup, and debugging tools
* Dart APIs, a collection of classes that provide core
  and web programming capabilities
* Web components, a model for easily building 
  visually rich, reusable UI widgets
* the Dart SDK, which contains the stand-alone virtual machine,
  a Dart > JavaScript compiler, and a package manager
* and a special build of Chromium that has the Dart VM embedded in it
  for running Dart web apps directly

Dartboard's primary objective is to teach you how to
write Dart web apps.
It provides enough information about HTML5 and the DOM
to get you successfully programming web apps in Dart,
but does not cover them exhaustively.

{% endcomment %}

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

<img src="/imgs/Dart_Logo_21.png" width="21" height="21" alt="Dart"> [Target 2: Connect Dart & HTML](connect-dart-html/)
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

{% comment %}
[Set Up Your Dart Installation](dart-software.html)
: In this section, you will download the Dart software
and learn about the software and tools that it contains.

<a href="why-dart.html">Why Dart?</a>
is a little bit of propaganda.
It explains the goals and philosophies of the Dart project
and how it can help you be more productive.
[XX: I stole the content from the front page.
Should I also steal the front section from Up and Running, too?]

<a href="dart-icore-apis/">The `dart.core` Library</a>
contains classes for basic capability such as
strings, numbers, Math and more.

<a href="dart-html-apis/">The `dart.html` Library</a>
describes the classes that correspond to objects in the DOM.

<a href="language/">The Dart Language</a>
teaches you the syntax of the Dart language,
including some of its "syntactic sugar".

{% endcomment %}

<TD style="float:left">Tutorial version: 2 Nov 2012</TD>

<TD><a href="/docs/tutorials/get-started/" style="float:right;">Next</a></TD>

{% endcapture %}

{% include tutorial.html %}
