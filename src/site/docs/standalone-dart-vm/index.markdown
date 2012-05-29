---
layout: default
title: "dart: The Standalone Dart VM"
description: "Use the standalone Dart VM to run Dart programs on the command line. You can write server-side scripts, programs, and servers with the Dart VM."
---

# {{ page.title }}

Find the standalone Dart VM in the [Dart SDK](/docs/sdk/).

To run a Dart file in the Dart VM, use `bin/dart`.
For example:

{% pretty_code console 0 %}
$DART_SDK/bin/dart test.dart
{% endpretty_code %}

Print all the command-line options with `--print-flags`:

{% pc console 0 %}
$DART_SDK/bin/dart --print-flags Test
{% endpc %}

That third argument is required for now, until we fix
<a href="http://code.google.com/p/dart/issues/detail?id=2837">bug #2837</a>.

## Enabling type checks

Dart programs run in one of two modes: checked or production.
In checked mode, assignments are dynamically checked, and
certain violations of the type system raise exceptions at run time.
In production mode, static type annotations have no
effect.

During development, we recommend using checked mode. You can
run the VM in checked mode with a command-line flag:

{% pretty_code console 0 %}
$DART_SDK/bin/dart --enable_type_checks test.dart
{% endpretty_code %}

## Enabling assertions

An assertion checks a boolean condition and, if false, raises an exception.
The `assert()` statements do not run in production mode.
We recommend that you enable assertions during development.

You can enable assertions in the VM with a command-line flag:

{% pretty_code console 0 %}
$DART_SDK/bin/dart --enable_asserts test.dart
{% endpretty_code %}

{% include syntax-highlighting.html %}