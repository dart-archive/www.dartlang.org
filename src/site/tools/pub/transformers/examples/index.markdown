---
layout: default
title: "Writing a Pub Transformer: Examples"
---

# {{ page.title }}

{% include toc.html %}

When _pub_ serves or builds an app, it can run one or more
transformers. ([Learn more about pub](/tools/pub/).)

Transformers operate on _assets_, where an asset is a resource,
such as a Dart file, a CSS file, or an image, that is intended to
be part of a deployed package.
([Learn more about assets and transformers](/tools/pub/assets-and-transformers.html).)

The following are examples of custom transformers written using
the [barback](http://pub.dartlang.org/packages/barback) package.
See [Writing a Pub Transformer](/tools/pub/transformers/) for more information
about these examples.

* [SimpleTransformer](SimpleTransformer.zip)
  inserts a copyright string at the beginning of a ".txt" file.

* [MarkdownConverter](MarkdownConverter.zip)
  converts a markdown file (with either a ".mdown", ".md", or
  a ".markdown" extension) to HTML. The output asset has
  an ".html" extension.

Once you download and unzip these examples, you can run
`pub build` to generate the assets. Sample input assets are
included under the `asset` directory, and the output assets
(after running `pub build`) are placed under the `build`
directory.
