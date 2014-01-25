---
layout: default
title: "Command-Line Apps"
description: "Documentation, references, and more about server-side programming."
has-permalinks: true
---

# {{ page.title }}

You can use Dart for any kind of command-line app from scripts to servers.

{% include default_toc.html %}

## Show me the code

If you prefer to plow through code, start with the following examples.
These samples progress from simple to complex
and illustrate a variety of APIs specific to command-line apps and servers.

<hr>

<div class="row">
<div class="col-md-5" markdown="1">

### Best place to start

* [Dart by Example](/dart-by-example/#dart-io-and-command-line-apps)

</div>
<div class="col-md-7" markdown="1">

#### Top 10
{:.no_toc}

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
<div class="col-md-5" markdown="1">

### Basic command-line apps

* [dcat](https://code.google.com/p/dart/source/browse/branches/bleeding_edge/dart/samples/dcat/README.md)
* [dgrep](https://code.google.com/p/dart/source/browse/branches/bleeding_edge/dart/samples/dgrep/README.md)
</div>
<div class="col-md-7" markdown="1">

#### APIs
{:.no_toc}

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
<div class="col-md-5" markdown="1">

#### Servers
{:.no_toc}

* [slambookserver](https://github.com/dart-lang/dart-tutorials-samples/blob/master/web/slambook/)
* [dartiverse_search](https://code.google.com/p/dart/source/browse/branches/bleeding_edge/dart/samples/dartiverse_search/readme.txt)

</div>
<div class="col-md-7" markdown="1">

#### APIs
{:.no_toc}

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

* [Weigh Anchor: Deploy a Server and App](/codelabs/deploy/) (a code lab about deploying Dart code to Heroku)
* [Get Input from a Form](/docs/tutorials/forms/)
<img src="/docs/tutorials/images/target.png" height="16" width="16">
(contains an HTTP server/client pair)
* [Walkthrough: Dartiverse Search](/docs/dart-up-and-running/contents/ch05.html)
(HTTP server, Web Sockets, logging, and routing)
* [Deploy to Heroku](https://github.com/igrigorik/heroku-buildpack-dart)

### Shell scripting

Kevin Moore created a five-part video series on shell scripting with Dart.

* Part 1: [Basics of creating and running a Dart command][dartshell1]
* Part 2: [Passing args to your command][dartshell2]
* Part 3: [Smarter arguments with ArgParser][dartshell3]
* Part 4: [Advanced ArgParser and Logging][dartshell4]
* Part 5: [Implementing shell completion using the Bag of Tricks][dartshell5]

Read more about
[shell scripting with Dart](http://news.dartlang.org/2013/02/dart-in-shell-video-tutorials-now.html).

### Packages

* [http_server](https://pub.dartlang.org/packages/http_server)&mdash;
   Virtual directory, virtual host, and static file serving. (Dart team)

* [route](http://pub.dartlang.org/packages/route)&mdash;
   URL routing for the server (and the client). (Dart team)

* [args](http://pub.dartlang.org/packages/args)&mdash;
   Handle command-line arguments. (Dart team)

* [http](http://pub.dartlang.org/packages/http)&mdash;
   Connect to HTTP resources. (Dart team)

Find more packages useful for server-side and command-line apps
at [pub.dartlang.org][pub].

### Reference docs

* [dart:io](https://api.dartlang.org/dart_io.html)&mdash;
   Includes support for UDP, TCP, HTTP client and server,
   files, directories, web sockets, processes, server sockets, and more.
* [args package](https://api.dartlang.org/args.html)&mdash;
   Help with handling command-line arguments.
* [dart:async](https://api.dartlang.org/dart_async.html)&mdash;
    Asynchronous programming with Futures, Streams.
* [dart:convert](https://api.dartlang.org/dart_convert.html)&mdash;
    Converters for data types such as JSON and UTF-8.


[dartshell1]: http://www.youtube.com/watch?v=Rh_kaQUXXX4
[dartshell2]: http://www.youtube.com/watch?v=PK7gEocFfII
[dartshell3]: http://www.youtube.com/watch?v=zOB8_9pHBik
[dartshell4]: http://www.youtube.com/watch?v=meAicYl4HHI
[dartshell5]: http://www.youtube.com/watch?v=18gvMuyfuuY
[pub]: http://pub.dartlang.org