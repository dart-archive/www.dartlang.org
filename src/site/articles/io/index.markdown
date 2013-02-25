---
layout: default
title: "An Introduction to the dart:io Library"
description: "An introduction to the Dart I/O library, which is aimed at server-side code that runs on the standalone Dart VM."
rel:
  author: mads-ager
has-permalinks: true
article:
  written_on: 2012-03-01
  updated_on: 2013-02-01
  collection: libraries-and-apis
---

# {{ page.title }}
_Written by Mads Ager <br />
March 2012 (updated February 2013)_

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
[Timer](http://api.dartlang.org/dart_isolate/Timer.html) object.
The following example registers a timer with the event queue
and then drops off the end of main().
Because a pending operation is in the event queue,
the VM does not terminate at that point.
After one second,
the timer fires and the code in the argument callback executes.
Once that code executes to completion,
no more pending operations are in the event queue
and the VM terminates.

{% prettify dart %}
import 'dart:async';

main() {
  new Timer(new Duration(seconds:1), () => print('timer'));
  print('end of main');
}
{% endprettify %}

Running this example at the command line, we get:

    $ dart timer.dart 
    end of main
    timer

Had we made the timer repeating by using the Timer.repeating() constructor,
the VM would not terminate
and would continue to print out 'timer' every second.
</section>


<section id="file-system" markdown="1">
## File system access

The dart:io library provides access to files and directories through the
[File](http://api.dartlang.org/io/File.html) and
[Directory](http://api.dartlang.org/io/Directory.html) classes.

The following example prints its own source code.
To determine the location of the source code being executed,
we use the
[Options](http://api.dartlang.org/dart_core/Options.html) class
from [dart:core](http://api.dartlang.org/dart_core.html).

{% prettify dart %}
import 'dart:io';

main() {
  var options = new Options();
  var file = new File(options.script);
  Future<String> finishedReading = file.readAsString(Encoding.ASCII);
  finishedReading.then((text) => print(text));
}
{% endprettify %}

Notice that the readAsString() method is asynchronous;
it returns a [Future](http://api.dartlang.org/dart_core/Future.html)
that will return the contents of the file
once the file has been read from the underlying system.
This asynchronicity allows the Dart thread to perform other work
while waiting for the I/O operation to complete.

To illustrate more detailed file operations,
let's change the example to read the contents
only up to the first semicolon and then to print that.
You could do this in two ways:
either open the file for random access,
or open an
[InputStream](http://api.dartlang.org/io/InputStream.html)
for the file and stream in the data.

Here is a version that opens the file for random access operations.
The code opens the file for reading and then reads one byte at a time
until it encounters the char code for ';'.

{% prettify dart %}
import 'dart:io';

main() {
  var options = new Options();
  var semicolon = ';'.charCodeAt(0);
  var result = [];

  new File(options.script).open(FileMode.READ).then((RandomAccessFile file) {
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
{% endprettify %}

When you see a use of `then()`, you are seeing a Future in action.
Both the `open()` and `readByte()` methods return a Future object.

This code is, of course,
a very simple use of random-access operations.
Operations are available for writing,
seeking to a given position, truncating, and so on.

Let's implement a version using an input stream.
The following code opens an InputStream object for the file.
InputStreams are active objects that start reading data
when they are created.
Whenever data is available,
the onData handler is called and the data can be read out from the stream
using the `read()` method.
The onData handler will continue to be called as long as
data can be read from the stream.
If all data is not read from the stream in the onData handler,
the handler is guaranteed to be called again.
To prevent further calls,
you can set the onData handler to null.

{% prettify dart %}
import 'dart:io';

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
{% endprettify %}

[InputStream](http://api.dartlang.org/io/InputStream.html)s
are used in multiple places in dart:io:
when working with stdin, files, sockets, HTTP connections, and so on.
Similarly, [OutputStream](http://api.dartlang.org/io/OutputStream.html)s
are used to stream data to
stdout, files, sockets, HTTP connections, and so on.
</section>


<section id="processes" markdown="1">
##Interacting with processes

For the simple case, use
[Process.run()](http://api.dartlang.org/docs/continuous/dart_io/Process.html#run)
to run a process
and collect its output. Use `run()` when you don't
need interactive control over the process.

{% prettify dart %}
import 'dart:io';

main() {
  // List all files in the current directory,
  // in UNIX-like operating systems.
  Process.run('ls', ['-l']).then((ProcessResult results) {
    print(results.stdout);
  });
}
{% endprettify %}

You can also start a process by creating a
[Process](http://api.dartlang.org/io/Process.html) object
using the Process.start() constructor.
Once you have a Process object you can interact with the process
by writing data to its stdin stream,
reading data from its stderr and stdout streams,
and killing the process.
When the process exits the onExit handler is called with
the exit code of the process.

The following example runs 'ls -l' in a separate process
and prints the output and the exit code for the process to stdout.
Since we are interested in getting lines,
we are wrapping the stdout stream of the process in a StringInputStream.
A [StringInputStream](http://api.dartlang.org/io/StringInputStream.html)
has an onLine handler that gets called
whenever a full line of text has been decoded
and is ready to be read using readLine.

{% prettify dart %}
import 'dart:io';

main() {
  Process.start('ls', ['-l']).then((process) {
    var stdoutStream = new StringInputStream(process.stdout);
    stdoutStream.onLine = () => print(stdoutStream.readLine());
    process.stderr.onData = process.stderr.read;
    process.onExit = (exitCode) {
      print('exit code: $exitCode');
    };
  });
}
{% endprettify %}

Notice that the onExit handler can be called
before all of the lines of output have been processed. Also note
that we do not explicitly close the process. In order to 
not leak resources we have to drain both the stderr and the stdout 
streams. To do that we set the `onData` handler which will make sure 
to drain the stderr stream as well as the stdout stream once all data 
has been read.

Instead of printing the output to stdout,
we can use the streaming classes
to pipe the output of the process to a file.

{% prettify dart %}
import 'dart:io';

main() {
  var output = new File('output.txt').openOutputStream();
  Process.start('ls', ['-l']).then((process) {
    process.stdout.pipe(output);
    process.stderr.pipe(output);
    process.onExit = (exitCode) {
      print('exit code: $exitCode');
    };
   });
}
{% endprettify %}

</section>


<section id="web-servers" markdown="1">
##Writing web servers

dart:io makes it easy to write HTTP servers and clients.
To write a simple web server,
all you have to do is create an
[HttpServer](http://api.dartlang.org/io/HttpServer.html)
and hook up a `defaultRequestHandler`.

Here is a simple web server
that just answers 'Hello, world' to any request.

{% prettify dart %}
import 'dart:io';

main() {
  var server = new HttpServer();
  server.listen('127.0.0.1', 8080);
  server.defaultRequestHandler = (HttpRequest request, HttpResponse response) {
    response.outputStream.write('Hello, world'.charCodes);
    response.outputStream.close();
  };
}
{% endprettify %}

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
to pipe all the data read from a file directly to the response output stream.

{% prettify dart %}
import 'dart:io';

_send404(HttpResponse response) {
  response.statusCode = HttpStatus.NOT_FOUND;
  response.outputStream.close();
}

startServer(String basePath) {
  var server = new HttpServer();
  server.listen('127.0.0.1', 8080);
  server.defaultRequestHandler = (HttpRequest request, HttpResponse response) {
    final String path = request.path == '/' ? '/index.html' : request.path;
    final File file = new File('${basePath}${path}');
    file.exists().then((bool found) {
      if (found) {
        file.fullPath().then((String fullPath) {
          if (!fullPath.startsWith(basePath)) {
            _send404(response);
          } else {
            file.openInputStream().pipe(response.outputStream);
          }
        });
      } else {
        _send404(response);
      }
    });
  };
}

main() {
  // Compute base path for the request based on the location of the
  // script and then start the server.
  File script = new File(new Options().script);
  script.directory().then((Directory d) {
    startServer(d.path);
  });
}
{% endprettify %}

Writing HTTP clients is very similar to using the
[HttpClient](http://api.dartlang.org/io/HttpClient.html) class.

</section>


<section id="feedback" markdown="1">
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

</section>



