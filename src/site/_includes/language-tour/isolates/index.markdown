All code in Dart runs in the context of an isolate.
Use additional isolates for concurrent programming,
and to run third-party code more securely.

### Isolate concepts

Each isolate has its own heap, which means that all its values in memory,
including globals, are available only to that isolate. The only mechanism
available to communicate between isolates is to pass messages.
Messages are sent through ports.

The content of the message can be:

* A primitive value (null, num, bool, double, String)
* An instance of SendPort
* A list or map whose elements are any of the above, including other lists and maps
* In [special circumstances](#send-any-type-of-object), an object of any type

Lists and maps can have cyclic references to themselves.
Each message is copied when sent to another isolate, ensuring
one isolate cannot change the state in another isolate.

Isolates might run in a separate process or thread, depending on the
implementation. For web applications, isolates can
be compiled to Web workers, if they are available.

### Isolates in the VM

In the standalone VM, the main() function runs in the first isolate
(also knows as the _main isolate_).
When the main isolate terminates, it terminates the whole VM, regardless
of whether other isolates are still running.

In the VM, an isolate continues to run as long as it has an open
ReceivePort inside the isolate. If the main function only starts other
isolates, doing no work itself, you must keep the main isolate
alive to keep the program alive. To keep a main isolate alive,
open a ReceivePort in the main isolate.

When all the child isolates have finished their work, you can send a message
to the main isolate to close its ReceivePort, thus stopping the program.

### Using isolates

To use an isolate, you import the isolates library,
spawn a new isolate, and then send and receive messages.

#### Import the isolates library

The isolates API can be found in the `dart:isolate` library.

{% pc dart 0 %}
#import('dart:isolate');
{% endpc %}

#### Spawn an isolate

Any top-level function or static method
([not currently working](#isolates-static-method))
is a valid entry point for an isolate.
The entry point should not expect arguments and should return void.
It is illegal to use a function closure as an entry point to an isolate.
Pass the entry point to
[spawnFunction()](http://api.dartlang.org/dart_isolate.html#spawnFunction).

<aside class="note" id="isolates-static-method" markdown="1">
<b>Note:</b> Both the dart2js compiler and the Dart VM
([bug #3011](http://code.google.com/p/dart/issues/detail?id=3011)) do not yet
support static methods as isolate entry points.
</aside>

{% pc dart 0 %}
#import('dart:isolate');

runInIsolate() {
  print("hello from an isolate!");
}

main() {
  spawnFunction(runInIsolate);

  // Note: incomplete.
  // Use a ReceivePort (details below) to keep the main isolate alive
  // long enough for runInIsolate to perform its work.
}
{% endpc %}

We plan to support spawning an isolate from code at a URI.

#### Send messages

Send a message to an isolate via a
[SendPort](http://api.dartlang.org/dart_isolate/SendPort.html).
The spawnFunction() method returns a handle to the
newly created isolate's SendPort.

To simply send a message, use
[send()](http://api.dartlang.org/dart_isolate/SendPort.html#send).

{% pc dart 0 %}
#import('dart:isolate');

echo() {
  // receive messages here, see next section
}

main() {
  SendPort sendPort = spawnFunction(echo);
  sendPort.send("Hello from main");

  // Note: incomplete.
  // Use a ReceivePort (details below) to keep the main isolate alive
  // long enough for echo to perform its work.
}
{% endpc %}

#### Send any type of object

In special circumstances (such as when using spawnFunction() inside the Dart VM),
it is possible to send any type of object instance to an isolate.
The object message is copied when sent.

Sending arbitrary object instances to an isolate, even if
using spawnFunction(), is not yet available when compiling to
JavaScript.

#### Receive messages

Use a [ReceivePort](http://api.dartlang.org/dart_isolate/ReceivePort.html)
to receive messages sent to an isolate. Obtain a handle to the
default ReceivePort
from the [port](http://api.dartlang.org/dart_isolate.html#get:port)
property. You can also create new instances of ReceivePort, if
you want to route messages to different ports and callbacks.

Handle an incoming message with a
callback function passed to the
[receive()](http://api.dartlang.org/dart_isolate/ReceivePort.html#receive)
method.

{% pc dart 0 %}
#import('dart:isolate');

echo() {
  port.receive((msg, SendPort reply) {
    print("I received: $msg");
  });
}

main() {
  SendPort sendPort = spawnFunction(echo);
  sendPort.send("Hello from main");

  // Note: incomplete.
  // Use a ReceivePort (details below) to keep the main isolate alive
  // long enough for runInIsolate to perform its work.
}
{% endpc %}

#### Receive a reply

Use the [call()](http://api.dartlang.org/dart_isolate/SendPort.html#call)
method on SendPort as a simple way to send a
message and receive a reply. The call() method returns a
[Future](http://api.dartlang.org/dart_core/Future.html) for the reply.

{% pc dart 0 %}
#import('dart:isolate');

echo() {
  port.receive((msg, SendPort reply) {
    reply.send("I received: $msg");
  });
}

main() {
  SendPort sendPort = spawnFunction(echo);
  sendPort.call("Hello from main").then((reply) {
    print(reply);    // I received: Hello from main
  });
}
{% endpc %}

The `call()` method creates a new receive port, sends a message to this
send port with replyTo set to such receive port. When a reply is
received, it closes the receive port and completes the returned future.

### Coordination Strategy

As mentioned above, when the main isolate terminates, the entire VM
terminates (even if there are other child isolates running). To keep
the main isolate running, it must create an open ReceivePort. Before the
main isolate can terminate, the ReceivePort must be closed.

You can coordinate isolates with message passing,
sending a message to inform the main isolate when a child
isolate is finished. Here is an example:

{% pc dart 0 %}
#import('dart:isolate');

childIsolate() {
  port.receive((msg, SendPort replyTo) {
    print('doing some work');
    if (replyTo != null) replyTo.send("shutdown");
  });
}

main() {
  SendPort sender = spawnFunction(childIsolate);
  ReceivePort receiver = new ReceivePort();
  receiver.receive((msg, _) {
    if (msg == 'shutdown') {
      print('shutting down');
      receiver.close();
    }
  });
  sender.send("do work please", receiver.toSendPort());
}
{% endpc %}

In the above example, the child isolate is allowed to run to completion
because the main isolate kept a ReceivePort open.

The main isolate creates a ReceivePort to wait for
a "shutdown" message. The term "shutdown" is arbitrary, the ReceivePort
simply needs to wait for some signal.

Once the "shutdown" message is received, the main isolate closes the
ReceivePort. With the ReceivePort closed, and with nothing else to do,
the main isolate terminates, also terminating the program.