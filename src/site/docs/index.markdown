---
layout: default
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
or just start playing in
<a href="{{site.custom.dartpad.direct-link}}"
   target="_blank">DartPad</a>.

[Avast, Ye Pirates: Write a Web App](/codelabs/darrrt/)
: Walks you through building a web app, using DartPad.
This one-hour code lab assumes you have some programming experience
but no previous experience with either Dart or web apps.

[Beware the Nest o’ Pirates: Write a Server App](https://dart-lang.github.io/server/codelab/)
: Walks you through creating a RESTful web server
using the Dart SDK.
This one-hour code lab assumes no previous experience with
servers or web apps.

[Dart Tutorials](/docs/tutorials/)
: Your step-by-step guide to using Dart.

[A Tour of the Dart Language](/docs/dart-up-and-running/ch02.html) (the language tour)
: Shows each major Dart language feature, from variables to
operators to classes and libraries.

[A Tour of the Dart Libraries](/docs/dart-up-and-running/ch03.html) (the library tour)
: Introduces you to the dart:* libraries, covering
dart:core, dart:async, dart:html, dart:io, and more.


## Creating web apps

If you're new to web apps,
start with the <a href="/docs/tutorials/">Dart Tutorials</a>&mdash;a
set of tutorials that assume no previous experience with
either Dart or web apps.

While you're developing your web app,
you can run it in Dartium.
Later, you can compile your app to JavaScript
and run it in other browsers.

When creating web apps, you can use
dart:html and the polymer.dart package
or AngularDart.
Although you don't need to use polymer.dart or AngularDart,
they're great ways to simplify your code.


### dart:html

A basic, yet Darty, interface to the browser.

* [Connect Dart &amp; HTML](/docs/tutorials/connect-dart-html/)
  (part of the Dart tutorials)
* [Improving the DOM](/articles/improving-the-dom/)
* [dart:html API documentation](http://api.dartlang.org/dart_html.html)

### Polymer.dart

A package that lets you use tomorrow's web APIs today.

* [Polymer.dart homepage](/polymer/)
* [pub.dartlang.org/packages/polymer](https://pub.dartlang.org/packages/polymer)
* [Samples that use polymer.dart](/samples/#polymer_dart)

### AngularDart

A port of the Angular framework to Dart.

* [AngularDart tutorial](https://github.com/angular/angular.dart.tutorial/wiki)
* [pub.dartlang.org/packages/angular](https://pub.dartlang.org/packages/angular)
* [Samples that use AngularDart](/samples/#angular_dart)


{% comment %}
[PENDING: bring back when new js interop is ready]
### Dart and JavaScript

You aren't limited to Dart libraries.
With the dart:js library,
you can use JavaScript libraries in your Dart app.

* [dart:js API documentation](http://api.dartlang.org/dart_js.html)
* [Samples that use JavaScript](/samples/#using_javascript_from_dart)
{% endcomment %}


## Creating command-line apps

You can use Dart for anything from scripts to web servers.

[Dart on the Server](https://dart-lang.github.io/server/)
: Provides a set of samples, tutorials, and articles that
explain the APIs, tools, and techniques for writing and
deploying command-line apps such as servers and scripts.

[Dart and Google Cloud Platform](https://dart-lang.github.io/server/google-cloud-platform/)
: Has information on using Dart with Google's infrastructure,
such as App Engine Managed VMs.


## Tools

Thanks to Dart's tool friendliness,
you have many choices for editors, IDEs, and other tools.
Here are the tools you're likely to want,
once you're ready to move beyond DartPad:

[Dart SDK](/tools/sdk/)
: The libraries and command-line tools you need for Dart development.
  Includes the Dart VM (dart), a Dart-to-JavaScript compiler (dart2js),
  and a package manager (pub).

[Dartium](/tools/dartium/) (optional)
: A development browser with built-in Dart support.

An IDE or code editor with a Dart plugin (optional)
: If you don't already have a favorite IDE or code editor,
  we recommend trying [WebStorm](/tools/webstorm/),
  which has a built-in Dart plugin.

See [Dart Tools](/tools/) for links to more information and
plugin downloads.


## Testing

A static analyzer and testing library
provide support for testing your web or command-line app.
If your code is open source,
try drone.io for continuous testing.

* [dartanalyzer: The Static Analyzer](/tools/analyzer)
* [testing library](https://pub.dartlang.org/packages/test)
* [drone.io](http://drone.io)

## Other resources

When you have a question or find a problem,
try these resources.


### Best practices

Whenever possible, follow the practices
recommended in this guide:

* [Effective Dart](/effective-dart/)


### Programming questions

Ask specific programming questions here:

* [Stack Overflow](http://stackoverflow.com/questions/tagged/dart)


### Issues and feature requests

If you think you've found a bug,
check the list of [Dart issues](http://dartbug.com)
to see whether
the problem has already been reported
and has a workaround.

To request a feature, you can create an issue
or start a discussion on the appropriate
[mailing list](/support/).

