---
layout: default
title: "Dartboard: A Dart Tutorial"
description: "Learn how to build great Web apps using Dart."
tutorial:
  id: tut-home
---

{% capture whats_the_point %}

* Dart is open-source.
* Dart is a complete programming platform with support for Web apps.
* Dart brings structure to Web app engineering.
* Learn Dart here: No Web experience required.

{% endcapture %}

{% capture content %}

# {{ page.title }}

Welcome to **Dartboard**,
your guide to building great Web apps using Dart.

![Dartboard Cake](images/dart-cake.jpeg)

<aside class="alert alert-warning">
<strong>Under Construction</strong>:
This tutorial is under construction
and is a draft.
Please be patient.
Send kindly worded comments to [XX:].
</aside>

Dartboard is a collection of tutorials, _Targets_, that teach:

* the Dart programming language,
  an object-oriented structured language
  with lexical scoping, closures and optional static typing
* Dart Editor, a light-weight, open source editor with
  code completion, API lookup, and debugging tools
* Dart APIs, a collection of classes that provide core
  and Web programming capabilities
* Web components, a model for easily building 
  visually rich, reusable UI widgets
* the Dart SDK, which contains the stand-alone virtual machine,
  a Dart > JavaScript compiler, and a package manager
* and a special build of Chromium that has the Dart VM embedded in it
  for running Dart Web apps directly

Dartboard is designed so that you can follow the Targets in order,
building your knowledge of Dart from the ground up,
or you can customize your learning experience by
choosing just the Targets you need.

If you are new to Web programming, you're in luck.
After you download the Dart software,
you will begin with a very tiny Dart Web app.
Through this example, you will learn basic concepts
about Dart, its libraries and tools, HTML,
and the DOM (The Document Object Model),
which is the programming interface used by browsers
to represent and manipulate elements on a browser page.
Understanding the DOM is key to Web programming.

[Target 1: Get Started](getting-started/index.html)
: Here you will download the Dart software bundle,
discover what tools and libraries come with the Dart software,
and use Dart Editor to run two apps.

[Target 2: Build a Mini Web App](mini-web-app/index.html)
: In this Target, you will use Dart Editor to create
a stripped-down Web application to
learn about Dart applications,
the DOM,
core concepts of Web programming,
Dart language fundamentals,
and basic Dart Editor capabilities.

{% comment %}
[Target 3: Write a To Do List App](todo-app/index.html)
: [XX: this is not here] By writing a small practical Web app,
you will learn how to use widgets in your app.
{% endcomment %}

...stay tuned for more...

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
