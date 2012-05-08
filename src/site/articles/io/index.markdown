---
layout: default
title: "An Introduction to the dart:io Library"
rel:
  author: mads-ager
---

# {{ page.title }}
_Written by Mads Ager <br />
March 2012_

<section markdown="1">
The [dart:io](http://api.dartlang.org/io.html) library
is aimed at server-side code
that runs on the standalone Dart VM.
In this article we will give you a feel for
what is currently possible with dart:io
by going through a couple of examples.

Dart is a single-threaded programming language.
If an operation blocks the Dart thread,
the application will make no progress before that operation completes.
For scalability it is therefore crucial that no I/O operations block.
Instead of blocking on I/O operations,
dart:io uses an asynchronous programming model inspired by
[node.js](http://nodejs.org),
[EventMachine](https://github.com/eventmachine/eventmachine/wiki), and
[Twisted](http://twistedmatrix.com/trac/).
</section>


<section id="toc" markdown="1">

#### Contents

<ol class="toc">
  <li> <a href="#vm">The Dart VM and the event loop</a> </li>
  <li> <a href="#file-system">File system access</a> </li>
  <li> <a href="#processes">Interacting with processes</a> </li>
  <li> <a href="#web-servers">Writing web servers</a> </li>
  <li> <a href="#feedback">Feature requests welcome</a> </li>
</ol>
</section>


<section id="vm" markdown="1">
## The Dart VM and the event loop

Before we dive into asynchronous I/O operations,
it might be useful to explain how the standalone Dart VM operates.

When executing a server-side application,
the Dart VM runs in an event loop with
an associated event queue of pending asynchronous operations.
The VM terminates when it has executed the current code to completion
and no more pending operations are in the queue.

One simple way to add an event to the event queue is to
schedule a function to be called in the future.
You can do this by creating a
[Timer](http://api.dartlang.org/io/Timer.html) object.
The following example registers a timer with the event queue
and then drops off the end of main().
Because a pending operation is in the event queue,
the VM does not terminate at that point.
After one second,
the timer fires and the code in the argument callback executes.
Once that code executes to completion,
no more pending operations are in the event queue
and the VM terminates.

{% pretty_code dart 0 %}#import('dart:io');

main() {
  new Timer(1000, (Timer t) => print('timer'));
  print('end of main');
}
{% endpretty_code %}

Running this example at the command line, we get:

    $ dart timer.dart 
    end of main
    timer

Had we made the timer repeating by using the Timer.repeating() constructor,
the VM would not terminate
and would continue to print out ‘timer’ every second.
</section>


<section id="file-system" markdown="1">
## File system access

The dart:io library provides access to files and directories through the
[File](http://api.dartlang.org/io/File.html) and
[Directory](http://api.dartlang.org/io/Directory.html) interfaces.

The following example prints its own source code.
To determine the location of the source code being executed,
we use the
[Options](http://api.dartlang.org/dart_core/Options.html) interface
from [dart:core](http://api.dartlang.org/dart_core.html).

{% pretty_code dart 0 %}#import('dart:io');

main() {
  var options = new Options();
  var file = new File(options.script);
  file.readAsText(Encoding.ASCII, (text) => print(text));
}
{% endpretty_code %}

Notice that the readAsText() method is asynchronous;
it takes a callback argument that is called with the contents of the file
once the file has been read from the underlying system.
This asynchronicity allows the Dart thread to perform other work
while waiting for the I/O operation to complete.

To illustrate more detailed file operations,
let’s change the example to read the contents
only up to the first semicolon and then to print that.
You could do this in two ways:
either open the file for random access,
or open an
[InputStream](http://api.dartlang.org/io/InputStream.html)
for the file and stream in the data.

Here is a version that opens the file for random access operations.
The code opens the file for reading and then reads one byte at a time
until it encounters the char code for ‘;’.

{% pretty_code dart 0 %}#import('dart:io');

main() {
  var options = new Options();
  var result = [];

  new File(options.script).open(FileMode.READ, (RandomAccessFile file) {
    var semicolon = ';'.charCodeAt(0);
    // Callback to deal with each byte.
    void onByte(byte) {
      result.add(byte);
      if (byte == semicolon) {
        print(new String.fromCharCodes(result));
        file.close(() => null);
      } else {
        file.readByte(onByte);
      }
    }

    // Read the first byte to get started.
    file.readByte(onByte);
  });
}
{% endpretty_code %}

This code is, of course,
a very simple use of random-access operations.
Operations are available for writing,
seeking to a given position, truncating, and so on.

Let’s implement a version using an input stream.
The following code opens an InputStream object for the file.
InputStreams are active objects that start reading data
when they are created.
Whenever data is available,
the onData handler is called and the data can be read out from the stream
using the read() method.
The onData handler will continue to be called as long as
data can be read from the stream.
If all data is not read from the stream in the onData handler,
the handler is guaranteed to be called again.
To prevent further calls,
you can set the onData handler to null.

{% pretty_code dart 0 %}#import('dart:io');

main() {
  Options options = new Options();
  List result = [];

  InputStream stream = new File(options.script).openInputStream();
  int semicolon = ';'.charCodeAt(0);
  stream.onData = () {
    result.addAll(stream.read(1));
    if (result.last() == semicolon) {
      print(new String.fromCharCodes(result));
      stream.close();
    }
  };
}
{% endpretty_code %}

[InputStream](http://api.dartlang.org/io/InputStream.html)s
are used in multiple places in dart:io:
when working with stdin, files, sockets, HTTP connections, and so on.
Similarly, [OutputStream](http://api.dartlang.org/io/OutputStream.html)s
are used to stream data to
stdout, files, sockets, HTTP connections, and so on.
</section>


<section id="processes" markdown="1">
##Interacting with processes

You can start a process by creating a
[Process](http://api.dartlang.org/io/Process.html) object
using the Process.start() constructor.
Once you have a Process object you can interact with the process
by writing data to its stdin stream,
reading data from its stderr and stdout streams,
and killing the process.
When the process exits the onExit handler is called with
the exit code of the process.

The following example runs ‘ls -l’ in a separate process
and prints the output and the exit code for the process to stdout.
Since we are interested in getting lines,
we are wrapping the stdout stream of the process in a StringInputStream.
A [StringInputStream](http://api.dartlang.org/io/StringInputStream.html)
has an onLine handler that gets called
whenever a full line of text has been decoded
and is ready to be read using readLine.

{% pretty_code dart 0 %}#import('dart:io');

main() {
  var p = new Process.start('ls', ['-l']);
  var stdoutStream = new StringInputStream(p.stdout);
  stdoutStream.onLine = () => print(stdoutStream.readLine());
  p.onExit = (exitCode) {
    print('exit code: $exitCode');
    p.close();
  };
}
{% endpretty_code %}

Notice that the onExit handler can be called
before all of the lines of output have been processed.
It is safe to call the close() method on the process
even though there is still data in the stdout and stderr streams.
The streams will be marked as closed
but will not actually close until all data has been read.

Instead of printing the output to stdout,
we can use the streaming interfaces
to pipe the output of the process to a file instead.

{% pretty_code dart 0 %}#import('dart:io');

main() {
  var output = new File('output.txt').openOutputStream();
  var p = new Process.start('ls', ['-l']);
  p.stdout.pipe(output);
  p.onExit = (exitCode) => print('exit code: $exitCode');
}
{% endpretty_code %}

The current process API can be a bit heavy to use
if all you really want to do is run a process to completion
and then inspect its output.
We will be adding more convenient ways of
starting processes for that scenario.

</section>


<section id="web-servers" markdown="1">
##Writing web servers

Recently, we landed an HTTP library as part of dart:io
to make it easy to write HTTP servers and clients.
To write a simple web server,
all you have to do is create an
[HttpServer](http://api.dartlang.org/io/HttpServer.html)
and hook up a `defaultRequestHandler`.

Here is a simple web server
that just answers ‘Hello, world’ to any request.

{% pretty_code dart 0 %}#import('dart:io');

main() {
  var server = new HttpServer();
  server.listen('127.0.0.1', 8080);
  server.defaultRequestHandler = (HttpRequest request, HttpResponse response) {
    response.outputStream.write('Hello, world'.charCodes());
    response.outputStream.close();
  };
}
{% endpretty_code %}

Running this application
and pointing your browser to ‘http://127.0.0.1:8080’
gives you ‘Hello, world’ as expected.

Let’s add a bit more and actually serve files.
The base path for every file that we serve will be
the location of the script.
If no path is specified in a request we will serve index.html.
For a request with a path,
we will attempt to find the file and serve it.
If the file is not found we will respond with a ‘404 Not Found’ status.
We make use of the streaming interface
to pipe all the data read from a file directly to the response output stream.

{% pretty_code dart 0 %}
#import('dart:io');

startServer(String basePath) {
  var server = new HttpServer();
  server.listen('127.0.0.1', 8080);
  server.defaultRequestHandler = (HttpRequest request, HttpResponse response) {
    var path = request.path == '/' ? '/index.html' : request.path;
    var file = new File('${basePath}${path}');
    file.exists((found) {
      if (found) {
        file.openInputStream().pipe(response.outputStream);
      } else {
        response.statusCode = HttpStatus.NOT_FOUND;
        response.outputStream.close();
      }
    });
  };
}

main() {
  // Compute base path for the request based on the location of the
  // script and then start the server.
  File script = new File(new Options().script);
  script.directory((Directory d) {
    startServer(d.path);
  });
}
{% endpretty_code %}

Writing HTTP clients is very similar using the
[HttpClient](http://api.dartlang.org/io/HttpClient.html) class.

One word of warning about the new HTTP library:
performance has not been a priority for the library yet.
Rest assured that it will be.
We plan on optimizing the HTTP library in the near future!

</section>


<section id="feedback" markdown="1">
## Feature requests welcome

The dart:io library is already capable of performing a lot of tasks.
As an example of our own use of dart:io,
we have rewritten the Dart testing scripts from Python to Dart.
All of the tests that you see being run on the
[buildbot](http://build.chromium.org/p/client.dart)
are running on the Dart VM using the dart:io library!

That said, we’d like to add a lot of features to dart:io.
Some of the things on our list are:

* Better support for path manipulation.
* Addition of string encodings on string write methods.
* Completion of the HTTP library.
  At this point the library supports only a subset of HTTP 1.1.
* Improvement of the dart:io error messages.
  At this point they are not very helpful.
* Native extension libraries that will make it easy to
  wrap native libraries in an asynchronous API
  for use with dart:io on the Dart VM.
* Improved performance of all operations.

Please give dart:io a spin and let us know what you think.
Feature requests are very welcome!
When you file a bug or feature request,
use the Area-IO label in the issue tracker at
[dartbug.com](http://dartbug.com).

</section>


{% include syntax-highlighting.html %}
