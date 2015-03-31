---
layout: default
title: "Dart Editor"
description: "Get Dart Editor, a custom, powerful editor for Dart developers."
has-permalinks: false
---

{% include toc.html %}
{% include breadcrumbs.html %}
  
# {{ page.title }}

For an overview, watch this short video on how to use Dart Editor.

<iframe style="display:block;margin: 0 auto;" width="560" height="315"
    src="//www.youtube.com/embed/VQLdm8BY1Ao?vq=hd720" frameborder="0"
    allowfullscreen></iframe>

<p></p>
<aside class="alert alert-info" markdown="1">
**Support for new language features:**
To use new language support for asynchrony (such as async functons
and await expressions) or for enumerated types, you must opt in.
For more information, see
[the troubleshooting page](troubleshoot.html#new-features).
</aside>

## Installing Dart Editor

[Download Dart Editor](/downloads/), if you haven't already.

Dart Editor requires the Java runtime.
[Download the JRE](http://www.oracle.com/technetwork/java/javase/downloads/),
if needed. Dart Editor requires JRE 6.0 or later.

<aside class="alert alert-info" markdown="1">
**Problems?**
See [Troubleshooting Dart Editor](troubleshoot.html).
</aside>

{% comment %}
However, you might want to set environment variables,
as described in the [SDK page](/tools/sdk/).
{% endcomment %}

The default version of Dart Editor is the _stable build_.
It's automatically updated about once every six weeks. The
<a target="_blank"
  href="{{ site.custom.downloads.dartarchive-stable-url-prefix }}/latest/changelog.html">change log</a>
has a list of release dates and features.

The _dev channel build_, on the other hand, is the
latest tested version of the Dart Editor which contains the newest
features but may still contain some bugs.
If you use the dev channel build, please get new builds frequently,
and send feedback about new features and bugs that you encounter.

<aside class="alert alert-info" markdown="1">
Want to use the command-line tools, as well?
You already have them, thanks to the Dart download including the
[SDK](/tools/sdk/).
</aside>

## Updating Dart Editor

Dart Editor can automatically update itself,
along with the SDK and Dartium,
whenever a new integration build is available.
To enable automatic updates,
go to **Preferences**, choose **Update**, and
select **Download updates automatically**.

If you'd rather choose when to update,
make sure **Download updates automatically** is not selected.
Then when you're ready to update,
use the **About Dart Editor** dialog
to download and apply updates.

## Using Dart Editor

To get started with Dart Editor, read these:

* [Get Started](http://www.dartlang.org/docs/tutorials/get-started/)
   (the first tutorial in the _Dart Tutorials_)<br>
   Gently introduces you to Dart Editor,
   from downloading it to creating and running apps.

* [Up and Running](/docs/dart-up-and-running/ch01.html#up-and-running)
  (a section from Chapter 1 of _Dart Up and Running_)<br>
  Quickly leads you through downloading Dart Editor, running a sample,
  and creating an app.

For details on _using_ Dart Editor, read this:

* [Tips for Using Dart Editor](using.html)<br>
  Teaches how to use Dart Editor&mdash;for example,
  how to set up launches for different browsers.

## Features

Dart Editor, with its static analysis engine
and direct integration with Dartium,
helps you develop, debug, and maintain your apps.

<div class="container-fluid" markdown="1">
<div class="row" markdown="1">
<div class="col-md-6" markdown="1">
<div class="thumbnail" markdown="1">
<img src="images/editor-code-completion.png" width="100%"
     alt="Code completion in Dart Editor" />

**Code completion**

Explore the methods and fields
available to an object.
</div></div>

<div class="col-md-6" markdown="1">
<div class="thumbnail" markdown="1">
<img src="images/editor-refactor.png" width="100%"
     alt="Refactoring in Dart Editor"/>

**Refactoring**

Change your code structure without changing the behavior.
</div></div></div>

<div class="row" markdown="1">
<div class="col-md-6" markdown="1">
<div class="thumbnail" markdown="1">
<img src="images/editor-outline.png" width="100%"
     alt="Code completion in Dart Editor" />

**Outline view**

List the classes, methods, and functions in a simple tree display.
</div></div>

<div class="col-md-6" markdown="1">
<div class="thumbnail" markdown="1">
<img src="images/editor-debug.png" width="100%"
     alt="Debugging in Dart Editor">

**Debugger**

Set breakpoints, inspect variables, and step over, into, and out of code.
</div></div></div>

<div class="row" markdown="1">
<div class="col-md-6" markdown="1">
<div class="thumbnail" markdown="1">
<img src="images/editor-warnings.png" width="100%"
     alt="Static analysis warnings in Dart Editor">

**Static analysis**

See warnings when inconsistencies and potential problems are detected.
</div></div>

<div class="col-md-6" markdown="1">
<div class="thumbnail" markdown="1">
<img src="images/editor-callers.png" width="100%"
     alt="Find callers for methods in Dart Editor">

**Find callers**

Quickly find all callers for a method, and easily jump to these locations.
</div></div></div></div>

## Customizing the build

You can add behavior to the Dart Editor build process
by creating a build.dart file. 
See [Build.dart and the Dart Editor Build System](build.html)
for details on implementing your own build.dart file.

<aside class="alert alert-info" markdown="1">
**Note**:
For the most part, `build.dart` has been replaced by pub transformers.
Pub uses transformers to transform a package's assets before serving the app.

To learn how to use transformers, see
[Assets and Transformers](/tools/pub/assets-and-transformers.html).
To learn how to write a transformer, see
[Writing a Pub Transformer](/tools/pub/transformers/).
</aside>

## Filing bugs and feature requests

Click the SEND FEEDBACK link
(at the upper right of the Dart Editor window)
whenever you notice a problem
or have an idea for improving Dart Editor.
We’ll open a new issue for you, if appropriate,
without disclosing your sensitive or personally identifiable information.

<aside class="alert alert-info" markdown="1">
**Tip:**
If you'd like to talk with the Dart Editor team about your bug,
**include your email address**.
</aside>

To see existing issues or create a new one directly, go to the
[Dart Editor issue list](https://code.google.com/p/dart/issues/list?can=2&amp;q=label%3AArea-Editor).

## Troubleshooting

[Troubleshooting Dart Editor](troubleshoot.html)
gives solutions to problems you might encounter
when installing, launching, and using Dart Editor.

