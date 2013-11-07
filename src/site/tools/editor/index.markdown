---
layout: default
title: "Dart Editor"
description: "Get Dart Editor, a custom, powerful editor for Dart developers."
has-permalinks: false
js:
- url: /js/os-switcher.js
  defer: true
- url: /js/editor-downloads-analytics.js
  defer: true
- url: /js/editor-version.js
  defer: true
---

<div class="jumbotron">
  <div class="row">
    <div class="col-md-6">
      <h1> {{page.title}} </h1>
      <p>
        An open-source tool for editing, debugging, and running Dart applications.
      </p>
    </div>
    <div class="col-md-6">
      <iframe width="350" height="197" src="//www.youtube.com/embed/VQLdm8BY1Ao?vq=hd720" frameborder="0" allowfullscreen></iframe>
    </div>
  </div>
</div>

  
{% include toc.html %}


## Getting Dart Editor {#download}

<p>
Dart Editor is in the Dart download for
{% include os-choices.html %}
See <a href="/docs/dart-up-and-running/contents/ch01.html#ch01-editor">Up and Running</a>
for help with downloading and launching Dart Editor.
</p>

<p>
  {% include downloads/_dart-editor.html %}
</p>

<aside class="alert alert-info">
  <b> Problems? </b>
  See <a href="troubleshoot.html">Troubleshooting Dart Editor</a>.
</aside>

<p>
  {% include downloads/_dart-editor-continuous.html %}
</p>

<p>
The default version of Dart Editor
is the <em>stable build</em>.
It's automatically updated about once every six weeks.
The
<a target="_blank"
  href="{{ site.custom.downloads.dartarchive-stable-url-prefix }}/latest/changelog.html">change log</a>
has a list of release dates and features.
The <em>dev channel build</em>, on the other hand, is the
latest tested version of the Dart Editor which contains the newest features but may still contain some bugs.
If you use the dev channel build, please get new builds frequently,
and send feedback about new features and bugs that you encounter.
</p>


### Updating {#update}

<p>
  Dart Editor can automatically update itself,
  along with the SDK and Dartium,
  whenever a new integration build is available.
  To enable automatic updates,
  go to <b>Preferences</b>, choose <b>Update</b>, and
  select <b>Download updates automatically</b>.
</p>

<p>
  If you'd rather choose when to update,
  make sure <b>Download updates automatically</b> is not selected.
  Then when you're ready to update,
  use the <b>About Dart Editor</b> dialog
  to download and apply updates.
</p>


## Installing Dart Editor {#install}

<p>
  Unzip the file you downloaded. You're done!
</p>

<p>
  Want to use command-line tools, as well?
  You already have them, thanks to the Dart download including the SDK.
  However, you might want to set environment variables,
  as described in the <a href="/tools/sdk/">SDK page</a>.
</p>


## Using Dart Editor {#using}

To get started with Dart Editor,
read these:

[Get Started](http://www.dartlang.org/docs/tutorials/get-started/) (the first tutorial in the _Dart Tutorials_)
: Gently introduces you to Dart Editor,
  from downloading it to creating and running apps.

[Up and Running](/docs/dart-up-and-running/contents/ch01.html#ch01-editor) (a section from Chapter 1 of _Dart Up and Running_)
: Quickly leads you through downloading Dart Editor,
  running a sample,
  and creating an app.

For details on _using_ Dart Editor,
read this:

[Dart Editor](/docs/dart-up-and-running/contents/ch04-tools-editor.html) (a section from Chapter 4 of _Dart Up and Running_)
: Teaches how to use Dart Editor—for example,
  how to set up launches for different browsers.


## Customizing the build {#build}

You can add behavior to the Dart Editor build process
by creating a build.dart file.
For example,
Web UI uses a build.dart file to run custom tools over Dart and HTML files
and to map from the original files to the generated files.
See [Build.dart and the Dart Editor Build System](build.html)
for details on implementing your own build.dart file.


## Features {#features}

  <p>
    Dart Editor,
    with its static analysis engine
    and direct integration with Dartium,
    helps you develop, debug, and maintain your apps.
  </p>  

  <div class="row">
    <div class="col-md-12">
      <ul class="thumbnails">
        <li class="col-md-6">
          <div class="thumbnail">
            <img src="images/editor-code-completion.png" alt="Code completion in Dart Editor">
            <h5>Code completion</h5>
            <p>
              Explore the methods and fields
              available to the object you're working on.
            </p>
          </div>
        </li>

        <li class="col-md-6">
          <div class="thumbnail">
            <img src="images/editor-refactor.png" alt="Refactoring in Dart Editor">
            <h5>Refactoring</h5>
            <p>
              Change your code structure
              without changing the behavior.
            </p>
          </div>
        </li>
      </ul>
    </div>
  </div>

  <div class="row">
    <div class="col-md-12">
      <ul class="thumbnails">
        <li class="col-md-6">
          <div class="thumbnail">
            <img src="images/editor-outline.png" alt="Code completion in Dart Editor">
            <h5>Outline view</h5>
            <p>
              List the classes,
              methods, and functions
              in a simple tree display.
            </p>
          </div>
        </li>

        <li class="col-md-6">
          <div class="thumbnail">
            <img src="images/editor-debug.png" alt="Debugging in Dart Editor">
            <h5>Debugger</h5>
            <p>
              Set breakpoints, inspect variables,
              and step over, into, and out of code.
            </p>
          </div>
        </li>
      </ul>
    </div>
  </div>

  <div class="row">
    <div class="col-md-12">
      <ul class="thumbnails">

        <li class="col-md-6">
          <div class="thumbnail">
            <img src="images/editor-warnings.png" alt="Static analysis warnings in Dart Editor">
            <h5>Static analysis</h5>
            <p>
              See warnings when inconsistencies and potential problems are detected.
            </p>
          </div>
        </li>

        <li class="col-md-6">
          <div class="thumbnail">
            <img src="images/editor-callers.png" alt="Find callers for methods in Dart Editor">
            <h5>Find callers</h5>
            <p>
              Quickly find all callers for a method, and easily jump to those locations.
            </p>
          </div>
        </li>
      </ul>
    </div>
  </div>


## Filing bugs and feature requests {#bugs}

<p>
  Click the SEND FEEDBACK link
  (at the upper right of the Dart Editor window)
  whenever you notice a problem
  or have an idea for improving Dart Editor.
  We’ll open a new issue for you, if appropriate,
  without disclosing your sensitive or personally identifiable information.
</p>

<aside class="alert alert-info">
  <b>Tip:</b>
  If you'd like to talk with the Dart Editor team about your bug,
  <b>include your email address</b>.
</aside>

<p>
  To see existing issues or create a new one directly,
  go to the
  <a href="https://code.google.com/p/dart/issues/list?can=2&amp;q=label%3AArea-Editor">Dart Editor issue list</a>.
</p>


## Troubleshooting

[Troubleshooting Dart Editor](troubleshoot.html)
gives solutions to problems you might encounter
when installing and launching Dart Editor.

