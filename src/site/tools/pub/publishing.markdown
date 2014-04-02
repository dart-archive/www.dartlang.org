---
layout: default
title: "Publishing a Package"
---

{% include toc.html %}

# {{ page.title }}

[Pub](/tools/pub) isn't just for using other people's packages. It also allows you to share
your packages with the world. Once you've written some useful code and you want
everyone else to be able to use it, just run:

    $ pub publish

Pub will check to make sure that your package follows the [pubspec
format](pubspec.html) and [package layout conventions](package-layout.html),
and then upload your package to [pub.dartlang.org](http://pub.dartlang.org).
Then any Pub user will be able to download it or depend on it in their
pubspecs. For example, if you just published version 1.0.0 of a package named
`transmogrify`, then they can write:

{% prettify yaml %}
dependencies:
  transmogrify: ">= 1.0.0 < 2.0.0"
{% endprettify %}

Keep in mind that publishing is forever. As soon as you publish your package,
users will be able to depend on it. Once they start doing that, removing
the package would break theirs. To avoid that, pub strongly discourages
deleting packages. You can always upload new versions of your package, but
old ones will continue to be available for users that aren't ready to
upgrade yet.

For more information, see the reference pages for:

* [`pub publish`](cmd/pub-lish.html)
* [`pub uploader`](cmd/pub-uploader.html)
