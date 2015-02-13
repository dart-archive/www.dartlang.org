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

When you publish your package to [pub.dartlang.org](https://pub.dartlang.org/),
it gets its very own page at pub.dartlang.org/packages/<your_package>. This
page uses content from files in your package, and contains several sections:

* **README**: If your package includes a README file, then it will be shown as
  the main content at your package's pub.dartlang.org URL.

* **CHANGLOG**: If your package includes a CHANGELOG file, that will be listed
  as one of the tabs at the top of the page.

* **Installing**: The "Installing" tab is generated based on the latest version
  of your package that has been published, giving users a nice recommendation
  of how to include it in their `pubspec.yaml` file.

* **Versions**: The "Versions" tab shows a history of all versions of your
  package that have ever been published, with links to their documentation,
  hosted at [dartdocs.org](https://dartdocs.org), and an archive `.tar.gz`
  file.

* **Sidebar**: The sidebar at your package's pub.dartlang.org URL includes
  information drawn from your `pubspec.yaml` file, including the description,
  author(s), homepage, documentation URL, and a list of uploaders.

For more information about how to write your README and CHANGELOG, take a look
at the [package layout conventions](package-layout.html).

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
