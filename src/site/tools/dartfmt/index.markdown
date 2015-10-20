---
layout: default
title: "dartfmt: The Dart Code Formatter"
short-title: "dartfmt"
description: "A tool that makes your code follow the conventions in the
  Dart Style Guide."
---

{% include toc.html %}
{% include breadcrumbs.html %}

# {{ page.title }}

---
Use _dartfmt_ to format your Dart code according to the conventions in the
[Effective Dart][]'s [style guide][].

[effective dart]: /effective-dart/
[style guide]: /effective-dart/style/

To format your code in WebStorm,
right-click anywhere in a Dart file's content pane,
and select **Reformat with Dart Style** from the popup menu.

The formatter fixes indentation and white space, and inserts line
breaks where appropriate. Only white space is affected.
Dartfmt is safe to run automatically. We encourage you to add it to your
build scripts.

The following example shows a complex expression, with most
white space removed, and the code that results when using dartfmt.

{% prettify dart %}
// BEFORE formatting
if (tag=='style'||tag=='script'&&(type==null||type == TYPE_JS
      ||type==TYPE_DART)||
  tag=='link'&&(rel=='stylesheet'||rel=='import')) {}
{% endprettify %}

Dartfmt converts this to:

{% prettify dart %}
// AFTER formatting
if (tag == 'style' ||
    tag == 'script' &&
        (type == null || type == TYPE_JS || type == TYPE_DART) ||
    tag == 'link' && (rel == 'stylesheet' || rel == 'import')) {}
{% endprettify %}

## Basic usage {#basic-usage}

Here’s a simple example of using dartfmt on the command line:

{% prettify sh %}
dartfmt test.dart
{% endprettify %}

This command formats the `test.dart` file and writes the result
to standard output.
If you specify a directory instead of a file, dartfmt recurses through
the directory and formats all files with a `.dart` extension.

If no file or directory is specified, dartfmt reads from standard input.

## Options {#options}

<aside class="alert alert-info" markdown="1">
**Note:**
To run dartfmt from the command line, you might want to
[add the SDK's bin directory to your system path](/tools/pub/installing.html).
</aside>

Common command-line options for dartfmt include:

`-h` or `--help`
: Display help.

`-l <value>` or `--max_line_length=<value>`
: Wrap any lines longer than the specified value.
  The default value is 80.  Comments are not affected.

`-n ` or `--dry-run`
: Show which files would be modified, but make no changes.

`-w ` or `--overwrite`
: Write the output back into the source file.
  By default, the output goes to standard output.

## More information

* [Dart Style Guide](/articles/style-guide/)

## Filing bugs and feature requests

  To see existing issues or create a new one, go to the
  [dart_style](https://github.com/dart-lang/dart_style/issues)
  repo on GitHub.
