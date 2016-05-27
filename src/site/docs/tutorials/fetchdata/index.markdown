---
layout: tutorial
title: "Fetch Data Dynamically"
description: "Use HttpRequest to fetch data from a file or a server."
has-permalinks: true
tutorial:
  id: fetchdata
next: cmdline/
next-title: "Write Command-Line Apps"
prev: streams/
prev-title: "Asynchronous Programming: Streams"
---

{% capture whats_the_point %}

* Data on the web is often formatted in JSON.
* JSON is text based and human readable.
* The dart:convert library provides support for JSON.
* Use HttpRequest to dynamically load data.

{% endcapture %}

{% comment %}
NOTE: No sample_links section goes here because all the samples are in embedded
DartPads.
{% endcomment %}

{% capture content %}

<div class="tute-target-title">
<h1>{{page.title}}</h1>
<h3>Get data from a file or server.</h3>
</div>

Web applications often use
<a href="http://www.json.org/" target="_blank">JSON</a>
(JavaScript Object Notation)
to pass data between clients and servers.
Data can be _serialized_ into a JSON string,
which is then passed between a client and server,
and revived as an object at its destination.
This tutorial shows you how to use functions in the
<a href="https://api.dartlang.org/dart_convert.html"
   target="_blank">dart:convert</a>
library to produce and consume JSON data.
Because JSON data is typically loaded dynamically,
this tutorial also shows how a web app
can use an HTTP request to get data from an HTTP server.
For web apps,
HTTP requests are served by the browser in which the app is running,
and thus are subject to the browser's security restrictions.

