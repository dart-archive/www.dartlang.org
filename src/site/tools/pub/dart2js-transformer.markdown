---
layout: default
title: "Configuring the Built-in dart2js Transformer for Pub"
---

{% include breadcrumbs.html %}

# {{ page.title }}

The [pub serve](cmd/pub-serve.html), [pub build](cmd/pub-build.html),
and [pub run](cmd/pub-run.html) commands use the [dart2js](/tools/dart2js/)
compiler to convert your Dart files to JavaScript.

You can configure dart2js in the [pubspec](/tools/pub/pubspec.html)
for your package.
To do this, add `$dart2js` (note the leading dollar sign) under the
`transformers:` field.

For example, by default, `pub` minifies an app when in release mode
(`pub build` defaults to `release` mode), but not otherwise
(`pub serve` defaults to `debug` mode).
The following example ensures that pub minifies the app in all situations:

{% prettify yaml %}
transformers:
- $dart2js:
    minify: true
{% endprettify %}

Some apps, for example, Chrome Apps and apps that run as Chrome extensions,
must generate the CSP (content-security policy) version of JavaScript.
You can do this by passing the `--csp` flag to dart2js with a value of `true`.

<aside class="alert alert-info" markdown="1">
**Version note:**
Prior to Dart 1.8, the CSP version of JavaScript was generated
automatically, and saved with the extension `.precompiled.js`.
As of the 1.8 release, you must specify the CSP format using the `--csp`
flag and the resulting file is saved with the normal `.js` extension.
</aside>

You can specify the `csp` flag in the pubspec file, as follows:

{% prettify yaml %}
transformers:
- chrome
- $dart2js:
  csp: true
{% endprettify %}

## Options {#options}

The following options are available. For more information on how these options
work, see the [documentation](/tools/dart2js/#options) for dart2js:

{% prettify yaml %}
transformers:
- $dart2js:
    checked: true
    minify: true
    verbose: true
    environment: {name: value, ...}
    analyzeAll: true
    sourceMaps: true
    suppressWarnings: true
    suppressHints: true
    terse: true
    csp: true
{% endprettify %}

For command-line options not covered in this list,
such as `--enable-enum`, see [Special-case options](#additional-options).

## Excluding an asset {#exclude-assets}

You can also exclude a particular asset, or set of assets,
from being processed by a transformer.
You can also configure a transformer to run
only on a particular asset, or set of assets.
For more information, see
[How to exclude assets](assets-and-transformers.html#exclude-assets) in
[Pub Assets and Transformers](assets-and-transformers.html).

## Special-case options {#additional-options}

`commandLineOptions: [...args...]`

In addition to the options previously listed, `commandLineOptions`
is available as a fallback for cases where a new command-line option has
been added to dart2js, but a corresponding configuration option has not
yet been added to pub.

An example of this is the `--enable-enum` option. 

{% prettify yaml %}
dependencies:
  polymer: '>=0.14.0 <0.15.0'
  core_elements: any
  browser: any
  range:
transformers:
- polymer:
    entry_points: web/index.html
[[highlight]]- $dart2js:
    commandLineOptions: [--enable-enum][[/highlight]]
{% endprettify %}
