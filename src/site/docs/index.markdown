---
layout: article
title: "Programmer's Guide"
description: "Documentation, references, and more about the Dart language, libraries, and tools."
has-permalinks: true
---

{% include docs_toc.html %}

# {{ page.title }}

This overview of Dart development
points you to docs, articles, and other resources
to help you as you create, test, and deploy Dart code.

## Getting started

Read these,
or just [download Dart](/#get-started)
and start playing with Dart Editor.

[Quick Start (_Dart: Up and Running_, Chapter 1)](/docs/dart-up-and-running/contents/ch01.html)
: A brief intro to Dart's history and features,
followed by instructions to help you get started with Dart Editor.

[Language Tour (_Dart: Up and Running_, Chapter 2)](/docs/dart-up-and-running/contents/ch02.html)
: Shows each major Dart language feature, from variables to
operators to classes and libraries.

[Dart Tutorials](/docs/tutorials/)
: Your step-by-step guide to building web apps using Dart.

## Tools

Thanks to Dart's tool friendliness,
you have many choices for editors, IDEs, and other tools.


When you [download Dart](/#get-started),
you get not only [Dart Editor](/tools/editor/), but also
[Dartium](/tools/dartium/) (a browser with built-in Dart support)
and the [Dart SDK](/tools/sdk/).
The SDK includes command-line tools such as
the Dart VM (dart), a Dart-to-JavaScript compiler (dart2js),
and a package manager (pub).

[Dart Editor](/tools/editor/)
: The easiest way to start writing Dart programs.

[Tools for Dart](/tools/)
: Information about tools,
plus links to downloads.


## Concepts

You don't need to follow all of these links right now,
but remember them for the future.


### Libraries

The Dart download includes several libraries.
You can also define your own libraries
and get many more using the
[pub package manager](http://pub.dartlang.org).

[Libraries and Visibility (a section of _Dart: Up and Running_, Chapter 2)](/docs/dart-up-and-running/contents/ch02.html#libraries)
: Learn how to use and create libraries. 

[Library Tour (_Dart: Up and Running_, Chapter 3)](/docs/dart-up-and-running/contents/ch03.html)
: Learn how to use the major features in each library that comes with Dart.

[Articles](/articles/)
: Look in the "Libraries and APIs" section
for help using individual packages, libraries, and APIs such as
[polymer.dart](/polymer-dart/),
[unittest](/articles/dart-unit-tests/),
and [Futures](/articles/using-future-based-apis/).

[API Reference](http://api.dartlang.org)
: Browse the full API reference docs for the Dart libraries.


### Fundamental classes

Many Dart methods return Iterable, Future, or Stream objects.


#### Iterable

An Iterable object is a collection of objects,
such as a list or set.
Closely tied to the Dart language,
the Iterable class provides the interface used by for-in loops.
Learn more:

* [Collections (a section of _Dart: Up and Running_, Chapter 3)](/docs/dart-up-and-running/contents/ch03.html#ch03-collections)
* [Iteration (a section of _Dart: Up and Running_, Chapter 3)](/docs/dart-up-and-running/contents/ch03.html#ch03-iteration)
* [Iterables (an article for the M3 update to the Iterable API)](/articles/m3-whats-new/iterables.html)
* [Iterable API documentation](http://api.dartlang.org/dart_core/Iterable.html)


#### Future

A Future object represents a value to be delivered in the future.
For example, the dart:io File class's readAsString() method
returns a Future&lt;String>,
which you can use to get the file's entire contents as a string.
Learn more:

* [Using Future Based APIs](/articles/using-future-based-apis/)
* [Futures and Error Handling](/articles/futures-and-error-handling/)
* [Future API documentation](http://api.dartlang.org/dart_async/Future.html)


#### Stream

A Stream object represents a sequence of data
to be delivered in the future.
One example of a stream is the onClick stream of events
for a dart:html button.
Another example is the file content stream returned by
the dart:io File class's openRead() method.
Learn more:

* [Getting Your Feet Wet with Streams](/articles/creating-streams/)
* [Creating Streams in Dart](/articles/feet-wet-streams/)
* [Stream API documentation](http://api.dartlang.org/dart_async/Stream.html)


## Creating web apps

If you're new to web apps,
start with the <a href="/docs/tutorials/">Dart Tutorials</a>&mdash;a
of tutorials that teach you how to use Dart to write web apps,
assuming no previous experience with either Dart or web apps.

While you're developing your web app,
you can run it in Dartium.
Later, you can compile your app to JavaScript
and run it in other browsers.

Two libraries are important for creating web apps:
dart:html and the polymer.dart package.
You don't need to use polymer.dart,
but it's a great way to simplify your code.


### dart:html

A basic, yet Darty, interface to the browser.

* [Connect Dart &amp; HTML](/docs/tutorials/connect-dart-html/)
  (part of the Dart tutorials)
* [Improving the DOM](/articles/improving-the-dom/)
* [dart:html API documentation](http://api.dartlang.org/dart_html.html)
* [HTML DOM](/docs/cookbook/#html-dom)
  (recipes in the Dart Cookbook)

### polymer.dart

A package that lets you use tomorrow's web APIs today.

* [polymer.dart](/polymer-dart/)
* [pub.dartlang.org/packages/polymer](http://pub.dartlang.org/packages/polymer)
* [Upgrading to polymer.dart from Web UI](/polymer-dart/upgrading-to-polymer-from-web-ui.html)

### Dart and JavaScript

You aren't limited to Dart libraries.
With the js package,
you can use JavaScript libraries in your Dart app.

* [Using JavaScript from Dart: The js Library](/articles/js-dart-interop/)
* [pub.dartlang.org/packages/js](http://pub.dartlang.org/packages/js)


## Creating command-line apps

You can use Dart for anything from scripts to web servers.
Thanks to Heroku's support for third-party runtimes,
you can run your server-side Dart app on Heroku's cloud. 

* [dart: The Standalone VM](/docs/dart-up-and-running/contents/ch04-tools-dart-vm.html)
* [Heroku cloud application platform](http://www.heroku.com) 

## Testing

A static analyzer and unit testing library
provide support for testing your web or command-line app.
If your code is open source,
try drone.io for continuous testing.

* [dartanalyzer: The Static Analyzer](/docs/dart-up-and-running/contents/ch04-tools-dart_analyzer.html)
* [Writing Unit Tests for Pub Packages](/articles/writing-unit-tests-for-pub-packages/)
* [Unit Testing with Dart](/articles/dart-unit-tests/)
* [Testing](/docs/cookbook/#testing)
  (recipes in the Dart Cookbook)
* [drone.io](http://drone.io)

## Other resources

When you have a question or find a problem,
try these resources.


### Programming questions

Two great resources for all kinds of programming questions:

* [Dart Cookbook](/docs/cookbook/)
* [Stack Overflow](http://stackoverflow.com/questions/tagged/dart)

Or try a <a href="/support/">mailing list</a>.


### Style

Whenever possible, follow the practices
recommended in these documents:

* [Idiomatic Dart](/articles/idiomatic-dart/)
* [Dart Style Guide](/articles/style-guide/)
* [Guidelines for Dart Doc Comments](/articles/doc-comment-guidelines/)

### Issues and feature requests

If you think you've found a bug,
check the list of Dart issues to see whether
the problem has already been reported
and has a workaround.

To request a feature, you can create an issue
or start a discussion on the appropriate
[mailing list](/support/).

* [Dart issues](http://code.google.com/p/dart/issues/list)

