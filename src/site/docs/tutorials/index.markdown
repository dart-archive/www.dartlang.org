---
layout: default
title: "A Game of Darts&mdash;Tutorials"
description: "A beginner's guide to building web apps with Dart."
has-permalinks: true
rel:
  author:
    - mary-campione
tutorial:
  id: tut-home
article:
  written_on: 2012-10-01
  updated_on: 2013-07-01
  collection: everyday-dart
---

{% capture whats_the_point %}

* This blue box shows page highlights.
* Learn Dart here: No web experience required.
* Dart is an open-source platform for building structured HTML5 web apps.

{% endcapture %}

{% capture sample_links %}

<ul>
  <li>
    Get the source code for all the tutorial examples from
    <a href="https://github.com/dart-lang/dart-tutorials-samples"
       target="_blank">github</a>.
  </li>

  <li>
    Run the examples from the
    <a href="http://dart-lang.github.com/dart-tutorials-samples/"
       target="_blank">index</a>.
  </li>
</ul>

{% endcapture %}

{% capture content %}

Welcome to 
your guide to building great web apps using Dart.

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

<hr>

<div id="target-group" markdown="1">
<i class="icon-star"> Check out the newest target on IndexedDB.
This target shows you how to give your app persistence
and offline capability by saving data on the client side.
[Target 11: Use IndexedDB](indexeddb/).
</div>

<hr>

<img src="/imgs/Dart_Logo_21.png" width="21" height="21" alt="Dart"> [ Target 1: Get Started](get-started/)
: Download the Dart software bundle,
discover which tools and libraries come with the Dart software,
and use Dart Editor to run two apps.

<hr>

<img src="/imgs/Dart_Logo_21.png" width="21" height="21" alt="Dart"> [ Target 2: Connect Dart &amp; HTML](connect-dart-html/)
: Use Dart Editor to create
a stripped-down Dart program
that simply puts text on a browser page.
Though simple,
this tiny program
shows you how to host a Dart program on a web page
and one way to manipulate the DOM.
You will also begin learning about the Dart language,
Dart Editor, HTML, and CSS.

<hr>

<img src="/imgs/Dart_Logo_21.png" width="21" height="21" alt="Dart"> [ Target 3: Add an Element to the DOM](add-elements/)
: The small app in this target
responds to a user-generated event
by adding an Element to the DOM.

<hr>

<img src="/imgs/Dart_Logo_21.png" width="21" height="21" alt="Dart"> [ Target 4: Remove DOM Elements](remove-elements/)
: In this target,
you will modify the little todo app from Target 3
to remove elements from the DOM.

<hr>

<img src="/imgs/Dart_Logo_21.png" width="21" height="21" alt="Dart"> [ Target 5: Install Shared Packages](packages/)
: Packages help programmers to organize and share code.
Many open-source Dart packages are hosted at the
<a href="http://pub.dartlang.org/">pub.dartlang.org</a>
repository.
This target walks you through the steps to install one of those packages.

<hr>

<div id="target-group" markdown="1">
<h3> <i class="icon-magic"> </i> Dart's Web UI package</h3>
Web components and templates
are the next great ideas in web application development.
Together they provide the building blocks to
create richer and more dynamic web applications.
With the Dart team's Web UI package,
you can get started using web components and templates now.

<hr>

<img src="web-ui-icon.png" width="48" height="48"> [ Target 6: Get Started with Web UI](web-ui/)
: This target starts with the logistics
of installing the Web UI package and
setting up Dart Editor to automate the build process.
Then it shows you how to use one- and two- way data binding
to synchronize Dart data with UI elements.
Finally, you learn about template expressions
and declaratively attaching event handlers to UI elements.

<hr>

<img src="web-ui-icon.png" width="48" height="48"> [ Target 7: Use &lt;template&gt;](templates/)
: This target shows how to use Web UI templates
to conditionally activate UI elements.
It also shows you how to use template loops to
create a UI based on an Iterable Dart object, such as a list or map.
<hr>

<img src="web-ui-icon.png" width="48" height="48"> [ Target 8: Define a Custom DOM Tag](custom-elements/)
: Continuing your introduction to the Web UI package,
this target shows you how to use custom elements to
define a new DOM tag.

</div>
<hr>

<img src="/imgs/Dart_Logo_21.png" width="21" height="21" alt="Dart"> [ Target 9: Fetch Data Dynamically](fetchdata/)
: Your Dart web app can load data dynamically,
either from a static file or from a server.
Web data are often formatted using JSON (JavaScript Object Notation)&mdash;a
text based, human friendly data format.

<hr>

<img src="/imgs/Dart_Logo_21.png" width="21" height="21" alt="Dart"> [ Target 10: Get input from a form](forms/)
: Most Web apps use forms and input elements to 
gather data from the user and submit that data to a server.
The example in this target has a client-server pair
that shows how to use forms and input elements,
and how clients and servers use the classes
in the Dart libraries to communicate.
This target brings together a lot of the information you learned in
the other targets, including the use of Web UI to sync
the data in the form with Dart data.

<hr>

<img src="new-icon.png" width="48" height="48" alt="Dart"> [ Target 11: Use IndexedDB](indexeddb/)
: Learn about IndexedDB here!

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
  <p style="font-size:xx-small">Version: 1 July 2013</p>
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
