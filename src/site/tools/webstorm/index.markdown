---
layout: default
description: "Use Dart with a variety of IDEs and editors from JetBrains."
has-permalinks: false
title: "Dart Plugin from JetBrains"
---

{% include toc.html %}
{% include breadcrumbs.html %}

# {{ page.title }}

The Dart plugin adds Dart support to JetBrains IDEs such as
WebStorm and IntelliJ IDEA.
WebStorm is an IDE for client-side development.
IntelliJ IDEA is an intelligent Java IDE
with support for many other languages and frameworks.

Whichever JetBrains IDE you choose for Dart development,
this page has resources to help you get started quickly
and find more information when you need it.


## Getting started

The Dart plugin is built into WebStorm,
but not into IntelliJ IDEA.
Once your IDE has the Dart plugin,
you just need to tell it where to find the Dart SDK and
(optionally) Dartium.


### Downloading the IDE

Before starting, download a JetBrains IDE if you don't already have one:

* <a target="_blank"
     href="http://www.jetbrains.com/webstorm/download/">Download WebStorm</a>
  <br>_or_
* <a target="_blank"
     href="http://www.jetbrains.com/idea/download/">Download IntelliJ IDEA</a>

<aside class="alert alert-info" markdown="1">
  **Note:**
  The Community Edition of IntelliJ IDEA has limited functionality.
  For example, it doesn't support debugging web apps.
  It also has very little support for JavaScript, HTML, CSS, and YAML.
</aside>


### Downloading the Dart SDK

If you don't already have the Dart SDK,
you need to download it.
If you're using Dart to develop web apps,
we recommend downloading Dartium, as well.

* [Download the Dart SDK](/downloads/)
* [Download Dartium](/tools/dartium/) (optional)


### Configuring Dart support

Here's one way to configure Dart support:

<ol>
<li>
  <p>
    <b>IntelliJ IDEA only:</b>
    Start IntelliJ IDEA, and install the <b>Dart</b> plugin.
    To find the Dart plugin, from the Welcome screen
    choose <b>Configure > Plugins</b>,
    then click <b>Install JetBrains plugin</b>,
    and then search or scroll down until you find <b>Dart</b>.
    Once you've installed the Dart plugin, restart IntelliJ IDEA.
  </p>
</li>

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
  The IDE ensures that the paths are valid.
</aside>
</li>
</ol>

An alternative to Step 2 is to open an existing Dart project,
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

<aside class="alert alert-info" markup="1">
  **Workaround:**
  The first time you try to run a Dart web app
  after starting the IDE,
  you might get an error from Pub Serve with the message
  "Failed to create server socket (OS Error: Address already in use, errno = 48)".
  Eventually the browser window displays "502 Bad Gateway".

  Run the app again, and it should work.
  See [issue WEB-16199](https://youtrack.jetbrains.com/issue/WEB-16199)
  for more information.
</aside>


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

Please report issues and feedback via the official
[JetBrains issue tracker for Dart](https://youtrack.jetbrains.com/issues/WEB?q=Subsystem%3A+Dart).
Include details of the expected behavior, the actual behavior,
and screenshots if appropriate.

Your questions are welcome in the
[Dart plugin for WebStorm/IntelliJ editors mailing list](https://groups.google.com/a/dartlang.org/forum/#!forum/jetbrains-dart-plugin-discuss).


## More information

See the JetBrains website for more information.

* [WebStorm](https://www.jetbrains.com/webstorm/)
  * [Getting started with Dart](https://confluence.jetbrains.com/display/WI/Getting+started+with+Dart)
  * [Features](https://www.jetbrains.com/webstorm/features/)
  * [Quick start](https://www.jetbrains.com/webstorm/quickstart/)
* [IntelliJ IDEA](https://www.jetbrains.com/idea/)
  * [Dart support](https://www.jetbrains.com/idea/help/dart-support.html)
  * [Features](https://www.jetbrains.com/idea/features/)
  * [Quick start](https://www.jetbrains.com/idea/help/intellij-idea-quick-start-guide.html)
* [Dart Plugin by JetBrains](https://plugins.jetbrains.com/plugin/6351)
* [FAQ for Eclipse users migrating to WebStorm/IntelliJ](https://www.jetbrains.com/idea/documentation/migration_faq.html)
