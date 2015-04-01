---
layout: default
title: "Dart SDK"
description: "Dart libraries and command-line tools."
has-permalinks: false
---

{% include toc.html %}
{% include breadcrumbs.html %}

# {{ page.title }}

The Dart SDK has the libraries and command-line tools
that you need to develop Dart applications.
To learn about other tools you can use for Dart development,
see [Dart Tools](/tools/).

## Getting the SDK

If you have an up-to-date version of [Dart Editor](/tools/editor/),
you already have the SDK.
It's in the `dart-sdk` subdirectory
of the Dart installation directory.

Otherwise, you can 
[download the SDK](/downloads/) directly.

## What's in the SDK

The SDK directory includes a `lib` directory for the
[Dart libraries](/docs/dart-up-and-running/ch03.html)
and a `bin` directory that has these command-line tools:

<div class="row"> <div class="col-md-6" markdown="1">

[dart](/tools/dart-vm/)
: The standalone VM

[dart2js](/tools/dart2js/)
: The Dart-to-JavaScript compiler

[dartanalyzer](/tools/analyzer/)
: The static analyzer

</div> <div class="col-md-6" markdown="1">

[dartdocgen](/tools/dartdocgen/)
: The API documentation generator

[pub](/tools/pub/)
: The Dart package and asset manager

[dartfmt](/tools/dartfmt/)
: The Dart code formatter

</div> </div>

For more information about the SDK, see its
[README file](https://raw.github.com/dart-lang/bleeding_edge/master/dart/README.dart-sdk).

## Installing the SDK

Unzip the SDK download file. Dart is installed!

<aside class="alert alert-info" markdown="1">
**Note for Linux users:** If your system uses an older
version of Ubuntu and you are compiling the SDK,
you may need to update to GCC 4.6 or later.
See the [Tools FAQ](../faq.html) for more information.
</aside>

## Filing bugs and feature requests

To see existing issues or create a new one,
go to [dartbug.com](http://dartbug.com).
Here are some handy searches:

* [dart (VM) issues](https://code.google.com/p/dart/issues/list?can=2&amp;q=label%3AArea-VM)
* [dart2js issues](https://code.google.com/p/dart/issues/list?can=2&amp;q=label%3AArea-Dart2JS)
* [dartanalyzer issues](https://code.google.com/p/dart/issues/list?can=2&amp;q=label%3AArea-Analyzer)
* [dartdocgen issues](https://code.google.com/p/dart/issues/list?can=2&amp;q=label%3AArea-DartDoc)
* [pub issues](https://code.google.com/p/dart/issues/list?can=2&amp;q=label%3AArea-Pub)
* [issues for the SDK as a whole](https://code.google.com/p/dart/issues/list?can=2&amp;q=label%3AArea-SDK)
