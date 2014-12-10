---
layout: default
title: "dartanalyzer: The Static Analyzer"
short-title: "dartanalyzer"
description: "The Dart tool for analyzing your Dart source from the command line."
has-permalinks: false
---

{% include toc.html %}
{% include breadcrumbs.html %}

# {{ page.title }}

You can use the *dartanalyzer* tool (`bin/dartanalyzer`) to statically
analyze your code at the command line, checking for errors and warnings
that are specified in the [Dart Language Specification](/docs/spec/).
Dart Editor performs the same analysis that dartanalyzer does.

<aside class="alert alert-info" markdown="1">
**Support for new language features:**
To use the dart tool with code that uses language support for asynchrony
(such as async functions and await expressions) or enumerated types,
you must opt in.

For code that uses asynchrony, specify the `--enable-async` flag.
For code that uses enumerated types, specify the `--enable-enum` flag.
</aside>

## Basic usage

Here’s an example of testing a Dart file:

{% prettify sh %}
dartanalyzer --package-root=code/packages test.dart
{% endprettify %}

As the following table shows,
the exit code of dartanalyzer tells you whether the code
passed analysis.

|-----------+--------------------------------
| Exit code | Description
|-----------+--------------------------------
| 0         | No issues found
| 1         | Warnings found (but no errors)
| 2         | Errors found
{:.table .table-striped}


## Options

You can use the following command-line options with dartanalyzer:

{% comment %}
{NOTE:
I'm still not documenting --perf. It's displayed by --help but seems of
limited use to most developers. I'm also not documenting the following,
which I got from sdk/bin/dartanalyzer or pkg/analyzer/lib/options.dart
but aren't displayed by help: -batch|--batch|-b (though -b doesn't seem
to be treated specially by the script), --ignore-unrecognized-flags
(doesn't seem to change the output), --fatal-warnings, --warnings (only
for SDK developers?), --show-sdk-warnings (deprecated)}
{% endcomment %}

`--dart-sdk=`
: Specify the directory that contains the Dart SDK.

`-p` *or* `--package-root=`
: Specify the directory to search for any libraries that are imported
  using `package:`.

`--package-warnings`
: Show warnings not only for code in the specified .dart file and
  others in its library, but also for libraries imported with
  `package:`.

`--enable-async`
: Enable using async functions and await expressions. For more
  information on these features, see
  [Asynchrony support](/docs/dart-up-and-running/ch02.html#asynchrony).

`--enable-enum`
: Enable using enumerated types in your code. For more information on
  this feature, see
  [Enumerated types](/docs/dart-up-and-running/ch02.html#enums).

`--format=machine`
: Produce output in a format suitable for parsing.

`--no-hints`
: Don't show hints for improving the code.

`--version`
: Show the analyzer version.

`-h` *or* `--help`
: Show all the command-line options.

