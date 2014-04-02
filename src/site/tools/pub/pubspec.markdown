---
layout: default
title: "Pubspec Format"
---

{% include toc.html %}

# {{ page.title }}

Every [pub](/tools/pub/) package needs some metadata so it can specify its
[dependencies](glossary.html#dependency). Pub packages that are shared with
others also need to provide some other information so users can discover them.
Pub stores this in a file named `pubspec.yaml`, which is written in
the [YAML](http://www.yaml.org/) language.

At the top level are a series of fields. The currently supported ones are:

Name
: Required for every package.

Version
: Required for packages that will be hosted on pub.dartlang.org.

Description
: Required for packages that will be hosted on pub.dartlang.org.

Author/Authors
: Optional.

Homepage
: Optional.

Documentation
: Optional.

Dependencies
: Can be omitted if your package has no dependencies.

Dev dependencies
: Can be omitted if your package has no dev dependencies.

Dependency overrides
: Can be omitted if you do not need to override any dependencies.

Transformers
: Optional. Used to configure dart2js or other transformers.
For more information, see
[Pub Assets and Transformers](assets-and-transformers.html) and
[Configuring the Built-in dart2js Compiler](dart2js-transformer.html).

All other fields will be ignored. A simple but complete pubspec looks something
like the following:

{% prettify yaml %}
name: newtify
version: 1.2.3
description: >
  Have you been turned into a newt?  Would you like to be?
  This package can help: it has all of the
  newt-transmogrification functionality you've been looking
  for.
author: Nathan Weizenbaum <nweiz@google.com>
homepage: http://newtify.dartlang.org
documentation: http://docs.newtify.com
dependencies:
  efts: '>=2.0.4 <3.0.0'
  transmogrify: '>=0.4.0 <1.0.0'
dev_dependencies:
  unittest: '>=0.6.0'
dependency_overrides:
  transmogrify:
    path: ../transmogrify_patch/
{% endprettify %}

## Name

Every package needs a name.  It's how other packages will refer to yours,
and how it will appear to the world, should you publish it.

It should be all lowercase, with underscores to separate words,
`just_like_this`. Stick with basic Latin letters and Arabic digits:
`[a-z0-9_]` and ensure that it's a valid Dart identifier (i.e. doesn't start
with digits and isn't a reserved word).

Try to pick a name that is clear, terse, and not already in use.
A quick search of packages on
[pub.dartlang.org](http://pub.dartlang.org/packages)
to make sure that nothing else is using your name is recommended.

## Version

Every package has a version. A version number is required to host your package
on pub.dartlang.org, but can be omitted for local-only packages. If you omit
it, your package is implicitly versioned `0.0.0`.

Versioning is necessary for reusing code while letting it evolve quickly. A
version number is three numbers separated by dots, like `0.2.43`. It can also
optionally have a build (`+hotfix.oopsie`) or pre-release (`-alpha.12`) suffix.

Each time you publish your package, you will publish it at a specific version.
Once that's been done, consider it hermetically sealed: you can't touch it
anymore. To make more changes, you'll need a new version.

When you select a version, follow [semantic versioning][].

[semantic versioning]: http://semver.org/spec/v2.0.0-rc.1.html

## Description

This is optional for your own personal packages, but if you intend to
publish your package you must provide a description. This should
be relatively short&mdash;a few sentences, maybe a whole paragraph&mdash;and
tells a casual reader what they might want to know about your package.

Think of the description as the sales pitch for your package. Users will see it
when they [browse for packages](http://pub.dartlang.org/packages).
It should be simple plain text: no markdown or HTML.
That's what your README is for.

## Author/Authors

You're encouraged to use these fields to describe the author(s) of your package
and provide contact information. `author` should be used if your package has a
single author, while `authors` should be used with a YAML list if more than one
person wrote the package. Each author can either be a single name (e.g. `Nathan
Weizenbaum`) or a name and an email address (e.g. `Nathan Weizenbaum
<nweiz@google.com>`). For example:

{% prettify yaml %}
authors:
- Nathan Weizenbaum <nweiz@google.com>
- Bob Nystrom <rnystrom@google.com>
{% endprettify %}

If anyone uploads your package to pub.dartlang.org, your email address will be
public.

## Homepage

This should be a URL pointing to the website for your package.
For [hosted packages](dependencies.html#hosted-packages),
this URL will be linked from the package's page.
While this is technically optional *please do* provide one. It
helps users understand where your package is coming from. If nothing else, you
can always use the URL where you host the source code:
[GitHub](http://github.com), [code.google.com](http://code.google.com/),
whatever.

## Documentation

Some packages may have a site that hosts documentation separate from the main
homepage. If your package has that, you can also add a `documentation:` field
with that URL. If provided, a link to it will be shown on your package's page.

## Dependencies


[Dependencies](glossary.html#dependency) are the pubspec's *raison d'être*.
In this section you list each package that your package needs in order to work.

Dependencies fall into one of two types. "Regular dependencies" are listed
under `dependencies:`&mdash;these are packages that anyone using your package
will also need. Dependencies that are only needed in the development phase of
the package itself are listed under `dev_dependencies`.

During the development process, you might need to temporarily override
a dependency.  You can do so using `dependency_overrides`.

For more information, see [Pub Dependencies](dependencies.html).

## SDK constraints

A package can indicate which versions of its dependencies it supports, but there
is also another implicit dependency all packages have: the Dart SDK itself.
Since the Dart platform evolves over time, a package may only work with certain
versions of it.

A package can specify that using an *SDK constraint*. This goes inside a
separate top-level "environment" field in the pubspec and uses the same
[version constraint](dependencies.html#version-constraints) syntax as
dependencies. For example, the following constraint says that this package
works with any Dart SDK from 0.3.4 or later:

{% prettify yaml %}
environment:
  sdk: ">=0.3.4"
{% endprettify %}

Pub will try to find the latest version of a package whose SDK constraint works
with the version of the Dart SDK that you have installed.

[pubsite]: http://pub.dartlang.org
[semantic versioning]: http://semver.org/spec/v2.0.0-rc.1.html
