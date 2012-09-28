---
layout: default
title: "Dartboard"
description: "Learn how to build great web apps using Dart."
tutorial:
  id: tut-home
---

{% capture whats_the_point %}

* Learn to write web apps in Dart.
* No web experience required.
* Dart brings structure to web app engineering.

{% endcapture %}

{% capture content %}

# {{ page.title }}

Welcome to **Dartboard**,
your guide to building great web apps using Dart.

Dartboard is a collection of tutorials, _Targets_, that
will teach you:
* the Dart programming language,
  an object-oriented structured language
  with lexical scoping, closures and optional static typing
* Dart Editor, a light-weight open source editor with
  code completion and debugging tools
* Dart APIs, a collection of classes that provide core
  and web programming capabilities
* and the Dart SDK, which contains the stand-alone virtual machine,
  a package manager, and Chromium with an embedded Dart VM

You can follow the tutorials in order,
building your knowledge of Dart from the ground up,
or you can choose the 


This guide assumes that you know how to write programs in a
structured language such as C++ or Java.
If you are new to web programming, you're in luck.
This tutorial starts at the beginning,
explaining everything you need to know to write
an app that can run on the web or on mobile devices.

Go through the following trails in order,
or read only the sections you need.

<a href="why-dart.html">Why Dart?</a>
explains the goals and philosophies of the Dart project
and how it can help you be more productive.

<a href="getting-started/index.html">Getting Started</a>
steps you through downloading the software
and running a couple of apps.

[XX: There are no pages from here down]

<a href="web-programming/index.html">Web Programming Basics</a>
explains the runtime environment for a web application.
Here you will learn about the DOM (Document Object Model)
and how to use its objects to manipulate the elements on a page.

<a href="dart-icore-apis/index.html">The `dart.core` Library</a>
contains classes for basic functionality such as
strings, numbers, Math and more.

<a href="dart-html-apis/index.html">The `dart.html` Library</a>
describes the classes that correspond to objects in the DOM.

<a href="language/index.html">The Dart Language</a>
teaches you the syntax of the Dart language,
including some of its "syntactic sugar".

...stay tuned for more...

{% endcapture %}

{% include tutorial.html %}

