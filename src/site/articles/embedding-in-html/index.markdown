---
layout: default
title: "Embedding Dart in HTML"
description: "Find out how you can embed Dart into HTML pages."
has-permalinks: true
rel:
  author:
    - sigmund-cherem
    - vijay-menon
    - seth-ladd
---

# Embedding Dart in HTML

<p>
<em>Written by Sigmund Cherem, Vijay Menon, and Seth Ladd <br>
October 2011
(updated November 2012)</em>
</p>

Dart apps compile to JavaScript to run across modern desktop and mobile
browsers. Dart apps can also run inside a Dart virtual machine (VM), which can be
embedded into web browsers.

This article covers how to integrate Dart apps into web pages, when first
compiled to JavaScript or when run in the Dart VM.

#### Contents

1. [Quick start](#quick-start)
1. [Dart MIME type and the &lt;script&gt; tag](#dart-mime-type)
1. [The dart.js script](#dartjs-script)
1. [Fundamental differences from JavaScript](#fundamental-differences-from-javascript)
{: .toc}

## Quick start

1. Compile your Dart app to JavaScript with [dart2js](/docs/dart2js/).
   If your Dart file is `app.dart` then name your JavaScript version `app.dart.js`.
1. Load your Dart app with a `<script type="application/dart">` tag (only one per HTML page).
1. Follow that tag with a &lt;script&gt; tag for the `dart.js` file.

Here is a minimal example, which works in all browsers (even if they don't
  support the Dart VM):

{% highlight dart %}
<!DOCTYPE html>
<html>
  <head>
    <title>Simple Dart App</title>
  </head>
  <body>
    <h1>Hello, Dart!</h1>
    <script type="application/dart" src="app.dart"></script>
    <script type="text/javascript" src="dart.js"></script>
  </body>
</html>
{% endhighlight %}

Your Dart app's `main()` function is run after DOM content is loaded.

## Dart MIME type and the &lt;script&gt; tag
{:#dart-mime-type}

HTML `script` tags provide a
`type` attribute to define the language of the script.
For Dart, this attribute has the value `application/dart`.

Here is an example:

{% highlight html %}
<script type="application/dart" src="app.dart"></script>
{% endhighlight %}

Dart doesn't support inline scripts (scripts defined inside the HTML page).
While an inline script technically works in Dartium (a build of Chromium
with the Dart VM), the Dart-to-JavaScript compiler (dart2js) doesn't work with inline
scripts.

The Dart app must have a visible top-level function called `main()`.
The browser invokes `main()` when the DOM content is loaded.

You should use only one `<script type="application/dart">` inside the HTML
page. The dart2js compiler produces JavaScript that assumes it is
the only Dart app on the page.

## The dart.js script
{:#dartjs-script}

Use the dart.js script to start the Dart VM (if it exists) and to run your app
in browsers that don't have a Dart VM. The dart.js script allows you to use the
same HTML page for both Dartium and other browsers.

If no Dart VM is detected in the browser, the dart.js script swaps out the
`application/dart` script for a
`text/javascript` script that points to the JavaScript version of the
Dart app.

The dart.js script tag must come after the Dart script tag.

For example:

{% highlight html %}
<script type="application/dart" src="awesome_app.dart"></script>
<script type="text/javascript" src="dart.js"></script>
{% endhighlight %}

You can download a copy of dart.js from
[https://dart.googlecode.com/svn/branches/bleeding_edge/dart/client/dart.js](https://dart.googlecode.com/svn/branches/bleeding_edge/dart/client/dart.js). We expect to provide
this script via a pub package in the future.

## Fundamental differences from JavaScript

Embedding Dart code is different from embedding JavaScript
in a few ways.

### A single script tag

Each HTML page can have at most one Dart script tag, or only one
script tag that references a Dart app that is compiled to JavaScript.
This fundamentally differs from the way
that JavaScript is embedded in HTML&mdash;in
JavaScript, you can have multiple script tags per page.

In JavaScript, additional script tags are used to import third party libraries
(e.g., jQuery).  In Dart, this is not necessary: import is part of the language.

### Delayed execution

Unlike in JavaScript,
top-level Dart constructs (such as interfaces, classes, and functions)
are declarative.
Each Dart application (defined via a script tag)
provides an explicit `main()` entry point
that is invoked by the browser when it is ready to run.

By default, the Dart app's `main()` function
is invoked after the page's DOM is loaded.

### No inline event listeners

We disallow inline event listeners of the form:

{% highlight html %}
<div onclick="foo()">Click this text.</div>
{% endhighlight %}

With JavaScript, programmers can embed inline event listener code
directly onto HTML nodes.
However, this is typically discouraged in modern JavaScript applications.
HTML pages generally render more quickly
if listeners are added programmatically afterwards.
Modern security guidelines also discourage inline code.
As such, we propose to not allow inline Dart listeners.

### No script injection of Dart code

We do not support dynamically injecting a `<script>` tag that loads Dart
code. Recent browser security trends, like Content Security Policy, actively
prevent this practice.
