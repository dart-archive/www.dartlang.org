---
layout: default
title: "Writing a Pub Transformer: Examples"
---
{% include breadcrumbs.html %}

# {{ page.title }}

When _pub_ serves or builds an app, it can run one or more
transformers. ([Learn more about pub](/tools/pub/).)

Transformers operate on _assets_, where an asset is a resource,
such as a Dart file, a CSS file, or an image, that is intended to
be part of a deployed package.
([Learn more about assets and transformers](/tools/pub/assets-and-transformers.html).)

The following are examples of custom transformers written using
the [barback](http://pub.dartlang.org/packages/barback) package.
The description for each example states where you can get more information
about that particular example.

aggregate_transformer
: Combines partial HTML files contained in a "recipes" directory into a
  single HTML file. See
  [Writing an Aggregate Transformer](/tools/pub/transformers/aggregate.html)
  for more information.

markdown_converter
: Converts a markdown file (with either a ".mdown", ".md", or
  a ".markdown" extension) to HTML. The output asset has
  an ".html" extension.  See
  [Writing a Pub Transformer](/tools/pub/transformers/) for more information.

simple_transformer
: Inserts a copyright string at the beginning of a ".txt" file. See
  [Writing a Pub Transformer](/tools/pub/transformers/) for more information.

You get all of these examples when you download the
[`barback`](http://pub.dartlang.org/packages/barback) package.

Once you download and open the barback package, these examples
are under the `/example` directory.  You can run
`pub build` to generate the assets, or `pub serve` to serve
the assets. Sample input assets are
included, and the output assets (after running `pub build`)
are placed under the `build` directory.
