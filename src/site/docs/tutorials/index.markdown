---
layout: default
title: "Dartboard"
description: "Learn how to build great Web apps using Dart."
tutorial:
  id: tut-home
---

{% capture whats_the_point %}

* Dart is open-source.
* Dart is a complete Web programming platform.
* Dart brings structure to Web app engineering.
* Learn Dart here: No Web experience required.

{% endcapture %}

{% capture content %}

# {{ page.title }}

Welcome to **Dartboard**,
your guide to building great Web apps using Dart.

Dartboard is a collection of tutorials, _Targets_, that
will teach you:

* the Dart programming language,
  an object-oriented structured language
  with lexical scoping, closures and optional static typing
* Dart Editor, a light-weight, open source editor with
  code completion and debugging tools
* Dart APIs, a collection of classes that provide core
  and Web programming capabilities
* Web components, [XX: get a nice description of these here]
* and the Dart SDK, which contains the stand-alone virtual machine,
  a package manager, and Chromium with an embedded Dart VM

Dartboard is designed so that you can follow the Targets in order,
building your knowledge of Dart from the ground up,
or you can customize your learning experience by
choosing just the Targets you need.

If you are new to Web programming, you're in luck.
After you download the Dart software,
you will begin with a very tiny Dart Web app.
Through this example, you will learn basic concepts
about Dart, its libraries and tools, HTML5,
and the Document Object Model (DOM).
DOM is the programming interface used by browsers
to represent and manipulate elements on a browser page.
Understanding the DOM is key to Web programming.

Target 1: Get Dart
: [XX: FOR NOW... later will/may provide
instructions here] To get started, go to the
[Downloads and Source](/downloads.html)
page and download the Dart software for your system.
Be sure to download the package under **Everything you need**
because you will be using Dart Editor
throughout this tutorial.

{% comment %}
[Target 1: Getting Started](getting-started/index.html)
: [XX FOR LATER...THIS IS now completely broken.
It will cover the download process,
what tools and libraries come with the Dart software,
and running the two default apps.]
[XX much of what's in here is repetitive to
stuff that's already out there
and to stuff in Target 2.
download, run cmd-line, run Web app.
Adds a little value with definition of terms
and some hand-holding.
Should I include this and keep working on it? Or should I chuck it?
 {% endcomment %}

[Target 2: Build a Mini Web App](mini-web-app/index.html)
: In this Target, you will use Dart Editor to create
a stripped-down Web application to
learn about Dart applications,
core concepts of Web programming,
Dart language fundamentals,
and basic Dart Editor capabilities.

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

<a href="getting-started/index.html">Getting Started</a>
steps you through downloading and installing the software.
In addition, you will use Dart Editor
to create and run a stripped-down, bare bones Web app.

[XX: There are no pages from here down]

<a href="web-programming/index.html">Web Programming Basics</a>
explains the runtime environment for a web application.
Here you will learn about the DOM (Document Object Model)
and how to use its objects to manipulate the elements on a page.

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

