---
layout: default
title: "pub global"
description: "Run Dart scripts from the command line, from anywhere on your machine."
---

{% include breadcrumbs.html %}

# {{ page.title }}

<aside class="alert alert-info" markdown="1">
**Note:** The `global` command for pub is coming in 1.6, but is available
now in the [Dev Channel download](https://www.dartlang.org/tools/download.html).
</aside>

_Global_ is one of the commands of the _pub_ tool.
[Learn more about pub](/tools/pub/).

{% prettify lang-sh %}
$ pub global activate <package> [constraint]
$ pub global run <package> <executable> [args...]
$ pub global deactivate <package> 
{% endprettify %}

Use this command to run Dart scripts from the command line when
you are not currently inside a package. The scripts must be inside of
a package hosted on [pub.dartlang.org](http://pub.dartlang.org/).

If you want to run a Dart script from your package or one you depend on,
see [pub run](pub-run.html).

## Activating a package

Use `pub global activate` to make the package available locally.
You can specify an optional constraint.
The following example pulls the 0.6.0 version of the `markdown` package:

{% prettify lang-sh %}
$ pub global activate markdown 0.6.0
{% endprettify %}

If you specify a range, Pub picks the best version that meets that constraint.
For example:

{% prettify lang-sh %}
pub global activate foo <3.0.0
{% endprettify %}

## Running a script

Use `run` to run a script from the package's `bin` directory.
You can also specify optional arguments. For example:

{% prettify lang-sh %}
$ pub global run foo:bar arg1 arg2
{% endprettify %}

## Deactivating a package

Use `deactivate` to remove a package from the list of available
global packages. For example:

{% prettify lang-sh %}
$ pub global deactivate markdown
{% endprettify %}

You will no longer be able to invoke the package's scripts using
`pub global run`.

## Options {#options}

For options that apply to all pub commands, see
[Global options](/tools/pub/cmd/#global-options).

<aside class="alert alert-info" markdown="1">
*Problems?*
See [Troubleshooting Pub](../troubleshoot.html).
</aside>
