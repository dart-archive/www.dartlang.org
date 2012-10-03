---
layout: default
title: "Set up your Dart installation"
description: "What comes with the Dart Software?"
tutorial:
  id: gs-download
---

{% capture whats_the_point %}

* Dart Editor helps you with file management and debugging.
* The Dart VM can run on the command-line.
* You can run Dart web programs in Dartium.
* The dart2js tool converts Dart programs to JavaScript.
  
{% endcapture %}

{% capture content %}

# {{ page.title }}

Go to the 
[Downloads and Source](/downloads.html)
page and download the Dart package under
**Everything you need**.
It includes the Dart Editor,
which you will be using throughout this tutorial.

## What comes in the Dart software package?

[XX: I want this to be a table.]

![DartEditor](images/DartEditor.png)

Dart Editor is a powerful, lightweight, open source editor.
With it you can create and edit files,
manage the files for your project,
debug your code, and
control run-time conditions using named launches.
[XX: I'm certain there's more excellence.]

![Chromium](images/chromium.png)

Your download contains a special build of the chromium web browser
that includes the Dart VM.

![Dart SDK Folder](images/dart-sdk-folder.png)

The `dart-sdk` directory contains the complete
Dart Software Development Kit.
Here you will find Dart libraries,
such as `dart.core` and `dart.html`,
that define APIs useful to all apps and web apps.

The `dart-sdk/bin` contains several useful command-line tools.
In particular,
there's `dart2js`, the Dart->JavaScript compiler,
and `dart`, the command-line version of the Dart VM.

![Dart SDK Folder](images/samples-folder.png)

The `samples` directory contains the source code for several
Dart web applications.


**Plus some other stuff...**

You will notice there are some other directories
in the dart installation directory.
Don't mind your pretty little head about them.
They are of no concern to us just yet.

{% endcapture %}

{% include tutorial.html %}