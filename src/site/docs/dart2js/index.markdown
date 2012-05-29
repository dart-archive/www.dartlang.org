---
layout: default
title: "dart2js: The Dart to JavaScript Compiler"
description: "Use dart2js, the Dart to JavaScript compiler. Your Dart web apps can work on all modern browsers, thanks to dart2js."
---

# {{ page.title }}

Find the dart2js tool in the [Dart SDK](/docs/sdk/).

To compile a Dart file to JavaScript, use `bin/dart2js`.
For example:

{% pretty_code console 0 %}
$DART_SDK/bin/dart2js test.dart
{% endpretty_code %}

This command produces a `.js` file
that contains the JavaScript equivalent of your Dart code.

## Command-line options

Common command-line options for dart2js include:

-o &lt;file&gt;
: Generate the output into &lt;file&gt;

-c
: Insert runtime type checks and enable assertions (checked mode).

-h
: Display this message (add -v for information about all options).


<aside class="note">
<b>What happened to frog?</b>
frog was a previous version of a Dart-to-JavaScript
compiler. It has been deprecated and replaced by dart2js.
</aside>

{% include syntax-highlighting.html %}