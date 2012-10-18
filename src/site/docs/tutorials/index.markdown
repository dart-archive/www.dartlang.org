---
layout: default
title: "A Game of Darts"
description: "Learn how to build great web apps using Dart."
tutorial:
  id: tut-home
---

{% capture whats_the_point %}

* Dart is an open-source platform for building structured HTML5 web apps.
* Learn Dart here: No web experience required.

{% endcapture %}

{% capture content %}

Welcome to 
your guide to building great web apps using Dart.

<div id="under-construction" markdown="1">
<h3> <i class="icon-wrench"> </i> Under construction </h3>

This tutorial is a draft under construction.
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
It is designed so that you can follow the targets in order,
building your knowledge of Dart from the ground up,
or you can customize your learning experience by
choosing just the targets you need.

You should already know how to program in a structured language
like C or Java.
It helps to be familiar with object-oriented programming paradigms.

You do not need any former knowledge of JavaScript or the DOM
(Document Object Model) to use these tutorials.
(The DOM is key to web programming
and you will learn about it here,
starting with the basics in Target 2.)

![Dart Icon](/imgs/Dart_Logo_21.png) [Target 1: Get Started](get-started/index.html)
: Here you will download the Dart software bundle,
discover which tools and libraries come with the Dart software,
and use Dart Editor to run two apps.

![Dart Icon](/imgs/Dart_Logo_21.png) [Target 2: Put Text on a Page](put-text/index.html)
: In this target, you will use Dart Editor to create
a stripped down Dart program
that simply puts text on a browser page.
Though simple,
this tiny program
shows you how to host a Dart program on a web page
and one way to manipulate the DOM.
You will also begin learning about the Dart language,
Dart Editor, HTML, and CSS.

{% comment %}
[Target 3: Write a To Do List App](todo-app/index.html)
: [XX: this is not here] By writing a small practical web app,
you will learn how to use widgets in your app.
{% endcomment %}

<div>
  <hr>
  <div class="row">
    <div class="span1">
    <font size="24">
    <i class="icon-bullhorn"> </i>
    </font>
    </div>
    <div class="span8">
...stay tuned for more targets...
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

<a href="dart-icore-apis/index.html">The `dart.core` Library</a>
contains classes for basic capability such as
strings, numbers, Math and more.

<a href="dart-html-apis/index.html">The `dart.html` Library</a>
describes the classes that correspond to objects in the DOM.

<a href="language/index.html">The Dart Language</a>
teaches you the syntax of the Dart language,
including some of its "syntactic sugar".

{% endcomment %}

{% endcapture %}

{% include tutorial.html %}
