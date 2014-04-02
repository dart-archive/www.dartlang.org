---
layout: default
title: "Pub Assets and Transformers"
---

{% include toc.html %}

# {{ page.title }}

The [`pub serve`](cmd/pub-serve.html) and [`pub build`](cmd/pub-build.html)
commands use [transformers][] to prepare a package's [assets][] to be served
locally or to be deployed, respectively.

Use the `pubspec.yaml` file to specify which transformers your package uses
and, if necessary, to configure the transformers. (See
[Specifying transformers](#specifying-transformers) for details.) For example:

<pre>
name: myapp
dependencies:
  <b>polymer: any</b>
<b>transformers:
- polymer:
    entry_points:
    - web/index.html
    - web/index2.html</b>
</pre>

A package's assets must be in one or more of the following directories:
`lib`, `asset`, and `web`. After transformation by `pub build`, assets are
available under a directory called `build`. Assets generated from
files in a package's `lib` directory appear under a directory named
<code>packages/<em>&lt;pkg_name></em></code>, and those from the package's
`asset` directory appear under <code>assets/<em>&lt;pkg_name></em></code>.
For details, see
[Where to put assets](#where-to-put-assets) and
[How to refer to assets](#how-to-refer-to-assets).

## How transformers work {#how-transformers-work}

Here are some examples of transformers:

* The dart2js transformer, which reads in all of the `.dart` files for a
  program and compiles them to a single `.js` file.
* The polymer transformer, which converts HTML and Dart files into
  optimized HTML and Dart files.
* A linter that reads in files and produces warnings but no actual file.

Although you specify which transformers to use, you don't explicitly say
which transformers should be applied to which assets. Instead, each
transformer determines which assets it can apply itself to. For `pub serve`,
the transformers run when the dev server starts up and whenever a source
asset changes. The `pub build` command runs the transformers once and
then exits.

As the following figure shows, source assets can pass through, untransformed,
and become generated assets. Or a source asset can be transformed, such as a
`.dart` file (along with the `.dart` files that it refers to) that is
compiled to `.js`.

![a figure showing source assets and generated assets; the .html, .css, and .png files pass through, untransformed; the .dart file is transformed into a .js file (and, for pub serve only, the .dart file is passed through, as well)](/tools/images/assets-and-transformers.png)

Dart files are a special case. The `pub build` command doesn't produce `.dart`
files because browsers in the wild don't support Dart natively (yet). The `pub
serve` command, on the other hand, does generate `.dart` assets, because
you can use Dartium while you're developing your app.

## Specifying transformers  {#specifying-transformers}

To tell pub to apply a transformer to your package's assets, specify the
transformer, as well as the package that contains the transformer, in your
package's `pubspec.yaml` file. In the following pubspec, the bold lines
specify that this package requires the polymer transformer, which is in the
polymer package (along with the rest of Polymer.dart):

<pre>
name: myapp
dependencies:
  <b>polymer: any</b>
<b>transformers:
- polymer:
    entry_points: web/index.html</b>
</pre>

The following example configures the [dart2js](/tools/dart2js/)
transformer, which is used by both [`pub serve`](cmd/pub-serve.html)
and [`pub build`](cmd/pub-build.html), to analyze the code:

{% prettify yaml %}
transformers:
- $dart2js:
  analyzeAll: true
{% endprettify %}

For more information, see
[Configuring the Built-in dart2js Transformer](dart2js-transformer.html).

We expect more transformers to be available in the future. You can specify
multiple transformers, to run either in parallel (if they're independent of
each other) or in separate phases. To specify that transformers run in
parallel, use [<code><em>transformer_1</em>, ...,
<em>transformer_n</em></code>]. If order matters, put the transformers on
separate lines.

For example, consider three transformers, specified as follows:

{% prettify yaml %}
transformers:
- [t1, t2]
- t3
{% endprettify %}

The `t1` and `t2` transformers run first, in parallel. The `t3` transformer
runs in a separate phase, after `t1` and `t2` are finished, and can see the
outputs of `t1` and `t2`.

Pub implicitly appends a transformer that converts your Dart code to
JavaScript, so your code can run in any modern browser.

## Where to put assets  {#where-to-put-assets}

If you want a file to be an _asset_&mdash;to either be in or be used to
generate files in the built version of your package&mdash;then you need to
put it under one of the following directories:

* `lib`: Dart libraries defining the package's public API. Visible in all
  packages that use this package. Assets in `lib/src` are invisible
  to other packages.
* `asset`: Other public files. Visible in all packages that use this
  package. This directory may be phased out in the future. For more
  information, see
  [issue 16647](https://code.google.com/p/dart/issues/detail?id=16647).
* `web`: A web app's static content plus its main Dart file (the one that
  defines `main()`). Visible _only_ to this package.

The following picture shows how you might structure your app's source assets,
with your main Dart file under `web` and additional Dart files under `lib`.

<pre>
<em>app</em>/
  lib/
    *.dart
  packages/
    pck/
      lib/
        *.dart
        *.js
      asset/
        *.png
        *.html
        ...
  web/
    <em>app</em>.dart
    *.html
    *.css
    *.png
    ...
</pre>

After transformation, `pub build` places generated assets under a directory
named `build`, which we'll call the _build root_. The build root has two
special subdirectories: `packages` and `assets`. The dev server simulates this
hierarchy without generating files.

The following figure shows the source assets above, plus the generated assets
produced by `pub build` if the only transformer is dart2js. In this example,
all the source files have corresponding generated files, and all the Dart
files have been compiled into a single JavaScript file.

![under the build directory are assets/ and packages/ directories, plus a bunch of files derived from the web/ directory: app.dart.js, *.html, *.css, *.png, ...](/tools/images/input-and-output-assets.png)


## How to refer to assets

Here's how source asset locations correlate to generated asset locations,
for untransformed files:

<table>
  <tr>
    <th> Source asset location </th>
    <th> Generated asset location<br>(under the build root) </th>
  </tr>
  <tr>
    <td> <code>.../<em>&lt;your_pkg></em>/web/<em>&lt;path></em></code> </td>
    <td> <code>/<em>&lt;path></em></code> </td>
  </tr>
  <tr>
    <td> <code>.../<em>&lt;pkg_name></em>/asset/<em>&lt;path></em></code> </td>
    <td> <code>/assets/<em>&lt;pkg_name></em>/<em>&lt;path></em></code> </td>
  </tr>
  <tr>
    <td> <code>.../<em>&lt;pkg_name></em>/lib/<em>&lt;path></em></code> </td>
    <td> <code>/packages/<em>&lt;pkg_name></em>/<em>&lt;path></em></code> </td>
  </tr>
</table>

For example, consider a helloworld app's HTML file, which is in the
helloworld directory at `web/helloworld.html`. Running `pub build` produces a
copy at `build/helloworld.html`. In the dev server, you can get the HTML file
contents by using the URL `http://localhost:8080/helloworld.html`.

Transformers might change any part of <em>&lt;path></em>, especially the
filename, but they can't change the directory structure above
<em>&lt;path></em>.

[assets]: glossary.html#asset
[transformers]: glossary.html#transformer

## How to exclude assets {#exclude-assets}

If you have an asset that you do not want a transformer to process,
you can exclude it, by name, in the pubspec. For example, a transformer
named `simple_transformer` operates on HTML files,
but you do not want it to process your `lib/README.html` file.
You can exclude it by using the `$exclude` tag. The following example
tells pub to run the transformer on everything it would normally
process _except_ for lib/foo.html:

{% prettify yaml %}
transformers:
- simple_transformer:
    $exclude: "lib/foo.html"
{% endprettify %}

You must indent the `$exclude` line by at least 4 spaces and provide
the file's location from the top of the package.

If you want a transformer to run _only_ on a particular file, you can
use `$include`. The following example tells pub to run the transformer
only on lib/foo.html, assuming that foo.html is a file type that it
would operate on under normal conditions:

{% prettify yaml %}
transformers:
- simple_transformer:
    $include: "lib/foo.html"
{% endprettify %}

You can't use the include tag to force a transformer to operate on a
file type that it would not otherwise process.

You can also specify a list of files for the include or exclude tags:

{% prettify yaml %}
$exclude ["lib/foo.html", "lib/bar.html"]
{% endprettify %}

## How to configure assets {#configure-assets}

You can use include and exclude to make a transformer, 
such as dart2js, treat certain assets in a special way.

For example, say that your project includes a Dart file that
was written by another programmer who wasn't as careful as you are
about cleaning up compiler warnings. You want to suppress the
warnings from the dart2js compiler _for this particular file_
when running `pub build` or `pub serve`.
The offending code is in the `lib/lax_code.dart` file.
You can disable the warnings only on that file by using
the following:

{% prettify yaml %}
transformers:
- $dart2js:
    suppressWarnings: true
    $include: "lib/lax_code.dart"
- $dart2js:
    suppressWarnings: false
    $exclude: "lib/lax_code.dart"
{% endprettify %}

This suppresses warnings when processing lib/lax_code.dart, but
allows warnings when compiling all other Dart files.

## Writing a transformer {#writing-transformer}

To write a transformer, see
[Writing a Pub Transformer](transformers/index.html).
