---
layout: default
title: "Using Dart with JSON Web Services"
description: "Learn how to consume JSON-based web services with Dart."
rel:
  author: chris-buckett
has-permalinks: true
---

# Using Dart with JSON Web Services

_Written by Chris Buckett<br>
April 2012 (updated November 2012)_

Most client-side Dart apps need a way to communicate with a server, and sending
JSON via [XMLHttpRequest](https://developer.mozilla.org/en/XMLHttpRequest) is
the preferred way to do this. This article discusses communicating with a
server using the [HttpRequest API](http://api.dartlang.org/html/HttpRequest.html)
from the [dart:html](http://api.dartlang.org/html.html) library and parsing JSON
data using the [dart:json](http://api.dartlang.org/json.html) library. It then
goes on to show how to provide dot-notation access to JSON data through the
use of JsonObject.

#### Contents

<ol class="toc">
  <li><a href="#json-web-service">A JSON web service</a></li>
  <li><a href="#connecting-to-server">Connecting to a server</a>
    <ol>
      <li><a href="#getting-data">Getting data from the server</a></li>
      <li><a href="#saving-object">Saving objects on the server</a></li>
    </ol>
  </li>
  <li><a href="#parsing-json">Parsing JSON</a>
    <ol>
      <li><a href="#jsonobject">Introducing JsonObject</a></li>
      <li><a href="#note-on-jsonp">A note on JSONP and HttpRequest</a></li>
    </ol>
  </li>
  <li><a href="#summary">Summary</a></li>
  <li><a href="#resources">Resources</a></li>
  <li><a href="#about-author">About the author</a></li>
</ol>

<h2 id="json-web-service">A JSON web service</h2>

Many modern web apps are powered by RESTful web services that send and receive
data encoded as JSON. This article features a web service that responds to an
HTTP GET to the URL `/programming-languages/dart` by returning the following
JSON string, which contains a string, a list, and a map that represent
information about the Dart language:

{% highlight json %}
{
  "language": "dart",                                 // String
  "targets": ["dartium","javascript"],                // List
  "website": {                                        // Map
    "homepage": "www.dartlang.org",
    "api": "api.dartlang.org"
  }
}
{% endhighlight %}

The same web service accepts data on the same URL with an HTTP POST.  The web
service interprets a POST as a request to create a new object on the server,
like an SQL INSERT.  The POSTed JSON data is sent in the HTTP body.

<h2 id="connecting-to-server">Connecting to the server</h2>

When communicating with a web service, use the HttpRequest API from the
dart:html library.
HttpRequest is a standard way to programmatically send and receive data to
and from web servers.

<h3 id="getting-data">Getting data from the server</h3>

Get objects from the server using HTTP GET.  HttpRequest provides a named
constructor called <code>get</code> that takes a URL and a callback function
that's invoked when the server responds.

{% highlight dart %}
getLanguageData(String languageName, onSuccess(HttpRequest req)) {
  var url = "http://example.com/programming-languages/$languageName";

  // call the web server asynchronously
  var request = new HttpRequest.get(url, onSuccess);
}
{% endhighlight %}

Then elsewhere in your code, you can define an <code>onSuccess</code> 
callback function and call the <code>getLanguageData</code> function:
{% highlight dart %}
// print the raw json response text from the server
onSuccess(HttpRequest req) {
   print(req.responseText); // print the received raw JSON text
}

main() {
  getLanguageData("dart", onSuccess);
}
{% endhighlight %}

Note: HttpRequest.get() is a convenience constructor, and its name will change. The
full HttpRequest API is still an option for HTTP GET, if you need more control
over the API.

<h3 id="saving-object">Saving objects on the server</h3>

To create a new object on the server, use the raw HttpRequest API with the HTTP
POST method.  Use the readyStateChange listener to be notified when the request
is complete.  The example below calls an onSuccess function when the request is
complete:

{% highlight dart %}
saveLanguageData(String data, onSuccess(HttpRequest req)) {
  HttpRequest req = new HttpRequest(); // create a new XHR

  // add an event handler that is called when the request finishes
  req.on.readyStateChange.add((Event e) {
    if (req.readyState == HttpRequest.DONE &&
        (req.status == 200 || req.status == 0)) {
      onSuccess(req); // called when the POST successfully completes
    }
  });

  var url = "http://example.com/programming-languages/";
  req.open("POST", url); // Use POST http method to send data in the next call
  req.send(data); // kick off the request to the server
}

// print the raw json response text from the server
onSuccess(HttpRequest req) {
   print(req.responseText); // print the received raw JSON text
}

String jsonData = '{"language":"dart"}'; // etc...
saveLanguageData(stringData, onSuccess); // send the data to
                                         // the server
{% endhighlight %}

<h2 id="parsing-json">Parsing JSON</h2>

Now that you have seen how HttpRequest GETs data from the server back to the
client, and POSTs data from the client to the server, the next step is to make
use of the JSON data in the client application.

The dart:json library provides two static functions, JSON.parse() and
JSON.stringify().

The parse() function converts a JSON string into a List of values or a Map of
key-value pairs, depending upon the format of the JSON:

{% highlight dart %}
String listAsJson = '["Dart",0.8]'; // input List of data
List parsedList = JSON.parse(listAsJson);
print(parsedList[0]); // Dart
print(parsedList[1]); // 0.8

String mapAsJson = '{"language":"dart"}';  // input Map of data
Map parsedMap = JSON.parse(mapAsJson);
print(parsedMap["language"]); // dart
{% endhighlight %}

JSON also works for more complex data structures, such as nested maps inside
of lists.

Use JSON.parse() to convert the HttpRequest's response from raw text to an
actual Dart object:

{% highlight dart %}
onSuccess(HttpRequest req) {
  Map data = JSON.parse(req.responseText); // parse response text
  print(data["language"]); // dart
  print(data["targets"][0]); // dartium
  print(data["website"]["homepage"]); // www.dartlang.org
}
{% endhighlight %}

Using simple Maps with strings as keys has some unfortunate side effects.
Making a typo in any of the string names will return a null value which could
then go on to cause a NullPointerException.  Accessing the values from the map
cannot be validated, before run-time.

One of the benefits of using Dart is support for optional static types. Static
types help you catch bugs early by allowing tools to detect type mismatches
before you run your code, and to throw exceptions as soon as a runtime issue
occurs.  An additional benefit of using static types is that Dart Editor also
uses this type information to provide auto-complete information&mdash;helpful
when you are using a new library or data structure.

Ideally, you want to access JSON data in a structured way, taking advantage of
the tools to help you catch bugs early. The following example feels more like
natural Dart code:

{% highlight dart %}
Language data = // ... initialize data ...

// property access is validated by tools
print(data.language);
print(data.targets[0]);
print(data.website.homepage);
{% endhighlight %}

Fortunately, the ability to write code using this “dot notation” is built into
Dart, through its support of classes. The solution, then, is to combine the
flexibility of a Map with the structure of a class.

<h3 id="jsonobject">Introducing JsonObject</h3>

This flexibility of JSON and Maps combined with the structure of classes is made
 possible with JsonObject, which is a third-party open source library.
JsonObject uses JSON.parse() to extract the JSON data into a map, and then it
uses the noSuchMethod feature of Dart classes to provide a way to access values
in the parsed map by using dot notation.

To learn more about JsonObject and download its code, go to the [project on
GitHub](https://github.com/chrisbu/dartwatch-JsonObject).

JsonObject uses Dart's noSuchMethod method support, which enables objects to
intercept unknown method calls.  For example, if you invoke a getter such as
data.language, where data is a JsonObject, then behind the scenes
`noSuchMethod("get:language", null)` is called.  Likewise, when you try to set
a value on a JsonObject, `noSuchMethod("set:language", ["Dart"])` is called.
JsonObject intercepts the calls to noSuchMethod and accesses the underlying Map.

Here is an example of using JsonObject instead of a raw Map:

{% highlight dart %}
onSuccess(HttpRequest req) {
  // decode the JSON response text using JsonObject
  var data = new JsonObject.fromJsonString(req.responseText);

  // dot notation property access
  print(data.language);         // Get a simple value
  data.language = "Dart";       // Set a simple value
  print(data.targets[0]);       // Get a value in a list
  print(data.website.homepage); // Get a value from a child object
};
{% endhighlight %}

You can also use this in your own classes. By extending JsonObject, and
providing a suitable constructor, you can increase the readability of your code,
 and allow your classes to convert back and forth between a JSON string and
JsonObjects internal map structure.

{% highlight dart %}
class Language extends JsonObject {
  Language.fromJsonString(jsonString) : super.fromJsonString(jsonString);
}

onSuccess(HttpRequest req) {
  // decode the JSON response text using JsonObject
  Language data = new Language.fromJsonString(req.responseText);

  // dot notation property access
  print(data.language);         // Get a simple value
  data.language = "Dart";       // Set a simple value
  print(data.targets[0]);       // Get a value in a list
  print(data.website.homepage); // Get a value from a child object
};
{% endhighlight %}


JsonObject also allows you to create new, empty objects, without first
converting from a JSON string, by using the default constructor:

{% highlight dart %}
  Language data = new JsonObject();
  data.language = "Dart";
  data.website = new LanguageWebsite();
  data.website.homepage = "http://www.dartlang.org";
{% endhighlight %}

JsonObject also implements the Map interface, which means that you can use the
standard map syntax:

{% highlight dart %}
Language data = new JsonObject();
data["language"] = "Dart"; // standard map syntax
{% endhighlight %}

Because JsonObject implements Map, you can pass a JsonObject into
JSON.stringify(), which converts a Map into JSON for sending the data back to
the server:

{% highlight dart %}
Language data = new JsonObject.fromJsonString(req.responseText);

// later...
// convert the JsonObject data back to a string
String json = JSON.stringify(data);

// and POST it back to the server
HttpRequest req = new HttpRequest();
req.open("POST", url);
req.send(json);
{% endhighlight %}

You can include JsonObject in your project by using the
[pub](http://pub.dartlang.org) package manager.
Simply specify the following dependency:

{% highlight yaml %}
dependencies:
  json_object:
    git: git://github.com/chrisbu/dartwatch-JsonObject.git
{% endhighlight %}

and import the package using the following import statement:

{% highlight dart %}
import "package:json_object/json_object.dart";
{% endhighlight %}


<h3 id="note-on-jsonp">A note on JSONP and HttpRequest</h3>

One caveat: Make sure your app is served from the same origin (domain name,
port, and application layer protocol) as the web service you are trying to
access with HttpRequest. Otherwise your app will hit the
Access-Control-Allow-Origin restriction.  This is a security restriction to
prevent loading data from a different server than the one serving the client
app.

You can get around this restriction in a couple of ways.  The first is to use
an emerging technology known as
[Cross-Origin Resource Sharing](https://developer.mozilla.org/en/http_access_control)
(CORS), which is starting to become implemented by web servers. The second,
older way is to use a workaround called JSONP, which makes use of JavaScript
callbacks.  The Dart - JavaScript interop
libraries in the [js interop package](https://github.com/dart-lang/js-interop/)
are suitable for JavaScript callbacks:

{% highlight dart %}
import 'dart:html';
import 'package:js/js.dart', prefix: 'js';

void main() {
  js.scoped(() {
    // create a top-level JavaScript function called myJsonpCallback
    js.context.myJsonpCallback = new js.Callback.once( (jsonData) {
      print(jsonData); // js.Proxy object containing the data
                       // see js interop docs
    });

    // add a script tag for the api required
    ScriptElement script = new Element.tag("script");
    // add the callback function name to the URL
    script.src = "http://example.com/some/api?callback=myJsonpCallback";
    document.body.elements.addLast(script); // add the script to the DOM
  });
}
{% endhighlight %}

For more detailed information about JS Interop, see
the [js package docs](http://dart-lang.github.com/js-interop/docs/js.html).

<h2 id="summary">Summary</h2>

This article showed how a client-side Dart application communicates with a
JSON-based web service via HTTP GET and POST.  JSON data is parsed using the
dart:json library, which converts JSON strings into maps and lists.  Using
JsonObject with the JSON data allows you to extend the functionality of the
dart:json library by letting you use dot notation to access data fields.

<h2 id="resources">Resources</h2>

* [dart:json](http://api.dartlang.org/json/JSON.html)
* [HttpRequest](http://api.dartlang.org/html/HttpRequest.html)
* [JsonObject](https://github.com/chrisbu/dartwatch-JsonObject)
* [Using JSONP with Dart](http://blog.sethladd.com/2012/03/jsonp-with-dart.html)
* [About access-control restrictions](https://developer.mozilla.org/en/http_access_control)

<h3 id="about-author">About the author</h3>

<img src="chris-buckett.png" width="95" height="115"
alt="Chris Buckett head shot" align="left" style="margin-right: 10px">

Chris Buckett is a Technical Manager for
[Entity Group Ltd](http://www.entity.co.uk/), responsible for building and
delivering enterprise client-server webapps, mostly with GWT, Java and .Net.
He runs the [dartwatch.com blog](http://blog.dartwatch.com/), and is currently
writing the book _Dart in Action_, which is available
at [manning.com](http://www.manning.com/buckett).

