---
layout: default
title: "dartdoc: The API Documentation Generator"
description: "Generate docs from source code and doc comments."
has-permalinks: false
---

# {{ page.title }}

You can use the SDK's dartdoc tool (`bin/dartdoc`) to
generate documentation from your Dart code.
By default, dartdoc parses and creates documentation for
the `.dart` files that you pass to it,
plus the libraries they import.

To improve dartdoc’s output,
provide documentation comments as described in the article
[Guidelines for Dart Doc Comments](/articles/doc-comment-guidelines/).

To learn about other tools you can use for Dart development,
see [Tools for Dart](/tools/).

## Basic usage

Here’s an example of generating documentation from a Dart file.

{% prettify sh %}
dartdoc --out=/docs/mylib mylib.dart
{% endprettify %}

By default, the generated documentation appears in a directory named `docs/`.

## Options

Common command-line options for dartdoc include:

`--out=<absolute_path>`
: Put the documentation in the specified directory.
  If the directory doesn’t already exist, it’s created.

`--no-code`
: Don’t include source code in the generated documentation.

`--exclude-lib=<identifier>`
: Don’t generate documentation for the specified library.
  Example: `--exclude-lib=metadata`

`--omit-generation-time`
: Don’t put a timestamp at the bottom of every page.

`--mode=static`
: Use static HTML navigation.
  The resulting files can be much larger than the default,
  but previewing docs locally is easier.

`--package-root=<path>`
: Specify where to find imported libraries.
  You might need to use this option if
  dartdoc can’t find a library because
  your directory structure doesn’t match
  [pub’s package layout conventions](/tools/pub/package-layout.html).
  Example: `--package-root=foo/packages/`

`--help`
: Print all the command-line options.

