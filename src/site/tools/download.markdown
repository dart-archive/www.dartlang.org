---
layout: default
title: "Download Dart"
description: "The download bundles that support the Dart language."
has-permalinks: false
---

# Getting and Installing Dart Is Easy!

{% include default_toc.html %}

<p class="os-choices">
Confirm your platform: 
 {% include os-choices.html %}
</p>

You have two options for downloading Dart.

## Option 1: Choose the complete bundle {#whole_enchilada}

When you download the Dart Editor bundle, you get everything you
need to create, edit, test, and build both web-based and server-side
applications.

The Dart Editor bundle includes:

* Dart Editor - A powerful tool for editing, debugging, and running Dart
  applications.
* Dartium - A special version of Chromium that includes the Dart VM.
You can use Dartium to test and debug your Dart web applications.
* SDK - The software developers kit includes the Dart Virtual Machine,
  the Dart libraries, and all the command line tools used behind the
  scenes by the Dart Editor:

  * [dart](/tools/dart-vm/) - the standalone VM
  * [dart2js](/tools/dart2js/) - the Dart-to-JavaScript compiler
  * [dartanalyzer](/docs/dart-up-and-running/contents/ch04-tools-dart_analyzer.html) - the static analyzer
  * [pub](/tools/pub/) - the Dart package manager
  * [docgen](docgen/) - the API documentation generator

{% include downloads/_dart-editor.html buttonclass="btn-primary" %}

<aside class="alert alert-info" markdown="1">
**Note:** Dart Editor requires Java version 6 or higher.
Problems? See [Troubleshooting Dart Editor](editor/troubleshoot.html).
</aside>

Dart Editor can automatically update itself, along with the SDK and
Dartium, whenever a new integration build is available. To enable
automatic updates, go to **Preferences**, choose **Update**, and select
**Download updates automatically**.

<aside class="alert alert-info" markdown="1">
**Early Adopter?**  

<span class="windows downloads">
To get new features a few weeks earlier than the stable release,
you can download the latest <strong>Dev Channel</strong> build of
 <a data-tool="editor" class="download-link" data-bits="64" data-os="windows" data-build="continuous" href="https://storage.googleapis.com/dart-archive/channels/dev/release/latest/editor/darteditor-windows-x64.zip">Dart Editor for
Windows 64-bit</a> or
 <a data-tool="editor" class="download-link" data-bits="32" data-os="windows" data-build="continuous" href="https://storage.googleapis.com/dart-archive/channels/dev/release/latest/editor/darteditor-windows-ia32.zip">Dart Editor for
Windows 32-bit</a>.
</span>

<span class="linux downloads">
To get new features a few weeks earlier than the stable release,
you can download the latest <strong>Dev Channel</strong> build of
 <a data-tool="editor" class="download-link" data-bits="64" data-os="linux" data-build="continuous" href="https://storage.googleapis.com/dart-archive/channels/dev/release/latest/editor/darteditor-linux-x64.zip">Dart Editor for
Linux 64-bit</a> or
 <a data-tool="editor" class="download-link" data-bits="32" data-os="linux" data-build="continuous" href="https://storage.googleapis.com/dart-archive/channels/dev/release/latest/editor/darteditor-linux-ia32.zip">Dart Editor for
Linux 32-bit</a>.
</span>

<span class="macos downloads">
To get new features a few weeks earlier than the stable release,
you can download the latest <strong>Dev Channel</strong> build of
 <a data-tool="editor" class="download-link" data-bits="64" data-os="macos" data-build="continuous" href="https://storage.googleapis.com/dart-archive/channels/dev/release/latest/editor/darteditor-macos-x64.zip">Dart Editor for
Mac OS X</a>.
</span>
</aside>

Once the download is complete, unzip the bundle. Dart is installed!

You can now work through the [Avast, Ye Pirates](/codelabs/darrrt/) code lab.

------

## Option 2: Choose only the software that you need {#a_la_carte}
Perhaps you prefer to use a particular IDE or editor, and don't
require the Dart Editor.

No problem!

