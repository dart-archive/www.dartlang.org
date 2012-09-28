---
layout: default
title: "Getting Started"
description: "What is a Dart application?"
tutorial:
  id: gs-index
---

{% capture whats_the_point %}

* Run Dart applications in the Dart VM.
* The Dart VM runs in a web browser...
* ...or on the command line.
  

{% endcapture %}

{% capture content %}

# {{ page.title }}


When you have completed this getting started section,
you will have successfully downloaded the Dart software,
created and run two small applications,
and will be ready to get started writing web apps in Dart.

[The Dart Software Package](dart-software.html)

: In this section, you will download the Dart software
and learn about the software and tools that it contains.


## What is a Dart Application?

A Dart application is a software program
written in the Dart programming language.
All Dart applications are comprised of
at least one Dart source file
(a file with the `.dart` suffix)
that contains a `main` function.

The Dart VM,
which you get with the Dart software download,
is required to run Dart applications.
Depending on where the Dart VM is running,
your application is either a
command-line application or a web application.

**Define**: A _command-line application_
is invoked from the command line,
and runs independently of a web browser.
Because Dart is a general-purpose,
object-oriented language you can use it
to write any sort of program,
such as server-side scripts, stand-alone applications and servers.
Command-line apps are often used
to provide server-side functionality to a web app.

**Define**: A _web application_
runs inside of a browser page.
Typically, a web app provides the client-side user interface
for a server.
To write a web application,
you must understand the DOM (Document Object Model),
which is an API for accessing and maninpulating
a browser page and the page elements on it.
This tutorial primarily interests itself in web applications.

[Create and Run a Command-line App](command-line-app.html)

: This section shows you how to create and run
a command-line app.
You will also get started using Dart Editor.

[A Minimal Web App](minimal-web-app.html)

: This section shows you how to create a minimal web app
and describes its files and their contents.
In addition, it provides an overview
of the Document Object Model and the basic objects
your Dart program can access and manipulate.

{% endcapture %}

{% include tutorial.html %}