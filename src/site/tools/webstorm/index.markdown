---
layout: default
description: "Try WebStorm for developing Dart web apps."
has-permalinks: false
title: "WebStorm"
---

{% include toc.html %}
{% include breadcrumbs.html %}

# {{ page.title }}

WebStorm is an IDE from JetBrains for client-side development.
It comes with the Dart plugin pre-installed.

<aside class="alert alert-info" markdown="1">
**Note:**
If you're interested in using Dart
with another JetBrains IDE such as IntelliJ IDEA,
see the page [Dart Plugin from JetBrains](/tools/jetbrains-plugin/).
</aside>

## Getting started

To get started with WebStorm,
download it
and then tell it where to find the Dart SDK and
(optionally) Dartium.

### Downloading software

* [Download WebStorm](http://www.jetbrains.com/webstorm/download/) or,
  to try out the latest Dart language features,
  [download WebStorm EAP](https://confluence.jetbrains.com/display/WI/WebStorm+EAP)
* [Download the Dart SDK](/downloads/)
* [Download Dartium](/tools/dartium/) (optional)


### Configuring Dart support

Here's one way to configure Dart support in WebStorm:

<ol>
<li>
  <p>
    Create a new Dart project:
  </p>

  <ol type="a">
    <li> From the Welcome screen, click <b>Create New Project</b>. </li>
    <li> In the next dialog, click <b>Dart</b>.</li>
  </ol>
  </li>
</li>
<br>

<li>
  <p>
    If you don't see values for the <b>Dart SDK</b> path and
    (optional) <b>Dartium</b> path, enter them.
  </p>

  <p>
    For example, the SDK path might be
    <code><em>&lt;dart installation directory></em>/dart/dart-sdk</code>,
    and the Dartium path might be
    <code><em>&lt;dartium installation directory></em>/Chromium</code>.
  </p>

<aside class="alert alert-info" markdown="1">
  <b>Note:</b>
  The <b>Dart SDK</b> path specifies the directory that
  contains the SDK's `bin` and `lib` directories;
  the `bin` directory contains tools such as `dart` and `dart2js`.
  The <b>Dartium</b> path specifies the full path to the
  `Chromium` executable that contains the Dart VM.
  WebStorm ensures that the paths are valid.
</aside>
</li>
</ol>

An alternative to Step 1
is to open an existing Dart project,
and then open its `pubspec.yaml` file or any of its Dart files.


{% comment %}

NOTE TO EDITORS OF THIS FILE:
To reset to the initial WebStorm experience,
delete the IDE settings
by removing the directories specified in
https://www.jetbrains.com/webstorm/help/project-and-ide-settings.html.
On Mac, this worked for me:

rm -rf ~/Library/*/WebStorm10

{% endcomment %}


## Running a web app

To run a web app in Dartium, right-click the main HTML file
(for example, `web/index.html`),
and choose **Run 'index.html'**.

To run a web app in another browser (or in Dartium),
right-click the main HTML file
(for example, `web/index.html`)
and choose **Open in browser**.
Then choose the browser you want to run the app.
A browser window opens and,
after the app is compiled to JavaScript,
displays the app.


{% comment %}

## Creating an app from a template

## Debugging a web app

  PENDING: What other common tasks do we want to cover? Some guesses:
  * updating the Dart SDK
  * auto-completion?
  * updating the IDE?
  * updating the plugin?
{% endcomment %}


## Reporting issues

{% include tools/jetbrains-reporting-issues.html %}


## More information

See the JetBrains website for more information.

* [WebStorm](https://www.jetbrains.com/webstorm/)
  * [Getting started with Dart](https://confluence.jetbrains.com/display/WI/Getting+started+with+Dart)
  * [Features](https://www.jetbrains.com/webstorm/features/)
  * [Quick start](https://www.jetbrains.com/webstorm/quickstart/)
* [Dart Plugin by JetBrains](https://plugins.jetbrains.com/plugin/6351)
* [FAQ for Eclipse users migrating to WebStorm/IntelliJ](https://www.jetbrains.com/idea/documentation/migration_faq.html)
