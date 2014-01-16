---
layout: article
title: "An Introduction to the dart:io Library"
description: "An introduction to the Dart I/O library, which is aimed at server-side code that runs on the standalone Dart VM."
rel:
  author: mads-ager
has-permalinks: true
article:
  written_on: 2012-03-01
  updated_on: 2013-02-28
  collection: libraries-and-apis
---

{% include toc.html %}

# {{ page.title }}

_Written by Mads Ager <br />
March 2012 (updated October 2012, February 2013 and Januart 2014)_

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
[Timer](http://api.dartlang.org/dart_async/Timer.html) object.
The following example registers a timer with the event queue
and then drops off the end of main().
Because a pending operation is in the event queue,
the VM does not terminate at that point.
After one second,
the timer fires and the code in the argument callback executes.
Once that code executes to completion,
no more pending operations are in the event queue
and the VM terminates.

<!--- BEGIN(io_timer) -->{% prettify dart %}
import 'dart:async';

main() {
  new Timer(new Duration(seconds:1), () => print('timer'));
  print('end of main');
}
{% endprettify %}<!--- END(io_timer) -->

Running this example at the command line, we get:

    $ dart timer.dart 
    end of main
    timer

Had we made the timer repeating by using the Timer.periodic() constructor,
the VM would not terminate
and would continue to print out 'timer' every second.

## File system access

The dart:io library provides access to files and directories through the
[File](http://api.dartlang.org/io/File.html) and
[Directory](http://api.dartlang.org/io/Directory.html) classes.

The following example prints its own source code.
To determine the location of the source code being executed,
we use the
[Platform](http://api.dartlang.org/docs/releases/latest/dart_io/Platform.html)
class.

<!--- BEGIN(io_file_system) -->{% prettify dart %}
import 'dart:io';
import 'dart:async';
import 'dart:convert';

main() {
  var file = new File(Platform.script.toFilePath());
  Future<String> finishedReading = file.readAsString(encoding: ASCII);
  finishedReading.then((text) => print(text));
}
{% endprettify %}<!--- END(io_file_system) -->

Notice that the readAsString() method is asynchronous;
it returns a [Future](http://api.dartlang.org/dart_async/Future.html)
that will return the contents of the file
once the file has been read from the underlying system.
This asynchronicity allows the Dart thread to perform other work
while waiting for the I/O operation to complete.

To illustrate more detailed file operations,
let's change the example to read the contents
only up to the first semicolon and then to print that.
You could do this in two ways:
either open the file for random access,
or open a
[Stream](http://api.dartlang.org/dart_async/Stream.html)
for the file and stream in the data.

Here is a version that opens the file for random access operations.
The code opens the file for reading and then reads one byte at a time
until it encounters the char code for ';'.

<!--- BEGIN(io_random_access) -->{% prettify dart %}
import 'dart:io';

main() {
  var semicolon = ';'.codeUnitAt(0);
  var result = [];

  new File(Platform.script.toFilePath()).open(mode: FileMode.READ).then((RandomAccessFile file) {
    // Callback to deal with each byte.
    void onByte(int byte) {
      result.add(byte);
      if (byte == semicolon) {
        print(new String.fromCharCodes(result));
        file.close();
      } else {
        file.readByte().then(onByte);
      }
    }
    file.readByte().then(onByte);
  });
}
{% endprettify %}<!--- END(io_random_access) -->

When you see a use of `then()`, you are seeing a Future in action.
Both the `open()` and `readByte()` methods return a Future object.

This code is, of course,
a very simple use of random-access operations.
Operations are available for writing,
seeking to a given position, truncating, and so on.

Let's implement a version using a stream.
The following code opens the file for reading presenting the content
as a stream of lists of bytes. Like all streams in Dart you listen on
this stream and the data is given in chunks. You can always stop
reading more from the file by cancelling the subscription.

<!--- BEGIN(io_stream) -->{% prettify dart %}
import 'dart:io';
import 'dart:async';

main() {
  List result = [];

  Stream<List<int>> stream = new File(Platform.script.toFilePath()).openRead();
  int semicolon = ';'.codeUnitAt(0);
  StreamSubscription subscription;
  subscription = stream.listen((data) {
    for (int i = 0; i < data.length; i++) {
      result.add(data[i]);
      if (data[i] == semicolon) {
        print(new String.fromCharCodes(result));
        subscription.cancel();
        return;
      }
    }
  });
}
{% endprettify %}<!--- END(io_stream) -->

[Stream<List<int>>] is used in multiple places in dart:io:
when working with stdin, files, sockets, HTTP connections, and so on.
Similarly, [IOSink](http://api.dartlang.org/dart_io/IOSink.html)s
are used to stream data to
stdout, files, sockets, HTTP connections, and so on.

##Interacting with processes

For the simple case, use
[Process.run()](http://api.dartlang.org/dart_io/Process.html#run)
to run a process
and collect its output. Use `run()` when you don't
need interactive control over the process.

<!--- BEGIN(io_process) -->{% prettify dart %}
import 'dart:io';

main() {
  // List all files in the current directory,
  // in UNIX-like operating systems.
  Process.run('ls', ['-l']).then((ProcessResult results) {
    print(results.stdout);
  });
}
{% endprettify %}<!--- END(io_process) -->

You can also start a process by creating a
[Process](http://api.dartlang.org/dart_io/Process.html) object
using the Process.start() constructor.
Once you have a Process object you can interact with the process
by writing data to its stdin sink,
reading data from its stderr and stdout streams,
and killing the process.
When the process exits the exitCode future completes with
the exit code of the process.

The following example runs 'ls -l' in a separate process
and prints the output and the exit code for the process to stdout.
Since we are interested in getting lines,
we use a
[Utf8Decoder](http://api.dartlang.org/dart_convert/Utf8Decoder.html),
which decodes chunks of bytes into strings followed by a
[LineSplitter](http://api.dartlang.org/dart_convert/LineSplitter.html),
which splits the strings at line boundaries.

<!--- BEGIN(io_process_transform) -->{% prettify dart %}
import 'dart:io';
import 'dart:convert';

main() {
  Process.start('ls', ['-l']).then((process) {
    process.stdout.transform(new Utf8Decoder())
                  .transform(new LineSplitter())
                  .listen((String line) => print(line));
    process.stderr.listen((data) { });
    process.exitCode.then((exitCode) {
      print('exit code: $exitCode');
    });
  });
}
{% endprettify %}<!--- END(io_process_transform) -->

Notice that exitCode can complete before all of the lines of output
have been processed. Also note
that we do not explicitly close the process. In order to
not leak resources we have to drain both the stderr and the stdout
streams. To do that we set a listener to drain the stderr stream.

Instead of printing the output to stdout,
we can use the streaming classes
to pipe the output of the process to a file.

<!--- BEGIN(io_process_stdio) -->{% prettify dart %}
import 'dart:io';

main() {
  var output = new File('output.txt').openWrite();
  Process.start('ls', ['-l']).then((process) {
    process.stdout.pipe(output);
    process.stderr.listen((data) { });
    process.exitCode.then((exitCode) {
        print('exit code: $exitCode');
    });
  });
}
{% endprettify %}<!--- END(io_process_stdio) -->


##Writing web servers

dart:io makes it easy to write HTTP servers and clients.
To write a simple web server,
all you have to do is create an
[HttpServer](http://api.dartlang.org/dart_io/HttpServer.html)
and hook up a listener to its stream of `HttpRequest`s.

Here is a simple web server
that just answers 'Hello, world' to any request.

<!--- BEGIN(io_http_server) -->{% prettify dart %}
import 'dart:io';

main() {
  HttpServer.bind('127.0.0.1', 8080).then((server) {
    server.listen((HttpRequest request) {
      request.response.write('Hello, world');
      request.response.close();
    });
  });
}
{% endprettify %}<!--- END(io_http_server) -->

Running this application
and pointing your browser to 'http://127.0.0.1:8080'
gives you 'Hello, world' as expected.

Let's add a bit more and actually serve files.
The base path for every file that we serve will be
the location of the script.
If no path is specified in a request we will serve index.html.
For a request with a path,
we will attempt to find the file and serve it.
If the file is not found we will respond with a '404 Not Found' status.
We make use of the streaming interface
to pipe all the data read from a file directly to the response stream.

<!--- BEGIN(io_http_server_file) -->{% prettify dart %}
import 'dart:io';

_sendNotFound(HttpResponse response) {
  response.statusCode = HttpStatus.NOT_FOUND;
  response.close();
}

startServer(String basePath) {
  HttpServer.bind('127.0.0.1', 8080).then((server) {
    server.listen((HttpRequest request) {
      final String path = request.uri.toFilePath();
      // PENDING: Do more security checks here.
      final String resultPath = path == '/' ? '/index.html' : path;
      final File file = new File('${basePath}${resultPath}');
      file.exists().then((bool found) {
        if (found) {
          file.openRead()
              .pipe(request.response)
              .catchError((e) { });
        } else {
          _sendNotFound(request.response);
        }
      });
    });
  });
}

main() {
  // Compute base path for the request based on the location of the
  // script and then start the server.
  File script = new File(Platform.script.toFilePath());
  startServer(script.parent.path);
}
{% endprettify %}<!--- END(io_http_server_file) -->

Writing HTTP clients is very similar to using the
[HttpClient](http://api.dartlang.org/dart_io/HttpClient.html)
class.


## Feature requests welcome

The dart:io library is already capable of performing a lot of tasks.
As an example of our own use of dart:io,
we have rewritten the Dart testing scripts from Python to Dart.
All of the tests that you see being run on the
[buildbot](http://build.chromium.org/p/client.dart)
are running on the Dart VM using the dart:io library!

Please give dart:io a spin and let us know what you think.
Feature requests are very welcome!
When you file a bug or feature request,
use the Area-IO label in the issue tracker at
[dartbug.com](http://dartbug.com).
