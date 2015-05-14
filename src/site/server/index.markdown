---
layout: default
title: "Dart on the Server"
description: "Information on server-side programming for Dart."
has-permalinks: false
---

# {{ page.title }}

Dart is a great fit for server applications.

* Runs nearly everywhere
* Does nearly everything
* Easy to develop and debug
* Scales out

The Dart VM runs anywhere you can get a Linux, Windows, or Mac prompt.
It has been ported to i32, x64, ARM, ARM64, and MIPS.

You can access files, UDP and TCP sockets, HTTP, Web sockets, and more with the
[dart:io libraries][dart_io_libs]. Write a server, connect to a REST service,
parse JSON, and more.

Debugging and profiling your server app is easy with
[Observatory](/tools/observatory/). Connect
to your VM with your browser, and get real-time insight into your running
app.

Use [Isolates][isolate-docs] for secure, concurrent apps. Spawn an isolate to
run Dart
functions and libraries in an _isolated heap_, and take advantage of
multiple CPU cores.

Asynchronous code is easy to write, with the new _async/await/yield_
language features.

RPC services are easy to create and consume, with the
[rpc package](https://github.com/dart-lang/rpc).
You can write your RPC server in Dart, and generate client libraries for
Java, C#, and more.

### Get started

Start with our [tutorials](/docs/tutorials), and
then dive deep with our [articles](/articles/),
and other documentation. Once you're coding, consult the
[API documentation](https://api.dartlang.org/apidocs/channels/stable/dartdoc-viewer/home).

* [Tutorial: Write Command-Line Apps](/docs/tutorials/cmdline/)
* [Tutorial: Write HTTP Clients & Servers](/docs/tutorials/httpserver/)
* [Articles on a variety of Dart subjects](/articles/),
   many written by Dart engineers
* [Programmers Guide: Command-Line Apps](/docs/serverguide.html)&mdash;a
  collection of links to examples, tools, and other documentation
  of interest to server-side programmers

### Get support

Join our
[cloud@dartlang.org](https://groups.google.com/a/dartlang.org/forum/#!forum/cloud)
mailing list and chat with other engineers building
server-side Dart apps.

Post your "how-to" questions to
[Stack Overflow](http://stackoverflow.com/tags/dart).

And of course, we welcome [bug reports](http://dartbug.com/new).

### Learn more

Watch this video, recorded at the [Dart Developer Summit](/events/2015/summit/),
about moving from Node.js to Dart.

<iframe width="640" height="360" src="https://www.youtube.com/embed/NHsmiY0rFS8?list=PLOU2XLYxmsIIQorIS8gagUiMau9S84vZV&amp;showinfo=0" frameborder="0" allowfullscreen></iframe>

### Hosting Dart servers

You have many options. Here are a few:

* Google Cloud Platform; for details on Dart support, see
  [Dart and Google Cloud Platform](google-cloud-platform)
* [Heroku](https://github.com/igrigorik/heroku-buildpack-dart)  
* [Dartvoid](http://www.dartvoid.com/)

Of course, Dart runs on your favorite cloud provider, such as
Amazon's EC2, Digital Ocean, and more.

[dart_io_libs]: https://api.dartlang.org/apidocs/channels/stable/dartdoc-viewer/dart:io
[isolate-docs]: https://api.dartlang.org/apidocs/channels/stable/dartdoc-viewer/dart:isolate