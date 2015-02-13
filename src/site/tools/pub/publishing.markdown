---
layout: default
title: "Publishing a Package"
---

{% include breadcrumbs.html %}

# {{ page.title }}

[Pub](/tools/pub) isn't just for using other people's packages.
It also allows you to share your packages with the world. If you have a useful
project and you want others to be able to use it, use the `pub publish`
command. For your first time around, you can perform a dry run like so:

{% prettify sh %}
$ pub publish --dry-run
{% endprettify %}

Pub will check to make sure that your package follows the
[pubspec format](pubspec.html) and
[package layout conventions](package-layout.html), and then upload your package
to [pub.dartlang.org](https://pub.dartlang.org). Pub will also show you all of
the files it intends to "publish". Here's an example of publishing a package
named `transmogrify`:

{% prettify none %}
Publishing transmogrify 1.0.0 to https://pub.dartlang.org:
    .gitignore
    CHANGELOG.md
    README.md
    lib
        transmogrify.dart
        src
            transmogrifier.dart
            transmogrification.dart
    pubspec.yaml
    test
        transmogrify_test.dart

Package has 0 warnings.
{% endprettify %}

To publish your package for reals, remove the `--dry-run` argument:

{% prettify sh %}
$ pub publish
{% endprettify %}

After your package has been successfully uploaded to
[pub.dartlang.org](https://pub.dartlang.org/), any Pub user will be able to
download it or depend on it in their projects. For example, if you just
published version 1.0.0 of your `transmogrify` package, then another Dart
developer can add it as a dependency in their `pubspec.yaml`:

{% prettify yaml %}
dependencies:
  transmogrify: ">= 1.0.0 < 2.0.0"
{% endprettify %}

## Important files

Pub strictly uses the [package layout conventions](package-layout.html) to find
files that will go into your projects Pub package. Review the conventions to
understand what Pub will publish.

In particular, Pub uses the contents of a few files to create a page for your
package at pub.dartlang.org/packages/<your_package>. Here are the files that
will affect how your package's page will look:

* **README**: The README file (`README`, `README.md`, `README.mdown`,
  `README.markdown`) is the main content featured in your package's page.
* **CHANGELOG**: Your package's CHANGELOG (`CHANGELOG`, `CHANGELOG.md`,
  `CHANGELOG.mdown`, `CHANGELOG.markdown`), if found, will also be featured in a
  tab on your package's page, so that developers can read it right from
  pub.dartlang.org.
* **The pubspec**: Your package's `pubspec.yaml` file is used to fill out
  details about your package on the right-side of your package's page, like its
  description, authors, etc.

## Publishing is forever

Keep in mind that publishing is forever. As soon as you publish your package,
users will be able to depend on it. Once they start doing that, removing
the package would break theirs. To avoid that, Pub strongly discourages
deleting packages. You can always upload new versions of your package, but
old ones will continue to be available for users that aren't ready to
upgrade yet.

For more information, see the reference pages for:

* [`pub publish`](cmd/pub-lish.html)
* [`pub uploader`](cmd/pub-uploader.html)
