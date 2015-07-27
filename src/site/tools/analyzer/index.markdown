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
DartPad, code editors, and IDEs such as WebStorm
use the same analysis engine that dartanalyzer uses.

## Basic usage

Run the analyzer from the top directory of the package.
Here’s an example of testing a Dart file.

{% prettify sh %}
dartanalyzer bin/test.dart
{% endprettify %}

## Options

The following are the most commonly used options for dartanalyzer:

`--packages=`
: Specify the path to the package resolution configuration file.
  For more information, see
  [Package Resolution Configuration File](https://github.com/lrhn/dep-pkgspec/blob/master/DEP-pkgspec.md).
  _This feature is coming in Dart 1.12, but is available now in
  the Dev channel download._
  This option cannot be used with `--package-root`.

`--package-warnings`
: Show warnings not only for code in the specified .dart file and
  others in its library, but also for libraries imported with `package:`.

`--options=`
: Specify the path to an analysis options file.

`--lints`
: Show the results from the linter.

`--no-hints`
: Don't show hints for improving the code.

`--ignore-unrecognized-flags`
: Rather than printing the help message,
  ignore any unrecognized command line flags.

`--version`
: Show the analyzer version.

`-h` *or* `--help`
: Show all the command-line options.

The following are advanced options to use with dartanalyzer:

`-b` *or* `--batch`
: Run in batch mode.

`--dart-sdk=`
: Specify the directory that contains the Dart SDK.

`--fatal-warnings`
: Except for type warnings, treat warnings as fatal.

`--format=machine`
: Produce output in a format suitable for parsing.

`--warnings`
: Show warnings from the SDK imports.

`--url-mapping=libraryUri,/path/to/library.dart`
: Tells the analyzer to use the specified library as the source
  for that particular import.


The following options are deprecated:

`-p` *or* `--package-root=`
: **Deprecated.** Specify the directory to search for any libraries that are
  imported using `package:`. _This option is replaced in Dart 1.12 with
  `--packages`._

`--machine`
: **Deprecated.** Replaced by `--format`.

`--show-package-warnings`
: **Deprecated.** Replaced by `--package-warnings`.

`--show-sdk-warnings`
: **Deprecated.** Replaced by `--warnings`.
