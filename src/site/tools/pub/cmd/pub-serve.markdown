---
layout: default
title: "pub serve"
---

# {{ page.title }}

_Serve_ is one of the commands of the _pub_ tool.
[Learn more about pub](/tools/pub/).

{% prettify lang-sh %}
$ pub serve [--port <number>]
{% endprettify %}

This command starts up a _development server_, or _dev server_,
for your Dart web app. The dev server is an HTTP server on localhost
that serves up your web app's [assets](/tools/pub/glossary.html#asset).

Start the dev server from the directory that contains your web app's
`pubspec.yaml` file:

{% prettify lang-sh %}
$ cd ~/dart/helloworld
$ pub serve
Serving helloworld on http://localhost:8080
{% endprettify %}

The dev server doesn't just serve up assets, it produces them by running
[transformers](/tools/pub/glossary.html#transformer). A transformer converts
input assets (such as Dart files or Polymer-formatted HTML) into output assets
(such as JavaScript and HTML).

These output assets aren't in the file system; they exist only in the dev
server. When you're ready to deploy, generate output files by running
[`pub build`](pub-build.html).

Pub automatically includes a dart2js transformer that compiles your Dart code
to JavaScript. With this, you can change some Dart code, refresh your
non-Dartium browser, and immediately see the changes.

See
[Configuring the Built-in dart2js Transformer](/tools/pub/dart2js-transformer.html)
for information on how to configure the dart2js options in your pubspec.

See [Pub Assets and Transformers](/tools/pub/assets-and-transformers.html) for
information on:

* Where in your package to put assets.
* What URLs to use when referring to assets.
* How to use `pubspec.yaml` to specify which transformers run, and in
  what order.

## Options

For options that apply to all pub commands, see
[Global options](index.html#global-options).

### `--port`

By default the dev server uses `http://localhost:8080`. To change the port
number, use the `--port` option:

{% prettify lang-sh %}
$ pub serve --port 9080
Serving helloworld on http://localhost:9080
{% endprettify %}

### `--mode=<mode>`

Specifies a transformation mode. Typical values are "debug" and "release", but
any word is allowed. Transformers may use this to change how they behave.

If set to "release" pub generates minified JavaScript using dart2js.
Otherwise, it generates it unminified. Also, in release mode, Pub does not
include any source .dart files in the resulting build output since they have
been compiled to JavaScript. In any other mode, the raw Dart files are
included.

If omitted, it defaults to "debug".

## What about Dart Editor's server?

Dart Editor has its own dev server. We plan to unify it with the
pub dev server soon.