* [About JSON](#about-json)
* [Serializing data into JSON](#serializing-data-into-json)
* [Parsing JSON data](#parsing-json-data)
* [About URIs and HTTP requests](#about-uris)
* [Using the getString() function to load a file](#using-getString-function)
* [Using an HttpRequest object to load a file](#making-a-get-request)
* [Other resources](#other-resources)
* [What next?](#what-next)

##About JSON

The JSON data format is easy for humans
to write and read because it is lightweight and text based.
With JSON, various data types
and simple data structures such as lists and maps
can be serialized and represented by strings.

**Try it!**
The following app, `its_all_about_you`,
displays the JSON string for data of various types.
Click run ( <img src="/imgs/run.png" /> ) to start the app.
Then change the values of the input elements,
and check out the JSON format for each data type.
You might prefer to 
<a href="{{site.custom.dartpad.direct-link}}/245c841595786300b3f4" target="_blank">open the app in DartPad</a> 
to have more space for the app's code and UI.

{% comment %}
https://gist.github.com/Sfshaza/245c841595786300b3f4

main.dart:
// Copyright (c) 2015, the Dart project authors.
// Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:convert';

// Input fields
InputElement favoriteNumber;
InputElement valueOfPi;
InputElement horoscope;
InputElement favOne;
InputElement favTwo;
InputElement favThree;
RadioButtonInputElement loveChocolate;
RadioButtonInputElement noLoveForChocolate;

// Result fields
TextAreaElement intAsJson;
TextAreaElement doubleAsJson;
TextAreaElement stringAsJson;
TextAreaElement listAsJson;
TextAreaElement boolAsJson;
TextAreaElement mapAsJson;

void main() {

  // Set up the input text areas.
  favoriteNumber = querySelector('#favoriteNumber');
  valueOfPi = querySelector('#valueOfPi');
  horoscope = querySelector('#horoscope');
  favOne = querySelector('#favOne');
  favTwo = querySelector('#favTwo');
  favThree = querySelector('#favThree');
  loveChocolate = querySelector('#loveChocolate');
  noLoveForChocolate = querySelector('#noLoveForChocolate');

  // Set up the results text areas 
  // to display the values as JSON.
  intAsJson = querySelector('#intAsJson');
  doubleAsJson = querySelector('#doubleAsJson');
  boolAsJson = querySelector('#boolAsJson');
  stringAsJson = querySelector('#stringAsJson');
  listAsJson = querySelector('#listAsJson');
  mapAsJson = querySelector('#mapAsJson');

  // Set up the listeners.
  favoriteNumber.onKeyUp.listen(showJson);
  valueOfPi.onKeyUp.listen(showJson);
  loveChocolate.onClick.listen(showJson);
  noLoveForChocolate.onClick.listen(showJson);
  horoscope.onKeyUp.listen(showJson);
  favOne.onKeyUp.listen(showJson);
  favTwo.onKeyUp.listen(showJson);
  favThree.onKeyUp.listen(showJson);

  _populateFromJson();
  showJson(null);
}

// Pre-fill the form with some default values.
void _populateFromJson() {

  String jsonDataAsString = '''
  { "favoriteNumber":73,
    "valueOfPi":3.141592,
    "chocolate":true,
    "horoscope":"Cancer",
    "favoriteThings":["monkeys",
                      "parrots",
                      "lattes"]
  }
  ''';

  Map jsonData = JSON.decode(jsonDataAsString);

  favoriteNumber.value = jsonData['favoriteNumber'].toString();
  valueOfPi.value = jsonData['valueOfPi'].toString();
  horoscope.value = jsonData['horoscope'].toString();
  favOne.value = jsonData['favoriteThings'][0];
  favTwo.value = jsonData['favoriteThings'][1];
  favThree.value = jsonData['favoriteThings'][2];

  if (jsonData['chocolate']) {
    loveChocolate.checked = true;
  } else {
    noLoveForChocolate.checked = true;
  }
}

// Display all values as JSON.
void showJson(Event e) {
  
  // Grab the data that will be converted to JSON.
  num favNum = int.parse(favoriteNumber.value);
  num pi = double.parse(valueOfPi.value);
  bool chocolate = loveChocolate.checked;
  String sign = horoscope.value;
  List<String> favoriteThings = [ favOne.value, favTwo.value, favThree.value ];

  Map formData = {
    'favoriteNumber': favNum,
    'valueOfPi': pi,
    'chocolate': chocolate,
    'horoscope': sign,
    'favoriteThings': favoriteThings
  };

  // Convert everything to JSON and display the results.
  intAsJson.text    = JSON.encode(favNum);
  doubleAsJson.text = JSON.encode(pi);
  boolAsJson.text   = JSON.encode(chocolate);
  stringAsJson.text = JSON.encode(sign);
  listAsJson.text   = JSON.encode(favoriteThings);
  mapAsJson.text    = JSON.encode(formData);
}
{% endcomment %}

<iframe
src="{{site.custom.dartpad.embed-html-prefix}}?id=245c841595786300b3f4&horizontalRatio=50&verticalRatio=90"
    width="100%"
    height="600px"
    style="border: 1px solid #ccc;">
</iframe>

The dart:convert library contains two convenient functions
for working with JSON strings:

| dart:convert function | Description |
|---|---|
| <a href="https://api.dartlang.org/dart_convert.html" target="_blank">JSON.decode()</a> | Builds Dart objects from a string containing JSON data. |
| <a href="https://api.dartlang.org/dart_convert.html" target="_blank">JSON.encode()</a> |  Serializes a Dart object into a JSON string. |
{: .table}

To use these functions,
you need to import dart:convert into your Dart code:

{% prettify dart %}
import 'dart:convert';
{% endprettify %}

The JSON.encode() and JSON.decode() functions can handle these Dart types
automatically:

* num
* String
* bool
* null
* List
* Map

##Serializing data into JSON

Use the JSON.encode() function to serialize an object that supports JSON.
The `showJson` function, from the its_all_about_you example,
converts all of the data to JSON strings.

{% prettify dart %}
import 'dart:convert';
...
// Display all values as JSON.
void showJson(Event e) {
  
  // Grab the data that will be converted to JSON.
  num favNum = int.parse(favoriteNumber.value);
  num pi = double.parse(valueOfPi.value);
  bool chocolate = loveChocolate.checked;
  String sign = horoscope.value;
  List<String> favoriteThings = [ favOne.value, favTwo.value, favThree.value ];

  Map formData = {
    'favoriteNumber': favNum,
    'valueOfPi': pi,
    'chocolate': chocolate,
    'horoscope': sign,
    'favoriteThings': favoriteThings
  };

  // Convert everything to JSON and display the results.
  [[highlight]]intAsJson.text    = JSON.encode(favNum);[[/highlight]]
  [[highlight]]doubleAsJson.text = JSON.encode(pi);[[/highlight]]
  [[highlight]]boolAsJson.text   = JSON.encode(chocolate);[[/highlight]]
  [[highlight]]stringAsJson.text = JSON.encode(sign);[[/highlight]]
  [[highlight]]listAsJson.text   = JSON.encode(favoriteThings);[[/highlight]]
  [[highlight]]mapAsJson.text    = JSON.encode(formData);[[/highlight]]
}
{% endprettify %}

Below is the JSON string that results from the code
using the original values from the its_all_about_you app.

<img class="scale-img-max" src="images/jsonstring.png"
     alt="The JSON string for the its_all_about_you app">

Boolean and numeric values
appear as they would if they were literal values in code,
without quotes or other delineating marks.
A boolean value is either `true` or `false`.
A null object is represented with `null`.

Strings are contained within double quotes.
A list is delineated with square brackets;
its items are comma-separated.
The list in this example contains strings.
A map is delineated with curly brackets;
it contains comma-separated key/value pairs,
where the key appears first, followed by a colon,
followed by the value.
In this example,
the keys in the map are strings.
The values in the map vary in type but they are all JSON-parsable.

##Parsing JSON data

Use the JSON.decode() function from the dart:convert library to
create Dart objects from a JSON string.
The its_all_about_you example initially populates the values in the form
from this JSON string:

{% prettify dart %}
String jsonDataAsString = '''
{ "favoriteNumber":73,
  "valueOfPi":3.141592,
  "chocolate":true,
  "horoscope":"Cancer",
  "favoriteThings":["monkeys",
                    "parrots",
                    "lattes"]
}
''';

Map jsonData = JSON.decode(jsonDataAsString);
{% endprettify %}

This code calls the JSON.decode() function with a properly formatted JSON
string. <strong>Note that Dart strings can use either single or double
quotes to denote strings. JSON requires double quotes.</strong>

In this example, the full JSON string is hard coded into the Dart code,
but it could be created by the form itself
or read from a static file or received from a server.
An example later on this page shows how to dynamically fetch
JSON data from a file that is co-located with the code for the app.

The JSON.decode() function reads the string and
builds Dart objects from it.
In this example, 
the JSON.decode() function creates a Map object based on
the information in the JSON string.
The Map contains objects of various types
including an integer, a double, a boolean value, a regular string,
and a list.
All of the keys in the map are strings.

##About URIs and HTTP requests {#about-uris}

To make an HTTP GET request from within a web app,
you need to provide a URI (Uniform Resource Identifier) for the resource.
A URI (Uniform Resource Identifier) is a character string
that uniquely names a resource.
A URL (Uniform Resource Locator) is a specific kind of URI
that also provides the location of a resource.
URLs for resources on the World Wide Web
contain three pieces of information:

* The protocol used for communication
* The hostname of the server
* The path to the resource

For example, the URL for this page breaks down as follows:

<img class="scale-img-max" src="images/uri-details.png"
     alt="The tutorial URL">

This URL specifies the HTTP protocol.
At its most basic,
when you enter an HTTP address into a web browser,
the browser sends an HTTP GET request to a web server,
and the web server sends an HTTP response that contains the
contents of the page (or an error message).

<img class="scale-img-max" src="images/client-server.png"
     alt="Basic HTTP communication between client and server">

Most HTTP requests in a web browser are simple GET requests
asking for the contents of a page.
However, the HTTP protocol allows for other types of requests,
such as POST for sending data from the client.

A Dart web app running inside of a browser can make HTTP requests.
These HTTP requests are handled by the browser in which the app is running.
Even though the browser itself can make HTTP requests anywhere on the web,
a Dart web app running inside the browser can make only *limited*
HTTP requests because of security restrictions.
Practically speaking,
because of these limitations,
HTTP requests from web apps are primarily useful for
retrieving information in files specific to
and co-located with the app.

<aside class="alert alert-info" markdown="1">
<strong>A note about security:</strong>
Browsers place tight security restrictions on HTTP requests
made by embedded apps.
Specifically, any resources requested by a web app
must be served from the same origin.
That is, the resources must be from the same protocol, host, and port
as the app itself.
This means that your web app cannot request
just any resource from the web with HTTP requests through the browser,
even if that request is seemingly harmless (like a GET.)

Some servers do allow cross-origin requests
through a mechanism called
CORS (Cross-origin resource sharing),
which uses headers in an HTTP request
to ask for and receive permission.
CORS is server specific.
</aside>

The SDK provides these useful classes for
formulating URIs and making HTTP requests:

| Dart code | Library | Description |
|---|---|
| <a href="https://api.dartlang.org/dart_core/Uri.html" target="_blank">Uri</a> | (core library) | An object representing a URI. |
| <a href="https://api.dartlang.org/dart_html/HttpRequest.html" target="_blank">HttpRequest</a> |  dart:html | Client-side HTTP request object. For use in web apps. |
| <a href="https://api.dartlang.org/dart_io/HttpRequest.html" target="_blank">HttpRequest</a> |  dart:io | Server-side HTTP request object. Does not work in web apps. |
{: .table}

##Using the getString() function to load a file {#using-getString-function}

One useful HTTP request your web app *can* make is a GET request
for a data file served from the same origin as the app.
The example below reads a data file called `portmanteaux.json`
that contains a JSON-formatted list of words.
When you click the button,
the app makes a GET request of the server
and loads the file.

<aside class="alert alert-info" markdown="1">
**Implementation note:**
The original portmanteaux example loaded a co-located file:

<pre>
var path = 'portmanteaux.json';
</pre>

When we moved the example into [**DartPad**]({{site.custom.dartpad.direct-link}}),
we couldn't co-locate the JSON file because DartPad
supports at most 3 files: one Dart file, one HTML file,
and one CSS file.
The workaround was to move `portmanteaux.json` to dartlang.org and
configure dartlang.org's  CORS headers to allow read-only access
from everywhere.
</aside>

**Try it!** Click run ( <img src="/imgs/run.png" /> )
and then click the **Get portmanteaux** button.

{% comment %}
https://gist.github.com/Sfshaza/8640071ecb67b1309938

main.dart:
// Copyright (c) 2012, the Dart project authors.  
// Please see the AUTHORS file for details. 
// All rights reserved. Use of this source code 
// is governed by a BSD-style license that can be 
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:html';

var wordList;

void main() {
  querySelector('#getWords').onClick.listen(makeRequest);
  wordList = querySelector('#wordList');
}

Future makeRequest(Event e) async {
  var path = 'https://www.dartlang.org/f/portmanteaux.json';
  try {
    processString(await HttpRequest.getString(path));
  } catch (e) {
    print('Couldn\'t open $path');
    handleError(e);
  }
}

processString(String jsonString) {
  List<String> portmanteaux = JSON.decode(jsonString);
  for (int i = 0; i < portmanteaux.length; i++) {
    wordList.children.add(new LIElement()..text = portmanteaux[i]);
  }
}

handleError(Object error) {
  wordList.children.add(new LIElement()..text = 'Request failed.');
}
{% endcomment %}


<iframe
src="{{site.custom.dartpad.embed-html-prefix}}?id=8640071ecb67b1309938&horizontalRatio=68&verticalRatio=80"
    width="100%"
    height="500px"
    style="border: 1px solid #ccc;">
</iframe>

This program uses a convenience method,
`getString()`,
provided by the HttpRequest class
to request the file from the server.

<img class="scale-img-max" src="images/getstringfunction.png"
     alt="Use the getString() function to make a request">

The getString() method uses a Future object to handle the request.
A Future is a way to perform potentially time-consuming operations,
such as HTTP requests, asynchronously.
If you haven't encountered Futures yet,
you can learn more about them in
[Asynchronous Programming: Futures](/docs/tutorials/futures/).
Until then, you can use the code above as an idiom
and provide your own code for the body of the processString() function
and your own code to handle the error.

<aside class="alert alert-info" markdown="1">
**Note:**
The examples in this section use the `async` and `await` keywords.
If you are not familiar with these keywords, see
[Asynchrony support](/docs/dart-up-and-running/ch02.html#asynchrony)
in the [language tour](/docs/dart-up-and-running/ch02.html).
</aside>

##Using an HttpRequest object to load a file {#making-a-get-request}

The getString() method is good for an HTTP GET request that returns 
a string loaded from the resource.
For different cases,
you need to create an HttpRequest object,
configure its header and other information,
and use the `send()` method to make the request.

This section rewrites the portmanteaux code to explicitly construct
an HttpRequest object.

{% comment %}
https://gist.github.com/Sfshaza/83f7779d18a8bbe8ccb1

main.dart:
// Copyright (c) 2012, the Dart project authors.  
// Please see the AUTHORS file for details. 
// All rights reserved. Use of this source code 
// is governed by a BSD-style license that can be 
// found in the LICENSE file.

import 'dart:html';
import 'dart:convert';

var wordList;

void main() {
  querySelector('#getWords').onClick.listen(makeRequest);
  wordList = querySelector('#wordList');
}

void makeRequest(Event e) {
  var path = 'https://www.dartlang.org/f/portmanteaux.json';
  var httpRequest = new HttpRequest();
  httpRequest
    ..open('GET', path)
    ..onLoadEnd.listen((e) => requestComplete(httpRequest))
    ..send('');
}

requestComplete(HttpRequest request) {
  if (request.status == 200) {
    List<String> portmanteaux = JSON.decode(request.responseText);
    for (int i = 0; i < portmanteaux.length; i++) {
      wordList.children.add(new LIElement()..text = portmanteaux[i]);
    }
  } else {
    wordList.children.add(new LIElement()
      ..text = 'Request failed, status=${request.status}');
  }
}
{% endcomment %}

<iframe
src="{{site.custom.dartpad.embed-html-prefix}}?id=83f7779d18a8bbe8ccb1&horizontalRatio=68&verticalRatio=80"
    width="100%"
    height="500px"
    style="border: 1px solid #ccc;">
</iframe>

###Setting up the HttpRequest object

The mouse-click handler for the button
creates an HttpRequest object,
configures it with a URI and callback function,
and then sends the request.
Let's take a look at the Dart code:

{% prettify dart %}
void makeRequest(Event e) {
  var path = 'https://www.dartlang.org/f/portmanteaux.json';
  var httpRequest = new HttpRequest();
  httpRequest
    ..open('GET', path)
    ..onLoadEnd.listen((e) => requestComplete(httpRequest))
    ..send('');
}
{% endprettify %}

<img class="scale-img-max" src="images/portmanteaux-code.png"
     alt="Making an HTTP GET request">

###Sending the request

The send() method sends the request to the server.

{% prettify dart %}
httpRequest.send('');
{% endprettify %}

Because the request in this example is a simple GET request,
the code can send an empty string.
For other types of requests,
such as POST requests,
this string can contain further details or relevant data.
You can also configure the HttpRequest object
by setting various header parameters using the setRequestHeader() method.

###Handling the response

To handle the response from the request,
you need to set up a callback function
before calling send().
Our example sets up a one-line callback function
for `onLoadEnd` events
that in turn calls `requestComplete()`.
This callback function is called when the request completes,
either successfully or unsuccessfully.

<img class="scale-img-max" src="images/set-callback.png"
     alt="Set up a callback function for request completion">

The callback function for our example,
requestComplete(),
checks the status code for the request.
If the status code is 200,
the file was found and loaded successfully,
The contents of the requested file, `portmanteaux.json`, are
returned in the `responseText` property of an HttpRequest object.
Using the `JSON.decode()` function from the dart:convert library,
the code easily converts the JSON-formatted list of words
to a Dart list of strings,
creates a new LIElement for each one,
and adds it to the &lt;ul&gt; element on the page.

<img class="scale-img-max" src="images/portmanteaux-callback.png"
     alt="Getting the response text from an HTTP GET request">

###Populating the UI from JSON

The data file in the portmanteaux example,
portmanteaux.json,
contains a JSON-formatted list of strings.

{% prettify dart %}
[
  "portmanteau", "fantabulous", "spork", "smog",
  "spanglish", "gerrymander", "turducken", "stagflation",
  "bromance", "freeware", "oxbridge", "palimony", "netiquette",
  "brunch", "blog", "chortle", "Hassenpfeffer", "Schnitzelbank"
]
{% endprettify %}

Upon request, the server reads this data from the file
and sends it as a single string
to the client program.
The client program receives the JSON string
and uses JSON.decode() 
to create the String objects specified by the JSON string.

<img class="scale-img-max" src="images/json-parse.png"
     alt="Decode a JSON formatted list of strings">

##Other resources

Check out Chris Buckett's article,
<a href="/articles/json-web-service/"
   target="_blank">Using Dart with JSON Web Services</a>,
for more information and an example with source code for both
client and server programs.

##What next?

* If you skipped the 
[Asynchronous Programming: Futures](/docs/tutorials/futures/) tutorial,
we highly recommend that you go back and learn about Futures
before going any further.

* See the Angular documentation for discussions and example code for
[implementing forms](https://angular.io/docs/dart/latest/guide/forms.html)
and
[talking to a remote server](https://angular.io/docs/dart/latest/guide/server-communication.html).
{% endcapture %}

{% include tutorial.html %}
