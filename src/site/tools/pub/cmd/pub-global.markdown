---
layout: default
title: "pub global"
description: "Use pub global to run Dart scripts hosted on pub.dartlang.org from the command line."
---

{% include breadcrumbs.html %}

# {{ page.title }}

<aside class="alert alert-info" markdown="1">
**Note:** The `global` command for pub is coming in 1.6, but is available
now in the [Dev Channel download](https://www.dartlang.org/tools/download.html).
</aside>

_Global_ is one of the commands of the _pub_ tool.
[Learn more about pub](/tools/pub/).

**Contents**
{% include default_toc.html %}

Pub's `global` option allows you to run Dart scripts from the
command line when you are not currently inside a package.
You first [activate a package](#activating-a-package), then you can
[run scripts](#running-a-script) from that package's bin directory.
[Deactivating a package](#deactivating-a-package) removes it from
your list of globally available packages.

If you want to run a Dart script from within a package, or from a
package that your package depends on, see [pub run](pub-run.html).

## Activating a package {#activating-a-package}

{% prettify lang-sh %}
$ pub global activate <package> [constraint]
$ pub global activate --source path <path>
{% endprettify %}

Use `activate` to enable you to run a package's executables
from anywhere on your machine.
You can activate a package on [pub.dartlang.org](http://pub.dartlang.org/),
or you can activate a package on your local machine.
Once you have activated a package, see [Running a script](#running-a-script)
to run scripts from the package's `bin` directory.

### Activating a package on pub.dartlang.org

Use `activate <package> [constraint]` to activate a package
from pub.dartlang.org.  The optional constraint allows you to pull
in a specific version of the package. For example,
the following command pulls the 0.6.0 version of the `markdown` package:

{% prettify lang-sh %}
$ pub global activate markdown 0.6.0
{% endprettify %}

If you specify a range, Pub picks the best version that meets that constraint.
For example:

{% prettify lang-sh %}
pub global activate foo <3.0.0
{% endprettify %}

### Activating a package on your local machine

Use `activate --source <path>` to activate a package
on your local machine.
The following example activates the `stopwatch` package from the
`~/dart` directory:

{% prettify lang-sh %}
pub global activate --source path ~/dart/stopwatch
{% endprettify %}

## Running a script {#running-a-script}

{% prettify lang-sh %}
$ pub global run <package>:<executable> [args...]
{% endprettify %}

Once you have [activated a package](#activating-a-package), use
`run` to run a script from the package's `bin` directory.
You can also specify optional arguments. For example:

{% prettify lang-sh %}
$ pub global run foo:bar arg1 arg2
{% endprettify %}

## Deactivating a package {#deactivating-a-package}

{% prettify lang-sh %}
$ pub global deactivate <package> 
{% endprettify %}

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
