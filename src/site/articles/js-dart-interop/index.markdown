---
layout: default
title: "Using JavaScript from Dart"
rel:
  author: shailen-tuli
description: "An introduction to Dart-JavaScript interoperatibility using the dart:js library."
has-permalinks: true
article:
  written_on: 2013-11-20
  collection: libraries-and-apis
---

{% include toc.html %}

# {{ page.title }}

_Written by Shailen Tuli <br>
November 2013_

With the `dart:js` library,
you can use JavaScript code within Dart apps.
The library works both in Dartium and
in code that's compiled to JavaScript.


## Using the dart:js library

To use the dart:js library, first import it:

{% prettify dart %}
import 'dart:js';
{% endprettify %}

Then, add a link to your `.dart` file in your HTML page:

{% prettify html %}
<script src="myapp.dart" type="application/dart"></script>
{% endprettify %}

And add the following scripts:

{% prettify html %}
<script src="packages/browser/dart.js"></script>
<script src="packages/browser/interop.js"></script>
{% endprettify %}

## JsObject and the context getter

Use the top-level `context` getter to access the global object in JavaScript.
For example,
if your JavaScript code has a top-level `Point` variable,
your Dart code can use it like this:

{% prettify dart %}
var obj = context['Point'];
{% endprettify %}

Calling `context` returns a `JsObject`, which represents a proxy of a
JavaScript object.

The `JsObject` class provides ways to get references to JavaScript objects,
get and set object properties,
and invoke JavaScript constructors, functions and methods.

## Instantiating classes

Given a proxy to a JavaScript constructor, your Dart code can create JavaScript
objects.

Consider this JavaScript constructor function:

{% prettify dart %}
var Point = function(x, y) {
  this.x = x;
  this.y = y;
};
{% endprettify %}

You can instantiate a JavaScript `Point` using `dart:js` like this:

{% prettify dart %}
var point = new JsObject(context['Point'], [3, 4]);
{% endprettify %}

The `JsObject()` constructor takes two arguments: the name of a JavaScript
constructor, and the list of arguments that are passed to it.

Consider a more real-world example that uses the JavaScript Google Maps API.
In JavaScript you would instantiate a `Map` object like this:

{% prettify javascript %}
// JavaScript code.
var map = new google.maps.Map(...);
{% endprettify %}

In Dart, you can instantiate the `Map` object like this:

{% prettify dart %}
// Equivalent Dart code.
var googleMap = new JsObject(context['google']['maps']['Map'], [...]);
{% endprettify %}

Calling `new JsObject()` constructs a new JavaScript object
and returns a proxy to it.

## Accessing properties and calling methods

Let's say you want to use the following JavaScript code:

{% prettify javascript %}
var Point = function(x, y) {
  this.x = x;
  this.y = y;
  this.distanceFrom = function(otherPoint) {
    return Math.sqrt(Math.pow(otherPoint.x - this.x, 2) +
        Math.pow(otherPoint.y - this.y, 2));
  };
};
{% endprettify %}

In your Dart code, use the indexing operator (`[]`) to get and set properties:

{% prettify dart %}
var p1 = new JsObject(context['Point'], [5, 1]);
print(p1['x']); // Prints 5.
p1['x'] = 100;
print(p1['x']); // Prints 100.
{% endprettify %}

Call methods by invoking `callMethod()`:

{% prettify dart %}
var p1 = new JsObject(context['Point'], [5, 1]);
var p2 = new JsObject(context['Point'], [1, -2]);
print(p1.callMethod('distanceFrom', [p2])); // Prints 5.
{% endprettify %}

##  Converting a Dart collection to a JavaScript collection

Use the `JsObject.jsify()` constructor to recursively convert a JSON-like
collection of Dart objects to a collection of
JavaScript objects.
Calling `JsObject.jsify()` returns a `JsObject` proxy to the collection:

{% prettify dart %}
var mapOptions = new JsObject.jsify({
    "zoom": 8,
    "mapTypeId": context['google']['maps'['MapTypeId']['ROADMAP']
});
{% endprettify %}

The argument passed to `JsObject.jsify()` must be a Map or Iterable, elements
of which are converted recursively to JavaScript objects.

## Samples

Visit the
[dart:js section of the samples page](/samples/#using_javascript_from_dart)
to see the examples that call JavaScript code from Dart.

[Google Maps: Using the JavaScript API with dart:js](/samples/google_maps/)
: A simple introduction to using a JavaScript API from Dart.

[Using the Google Charts Visualization API](/samples/gauge/)
: An intermediate level sample that shows the use `dart:js` in an
async context.

[Fetching Data Using JSONP](/samples/jsonp/)
: A sample that uses JSONP to fetch data from GitHub for the user dart-lang.


## More resources


Read the API documentation:

* [dart:js](http://api.dartlang.org/docs/channels/stable/latest/dart_js.html)
* [JsObject](http://api.dartlang.org/docs/channels/stable/latest/dart_js/JsObject.html)
