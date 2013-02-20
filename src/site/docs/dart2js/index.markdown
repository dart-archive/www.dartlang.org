---
layout: default
title: "dart2js: The Dart-to-JavaScript Compiler"
description: "Use dart2js, the Dart to JavaScript compiler, to
enable your Dart web apps to work on all modern browsers."
has-permalinks: true
---

# {{ page.title }}

The _dart2js_ tool compiles Dart code to JavaScript,
allowing Dart apps to run in browsers that don't have Dart VMs.
Dart Editor uses dart2js behind the scenes whenever
[Dart Editor compiles to JavaScript](/docs/editor/#dart2js).

The JavaScript produced by dart2js runs in modern browsers, including:

* Internet Explorer 9 and 10
* Safari
* Firefox
* Chrome
* iOS Safari
* Chrome for Android

For Safari, Firefox, and Chrome, the generated JavaScript runs in
the most current stable version of the browser,
as well as the previous major version.

The `bin/dart2js` executable is in the [Dart SDK](/docs/sdk/).
You can either [download the SDK separately](/docs/sdk/#download)
or get it as part of the [Dart Editor package](/docs/editor/#download).

For details on using dart2js, see
_Dart: Up and Running_'s
[dart2js section](http://www.dartlang.org/docs/dart-up-and-running/contents/ch04-tools-dart2js.html).