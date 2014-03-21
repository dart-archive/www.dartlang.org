---
layout: default
title: "dart: The Standalone VM"
---

# {{ page.title }}

{% include toc.html %}

You can use the _dart_ tool (`bin/dart`) to run Dart command-line apps such as
server-side scripts, programs, and servers. During development, you also
have the option to run command-line apps using [Dart Editor](/tools/editor/).
    
### Basic usage {#basic-usage}

Here’s an example of running a Dart file on the command line:

{% prettify lang-sh %}
dart test.dart
{% endprettify %}

#### Options {#options}

Common command-line options for dart include:

`-c` or `--checked`
: Enable _both_ assertions and type checks (checked mode).

`-p <path>` or `-package-root=<path>`
: Specify where to find imported libraries.

`--version`
: Display VM version information.

`-h` or `--help`
: Display help. (Add `-v` for information about all options.)

You can also generate snapshots:

`--snapshot=<filename>`
: Generate a snapshot in the specified file. For information
  on generating and running snapshots, see the article
  [Snapshots in Dart](/articles/snapshots/).
  
### Enabling checked mode {#enabling-checked-mode}
  
Dart programs run in one of two modes: checked or production. By default, the
Dart VM runs in production mode. We recommend that you enable checked mode for
development and testing.

In checked mode, assignments are dynamically checked, and certain violations of
the type system raise exceptions at runtime. In production mode, static type
annotations have no effect.

Assert statements are also enabled in checked mode. An
[assert statement](/docs/dart-up-and-running/contents/ch02.html#assert)
checks a boolean condition, raising an exception if the condition is false.
Assertions do not run in production mode.

You can run the VM in checked mode with the `--checked` command-line flag:

{% prettify lang-sh %}
dart --checked test.dart
{% endprettify %}
