---
layout: default
title: "dart2js: The Dart-to-JavaScript Compiler"
description: "Use dart2js, the Dart to JavaScript compiler, to
enable your Dart web apps to work on all modern browsers."
has-permalinks: true
---

# {{ page.title }}

This page tells you how to use the _dart2js_ tool
to compile Dart code to JavaScript.
Dart Editor uses dart2js behind the scenes whenever
[Dart Editor compiles to JavaScript](/docs/editor/#dart2js).

The `bin/dart2js` executable is in the [Dart SDK](/docs/sdk/).
You can either [download the SDK separately](/docs/sdk/#download)
or get it as part of the [Dart Editor package](/docs/editor/#download).

## Basic usage

Here's an example of compiling a Dart file to JavaScript:

{% prettify %}
$DART_SDK/bin/dart2js test.dart
{% endprettify %}

This command produces a `.js` file
that contains the JavaScript equivalent of your Dart code.

## Options

Common command-line options for dart2js include:

-o_&lt;file&gt;_
: Generate the output into _&lt;file&gt;_.

-c
: Insert runtime type checks and enable assertions (checked mode).

-h
: Display this message (add -v for information about all options).
