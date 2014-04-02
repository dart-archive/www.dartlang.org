---
layout: default
title: "Installing and Configuring Pub"
---

{% include toc.html %}

# {{ page.title }}

[Pub](/tools/pub/) is in the [Dart SDK](/tools/sdk/),
which you can download by itself or as part of
[Dart Editor](/tools/editor/).
You can use pub through
[Dart Editor](/tools/editor/), or through the
`pub` command-line app, which lives inside the `bin` directory of the Dart SDK.

To use pub and other tools on the command line,
you might want to add the SDK's `bin` directory to your system path.
For example, on Mac and Linux:

    export PATH=$PATH:<path to sdk>/bin

Here, `<path to sdk>` is the absolute path
to the main directory of the SDK. For example,
if you install Dart Editor in
`/home/me/dart`, then add the following to your PATH:

    /home/me/dart/dart-sdk/bin

On Windows, you can set the system PATH environment variable through the
Control Panel. A quick
[search](https://www.google.com/search?q=windows+set+environment+variable)
should find the instructions for your version of Windows.

