---
layout: default
title: "Getting Started"
description: "Download Dart and create and run two Dart applications"
tutorial:
  id: gs-index
---

{% capture whats_the_point %}

* Run Dart applications in the Dart VM.
* The Dart VM runs in a Web browser...
* ...or on the command line.
* All Dart apps have a `main` function.
  

{% endcapture %}

{% capture content %}

# {{ page.title }}

When you have completed this Target,
you will have successfully downloaded the Dart software,
created and run two small applications,
and will be ready to begin writing Web apps in Dart.

[Set Up Your Dart Installation](dart-software.html)
: In this section, you will download the Dart software
and learn about the software and tools that it contains.

[Brief Introduction to Dart Editor](dart-editor.html)
: shows you a few key features of Dart Editor that will
help you be more efficient when writing Dart programs.


## What is a Dart Application?

A Dart application is a software program
written in the Dart programming language.
A Dart application is comprised of
at least one Dart source file
(a file with the `.dart` suffix)
and contains exactly one `main` function.
The Dart VM,
which you get with the Dart software download,
runs Dart applications
either from the command line or within a web browser.

Thus, there are two kinds of Dart applications:

A _command-line application_

: is invoked from the command line,
and runs independently of a Web browser.
Because Dart is a general-purpose,
object-oriented language you can use it
to write any sort of program,
such as server-side scripts,
stand-alone applications and servers.
Command-line apps are often used
to provide server-side support to a Web app.
The `dart` executable file that is included with the
Dart download implements the Dart VM.
Use it to run command-line applications.
Alternatively, you can run it in Dart Editor.

A _Web application_

: runs inside of a browser page.
Often, a Web app provides the client-side user interface
for a server.
To write a Web application,
you must understand the DOM (Document Object Model),
which is an API implemented by all modern browsers
for accessing and manipulating
a browser page and its page elements,
such as text, headers and canvases.
This tutorial primarily interests itself in Web applications.

The Chromium build that is included in the Dart download
has the Dart VM built-in.
You can run your Dart Web apps directly in this version of Chromium.
Alternatively,
if you want to see your Web app in a browser
that does not yet support Dart,
you can compile your Dart code to JavaScript
using the Dart->JavaScript compiler included with the Dart installation.

[Create and Run a Command-line App](command-line-app.html)

: This section shows you how to create and run
a command-line app.
You will also get started using Dart Editor.

[A Minimal Web App](minimal-web-app.html)

: This section shows you how to create a minimal Web app
and describes its files and their contents.
In addition, it provides an simplistic glimpse
of the Document Object Model and the basic objects
your Dart program can access and manipulate.

[Named Launches](named-launches.html)

: [xx: ]

{% endcapture %}

{% include tutorial.html %}