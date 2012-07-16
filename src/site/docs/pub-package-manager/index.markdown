---
layout: default
title: "pub: The Dart Package Manager"
description: "With pub, you can use third-party Dart libraries in 
your web and command-line Dart apps."
has-permalinks: true
---

# {{ page.title }}

<aside>
  <div class="alert alert-info">
    <strong>Note:</strong>
    Pub is under active development, so expect
    some changes to the functionality of the tool and these docs.
  </div>
</aside>

This page tells you how to use the _pub_ tool (`bin/pub`)
to manage Dart packages. A Dart package is simply
a directory containing any number of Dart libraries and their dependencies.

The `bin/pub` executable is in the [Dart SDK](/docs/sdk/).
You can either [download the SDK separately](/docs/sdk/#download)
or get it as part of the [Dart Editor package](/docs/editor/#download).

To use a library that's in a Dart package,
you need to create a **pubspec**, use pub to install the package,
point Dart to the packages location, and then import the library.

## Creating a pubspec

To use a package, your application must define a pubspec
that lists dependencies and their download locations.
This file is named **pubspec.yaml** and is placed into the
root directory of your package or app.

Here is an example of a pubspec.yaml file that associates the
`awesome` package with a git repository:

{% highlight yaml %}
dependencies:
  awesome:
    git: git://github.com/munificent/awesome.git
{% endhighlight %}

Packages can be installed from git today, and in the future
we expect to support other sources such as a hosted
service at pub.dartlang.org.

The pubspec uses the [YAML](http://yaml.org/) format.

## Installing the packages

Now that you have a pubspec, you can run `pub install`. You must
run this command from the directory containing the pubspec.yaml file,
which must be next to the entrypoint file (the file you pass
to the Dart VM or in your &lt;script&gt; tag).

{% highlight yaml %}
cd your/app
YOUR_DART_SDK_DIR/bin/pub install
{% endhighlight %}

This command creates a _packages_ directory inside the current directory,
cloning the git repositories into the packages directory.

The packages directory also contains any _transitive
dependencies_. 
For example, if the `awesome` package is dependent on the `sweet` package, 
the pub tool will also download and install the `sweet` package.

## Using libraries from the SDK

<aside>
  <div class="alert alert-info">
    <strong>Note:</strong>
    The functionality described in this section is temporary.
    It's possible that some libraries
    that currently ship in the SDK will be pulled out of the SDK and installable
    directly from pub.
  </div>
</aside>

Not all libraries that ship with the SDK are available in the `dart:`
namespace. To use those libraries (for example, unittest) in your app,
add an `sdk` source to your `pubspec.yaml` file. For example:

{% highlight yaml %}
dependencies:
  unittest:
    sdk: unittest
{% endhighlight %}

When you use the SDK as a source for packages, you must specify a
`--sdkdir` command-line
argument, pointing to the SDK location. The path to the
SDK must be a fully qualified path, until [bug 3714](http://code.google.com/p/dart/issues/detail?id=3714) is addressed.

{% highlight bash %}
cd your/app
$DART_SDK/bin/pub install --sdkdir=/full/path/to/dart/sdk
{% endhighlight %}

## Pointing Dart to your packages

The Dart runtime needs to know where the packages are located.
You can specify where packages are located for both the Dart Editor
and the Dart VM.

If you use the `pub install` command, the packages directory is created
for you next to the pubspec.yaml file.

### Mapping packages for the Dart Editor

To help the Dart Editor understand how to find packages, go to Preferences 
and point the "Package directory" to `/path/to/your/app/packages`.

<aside>
  <div class="alert alert-info">
    <strong>Note:</strong>
    In the future, you'll be able to configure the packages
    mapping per project, instead of globally.
  </div>
</aside>

### Mapping packages for the Dart VM

For command-line Dart applications that use packages, use the
`--package-root` option to specify the packages location.

For example:

{% highlight bash %}
$DART_SDK/bin/dart --package-root=./packages/ app.dart
{% endhighlight %}

Note the required trailing slash when specifying the `./packages/` directory.

## Importing libraries from packages

To import libraries found in packages, use the `package:` prefix.

{% highlight dart %}
#import('package:awesome/awesome.dart');
{% endhighlight %}

The Dart runtime will take everything after `package:` and look it up
within the package-root location.

## Additional options

Run `YOUR_DART_SDK_DIR/bin/pub --help` for a list of commands.


