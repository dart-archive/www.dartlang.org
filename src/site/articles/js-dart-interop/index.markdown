---
layout: default
title: "Using JavaScript from Dart"
description: "An introduction to Dart-JavaScript interoperatibility."
has-permalinks: true
article:
  written_on: 2013-11-20
  collection: libraries-and-apis
---

{% include toc.html %}
{% include breadcrumbs.html %}

# {{ page.title }}

As of the 1.13 release,
use [package:js](https://pub.dartlang.org/packages/js)
to implement Dart-JavaScript interoperability.
The [chartjs](https://github.com/google/chartjs.dart/) example provides
an end-to-end example of using package:js.

The `dart:js` library is no longer recommended for use in new code.
