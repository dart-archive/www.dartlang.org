---
layout: default
title: "dart: The Standalone Dart VM"
description: "Use the standalone Dart VM to run Dart scripts, programs, and servers from the command line."
---

# {{ page.title }}

This page tells you how to use the _dart_ tool (`bin/dart`)
to run Dart command-line apps
such as server-side scripts, programs, and servers.
During development, you also have the option to
[run command-line apps using Dart Editor](/docs/editor/#run).

The `bin/dart` executable is in the [Dart SDK](/docs/sdk/).
You can either [download the SDK separately](/docs/sdk/#download)
or get it as part of the [Dart Editor package](/docs/editor/#download).

## Basic usage

Here's an example of running a Dart file on the command line:

{% highlight bash %}
$DART_SDK/bin/dart test.dart
{% endhighlight %}


## Enabling type checks

Dart programs run in one of two modes: checked or production.
In checked mode, assignments are dynamically checked, and
certain violations of the type system raise exceptions at run time.
In production mode, static type annotations have no
effect.

During development, we recommend using checked mode. You can
run the VM in checked mode with a command-line flag:

{% highlight bash %}
$DART_SDK/bin/dart --enable_type_checks test.dart
{% endhighlight %}

## Enabling assertions

An [assert statement](/docs/language-tour/#assert)
checks a boolean condition,
raising an exception if the condition is false.
Assertions do not run in production mode.
We recommend that you enable assertions during development.

You can enable assertions in the VM with a command-line flag:

{% highlight bash %}
$DART_SDK/bin/dart --enable_asserts test.dart
{% endhighlight %}


## Additional options

Print all the command-line options with `--print-flags`:

{% highlight bash %}
$DART_SDK/bin/dart --print-flags
{% endhighlight %}


