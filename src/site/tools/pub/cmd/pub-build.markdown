---
layout: default
title: "pub build"
---

# {{ page.title }}

_Build_ is one of the commands of the [pub](/tools/pub/) tool.

    $ pub build [--mode=<mode>]

Use `pub build` when you're ready to deploy your web app. When you run
`pub build`, it generates the [assets](glossary.html#asset) for the current
package and all of its dependencies, putting them into a new directory
named `build`.

To use `pub build`, just run it in your package's root directory. For example:

    $ cd ~/dart/helloworld
    $ pub build
    Building helloworld......
    Built 5 files!

If the build directory already exists, `pub build` deletes it and then creates
it again.

To generate assets, `pub build` uses
[transformers](glossary.html#transformer). Any source assets that aren't
transformed are copied, as is, into the build directory or one of its
subdirectories. Pub also automatically compiles your Dart application to
JavaScript using dart2js.

See [Pub Assets and Transformers](assets-and-transformers.html) for information on:

* Where in your package to put assets.
* What URLs to use when referring to assets.
* How to use `pubspec.yaml` to specify which transformers run, and in
  what order.

Also see [`pub serve`](pub-serve.html). With `pub serve`, you can run a
development server that continuously generates and serves assets.

<aside class="alert alert-info" markdown="1">
**Note:** In earlier releases of Dart, _pub build_ was called _pub deploy_.
</aside>

## Options

### `--mode=<mode>`

Specifies a transformation mode. Typical values are "debug" and "release", but
any word is allowed. Transformers may use this to change how they behave.

If set to "release" pub generates minified JavaScript using dart2js.
Otherwise, it generates it unminified. Also, in release mode, pub does not
include any source .dart files in the resulting build output since they have
been compiled to JavaScript. In any other mode, the raw Dart files are
included.

If omitted, it defaults to "release".
