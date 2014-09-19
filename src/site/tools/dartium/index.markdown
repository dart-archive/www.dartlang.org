---
layout: default
title: "Dartium"
description: "Download and use Dartium, a build of Chromium with an embedded Dart VM."
has-permalinks: false
---

{% include toc.html %}
{% include breadcrumbs.html %}

# {{ page.title }}

Dartium is a special build of Chromium that includes the Dart VM.
Using Dartium means you don't have to compile your code to JavaScript
until you're ready to test on other browsers.
To learn about other tools you can use for Dart development,
see [Dart Tools](/tools/).

<aside class="alert alert-warning" markdown="1">
**Warning:** This browser is a technical preview,
and it might have security and stability issues.
**Do not use Dartium as your primary browser!**
</aside>


## Getting Dartium

If you have an up-to-date version of [Dart Editor](/tools/editor/),
you already have Dartium.

Otherwise, you can <a href="/tools/download.html">download Dartium</a> directly.

## Installing Dartium

You don’t usually need to do anything special to install Dartium:
just unarchive the ZIP file.
If you want Dart Editor to launch a particular copy of Dartium,
then put that copy inside the `dart-sdk` directory
of your Dart Editor installation directory,
replacing its original copy of Chromium.

<aside class="alert alert-info" markdown="1">
**Note**: While this tool is _referred to_ as Dartium,
the executable is named `Chromium`. In the Dart Editor bundle,
it is located in the `chromium` directory.
</aside>

## Setting the API keys

To use some features in the Google APIs, such as geolocation 
from the Google Maps API, you need to set the API keys in Dartium.
You can either build a special version of Dartium with the API
keys baked in, or you can specify the keys at runtime.
The [API Keys](http://www.chromium.org/developers/how-tos/api-keys)
page has information on how to acquire and use the API keys.

## Using Dartium

For details on using Dartium, read
[Dartium: Chromium with the Dart VM](/docs/dart-up-and-running/contents/ch04-tools-dartium.html).

## Filing bugs and feature requests

To file a bug, use the
[Dartium issue template](https://code.google.com/p/dart/issues/entry?template=Defect%20report%20for%20Dartium).
To see existing issues, go to the
[Dartium issue list](https://code.google.com/p/dart/issues/list?can=2&amp;q=label%3AArea-Dartium).
