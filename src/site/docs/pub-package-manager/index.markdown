---
layout: default
title: "Pub: Getting Started"
description: "How to get up and running with pub."
has-permalinks: true
---

# {{ page.title }}

<!-- TODO(rnystrom): Link **terms** to glossary when that exists. -->

*Pub* is a package mananger for Dart. It helps you reuse existing Dart code
and bundle your Dart apps and libraries so that you can reuse and share them
with other people. Pub handles versioning and dependency management so that you
can ensure that your app runs on other machines exactly the same as it does on
yours.

## Contents {#toc}

1. [Installing and configuring pub](#installing-and-configuring-pub)
1. [Creating a package](#creating-a-package)
1. [Adding a dependency](#adding-a-dependency)
1. [Installing dependencies](#installing-dependencies)
1. [Importing code from a dependency](#importing-code-from-a-dependency)
1. [Installing dependencies](#installing-dependencies)
1. [Updating a dependency](#updating-a-dependency)
1. [Finding packages in the Editor](#finding-packages-in-the-editor)
1. [Learning more](#learning-more)
{:.toc}

## Installing and configuring pub

Pub is part of the [Dart SDK](/docs/sdk/), so if you have Dart installed, you
have pub too. You tell pub *where* you installed the Dart SDK by setting an
environment variable. On Mac and Linux, add this to your shell's configuration
file:

    export DART_SDK=<path to dart>

Where `<path to dart>` is the path to the main `dart` directory of the SDK. If
you installed the SDK with the [Dart Editor](/docs/editor/#download), this
will be the `dart-sdk` directory inside the Editor's main directory.

On Windows, you can set the environment variable through the Control Panel. A
quick [search](https://www.google.com/search?q=windows+set+environment+variable)
should turn up the right instructions for your particular version of Windows.

<!-- TODO(rnystrom): Remove the above when bug #1145 is fixed. -->

Your primarily access pub through the `pub` command line app, which lives
inside the `bin` directory in the Dart SDK. To make it easier to access `pub`
(and other executables in there like the Dart VM), you may want to add `bin` to
your system path. On Mac and Linux, add this to your shell's configuration file:

    export PATH=$PATH:$DART_SDK/bin

On Windows, you'll go through the Control Panel and do something similar.

## Creating a package

A **package** in pub is a directory that contains Dart code and any other stuff
that goes along with it like resources, tests, and docs. Frameworks and
reusable libraries are obviously packages, but applications are too. If your
app wants to use pub packages, it needs to be a package too.

While everything is a package in pub, there are two flavors of packages that
are used slightly differently in practice. A **library package** is a package
that is intended to be reused by other packages. It will usually have code that
other packages import, and it will likely be hosted somewhere that people can
get to. An **application package** only *consumes* packages but doesn't itself
get reused. In other words, library packages will be used as dependencies, but
application packages won't.

In most cases, there's no difference between the two and we'll just say
"package". In the few places where it does matter, we'll specify "library
package" or "application package".

<!-- TODO(rnystrom): Enable this when that doc exists.
<a href="package-layout.html" style="text-align: right;">
  <i class="icon-hand-right icon-white">&nbsp;</i>
  Learn more about packages
</a>
-->

To turn your app into an application package so it can use other packages, you
just need to give it a **pubspec**. This file is written using the
[YAML language](http://yaml.org) and is named `pubspec.yaml`. The simplest
possible pubspec contains nothing, so just create an empty file and save it as
`pubspec.yaml` in the root directory of your app.

    $ cd path/to/your_app
    $ touch pubspec.yaml

<aside class="alert alert-info">
If you're on Windows or don't rock the command line, just make an empty file
and save it as <tt>pubspec.yaml</tt> in the root directory of your app.
</aside>

Now `your_app` is a pub package!

<a href="pubspec.html">
  <i class="icon-hand-right icon-white">&nbsp;</i>
  Learn more about the pubspec format
</a>

## Adding a dependency

One of pub's main jobs is managing **dependencies**. A dependency is just
another package that your package relies on. If your app is using some
templating framework called "handle_stache", then your app package will depend
on the `handle_stache` package.

<!-- TODO(rnystrom): Use a real package here when we have one. -->

You specify your package's dependencies in the pubspec, like so:

{% highlight yaml %}
dependencies:
  handle_stache:
    git: git://github.com/munificent/handle_stache.git
{% endhighlight %}

Here, we are declaring a dependency on some (fictional) `handle_stache` package
that we want to install from [Git](http://git-scm.com/) using the given URL.

<!-- TODO(rnystrom): Use a pub.dartlang.org dep when that's live. -->

<a href="pubspec.html#dependencies">
  <i class="icon-hand-right icon-white">&nbsp;</i>
  Learn more about specifying dependencies
</a>

## Installing dependencies

Once you've declared a dependency, you then tell pub to install it for you:

    $ cd path/to/your_app
    $ pub install

<aside class="alert alert-warning">
Today, this command must be run from the directory containing
<tt>pubspec.yaml</tt>. In the future, you will be able to run it from any
sub-directory of the package.
</aside>

When you do this, pub will create a `packages` directory in the same directory
as `pubspec.yaml`. In there, it will download and install each package that
your package depends on (these are called your **immediate dependencies**). It
will also look at all of those packages and install everything *they* depend
on, recursively (these are your **transitive dependencies**).

When this is done, you will have a `packages` directory that contains every
single package your program needs in order to run.

<a href="pub-install.html">
  <i class="icon-hand-right icon-white">&nbsp;</i>
  Learn more about <tt>pub install</tt>
</a>

## Importing code from a dependency

Now that you have a dependency wired up, you want to be able to use code from
it. To access a library in a another package, you will import it using the
`package:` scheme:

{% highlight dart %}
#import('package:handle_stache/handle_stache.dart');
{% endhighlight %}

This looks inside the `handle_stache` package for a top-level file named
`handle_stache.dart`. Most packages just define a single entrypoint whose name
is the same as the name of the package. Check the documentation for the package
to see if it exposes anything different for you to import.

<aside class="alert alert-info">
This works by looking inside the generated <tt>packages</tt> directory. If you
get an error, the directory may be out of date. Fix it by running
<tt>pub install</tt> whenever you change your pubspec.
</aside>

<!-- TODO(rnystrom): Enable this when that doc exists.
<a href="package-scheme.html">
  <i class="icon-hand-right icon-white">&nbsp;</i>
  Learn more about the <tt>package:</tt> scheme
</a>
-->

## Updating a dependency

The first time you install a new dependency for your package, pub will download
the latest version of it that's compatible with your other dependencies. It
then locks your package to *always* use that version by creating a **lockfile**.
This is a file named `pubspec.lock` that pub creates and stores next to your
pubspec. It lists the specific versions of each dependency (immediate and
transitive) that your package uses.

If this is an application package, you will check this file into source control.
That way, everyone hacking on your app ensures they are using the same versions
of all of the packages. This also makes sure you use the same versions of stuff
when you deploy your app to production.

When you are ready to upgrade your dependencies to the latest versions, do:

    $ pub update

This tells pub to regenerate the lockfile using the newest available versions of
your package's dependencies. If you only want to update a specific dependency,
you can specify that too:

    $ pub update handle_stache

This updates `handle_stache` to the latest version but leave everything else
the same.

<!-- TODO(rnystrom): Enable this when that doc exists.
<a href="command-update.html">
  <i class="icon-hand-right icon-white">&nbsp;</i>
  Learn more about <tt>pub update</tt>
</a>
-->

## Finding packages in the Editor

The [Dart Editor](/docs/editor/) needs to know where your package's `packages`
directory is so that it can understand `package:` imports too. To set this, go
to *Preferences* and point the "Package directory" to the root directory of
your package.

<aside class="alert alert-info">
In the future, you'll be able to set this per project, instead of globally.
</aside>

## Learning more

<a href="versioning.html">
  <i class="icon-hand-right icon-white">&nbsp;</i>
  Learn more about pub's approach to versioning
</a>
