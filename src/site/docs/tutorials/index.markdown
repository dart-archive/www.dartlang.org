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
---

{% capture content %}

<img src="images/banner.png">

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
    <li><a href="#polymer" data-toggle="tab">Polymer</a></li>
    <li><a href="#forms" data-toggle="tab">Forms & Data</a></li>
    <!--<li><a href="#mobile" data-toggle="tab">Mobile</a></li>-->
  </ul>

  <div class="tab-content">

  <!-- BASICS TAB -->
    <div class="tab-pane active" id="basics">

      Download the software and
      discover which tools and libraries you get with the bundle.
      Run two sample apps.

      <div class="row">

        <!-- Getting Started -->
        <div class="col-md-6">
          <section>
          <h4 class="no-permalink"><a href="get-started/"><img src="images/target.png" height="20" width="20">&nbsp;Get started</a></h4>
            <p>Get Dart. Run two apps.
            </p>
          <img src="images/clickme-screenshot.png" width="300">
          </section>
        </div>
        <div class="col-md-6">
          <section>
            <h4 class="no-permalink">Get the sample code</h4>
            Before moving on,
            get the code for all the tutorials' samples.
            <ol>
              <li><a href="https://github.com/dart-lang/dart-tutorials-samples/archive/master.zip">
                    Download the ZIP file.
                  </a>
              </li>
              <li>
                Unzip it.
              </li>
              <li>
                Open the dart-tutorials-samples directory in Dart Editor.
              </li>
              <li>
                Go to the next tutorial,
                <a href="/docs/tutorials/connect-dart-html">
                  Connect Dart & HTML
                </a>.
              </li>
            </ol>
            </a>
          </section>
        </div>

      </div> <!-- end row -->
    </div> <!-- end Getting Started tab -->

  <!-- DOM TAB -->
    <div class="tab-pane" id="dom">

      Web pages are programmed in HTML and represented
      within the browser as a tree structure
      called the DOM (Document Object Model).
      Dart apps can modify the DOM programmatically,
      thus dynamically changing the web page.
      First, learn how to connect Dart and HTML.
      Then learn how to add, move, and remove DOM elements.

      <div class="row">
        <!-- Connect Dart & HTML -->
        <div class="col-md-6">
          <section>
          <h4 class="no-permalink"><a href="connect-dart-html/"><img src="images/target.png" height="20" width="20">&nbsp;Connect Dart &amp; HTML</a></h4>
            <p>Include a Dart script in an HTML page.
            </p>
          <img src="images/miniapp-screenshot.png" width="300">
          </section>
        </div>

        <!-- Add Elements -->
        <div class="col-md-6">
          <section>
          <h4 class="no-permalink"><a href="add-elements/"><img src="images/target.png" height="20" width="20">&nbsp;Add Elements to the DOM</a></h4>
          <p>Add elements to the web page and move them.</p>
          <img src="images/todo-screenshot.png" width="300">
          </section>
        </div>

      </div>


      <div class="row">
        <!-- Remove Elements -->
        <div class="col-md-6">
          <section>
          <h4 class="no-permalink"><a href="remove-elements/"><img src="images/target.png" height="20" width="20">&nbsp;Remove DOM Elements</a></h4>
          <p>Delete elements from the web page.</p>
          <img src="images/todo-with-delete-screenshot.png" width="300">
          </section>
        </div>
        <div class="col-md-6">
        </div>

      </div> <!-- end row -->
    </div> <!-- end DOM tab -->

  <!-- PACKAGES TAB -->
    <div class="tab-pane" id="packages">

      Dart developers have been busy creating code libraries that can help you be more productive.
      Leverage that code or put your code out in the world to share with others.

      <div class="row">

        <!-- Packages -->
        <div class="col-md-6">
          <section>
          <h4 class="no-permalink"><a href="shared-pkgs/"><img src="images/target.png" height="20" width="20">&nbsp;Install Shared Packages</a></h4>
          <p>Organize and share code at <a href="http://pub.dartlang.org/">pub.dartlang.org</a>.</p>
          <img src="images/add-packages-screenshot.png" width="300">
          </section>
        </div>
        <div class="col-md-6">

        </div>
      </div>
    </div> <!-- end Packages tab -->

  <!-- POLYMER TAB -->
    <div class="tab-pane" id="polymer">
      <div class="row">

        <div class="col-md-6">
          <section>
          <h4 class="no-permalink"><a href="polymer-intro/"><img src="images/target.png" height="20" width="20">&nbsp;Define a Custom Element</a></h4>
          <p>Create a custom HTML element using Polymer.</p>
          <img src="images/stopwatch-screenshot.png" width="200">
          </section>
        </div>

        <div class="col-md-6">
        </div>

      </div>
    </div>

  <!-- FORMS TAB -->
    <div class="tab-pane" id="forms">

      Various classes in the Dart libraries help you get, send, receive,
      and save user data.
      You can use input elements within forms to get data from users.
      You can use JSON to format data and HttpRequest to send requests and receive responses.
      And, finally, you can save data on the client with IndexedDB.

      <div class="row">

        <!-- Fetch Data -->
        <div class="col-md-6">
          <section>
          <h4 class="no-permalink"><a href="fetchdata/"><img src="images/target.png" height="20" width="20">&nbsp;Fetch Data Dynamically</a></h4>
          <p>Load data from a static file or from a server.</p>
          <img src="images/allaboutyou-screenshot.png" width="300">
          </section>
        </div>

        <!-- Forms -->
        <div class="col-md-6">
          <section>
          <h4 class="no-permalink"><a href="forms/"><img src="images/target.png" height="20" width="20">&nbsp;Get Input from a Form</a></h4>
          <p>Use forms and input elements to get data.</p>
          <img src="images/slambook-screenshot.png" width="300">
          </section>
        </div>
      </div> <!-- end row -->

      <div class="row">
        <!-- IndexedDB -->
        <div class="col-md-6">
          <section>
          <h4 class="no-permalink"><a href="indexeddb/"><img src="images/target.png" height="20" width="20">&nbsp;Use IndexedDB</a></h4>
          <p>Save data on the client with IndexedDB.</p>
          <img src="images/countdown-screenshot.png" width="300">
          </section>
        </div>
        <div class="col-md-6">
        </div>
      </div> <!-- end row -->
    </div> <!-- end FORMS tab -->

  <!-- MOBILE TAB -->
  <!--
    <div class="tab-pane" id="mobile">
      <div class="row">

        <div class="col-md-6" style="border-right:1px solid Lavender">
          <section>
          <h4 class="no-permalink"><a href="mobile/"><img src="images/target.png" height="20" width="20">&nbsp;Write for Mobile Devices</a></h4>
          <p>Mobile devices are taking over the world!</p>
          <img src="images/countdown-screenshot.png" width="300">
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

{% endcapture %}

{% include tutorial_main_page.html %}
