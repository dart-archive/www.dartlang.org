---
layout: default
title: "Dart Tutorials"
description: "The Dart Tutorials&mdash;Your guide to building great web apps."
has-permalinks: true
rel:
  author:
    - mary-campione
tutorial:
  id: tut-home
next: get-started/
next-title: "Get Started"
header:
  css: ["/docs/tutorials/tute_main_page.css"]
---

{% capture content %}

<img class="scale-img-max" src="images/banner.png">

**The Dart Tutorials** teach you how to build web applications
using the Dart language, tools, and APIs.

<strong>Who are you?</strong>
<ul>
<li> You already know how to program in a structured language like C or Java.</li>
<li> You are familiar with object-oriented programming.</li>
<li> You might not know how to program the browser
     through the DOM (Document Object Model).</li>
</ul>

<strong>Let's go!</strong> Follow the tutorials in order
from left to right...or choose just the ones you need.

<div class="tute-tabs">
<div class="tabbable">
  <ul class="nav nav-tabs">
    <li class="active"><a href="#basics" data-toggle="tab">Get started</a></li>
    <li><a href="#dom" data-toggle="tab">Browser</a></li>
    <li><a href="#packages" data-toggle="tab">Packages</a></li>
    <li><a href="#futures" data-toggle="tab">Async</a></li>
    <li><a href="#forms" data-toggle="tab">Data</a></li>
    <li><a href="#commandline" data-toggle="tab">Servers</a></li>
    <!--<li><a href="#mobile" data-toggle="tab">Mobile</a></li>-->
  </ul>

  <div class="tab-content">

  <!-- BASICS TAB -->
    <div class="tab-pane active" id="basics">

      <div class="intro-para">
        Download the software and
        discover which tools and libraries you get with the bundle.
        Run two sample apps.
      </div>

      <div class="row">

        <!-- Getting Started -->
        <div class="col-md-6">
          <section>
          <h4 class="no-permalink"><a href="get-started/"><img src="images/target.png" height="20" width="20">&nbsp;Get started</a></h4>
            <p>Get Dart. Run two apps.
            </p>
          <img style="border:1px solid black" src="images/simple.png"
               width="300">
          </section>
        </div>

      </div> <!-- end row -->
    </div> <!-- end Getting Started tab -->

  <!-- DOM TAB -->
    <div class="tab-pane" id="dom">

      <div class="intro-para">
        Web pages are programmed in HTML and represented
        within the browser as a tree structure
        called the DOM (Document Object Model).
        Dart apps can modify the DOM programmatically,
        thus dynamically changing the web page.
        First, learn how to connect Dart and HTML.
        Then learn how to add, move, and remove DOM elements.
      </div>

      <div class="row">
        <!-- Connect Dart & HTML -->
        <div class="col-md-6">
          <section>
          <h4 class="no-permalink"><a href="connect-dart-html/"><img src="images/target.png" height="20" width="20">&nbsp;Connect Dart &amp; HTML</a></h4>
            <p>Include a Dart script in an HTML page.
            </p>
          <img style="border:1px solid black"
               src="images/miniapp-screenshot.png" width="300">
          </section>
        </div>

        <!-- Add Elements -->
        <div class="col-md-6">
          <section>
          <h4 class="no-permalink"><a href="add-elements/"><img src="images/target.png" height="20" width="20">&nbsp;Add Elements to the DOM</a></h4>
          <p>Add elements to the web page and move them.</p>
          <img style="border:1px solid black"
               src="images/todo-screenshot.png" width="300">
          </section>
        </div>

      </div>


      <div class="row">
        <!-- Remove Elements -->
        <div class="col-md-6">
          <section>
          <h4 class="no-permalink"><a href="remove-elements/"><img src="images/target.png" height="20" width="20">&nbsp;Remove DOM Elements</a></h4>
          <p>Delete elements from the web page.</p>
          <img style="border:1px solid black"
               src="images/todo-with-delete-screenshot.png" width="300">
          </section>
        </div>
        <div class="col-md-6">
        </div>

      </div> <!-- end row -->
    </div> <!-- end DOM tab -->

  <!-- PACKAGES TAB -->
    <div class="tab-pane" id="packages">

      <div class="intro-para">
        Dart developers have been busy creating code libraries that can help you be more productive.
        Leverage that code or put your code out in the world to share with others.
      </div>

      <div class="row">

        <!-- Packages -->
        <div class="col-md-6">
          <section>
          <h4 class="no-permalink"><a href="shared-pkgs/"><img src="images/target.png" height="20" width="20">&nbsp;Install Shared Packages</a></h4>
          <p>Organize and share code at <a href="https://pub.dartlang.org/">pub.dartlang.org</a>.</p>
          <img style="border:1px solid black"
               src="images/pub-dartlang-screenshot.png" width="300">
          </section>
        </div>
        <div class="col-md-6">

        </div>
      </div>
    </div> <!-- end Packages tab -->

  <!-- FUTURES & STREAMS TAB -->
    <div class="tab-pane" id="futures">

      <div class="intro-para">
        The Future and Stream classes provide API for performing tasks,
        such as input/output, asynchronously, so as to avoid blocking your
        program.
        Futures and Streams are fundamental to most Dart programs.
      </div>

      <div class="row">

        <div class="col-md-6">
          <section>
          <h4 class="no-permalink"><a href="futures/"><img src="images/target.png" height="20" width="20">&nbsp;Asynchronous Programming: Futures</a></h4>
          <p>A first look at using Futures for asynchronous tasks.</p>
          <img src="images/futures-code.png">
          </section>
        </div>
          <section>
          <h4 class="no-permalink"><a href="streams/"><img src="images/target.png" height="20" width="20">&nbsp;Asynchronous Programming: Streams</a></h4>
          <p>Use streams to manage sequences of data.</p>
          <img src="images/streams-code.png">
          </section>
        <div class="col-md-6">
        </div>

      </div>
    </div>

  <!-- FORMS TAB -->
    <div class="tab-pane" id="forms">

      <div class="intro-para">
        Various classes in the Dart libraries help you get, send, receive,
        and save user data.
        You can use JSON to format data and HttpRequest to send requests and receive responses.
      </div>

      <div class="row">

        <!-- Fetch Data -->
        <div class="col-md-6">
          <section>
          <h4 class="no-permalink"><a href="fetchdata/"><img src="images/target.png" height="20" width="20">&nbsp;Fetch Data Dynamically</a></h4>
          <p>Load data from a static file or from a server.</p>
          <img style="border:1px solid black"
               src="images/allaboutyou-screenshot.png" width="300">
          </section>
        </div>

        <!-- Forms -->
        <div class="col-md-6">
        </div>
      </div> <!-- end row -->
    </div> <!-- end FORMS tab -->

    <!-- COMMAND-LINE APPS TAB -->
    <div class="tab-pane" id="commandline">

      <div class="intro-para">
        Dart isn't just for browser-based applications.
        You can write standalone programs, such as servers and scripts, in Dart.
      </div>

      <div class="row">

        <div class="col-md-6">
          <section>
          <h4 class="no-permalink"><a href="cmdline/"><img src="images/target.png" height="20" width="20">&nbsp;Write Command-line Apps</a></h4>
          <p>Learn about features that command-line apps need.</p>
          <img src="images/cmdline-code.png" width="100%">
          </section>
        </div>

        <div class="col-md-6">
          <section>
          <h4 class="no-permalink"><a href="/docs/tutorials/httpserver/"><img src="images/target.png" height="20" width="20">&nbsp;Write HTTP Clients & Servers</a></h4>
          <p>Communicate over the internet.</p>
          <img src="images/httpserver-code.png" width="100%">
          </section>
        </div>

      </div>


    </div>

  <!-- MOBILE TAB -->
  <!--
    <div class="tab-pane" id="mobile">
      <div class="row">

        <div class="col-md-6" style="border-right:1px solid Lavender">
          <section>
          <h4 class="no-permalink"><a href="mobile/"><img src="images/target.png" height="20" width="20">&nbsp;Write for Mobile Devices</a></h4>
          <p>Mobile devices are taking over the world!</p>
          <img src="images/xxx.png" width="300">
          </section>
        </div>

        <div class="col-md-6">
        </div>

      </div>
    </div>
  -->

  </div> <!-- end tab content-->
</div> <!--end tabbable -->
</div> <!-- end of tute-tabs -->

<hr style="border:solid;border-color:Gainsboro">

<aside class="alert alert-info" markdown="1">
<strong>Do you like to learn by doing?</strong> Try our code labs:

* [Avast, Ye Pirates: Write a Web App](/codelabs/darrrt/)
* [More code labs](/codelabs/)

</aside>

{% endcapture %}

{% include tutorial_main_page.html %}
