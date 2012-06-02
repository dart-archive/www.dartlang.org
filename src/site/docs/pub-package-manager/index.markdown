---
layout: default
title: "pub: The Dart Package Manager"
description: "With pub, you can use third-party Dart libraries in 
your web and command-line Dart apps."
---

# {{ page.title }}

<aside class="note">
  <b>Note:</b> pub is under active development, so expect
  some changes to the functionality of the tool and these docs.
</aside>

This page tells you how to use the _pub_ tool (`bin/pub`)
to manage third-party library dependencies.

The `bin/pub` executable is in the [Dart SDK](/docs/sdk/).
You can either [download the SDK separately](/docs/sdk/#download)
or get it as part of the [Dart Editor package](/docs/editor/#download).

Before using the pub command, you need to set it up in your app.

## Setting up pub

Before installing libraries with pub you need to import them and 
create a pubspec file.

### Importing libraries from packages

To import third-party libraries, use the `package:` prefix. 

{% pretty_code dart 0 %}
#import('package:awesome/awesome.dart');
{% endpretty_code %}

The Dart runtime maps the `package:` prefix to a location containing
Dart packages.

### Creating a pubspec file

To help the Dart Editor understand how to map `package:`, go to Preferences 
and point the Packages directory to /<em>application_name</em>/packages.
Then create a file named **pubspec** to link the package name with a git repository. 
Put this file in the same directory as the file containing the app's 
main() method.

Here is an example of a pubspec file that associates the awesome library with a git
repository:

{% pretty_code console 0 %}
dependencies:
  awesome:
    git: git://github.com/munificent/awesome.git
{% endpretty_code %}

<aside class="note">
  <b>Note:</b> 	In the future, you'll be able to configure the packages
	mapping per project, instead of globally.
</aside>

## Installing the packages

Now that you have an import and a pubspec file, you can run `pub install`. 

{% pretty_code console 0 %}
$DART_SDK/bin/pub install
{% endpretty_code %}

This clones the git repositories and create a packages 
directory next to the application. The Dart Editor now knows
about the packages. 

The packages directory also contains any _transitive
dependencies_. 
For example, if the package `awesome` is dependent on the `sweet` package, 
then awesome has its own pubspec file in the packages directory.

## Additional options

Run `$DART_SDK/bin/pub --help` for a list of commands.



{% include syntax-highlighting.html %}
