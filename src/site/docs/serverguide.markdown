---
layout: article
title: "Command-Line Apps"
description: "Documentation, references, and more about server-side programming."
has-permalinks: true
---

{% include docs_toc.html %}

# {{ page.title }}

You can use Dart for any kind of command-line app from scripts to servers.

## Show me the code

If you prefer to plow through code, start with the following examples.
These samples progress from simple to complex
and illustrate a variety of APIs specific to command-line apps and servers.

<hr>

<div class="row">
<div class="col-md-5">

### Best place to start

* [Dart by Example](/dart-by-example/#dart-io-and-command-line-apps)

</div>
<div class="col-md-7">

#### Top 10

10. Using files, directories, and symlinks
9. Reading and writing files
8. Listing contents of directories
7. Using streams
6. Making HTTP requests
5. Getting the response
4. Handling errors
3. Serving index.html
2. Adding custom headers
1. Implementing an HTTP server
0. ...and more...

</div>
</div>

<hr>

<div class="row">
<div class="col-md-5">

### Basic command-line apps

* [dcat](https://code.google.com/p/dart/source/browse/branches/bleeding_edge/dart/samples/dcat/README.md)
* [dgrep](https://code.google.com/p/dart/source/browse/branches/bleeding_edge/dart/samples/dgrep/README.md)
</div>
<div class="col-md-7">

#### APIs

* Parsing command-line arguments
* Reading a file
* Converting data
* Using stdin, stdout, and stderr
* Listing a directory recursively
* Testing and getting information about paths
</div>
</div>

<hr>

<div class="row">
<div class="col-md-5">

#### Servers

* [slambookserver](https://github.com/dart-lang/dart-tutorials-samples/blob/master/web/slambook/)
* [dartiverse_search](https://code.google.com/p/dart/source/browse/branches/bleeding_edge/dart/samples/dartiverse_search/readme.txt)

</div>
<div class="col-md-7">

#### APIs

* Using the HttpServer class
* Handling GET, POST, and OPTIONS requests
* Using CORS headers
* Using WebSockets
* Getting responses
* Routing requests
* Handling errors

</div>
</div>

<hr>

## Read all about it

Follow these links in order to gain a full understanding
of how to write different kinds of command-line apps in Dart using
various Dart libraries and packages.

### Prerequisites (dart:async library)

* [Use Future-Based APIs](/docs/tutorials/futures/)
<img src="/docs/tutorials/images/target.png" height="16" width="16">
* [Use Streams for Data](/docs/tutorials/streams/)
<img src="/docs/tutorials/images/target.png" height="16" width="16">

### The Basics

* [Write a Command-Line App](/docs/tutorials/cmdline/)
<img src="/docs/tutorials/images/target.png" height="16" width="16">

### Servers

* [Get Input from a Form](/docs/tutorials/forms/)
<img src="/docs/tutorials/images/target.png" height="16" width="16">
(contains an HTTP server/client pair)
* [Walkthrough: Dartiverse Search](/docs/dart-up-and-running/contents/ch05.html)
* [Deploy to Heroku](https://github.com/igrigorik/heroku-buildpack-dart)

{% comment %}
* How to write a basic server using http_server package (sample link)
* How to write a web server (sample link)
* How to use Heroku to deploy (external link)

#### Other server-specific tasks

* How to perform server-side templating (??)
* How to use SSL to perform secure web messaging (??)
* Use zones for more control over your asychronous computations (??)
* How to write a long-running server (??)
* Using TCP for reliable transmissions (??)
* Using UDP for lightweight, efficient transmissions (??)
* Connecting to the postgres database (and concepts for other databases) (??)
* URL routing for god knows what purpose (??)

{% endcomment %}

### Reference docs

* [dart:io](https://api.dartlang.org/dart_io.html)
* [args package](https://api.dartlang.org/args.html)
* [dart:async](https://api.dartlang.org/dart_async.html)
* [dart:convert](https://api.dartlang.org/dart_convert.html)
