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

List and maps can have cyclic references to themselves.
Each message is copied when sent to another isolate, ensuring
one isolate cannot change the state in another isolate.

Isolates might run in a separate process or thread, depending on the
implementation. For web applications, isolates can
be compiled to Web workers, if they are available.

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
is a valid entry point for an isolate.
The entry point should not expect arguments and should return void.
It is illegal to use a function closure as an entry point to an isolate.
Pass the entry point to
[spawnFunction()](http://api.dartlang.org/dart_isolate.html#spawnFunction).

<aside class="note">
<b>Note:</b> dart2js does not yet support static methods as isolate entry points.
</aside>

{% pc dart 0 %}
#import('dart:isolate');

runInIsolate() {
  print("hello from an isolate!");
}

main() {
  spawnFunction(runInIsolate);
}
{% endpc %}

We plan to support spawning an isolate from code at a URI.

#### Send messages

Send a message to an isolate via a
[SendPort](http://api.dartlang.org/dart_isolate/SendPort.html).
The spawnFunction() method returns a handle to its SendPort.

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
to receive messages sent to an isolate. Obtain a handle to the ReceivePort
from the [port](http://api.dartlang.org/dart_isolate.html#get:port)
property. Then, handle a new message with a
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
}
{% endpc %}

#### Receive a reply

Use the [call()](http://api.dartlang.org/dart_isolate/SendPort.html#call)
method on SendPort as a simple way to send a
message and receive a reply. The call() method returns a [Future](http://api.dartlang.org/dart_core/Future.html) for the reply.

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