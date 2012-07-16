---
layout: default
title: "dart: The Standalone Dart VM"
description: "Use the standalone Dart VM to run Dart scripts,
programs, and servers from the command line."
has-permalinks: true
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
YOUR_DART_SDK_DIR/bin/dart test.dart
{% endhighlight %}

## Enabling checked mode

Dart programs run in one of two modes: _checked_ or _production_.
By default, the Dart VM runs in production mode.
We recommend that you enable checked mode for development
and testing.

In checked mode, assignments are dynamically checked, and
certain violations of the type system raise exceptions at run time.
In production mode, static type annotations have no
effect.

Assert statements are also enabled in checked mode.
An [assert statement](/docs/language-tour/#assert)
checks a boolean condition,
raising an exception if the condition is false.
Assertions do not run in production mode.

You can run the VM in checked mode with a command-line flag:

{% highlight bash %}
YOUR_DART_SDK_DIR/bin/dart --enable-checked-mode test.dart
{% endhighlight %}

## Additional options

Print all the command-line options with `--print-flags`:

{% highlight bash %}
$DART_SDK/bin/dart --print-flags
{% endhighlight %}
