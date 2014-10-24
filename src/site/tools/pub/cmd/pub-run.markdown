---
layout: default
title: "pub run"
description: "Use pub run to run a Dart script in your package."
---

{% include breadcrumbs.html %}

# {{ page.title }}

<aside class="alert alert-info" markdown="1">
**Note:** In 1.6, pub run starts up slowly. This is significantly improved
in the next release of the SDK.
</aside>

_Run_ is one of the commands of the _pub_ tool.
[Learn more about pub](/tools/pub/).

{% prettify sh %}
$ pub run [--mode=<mode>] <executable> [args...]
{% endprettify %}

Use this command to run a Dart script in your package,
or in one of its dependencies, from the command line.
If your app uses transformers, pub loads and runs the appropriate
transformers, then runs the app, passing in any specified parameters.

To run an executable when you are not currently inside a package,
see the [pub global](pub-global.html) command.

## Running a script in your package's bin directory

This is the simplest use case.

From the root of a package that contains `foo.dart`
in the `bin` directory, run the app using the following command:

{% prettify sh %}
$ pub run foo arg1 arg2
{% endprettify %}

This command looks in your package's `bin` directory for the
specified script and invokes it, passing in any arguments.

## Running a script in another directory in your package

To run a script inside a directory other than the top-level
bin directory (but within the package), prepend the path 
to the name of the script.
For example, to run `foo.dart` in the `example/sub` directory:

{% prettify sh %}
$ pub run example/sub/foo arg1 arg2
{% endprettify %}

## Running a script in a dependency

To run a script from the `bin` directory of a package that you depend on
in the pubspec, specify the package name.
For example, to run `bar.dart` in the foo package:

{% prettify sh %}
$ pub run foo:bar arg
{% endprettify %}

You can only run scripts out of another package's `bin` directory.
All other directories are private.

## Options {#options}

For options that apply to all pub commands, see
[Global options](/tools/pub/cmd/#global-options).

<code>--mode=&lt;mode&gt;</code>
: Optional. Specifies a transformation mode. Typical values are
  "debug" and "release", but any word is allowed.
  Transformers may use this to change how they behave.
  If omitted, it defaults to "release" for dependencies and
  "debug" for entrypoints.

<aside class="alert alert-info" markdown="1">
*Problems?*
See [Troubleshooting Pub](../troubleshoot.html).
</aside>
