---
layout: tutorial
title: "Use Streams for Data"
description: 
  Learn how to consume single-subscriber and broadcast streams, 
  with real-world uses.
tutorial:
  id: streams
next: fetchdata/
next-title: "Fetch Data Dynamically"
prev: futures/
prev-title: "Use Future-Based APIs"
rel:
  author: chris-buckett
has-permalinks: true
---

{% capture whats_the_point %}

* Streams provide an asynchronous sequence of data.
* Data sequences include user-generated events and data read from files.
* Use transformers to modify the data as it becomes available.
* Stream has methods for skipping, selecting, filtering, and validating data.
* Streams provide a way to respond to errors.

{% endcapture %}

{% capture sample_links %}


<p markdown="1"> This tutorial features these examples
in the `bin` directory:</p>

* feet_wet_streams.dart
* html_streams.dart
* http_request.dart

<p>
Don't have the source code?
<a href="https://github.com/dart-lang/dart-tutorials-samples/archive/master.zip">
  Download it.
</a>

{% endcapture %}

{% capture content %}

<div class="tute-target-title">
<h1>{{page.title}}</h1>
<h3>Use streams to handle sequences of data.</h3>
</div>

_Written by Chris Buckett_

Whether running in the browser as part of the various HTML events, such as 
button.onClick, or on the server as part of the dart:io changes, Streams form 
a unified interface to anything that might send out a repeating series of data.

This article explains how to consume streams using this unified interface.

