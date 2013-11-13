---
layout: article
title: "Getting Your Feet Wet with Streams"
description: 
  Learn how to consume single-subscriber and broadcast streams, 
  with real-world uses.
rel:
  author: chris-buckett
has-permalinks: true
article:
  written_on: 2013-03-20
  collection: libraries-and-apis
---

{% include toc.html %}

# {{ page.title }}

_Written by Chris Buckett <br />
March 2013_

Over the last few months you can't help but notice that Streams have appeared 
in Dart in a big way.  

Whether running in the browser as part of the various HTML events, such as 
button.onClick, or on the server as part of the dart:io changes, Streams form 
a unified interface to anything that might send out a repeating series of data.

This article explains how to consume streams using this unified interface.

## Background reading: futures

Before we get started, it is important to note that Streams are part 
of the [dart:async](http://api.dartlang.org/dart_async.html) library.
They share a close relationship with Dart's async staple, <code>Future</code>,
due to their asynchronous nature.
(You can't block code until a user clicks a button!)


The Future class is used for async communication within various Dart APIs. A 
common example is a browser <code>HttpRequest</code> (or AJAX request).  
You have some code running in the browser that wants to get a value from 
the server, let's say, the current number of logged on users.
If your client-side code called the server and then waited (blocking) for 
the server to respond, the UI would freeze up until the server responded 
(due to code execution being halted).
  
Fortunately (and provided by the A in AJAX), this call to the server is 
asynchronous, and modelled by Dart's Future API, which returns a future 
value wrapped up in a callback exposed by the <code>then()</code> 
function.

The following snippet shows how this might work, with the callback 
function specified as an argument to then():

<!--- BEGIN(http_request) -->{% prettify dart %}
var url = "http://example.com/userCount";
HttpRequest.getString(url).then((String result) {  // callback function
  print("User count: $result");
});
{% endprettify %}<!--- END(http_request) -->

This pattern is used by streams to retrieve or manipulate data that the 
stream is sending out to its consumers.

There is more detail about futures in the [Using Future Based APIs](http://www.dartlang.org/articles/using-future-based-apis/)
 article.

## What are streams for?

Imagine you are writing a chat application.  On a single client, you will be 
receiving messages and displaying them to the user.  You can't simply write a 
while loop because that will block execution, so you need to use async 
callbacks.  This is an ideal use case for streams: you have one part of your 
code pushing data into the stream, and another part of your code listening to 
the stream.  

### Key concepts

- **Consuming a stream**: Data is sent out of a stream to a 
<code>StreamSubscriber</code> (or possibly multiple subscribers).
- **Populating a stream**: Data gets into a stream from a 
<code>StreamController</code>.

We'll look at the **consuming** a stream in this article as you're more likely 
to come across streams as a consumer from existing APIs within Dart.  Populating
a stream will be covered in a future article.

## Consuming a stream

Let's take a look at some simple stream code.  For simplicity we're going to 
create a stream from a fixed, literal list at the moment by using the 
stream's <code>fromIterable()</code> constructor, rather than by dynamically 
populating it with a <code>StreamController</code>.

<!--- BEGIN(simple_stream_code) -->{% prettify dart %}
var data = [1,2,3,4,5]; // some sample data
var stream = new Stream.fromIterable(data); // create the stream
{% endprettify %}<!--- END(simple_stream_code) -->

Now that we have a stream that is ready to send out some data, we can use 
that stream to listen to some data.

The typical way is to use the stream's <code>listen()</code> method to 
subscribe to the stream.  This has a number of optional parameters, and 
one mandatory parameter, which is the <code>onData</code> handler callback 
function:

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

The <code>listen()</code> method is fired every time some data is received. 
In in our stream, the <code>listen()</code> callback is called for each of 
the data elements, so the output of running this code is as expected:

    Received: 1
    Received: 2
    Received: 3
    Received: 4
    Received: 5

There are other ways to consume data from the stream, using properties such 
as <code>first</code>, <code>last</code>, <code>length</code>, and
<code>isEmpty</code>.  Each of these properties returns a future. For example:

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
the <code>asBroadcastStream()</code> method, as shown below:

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
the <code>stream.isBroadcast</code> property.

## Common Stream methods

Lots of methods are available on the Stream class.
In the following section, I'll describe some of the more common ones.
Be sure to check out 
the [API docs](http://api.dartlang.org/dart_async/Stream.html)
for the complete list.

### Subsets of stream data

Streams have some useful methods for extracting parts of the data being 
sent out from the stream.  The <code>take()</code>, <code>skip()</code>, 
<code>takeWhile()</code>, <code>skipWhile()</code>, and <code>where()</code> 
methods
allow you to take a subset of data, as shown by the following example.  Each 
outputs its own stream that you can listen to.

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

Another useful method is the <code>transform()</code> method, which takes a 
<code>StreamTransformer</code> instance.  This allows you to modify the 
contents of the stream.  The <code>StreamTransformer</code> constructor takes 
a <code>handleData</code> function, which is called for each value passed from 
the stream.  You can modify the value as you wish, and add it back to the 
<code>StreamSink</code>, which results in the modified values being output on 
the <code>transform()</code> method's own stream.  The example below takes our 
data <code>[1,2,3,4,5]</code> and converts each item into two new 
<code>String</code> values, <code>"Message n"</code> and 
<code>"Body n"</code>. Each string is placed onto the new stream.

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
List&lt;int&gt; into a String by using a <code>StringDecoder</code>, such as 
when reading data from a file or HTTP request, as in the following example.

<!--- BEGIN(string_decoder) -->{% prettify dart %}
File file = new File("some_file.txt");
file.openRead()
    .transform(new StringDecoder()) // use a StringDecoder
    .listen((String data) => print(data), // output the data
        onError: (error) => print("Error, could not open file"),
        onDone: () => print("Finished reading data"));
{% endprettify %}<!--- END(string_decoder) --> 


### Validating stream data

Sometimes, you want to validate that the data returned from a stream meets 
certain conditions.  A following functions return 
<code>Future&lt;bool></code> values: <code>any()</code>, <code>every()</code>, 
and <code>contains()</code>.

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

## Single value streams
Some streams are designed to return only a single value, and you want to 
ensure that you only retrieve a  single value from them.
The <code>single</code> getter 
and <code>singleWhere()</code> method
both return a future containing the single value, 
or raise an error if they don't.  For example, with our data set containing 5 
values: <code>[1,2,3,4,5]</code>, the following will return the value 1:

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

## Error handling in streams and futures

There is already an [excellent article about handling errors with future 
based APIs](http://www.dartlang.org/articles/futures-and-error-handling/), 
so I'll not repeat that here.  It's useful to note, though, that we can 
rewrite our previous snippet to include some error handling so that we can 
detect that the <code>single</code> call has failed.  A Future's 
<code>then()</code> function returns a future, and you can use its 
<code>catchError()</code> handler.  This <code>catchError</code> handler 
will catch any errors thrown within the <code>then()<code> callback:

<!--- BEGIN(catch_error) -->{% prettify dart %}
broadcastStream
    .single  // will fail - there is more than one value in the stream
    .then((value) => print("single value: $value")) 
    .catchError((err) => print("Expected Error: $err")); // catch any error in the then()
    // output: Bad State: More than one element
{% endprettify %}<!--- END(catch_error) -->

### Error handling with StreamSubscription

When you use the <code>listen()</code> function to listen to values coming 
from a stream, you have the option of adding error handling.  The listen 
function creates a <code>StreamSubscription</code> instance, which is the 
return value of the <code>listen()</code> function. 

A StreamSubscription has a number of handlers, namely: <code>onData</code>, 
<code>onError</code> and <code>onDone</code>.  Each of these can be assigned 
via the <code>listen()</code> function, or later, via the returned 
<code>StreamSubscription</code> object.  Note the <code>onError</code> handler, 
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
<code>var subscription = stream.listen(null)</code> and then setting up the 
<code>onData</code> handler separately means that you can use the 
<code>subscription</code> object in the data handler itself.

The <code>onDone</code> handler is called when there is no more data, and the 
underlying stream is closed.

## Unsubscribing from a stream

You can use the <code>StreamSubscription</code> object to unsubscribe 
from the stream, using the <code>cancel()</code> method.  For example, 
the listener in the following code unsubscribes from the stream
after receiving the value 2, so it never 
receives the <code>onDone</code> message:

<!--- BEGIN(cancelling_a_stream) -->{% prettify dart %}
var subscription = stream.listen(null);
subscription.onData((value) {
  print("listen: $value");
  if (value == 2) subscription.cancel(); // cancel the subscription
});
subscription.onError((err) => print("error: $err"));
subscription.onDone(() => print("done"));
{% endprettify %}<!--- END(cancelling_a_stream) -->

## Streams are generic

All the stream classes are also generic, which means that you get strongly 
typed data in the handlers.  For example, if you create a 
<code>Stream&lt;String&gt;</code>, then all the handler functions will also be 
expecting a <code>String</code>, as shown by the following code:

<!--- BEGIN(stream_generics) -->{% prettify dart %}
var data = [1,2,3,4,5]; // ints, valid
// var data = ["1","2","3","4","5"]; // strings, not valid
var stream = new Stream<int>.fromIterable(data); // Stream<int>
stream.listen((value) { // value must be an int
  print("listen: $value");
});
{% endprettify %}<!--- END(stream_generics) -->

## Some real world examples of consuming a stream

Now that you've seen how to consume data in a stream, let's take a look at a 
couple of real-world examples: handling button clicks, and reading data from a 
file.

### Button clicks in dart:html

Buttons have a number of <code>onSomeEvent</code> streams defined, and the 
<code>onClick</code> stream is defined as <code>Stream&lt;MouseEvent&gt;</code>.
This type means that the data that you receive when you listen to the 
<code>onClick</code> stream is all going to be MouseEvents.

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
filesystem.  The <code>file.openRead()</code> returns a stream containing the 
file's contents.  The stream (which contains a <code>List&lt;int></code>) 
is decoded using a <code>StringDecoder</code> class to allow for UTF-8 
conversion.

<!--- BEGIN(reading_a_file) -->{% prettify dart %}
import 'dart:io';

main() {
  File file = new File("some_file.txt");
  file.openRead()
      .transform(new StringDecoder()) // use a StringDecoder
      .listen((String data) => print(data), // output the data
        onError: (error) => print("Error, could not open file"),
        onDone: () => print("Finished reading data"));
} 
{% endprettify %}<!--- END(reading_a_file) -->

## Conclusion

Streams are unified across Dart's asynchronous APIs, providing a powerful 
way to deal with streams of data, whether that data is event 
objects, bytes, or your own custom classes.

## About the author

<img src="chris-buckett.png" width="95" height="115"
alt="Chris Buckett head shot" align="left" style="margin-right: 10px">

Chris Buckett is a Technical Manager for
[Entity Group Ltd](http://www.entity.co.uk/), responsible for building and
delivering enterprise client-server webapps, mostly with GWT, Java and .Net.
He runs the [dartwatch.com blog](http://blog.dartwatch.com/), and has written
the book _Dart in Action_, which is available
at [manning.com](http://www.manning.com/buckett).
