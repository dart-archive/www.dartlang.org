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
[Dart Style Guide](/articles/style-guide/).

<aside class="alert alert-warning" markdown="1">
The _dartfmt_ tool is available in the Dart SDK and in Dart Editor
as of the 1.2 release.

Dartfmt is in Early Preview. Please file
issues and requests on [dartbug.com](http://dartbug.com/new).
</aside>

To format your code in Dart Editor, right-click in
the editor pane to bring up the menu, and select the **Format** option.
This runs the [code transform](#code-transform-formatting) level of formatting.

## Two levels of formatting

Dartfmt provides two levels of formatting.

### Basic formatting
The basic level of formatting cleans up indentation and white space,
and inserts line breaks where appropriate.
This level of formatting affects white space only.

The basic level of formatting is the default when running dartfmt
from the command line.

The following example breaks several conventions in the
[Dart Style Guide](/articles/style-guide/),
including the position of the curly braces,
using tabs for indentation, and the lack of white space around
an operator.

{% prettify dart %}
// BEFORE formatting
if (dayOfWeek==3)
{
        print("It's Donut Day!");
  }
{% endprettify %}

Dartfmt converts this to:

{% prettify dart %}
// AFTER formatting
if (dayOfWeek == 3) {
  print("It's Donut Day!");
}
{% endprettify %}

### Code transform formatting {#code-transform-formatting}

The second level of formatting applies transforms to the code
to perform light cleanup.
This level of formatting is the default in Dart Editor and is
enabled using the `--transform` option at the command line.

Code transform formatting involves enclosing control blocks, terminating
empty constructors, and removing empty statements.

#### Enclosing control blocks

Dartfmt ensures that all flow control structures are enclosed with
curly braces, with the exception of a single-line `if` statement
with no corresponding `else`.

For example, consider this code:

{% prettify dart %}
// BEFORE formatting
if (dayOfWeek == 3) print('Donut Day!');
else
  print('Kale Day!');
{% endprettify %}

After code transform formatting, it becomes this:

{% prettify dart %}
// AFTER formatting
if (dayOfWeek == 3) {
  print('Donut Day!');
} else {
  print('Kale Day!');
}
{% endprettify %}

#### Terminating empty constructors

In an empty constructor that is written using curly braces, `{}`,
the braces are replaced with a semicolon.

For example, consider this code:

{% prettify dart %}
// BEFORE formatting
class Point {
  int x, y;
  Point(this.x, this.y) {}
}
{% endprettify %}

After code transform formatting, it becomes this:

{% prettify dart %}
// AFTER formatting
class Point {
  int x, y;
  Point(this.x, this.y);
}
{% endprettify %}

#### Removing empty statements

Extra semicolons are removed, where possible.


## Basic usage {#basic-usage}

Here’s a simple example of using dartfmt on the command line:

{% prettify lang-sh %}
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

`-w ` or `--write`
: Write the output back into the source file.
  By default, the output goes to standard output.
            
`-t` or `--transform`
: Perform code transformations, as described in
  [Code transform formatting](#code-transform-formatting).
  This mode is disabled, by default.

`-m` or `--machine`
: Produce output with explicit line breaks that can be parsed.

`-l <value>` or `--max_line_length=<value>`
: Wrap any lines longer than the specified value. To never wrap,
  specify "Infinity" or "Inf".  The default value is 80.
  Comments are not affected.

`-h` or `--help`
: Display help.

## More information

* [Dart Style Guide](/articles/style-guide/)