* [Background reading: futures](#background-reading)
* [What are streams for?](#what-are-streams-for)
* [Consuming a stream](#consuming-a-stream)
* [Common Stream methods](#common-stream-methods)
* [Single value streams](#single-value-streams)
* [Error handling in streams and futures](#error-handling)
* [Unsubscribing from a stream](#unsubscribing)
* [Streams are generic](#streams-are-generic)
* [Some real world examples of consuming a stream](#real-world)
* [Conclusion](#conclusion)
* [About the author](#about-chris)

## Background reading: futures {#background-reading}

Before we get started, it is important to note that Streams are part 
of the [dart:async](http://api.dartlang.org/dart_async.html) library.
They share a close relationship with Dart's async staple, `Future`, due to their 
asynchronous nature. (You can't block code until a user clicks a button!)

For details about using Futures, refer to the previous
tutorial [Use Future-Based APIs](/docs/tutorials/futures/).

## What are streams for? {#what-are-streams-for}

Imagine you are writing a chat application.  On a single client, you will be 
receiving messages and displaying them to the user.  You can't simply write a 
while loop because that will block execution, so you need to use async 
callbacks.  This is an ideal use case for streams: you have one part of your 
code pushing data into the stream, and another part of your code listening to 
the stream.  

### Key concepts

- **Consuming a stream**: Data is sent out of a stream to a `StreamSubscriber` 
(or possibly multiple subscribers).
- **Populating a stream**: Data gets into a stream from a `StreamController`.

We'll look at the **consuming** a stream in this article as you're more likely 
to come across streams as a consumer from existing APIs within Dart.  Populating
a stream will be covered in a future article.

## Consuming a stream {#consuming-a-stream}

Let's take a look at some simple stream code.  For simplicity we're going to 
create a stream from a fixed, literal list at the moment by using the stream's 
`fromIterable()` constructor, rather than by dynamically populating it with a 
`StreamController`.

<!--- BEGIN(simple_stream_code) -->{% prettify dart %}
var data = [1,2,3,4,5]; // some sample data
var stream = new Stream.fromIterable(data); // create the stream
{% endprettify %}<!--- END(simple_stream_code) -->

Now that we have a stream that is ready to send out some data, we can use 
that stream to listen to some data.

The typical way is to use the stream's `listen()` method to subscribe to the 
stream.  This has a number of optional parameters, and one mandatory parameter, 
which is the `onData` handler callback function:

<!--- BEGIN(consuming_a_stream) -->{% prettify dart%}
import 'dart:async';

main() {
  var data = [1,2,3,4,5]; // some sample data
  var stream = new Stream.fromIterable(data);  // create the stream

  // subscribe to the streams events
  stream.listen((value) {       //
    print("Received: $value");  // onData handler
  });                           //
}
{% endprettify %}<!--- END(consuming_a_stream) -->

The `listen()` method is fired every time some data is received. In in our 
stream, the `listen()` callback is called for each of the data elements, so the 
output of running this code is as expected:

    Received: 1
    Received: 2
    Received: 3
    Received: 4
    Received: 5

There are other ways to consume data from the stream, using properties such 
as `first`, `last`, `length`, and `isEmpty`.  Each of these properties returns 
a future. For example:

<!--- BEGIN(stream_properties) -->{% prettify dart%}
stream = new Stream.fromIterable([1,2,3,4,5]);
stream.first.then((value) => print("stream.first: $value"));  // 1

stream = new Stream.fromIterable([1,2,3,4,5]);
stream.last.then((value) => print("stream.last: $value"));  // 5  

stream = new Stream.fromIterable([1,2,3,4,5]);
stream.isEmpty.then((value) => print("stream.isEmpty: $value"));  // false

stream = new Stream.fromIterable([1,2,3,4,5]);
stream.length.then((value) => print("stream.length: $value"));  // 5
{% endprettify %}<!--- END(stream_properties) -->

Streams comes in two flavours: **single** or **multiple** 
(also known as **broadcast**) subscriber.   By default, our stream is a
single-subscriber stream.
This means that if you try to listen to the stream more than 
once, you will get an exception, and using any of the callback functions or 
future properties counts as listening.

You can convert the single-subscriber stream into a broadcast stream by using 
the `asBroadcastStream()` method, as shown below:

<!--- BEGIN(as_broadcast_stream) -->{% prettify dart %}
var data = [1,2,3,4,5];
var stream = new Stream.fromIterable(data);
var broadcastStream = stream.asBroadcastStream();

broadcastStream.listen((value) => print("stream.listen: $value")); 
broadcastStream.first.then((value) => print("stream.first: $value")); // 1 
broadcastStream.last.then((value) => print("stream.last: $value")); // 5
broadcastStream.isEmpty.then((value) => print("stream.isEmpty: $value")); // false
broadcastStream.length.then((value) => print("stream.length: $value")); // 5
{% endprettify %}<!--- END(as_broadcast_stream) -->

Now that the stream allows multiple subscribers, you can add multiple 
listeners. You can check whether a stream is a broadcast stream by checking 
the `stream.isBroadcast` property.

## Common Stream methods {#common-stream-methods}

Lots of methods are available on the Stream class.
In the following section, I'll describe some of the more common ones.
Be sure to check out 
the [API docs](http://api.dartlang.org/dart_async/Stream.html)
for the complete list.

### Subsets of stream data

Streams have some useful methods for extracting parts of the data being 
sent out from the stream.  The `take()`, `skip()`, `takeWhile()`, `skipWhile()`, 
and `where()` methods allow you to take a subset of data, as shown by the 
following example.  Each outputs its own stream that you can listen to.

<!--- BEGIN(stream_subsets) -->{% prettify dart %}
broadcastStream
    .where((value) => value % 2 == 0) // divisible by 2
    .listen((value) => print("where: $value")); // where: 2
                                                // where: 4

broadcastStream
    .take(3) // takes only the first three elements
    .listen((value) => print("take: $value")); // take: 1
                                               // take: 2
                                               // take: 3

broadcastStream
    .skip(3)  // skips the first three elements
    .listen((value) => print("skip: $value")); // skip: 4
                                               // skip: 5

broadcastStream
    .takeWhile((value) => value < 3) // take while true
    .listen((value) => print("takeWhile: $value")); // takeWhile: 1
                                                    // takeWhile: 2

broadcastStream
    .skipWhile((value) => value < 3) // skip while true
    .listen((value) => print("skipWhile: $value")); // skipWhile: 4
                                                    // skipWhile: 5
{% endprettify %}<!--- END(stream_subsets) -->

### Transforming stream data

Another useful method is the `transform()` method, which takes a 
`StreamTransformer` instance.  This allows you to modify the contents of the 
stream.  The `StreamTransformer` constructor takes a `handleData` function, 
which is called for each value passed from the stream.  You can modify the value 
as you wish, and add it back to the `StreamSink`, which results in the modified 
values being output on the `transform()` method's own stream.  The example below 
takes our data `[1,2,3,4,5]` and converts each item into two new `String` 
values, `"Message n"` and `"Body n"`. Each string is placed onto the new stream.

<!--- BEGIN(stream_transformer) -->{% prettify dart %}
// define a stream transformer
var transformer = new StreamTransformer(handleData: (value, sink) {
  // create two new values from the original value
  sink.add("Message: $value");
  sink.add("Body: $value");
});
  
// transform the stream and listen to its output
stream.transform(transformer).listen((value) => print("listen: $value"));
{% endprettify %}<!--- END(stream_transformer) -->

Running this produces the following output:

    listen: Message: 1
    listen: Body: 1
    listen: Message: 2
    listen: Body: 2
    listen: Message: 3
    listen: Body: 3
    listen: Message: 4
    listen: Body: 4
    listen: Message: 5
    listen: Body: 5


Perhaps the most common transform you will use is transforming a 
List<int> into a String by using a `UTF8.decoder` from `dart:convert`, 
such as when reading data from a file or HTTP request, as in the following example.

<!--- BEGIN(string_decoder) -->{% prettify dart %}
File file = new File("some_file.txt");
file.openRead()
    .transform(UTF8.decoder) // use a UTF8.decoder
    .listen((String data) => print(data), // output the data
        onError: (error) => print("Error, could not open file"),
        onDone: () => print("Finished reading data"));
{% endprettify %}<!--- END(string_decoder) --> 


### Validating stream data

Sometimes, you want to validate that the data returned from a stream meets 
certain conditions.  A following functions return `Future<bool>` values: 
`any()`, `every()`, and `contains()`.

<!--- BEGIN(validating_stream_data) -->{% prettify dart %}
broadcastStream
    .any((value) => value < 5)
    .then((result) => print("Any less than 5?: $result")); // true
  
broadcastStream
    .every((value) => value < 5)
    .then((result) => print("All less than 5?: $result")); // false
  
broadcastStream
    .contains(4)
    .then((result) => print("Contains 4?: $result")); // true
{% endprettify %}<!--- END(validating_stream_data) -->

## Single value streams {#single-value-streams}

Some streams are designed to return only a single value, and you want to 
ensure that you only retrieve a  single value from them. The `single` getter 
and `singleWhere()` method both return a future containing the single value, 
or raise an error if they don't.  For example, with our data set containing 5 
values: `[1,2,3,4,5]`, the following will return the value 1:

<!--- BEGIN(single_where) -->{% prettify dart %}
broadcastStream
    .singleWhere((value) => value < 2)  // there is only one value less than 2
    .then((value) => print("single value: $value")); 
    // outputs: single value: 1
{% endprettify %}<!--- END(single_where) -->

However, the following raises an error and halts the application (because 
the error is unhandled):

<!--- BEGIN(failure_using_single) -->{% prettify dart %}
broadcastStream
    .single  // will fail - there is more than one value in the stream
    .then((value) => print("single value: $value"));
{% endprettify %}<!--- END(failure_using_single) -->

This brings us neatly on to...

## Error handling in streams and futures {#error-handling}

There is already an [excellent article about handling errors with future 
based APIs](http://www.dartlang.org/articles/futures-and-error-handling/), 
so I'll not repeat that here.  It's useful to note, though, that we can 
rewrite our previous snippet to include some error handling so that we can 
detect that the `single` call has failed.  A Future's `then()` function returns 
a future, and you can use its `catchError()` handler.  This `catchError` handler 
will catch any errors thrown within the `then()` callback:

<!--- BEGIN(catch_error) -->{% prettify dart %}
broadcastStream
    .single  // will fail - there is more than one value in the stream
    .then((value) => print("single value: $value")) 
    .catchError((err) => print("Expected Error: $err")); // catch any error in the then()
    // output: Bad State: More than one element
{% endprettify %}<!--- END(catch_error) -->

### Error handling with StreamSubscription

When you use the `listen()` function to listen to values coming from a stream, 
you have the option of adding error handling.  The listen function creates a 
`StreamSubscription` instance, which is the return value of the `listen()` function. 

A StreamSubscription has a number of handlers, namely: `onData`, `onError` and 
`onDone`.  Each of these can be assigned via the `listen()` function, or later, 
via the returned `StreamSubscription` object.  Note the `onError` handler, 
which you can use to catch errors output from the stream:

<!--- BEGIN(subscription_handler_methods) -->{% prettify dart %}
// setup the handlers through the subscription's handler methods
var subscription = stream.listen(null);
subscription.onData((value) => print("listen: $value"));
subscription.onError((err) => print("error: $err"));
subscription.onDone(() => print("done"));
{% endprettify %}<!--- END(subscription_handler_methods) -->

and:

<!--- BEGIN(arguments_to_listen) -->{% prettify dart %}
// setup the handlers as arguments to the listen() function
var subscription = stream.listen(
    (value) => print("listen: $value"),
    onError: (err) => print("error: $err"),
    onDone: () => print("done"));
{% endprettify %}<!--- END(arguments_to_listen) -->

These two both print the same output:

    listen: 1
    listen: 2
    listen: 3
    listen: 4
    listen: 5
    done

One of the benefits of using the form 
`var subscription = stream.listen(null)` and then setting up the `onData` 
handler separately means that you can use the `subscription` object in the data 
handler itself.

The `onDone` handler is called when there is no more data, and the underlying 
stream is closed.

## Unsubscribing from a stream {#unsubscribing}

You can use the `StreamSubscription` object to unsubscribe from the stream, 
using the `cancel()` method.  For example, the listener in the following code 
unsubscribes from the stream after receiving the value 2, so it never receives 
the `onDone` message:

<!--- BEGIN(cancelling_a_stream) -->{% prettify dart %}
var subscription = stream.listen(null);
subscription.onData((value) {
  print("listen: $value");
  if (value == 2) subscription.cancel(); // cancel the subscription
});
subscription.onError((err) => print("error: $err"));
subscription.onDone(() => print("done"));
{% endprettify %}<!--- END(cancelling_a_stream) -->

## Streams are generic {#streams-are-generic}

All the stream classes are also generic, which means that you get strongly 
typed data in the handlers.  For example, if you create a `Stream<String>`, 
then all the handler functions will also be expecting a `String`, as shown by 
the following code:

<!--- BEGIN(stream_generics) -->{% prettify dart %}
var data = [1,2,3,4,5]; // ints, valid
// var data = ["1","2","3","4","5"]; // strings, not valid
var stream = new Stream<int>.fromIterable(data); // Stream<int>
stream.listen((value) { // value must be an int
  print("listen: $value");
});
{% endprettify %}<!--- END(stream_generics) -->

## Some real world examples of consuming a stream {#real-world}

Now that you've seen how to consume data in a stream, let's take a look at a 
couple of real-world examples: handling button clicks, and reading data from a 
file.

### Button clicks in dart:html

Buttons have a number of `onSomeEvent` streams defined, and the `onClick` stream 
is defined as `Stream<MouseEvent>`. This type means that the data that you 
receive when you listen to the `onClick` stream is all going to be MouseEvents.

The following code sets up a button and a couple of event handlers.
One event handler remains
registered, and the other unregisters itself after the third button click.

<!--- BEGIN(html_streams) -->{% prettify dart %}
import 'dart:html';

void main() {
  var button = new ButtonElement();
  document.body.children.add(button);
  
  button.text = "Foo"; 
  var clickCount = 0;
  button.onClick.listen((mouseEvent) {
    print("clicked"); // remain subscribed for all clicks
  });
  
  var subscription = button.onClick.listen(null);
  subscription.onData((mouseEvent) {
    print("copy that");
    clickCount++;
    window.alert("Clicked");
    if (clickCount == 3) {
      subscription.cancel(); // unsubscribe after the third click
    }
  });  
}
{% endprettify %}<!--- END(html_streams) -->

When the button is clicked, the click counter is incremented. On the third 
click, the second event handler unsubscribes itself.

### Reading a file in dart:io

The second real-world example shows how to read some data from a file on the 
filesystem.  The `file.openRead()` returns a stream containing the file's 
contents.  The stream (which contains a `List<int>`) is decoded using a 
`UTF8.decoder` class from `dart:convert` to allow for UTF-8 conversion.

<!--- BEGIN(reading_a_file) -->{% prettify dart %}
import 'dart:io';

main() {
  File file = new File("some_file.txt");
  file.openRead()
      .transform(UTF8.decoder) // use a UTF8.decoder
      .listen((String data) => print(data), // output the data
        onError: (error) => print("Error, could not open file"),
        onDone: () => print("Finished reading data"));
} 
{% endprettify %}<!--- END(reading_a_file) -->

## Conclusion {#conclusion}

Streams are unified across Dart's asynchronous APIs, providing a powerful 
way to deal with streams of data, whether that data is event 
objects, bytes, or your own custom classes.

## About the author {#about-chris}

<img src="chris-buckett.png" width="95" height="115"
alt="Chris Buckett head shot" align="left" style="margin-right: 10px">

Chris Buckett is a Technical Manager for
[Entity Group Ltd](http://www.entity.co.uk/), responsible for building and
delivering enterprise client-server webapps, mostly with GWT, Java and .Net.
He runs the [dartwatch.com blog](http://blog.dartwatch.com/), and has written
the book _Dart in Action_, which is available
at [manning.com](http://www.manning.com/buckett).

{% endcapture %}

{% include tutorial.html %}