At the very minimum, you need to download the Dart SDK.
This is the only Dart bundle that you need. Besides the Dart VM,
and the Dart libraries, the SDK bundle contains the command-line Dart tools:

  * [dart](/tools/dart-vm/) - the standalone VM
  * [dart2js](/tools/dart2js/) - the Dart-to-JavaScript compiler
  * [dartanalyzer](/docs/dart-up-and-running/contents/ch04-tools-dart_analyzer.html) - the static analyzer
  * [pub](/tools/pub/) - the Dart package manager
  * [docgen](docgen/) - the API documentation generator

Note that if you choose the à la carte option you have less to download, but
you will occasionally need to perform a manual update when new
versions of Dart are released.

After downloading the software that you need, you may want to customize your
IDE or text editor by [downloading a plugin](more_downloads.html) that
supports Dart.

<p class="os-choices">
{% include downloads/_sdk.html buttonclass="btn btn-primary btn-lg" %}
</p>

If you are writing web-based apps, you should download Dartium.
Dartium is a special build of Chromium that includes a Dart VM
so that you can test and debug your applications without first
compiling them to JavaScript.

{% include downloads/_dartium.html buttonclass="btn btn-primary btn-lg" %}

The Dartium binary expires after 12 weeks.
When that happens, you will need to download a new copy
to continue using Dartium.

<aside class="alert alert-info" markdown="1">
**Early Adopter?**
<span class="windows">
To get new features a few weeks earlier than the stable release,
you can download the latest **Dev Channel** build of the
<a href="https://storage.googleapis.com/dart-archive/channels/dev/release/latest/sdk/dartsdk-windows-x64-release.zip">SDK for Windows 64-bit</a>
or 
<a href="https://storage.googleapis.com/dart-archive/channels/dev/release/latest/sdk/dartsdk-windows-ia32-release.zip">SDK for Windows 32-bit</a>.

<span class="macos">
To get new features a few weeks earlier than the stable release,
you can download the latest **Dev Channel** build of the
<a href="https://storage.googleapis.com/dart-archive/channels/dev/release/latest/sdk/dartsdk-macos-x64-release.zip">SDK for Mac OS X</a>.
</span>

<span class="linux">
To get new features a few weeks earlier than the stable release,
you can download the latest **Dev Channel** build of the
<a href="https://storage.googleapis.com/dart-archive/channels/dev/release/latest/sdk/dartsdk-linux-x64-release.zip">SDK for Linux 64-bit</a>
or
<a href="https://storage.googleapis.com/dart-archive/channels/dev/release/latest/sdk/dartsdk-linux-ia32-release.zip">SDK for Linux 32-bit</a>.
</span>

<span class="windows">
You can also download the latest **Dev Channel** build of
<a href="https://storage.googleapis.com/dart-archive/channels/dev/release/latest/dartium/dartium-windows-ia32-release.zip">Dartium for Windows</a>.
</span>

<span class="macos">
You can also download the latest **Dev Channel** build of
<a href="https://storage.googleapis.com/dart-archive/channels/dev/release/latest/dartium/dartium-macos-ia32-release.zip">Dartium for Mac OS X</a>.
</span>

<span class="linux">
You can also download the latest **Dev Channel** build of
<a href="https://storage.googleapis.com/dart-archive/channels/dev/release/latest/dartium/dartium-linux-x64-release.zip">Dartium for Linux 64-bit</a>
or
<a href="https://storage.googleapis.com/dart-archive/channels/dev/release/latest/dartium/dartium-linux-ia32-release.zip">Dartium for Linux 32-bit</a>.
</span>
</aside>

### Dart SDK for Debian and Ubuntu

If you are writing server-side code for Debian or Ubuntu, you can get a
Debian package with a 64-bit version of the SDK that allows for easy
installation of the Dart VM and tools on Debian wheezy and Ubuntu machines.
Choose either the **Stable Channel** or **Dev Channel** release.
The dev channel allows you to try new features ahead of the stable release.

{% include downloads/_debian.html buttonclass="btn btn-primary btn-lg" %}

------

### Note for Linux Users
If your system uses an older version of Ubuntu and you are compiling the
SDK, you may need to update to GCC 4.6 or later.
See the <a href="faq.html">Tools FAQ</a> for more information.

------

## Feedback
We welcome all of your feedback! Submit comments using the
SEND FEEDBACK link in the upper right corner of the Dart Editor window,
or file a bug on [dartbug.com](http://dartbug.com).
