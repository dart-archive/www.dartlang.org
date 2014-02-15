---
layout: default
title: "Configuring the Built-in dart2js Transformer"
--- 

# {{ page.title }}

The [pub serve](cmd/pub-serve.html) and [pub build](cmd/pub-build.html)
commands use the [dart2js](/tools/dart2js/) compiler to convert your
Dart files to JavaScript.

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

## Options {#options}

The following options are available. For more information on how these options
work, see the [documentation](/tools/dart2js/#options) for dart2js:

{% prettify yaml %}
transformers:
- $dart2js:
  checked: true,
  minify: true,
  verbose: true,
  environment: {name: value, ...},
  analyzeAll: true,
  suppressWarnings: true,
  suppressHints: true,
  terse: true
{% endprettify %}

## Special-case option {#additional-options}

`commandLineOptions: [...args...]`

In addition to the options previously listed, `commandLineOptions`
is available as a fallback for cases where a new command line option has
been added to dart2js, but a corresponding configuration option has not
yet been added to pub.
