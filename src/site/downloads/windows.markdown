---
layout: default
title: "Installing the Dart SDK on Windows"
description: "Installing Dart on your Windows platform."
---

{% include breadcrumbs.html %}

# {{ page.title }}

If you're using Windows, you have two options for downloading Dart.

* [Installing using Chocolatey](#chocolatey)
* [Downloading Dart manually](#manual)

## Installing using Chocolatey {#chocolatey}

With [Chocolatey](https://chocolatey.org/),
installing Dart is easy.

The **dart** package contains the [Dart SDK](/tools/sdk/),
which includes the Dart VM, libraries, and command-line Dart tools such as
[dart](/tools/dart-vm/), [dart2js](/tools/dart2js/),
[dartanalyzer](/docs/dart-up-and-running/contents/ch04-tools-dart_analyzer.html),
[pub](/tools/pub/), and [dartdocgen](/tools/dartdocgen/).
Optionally, you can add one more tool:

* [Dartium](/tools/dartium/):
  A special build of Chromium that includes a Dart VM.
  Use it to interactively test and debug Dart web apps
  without first compiling them to JavaScript.

For client-side Dart work, you might want to download *both* tools. If you're working on server-side Dart, all you need is the `dart-sdk`:

{% prettify sh %}
choco install dart-sdk -version <version>
choco install dartium  -version <version>
{% endprettify %}

For example, to download version 1.11.0:

{% prettify sh %}
choco install dart-sdk -version 1.11.0
choco install dartium  -version 1.11.0
{% endprettify %}

{% comment %}
To choose the dev channel version,
use `-dev<dev-version>`. For example:

{% prettify sh %}
choco install -y dart-sdk -version 1.12.0-dev.2.2 
choco install -y dartium  -version 1.12.0-dev.2.2
{% endprettify %}
{% endcomment %}

For more information on Chocolatey support for Dart, see:

* [Dart SDK package](https://chocolatey.org/packages/dart-sdk/)
  on [chocolatey.org](https://chocolatey.org/)
* [Dartium package](https://chocolatey.org/packages/dartium/)
  on [chocolatey.org](https://chocolatey.org/)
* [Blog post](http://divingintodart.blogspot.co.uk/2015/05/chocolatey-dart-packages-for-windows-110.html)
  on [Diving Into Dart](http://divingintodart.blogspot.co.uk/)

## Downloading Dart manually {#manual}

You can manually download and extract the Dart SDK from a zip file.
You can get the latest **stable channel** release:

<div class="text-center">
<div class="downloads download-buttons text-center">
{% capture platform_name %}64-bit Windows, stable{% endcapture %}
{% include downloads/_sdk-button.html name=platform_name buttonclass=btn-primary bits="64" os="windows" arch="x64" %}

{% capture platform_name %}32-bit Windows, stable{% endcapture %}
{% include downloads/_sdk-button.html name=platform_name buttonclass=btn-primary bits="32" os="windows" arch="ia32" %}
</div>
<div class="editor-current-version version">
  Current stable version of Dart:
  <span class="editor-build-rev-stable">[calculating]</span>
</div>
</div>

Or, for the latest bits, get the most recent **dev channel** release:

<div class="text-center">
<div class="downloads download-buttons">
{% capture platform_name %}64-bit Windows, dev{% endcapture %}
{% include downloads/_sdk-button-dev.html name=platform_name buttonclass=btn-primary bits="64" os="windows" arch="x64" %}

{% capture platform_name %}32-bit Windows, dev{% endcapture %}
{% include downloads/_sdk-button-dev.html name=platform_name buttonclass=btn-primary bits="32" os="windows" arch="ia32" %}
</div>
<div class="editor-current-version version">
  Current dev version of Dart:
  <span class="editor-build-rev-dev">[calculating]</span>
</div>
</div>

If you're writing a web app, we recommend getting
[Dartium](/tools/dartium/), as well:

<div class="text-center">
<div class="downloads download-buttons">
{% include downloads/_dartium.html name="Windows, stable" buttonclass=btn-primary bits="32" os="windows" arch="ia32" %}
</div>
<div class="downloads download-buttons">
{% include downloads/_dartium-dev.html name="Windows, dev" buttonclass=btn-primary bits="32" os="windows" arch="ia32" %}
</div>
</div>

The Dartium binary expires after 1 year.
When that happens, you need to
download a new copy to continue using Dartium.
