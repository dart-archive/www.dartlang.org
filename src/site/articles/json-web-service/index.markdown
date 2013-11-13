---
layout: article
title: "Using Dart with JSON Web Services"
description: "Learn how to consume JSON-based web services with Dart."
rel:
  author: chris-buckett
has-permalinks: true
article:
  written_on: 2012-04-01
  updated_on: 2013-02-02
  collection: libraries-and-apis
---

{% include toc.html %}

# {{ page.title }}

_Written by Chris Buckett<br>
April 2012 (updated February 2013)_

Most client-side Dart apps need a way to communicate with a server, and sending
JSON via [XMLHttpRequest](https://developer.mozilla.org/en/XMLHttpRequest) is
the preferred way to do this. This article discusses communicating with a
server using the 
[HttpRequest API](http://api.dartlang.org/html/HttpRequest.html)
from the [dart:html](http://api.dartlang.org/html.html) library and 
parsing JSON data using the [dart:convert](http://api.dartlang.org/docs/releases/latest/dart_convert.html) 
library. It then goes on to show how to provide dot-notation access to JSON 
data through the use of JsonObject.

## A JSON web service

Many modern web apps are powered by RESTful web services that send and receive
data encoded as JSON. This article features a web service that responds to an
HTTP GET request to the URL `/programming-languages/dart` by returning the 
following JSON string, which contains a string, a list, and a map that 
represents information about the Dart language:

{% prettify json %}
{
  "language": "dart",                                 // String
  "targets": ["dartium","javascript"],                // List
  "website": {                                        // Map
    "homepage": "www.dartlang.org",
    "api": "api.dartlang.org"
  }
}
{% endprettify %}

The same web service accepts data on the same URL with an HTTP POST.  The web
service interprets a POST as a request to create a new object on the server,
like an SQL INSERT.  The POSTed JSON data is sent in the HTTP body.

<aside class="alert alert-info" markdown="1">
  <strong>Note:</strong>
  The source code for the examples in this article, and a simple dart 
  web server that responds to these GET and POST requests is 
  [available on github](https://github.com/chrisbu/dartlang_json_webservice_article_code).  
  Full instructions for use are contained in the 
  [README file](https://github.com/chrisbu/dartlang_json_webservice_article_code/blob/master/README.md).
</aside>

## Connecting to the server

When communicating with a web service, use the <code>HttpRequest</code> 
API from the dart:html library. HttpRequest is a standard way to 
programmatically send and receive data to and from web servers.  This is 
Dart's equivalent to XMLHttpRequest in JavaScript.

### Getting data from the server

Get objects from the server using HTTP GET.  HttpRequest provides a named
constructor called <code>get</code> that takes a URL and a callback function
that's invoked when the server responds.

{% prettify dart %}
void loadData() {
  var url = "http://127.0.0.1:8080/programming-languages";

  // call the web server asynchronously
  var request = HttpRequest.getString(url).then(onDataLoaded);
}
{% endprettify %}

Then elsewhere in your code, you can define an <code>onDataLoaded</code> 
callback function and call the <code>loadData()</code> function:

{% prettify dart %}
// print the raw json response text from the server
void onDataLoaded(String responseText) {
  var jsonString = responseText;
  print(jsonString);
}

main() {
  loadData();
}
{% endprettify %}

<aside class="alert alert-info" markdown="1">
  <strong>Note:</strong>
  <code>HttpRequest.getString()</code> is a convenience static method that wraps the
full HttpRequest API.  The full HttpRequest API is still available if you need finer-grained control over the API.
</aside>

### Saving objects on the server

To create a new object on the server, use the full HttpRequest API with the 
HTTP POST method.  Use the readyStateChange listener to be notified when the 
request is complete.  The example below calls an onSuccess function when the 
request is complete:

{% prettify dart %}
void saveData() {
  HttpRequest request = new HttpRequest(); // create a new XHR
  
  // add an event handler that is called when the request finishes
  request.onReadyStateChange.listen((_) {
    if (request.readyState == HttpRequest.DONE &&
        (request.status == 200 || request.status == 0)) {
      // data saved OK.
      print(request.responseText); // output the response from the server
    }
  });

  // POST the data to the server
  var url = "http://127.0.0.1:8080/programming-languages";
  request.open("POST", url, async: false);

  String jsonData = '{"language":"dart"}'; // etc...
  request.send(jsonData); // perform the async POST
}
{% endprettify %}

<aside>
  <div class="alert alert-warning">
  <strong>Warning:</strong>
If you are trying this out for yourself against a real server, you may receive 
errors referring to <code>Access-Control-Allow-Origin</code>.  For details and workarounds, see the section
<a href="#a-note-on-cors-and-httprequest">A note on CORS and HttpRequest</a>. 
  </div>
</aside>

## Parsing JSON

Now that you have seen how HttpRequest GETs data from the server back to the
client, and POSTs data from the client to the server, the next step is to make
use of the JSON data in the client application.

The [dart:convert](http://api.dartlang.org/docs/releases/latest/dart_convert/JsonCodec.html) library provides a JsonCodec class,
which you can use to convert simple types (map, list, int, num, string) automatically 
from a and to a JSON string.  The two key static methods are, <code>JSON.encode(object)</code> and <code>JSON.decode(string)</code>.

<aside class="alert alert-info" markdown="1">
  <strong>Tip:</strong>
  JSON support was previously included as part of the dart:json library.  
  The equivalent <code>JSON.stringify()</code> function is now <code>JSON.encode()</code>, 
  and likewise <code>JSON.parse()</code> is now <code>JSON.decode()</code>
</aside>

The <code>JSON.decode()</code> static method converts a string containing JSON formatted 
text into a List of values or a Map of key-value pairs, depending upon the 
content of the JSON:

{% prettify dart %}
import 'dart:convert';

main() {
  String listAsJson = '["Dart",1.0]'; // input List of data
  List parsedList = JSON.decode(listAsJson);
  print(parsedList[0]); // Dart
  print(parsedList[1]); // 0.8

  String mapAsJson = '{"language":"dart"}';  // input Map of data
  Map parsedMap = JSON.decode(mapAsJson);
  print(parsedMap["language"]); // dart
}
{% endprettify %}

JSON also works for more complex data structures, such as nested maps inside
of lists.

Use <code>JSON.decode()</code> to convert the HttpRequest's response from raw text to an actual Dart <code>Map</code> object:

{% prettify dart %}
void onDataLoaded(HttpRequest req) {
  Map data = JSON.decode(req.responseText); // parse response text
  print(data["language"]); // dart
  print(data["targets"][0]); // dartium
  print(data["website"]["homepage"]); // www.dartlang.org
}
{% endprettify %}

The <code>encode()</code> static method works the same as <code>decode</code> but in reverse.

{% prettify dart %}
void saveData() {

  // snip setting up HttpRequest

  var mapData = new Map();
  mapData["language"] = "dart";
  mapData["targets"] = new List();
  mapData["targets"].add("dartium");

  String jsonData = JSON.encode(mapData); // convert map to String
  request.send(jsonData); // perform the async POST
}
{% endprettify %}

Using simple Maps with strings as keys has some unfortunate side effects.
Making a typo in any of the string names will return a null value which could
then go on to cause a NoSuchMethodError.  Accessing the values from the map
cannot be validated before run-time.

One of the benefits of using Dart is support for optional static types. Static
types help you catch bugs early by allowing tools to detect type mismatches
before you run your code, and to throw exceptions as soon as a runtime issue
occurs.  An additional benefit of using static types is that Dart Editor also
uses this type information to provide auto-complete information&mdash;helpful
when you are using a new library or data structure.

Ideally, you want to access JSON data in a structured way, taking advantage of
the tools to help you catch bugs early. The following example feels more like
natural Dart code:

{% prettify dart %}
var data = // ... initialize data ...

// property access is validated by tools
print(data.language);
print(data.targets[0]);
data.website.forEach((key, value) => print("$key=$value"));
{% endprettify %}

Fortunately, the ability to write code using this "dot notation" is built into
Dart, through its support of classes. The solution, then, is to combine the
flexibility of a Map with the structure of a class.

### Introducing JsonObject

This flexibility of JSON and Maps combined with the structure of classes is 
made possible with JsonObject, which is a third-party open source library.
JsonObject uses the dart:convert decode() function to extract the JSON data into 
a map, and then it uses the noSuchMethod feature of Dart classes to provide a 
way to access values in the parsed map by using dot notation.

To learn more about JsonObject and download its code, go to the [project on
GitHub](https://github.com/chrisbu/dartwatch-JsonObject).

JsonObject uses Dart's noSuchMethod method support, which enables objects to
intercept unknown method calls.  For example, if you invoke a getter such as
data.language, where data is a JsonObject, then behind the scenes
`noSuchMethod("get:language", null)` is called.  Likewise, when you try to set
a value on a JsonObject, `noSuchMethod("set:language", ["Dart"])` is called.
JsonObject intercepts the calls to noSuchMethod and accesses the underlying 
Map.  Data contained within a JsonObject is still Map data, and so the dart:convert encode() and decode() methods still work on JsonObjects.

Here is an example of using JsonObject instead of a raw Map:

{% prettify dart %}
void onDataLoaded(HttpRequest req) {
  // decode the JSON response text using JsonObject
  JsonObject data = new JsonObject.fromJsonString(req.responseText);

  // dot notation property access
  print(data.language);         // Get a simple value
  data.language = "Dart";       // Set a simple value
  print(data.targets[0]);       // Get a value in a list
  // iterate the website map
  data.website.forEach((key, value) => print("$key=$value")); 
}
{% endprettify %}

You can also use this in conjunction with your own classes. By extending 
JsonObject, providing a factory constructor and implementing a suitable 
interface, you can increase the readability of your code, allow the tools
to help with type checking, and allow your classes to convert back and forth between a JSON string and JsonObject's internal map structure.  

If factory constructors and implementing interfaces sounds like hard work, the following example shows that it really isn't.

{% prettify dart %}
// Abstract class defines the interface of our JSON data structure
abstract class Language {
  String language;
  List targets;
  Map website;
}

/** Implementation class extends JsonObject, and uses the structure
 *  defined by implementing the Language abstract class. 
 *  JsonObject's noSuchMethod() function provides the actual underlying
 *  implementation.
 */
class LanguageImpl extends JsonObject implements Language {
  LanguageImpl(); 
  
  factory LanguageImpl.fromJsonString(string) {
    return new JsonObject.fromJsonString(string, new LanguageImpl());
  }
}
{% endprettify %}

Elsewhere in your code, you can use this structure to get strong typing of your JSON data. 

{% prettify dart %}
void onDataLoaded(HttpRequest req) {
  // Decode the JSON response text using LanguageImpl
  // The Language interface provides structure 
  Language data = new LanguageImpl.fromJsonString(req.responseText);

  // dot notation property access
  print(data.language);         // Get a simple value
  data.language = "Dart";       // Set a simple value
  print(data.targets[0]);       // Get a value in a list
  // iterate the website map
  data.website.forEach((key, value) => print("$key=$value")); 
}
{% endprettify %}

JsonObject also allows you to create new, empty objects, without first
converting from a JSON string, by using the default constructor:

{% prettify dart %}
  var data = new JsonObject();
  data.language = "Dart";
  data.targets = new List();
  data.targets.add("Dartium");
{% endprettify %}

JsonObject also implements the Map interface, which means that you can use the
standard map syntax:

{% prettify dart %}
var data = new JsonObject();
data["language"] = "Dart"; // standard map syntax
{% endprettify %}

Because JsonObject implements Map, you can pass a JsonObject into
JSON.encode(), which converts a Map into JSON for sending the data back to
the server:

{% prettify dart %}
var data = new JsonObject.fromJsonString(req.responseText);

// later...
// convert the JsonObject data back to a string
String json = JSON.encode(data);

// and POST it back to the server
HttpRequest req = new HttpRequest();
req.open("POST", url);
req.send(json);
{% endprettify %}

You can include JsonObject in your project by using the
[pub](http://pub.dartlang.org) package manager.
Simply specify the following dependency:

{% prettify yaml %}
dependencies:
  json_object: any
{% endprettify %}

and import the package using the following import statement:

{% prettify dart %}
import "package:json_object/json_object.dart";
{% endprettify %}

### A note on CORS and HttpRequest

One caveat: Make sure your app is served from the same origin (domain name,
port, and application layer protocol) as the web service you are trying to
access with HttpRequest. Otherwise your app will hit the
<code>Access-Control-Allow-Origin</code> restriction build into your web
browser.  This is a security restriction to prevent loading data from a 
different server than the one serving the client app.

You can get around this restriction in a couple of ways.  The first is to use
an emerging technology known as
[Cross-Origin Resource Sharing](https://developer.mozilla.org/en/http_access_control)
(CORS), which is starting to become implemented by web servers. In [the code 
that accompanies this article](https://github.com/chrisbu/dartlang_json_webservice_article_code), 
you can find [simpleserver.dart](https://github.com/chrisbu/dartlang_json_webservice_article_code/blob/master/simpleserver/simpleserver.dart) that serves example JSON data for this article.
This makes use of CORS headers to allow access from a different URL, such as 
the automatically generated URL of apps launched from the Dart editor.

The second, older way, that only works for GET requests is to use a workaround 
called JSONP, which makes use of JavaScript callbacks.  
The Dart - JavaScript interop libraries in the [js 
interop package](http://pub.dartlang.org/packages/js) available on pub
are suitable for JavaScript callbacks:

{% prettify dart %}
import 'dart:html';
import 'package:js/js.dart' as js;

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
    document.body.children.add(script); // add the script to the DOM
  });
}
{% endprettify %}

For more detailed information about JS Interop, see
the [js package docs](http://dart-lang.github.com/js-interop/docs/js.html).

## Summary

This article showed how a client-side Dart application communicates with a
JSON-based web service via HTTP GET and POST.  JSON data is parsed using the
dart:convert library, which converts JSON strings into maps and lists.  Using
JsonObject with the JSON data allows you to extend the functionality of the
dart:convert library by letting you use dot notation to access data fields.

## Resources

* [Source code examples from this article](https://github.com/chrisbu/dartlang_json_webservice_article_code)
* [dart:convert](http://api.dartlang.org/docs/releases/latest/dart_convert.html)
* [HttpRequest](http://api.dartlang.org/html/HttpRequest.html)
* [JsonObject](https://github.com/chrisbu/dartwatch-JsonObject)
* [Using JSONP with Dart](http://blog.sethladd.com/2012/03/jsonp-with-dart.html)
* [Dart JS Interop Library](http://dart-lang.github.com/js-interop/docs/js.html)
* [About access-control restrictions](https://developer.mozilla.org/en/http_access_control)

### About the author

<img src="chris-buckett.png" width="95" height="115"
alt="Chris Buckett head shot" align="left" style="margin-right: 10px">

Chris Buckett is a Technical Manager for
[Entity Group Ltd](http://www.entity.co.uk/), responsible for building and
delivering enterprise client-server webapps, mostly with GWT, Java and .Net.
He runs the [dartwatch.com blog](http://blog.dartwatch.com/), and has written
the writing the book _Dart in Action_, which is available
at [manning.com](http://www.manning.com/buckett).

