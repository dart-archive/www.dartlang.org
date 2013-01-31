---
layout: default
title: "Using JavaScript from Dart: The js Library"
rel:
  author: vijay-menon
description: "An introduction to Dart-JavaScript interoperatibility
             using the js Dart library."
has-permalinks: true
article:
  written_on: 2012-09-01
  collection: libraries-and-apis
---

# {{ page.title }}
_Written by Vijay Menon <br />
September 2012_

This article describes how to use the js Dart library,
which allows Dart web apps
to use JavaScript libraries.
You can use the js library
both in native Dart code (in Dartium)
and in code that's compiled to JavaScript (using dart2js)
and executed in a modern browser.

The library is implemented in the GitHub project
[dart-lang/js-interop](https://github.com/dart-lang/js-interop).


#### Contents

1. [Installing the library's package](#installing-the-librarys-package)
1. [Importing the library](#importing-the-library)
1. [Getting the top-level context](#getting-the-top-level-context)
1. [Creating JavaScript objects from Dart](#creating-javascript-objects-from-dart)
   1. [Instantiating classes](#instantiating-classes)
   1. [Creating maps and arrays](#creating-maps-and-arrays)
1. [Calling Dart from JavaScript](#calling-dart-from-javascript)
1. [Managing proxy lifetimes](#managing-proxy-lifetimes)
1. [Managing callback lifetimes](#managing-callback-lifetimes)
1. [Examples](#examples)
   1. [Google Maps](#google-maps)
   1. [Google Charts](#google-charts)
   1. [Twitter](#twitter)
1. [For more information](#for-more-information)
{:.toc}

## Installing the library's package

To install the library's package using [pub](http://pub.dartlang.org/doc),
put the following lines in your app's pubspec.yaml file:

{% prettify yaml %}
dependencies:
  js:
    hosted: js
{% endprettify %}

Then use pub install:

    $ pub install
    Dependencies installed!

For details about using pub, see the
[pub documentation](http://pub.dartlang.org/doc).


## Importing the library

A Dart program can import the js library if it is running on the UI thread of the browser&mdash;that is, if the program imports dart:html.

To import the js library, use the following code:

{% prettify dart %}
import 'package:js/js.dart' as js;
{% endprettify %}


## Getting the top-level context

To use the js library, you
must get a proxy to the top-level JavaScript context of your app's page:

{% prettify dart %}
var context = js.context;
{% endprettify %}

References to the context are automatically forwarded to JavaScript.  For example, you can invoke the top-level alert function in JavaScript as follows:

{% prettify dart %}
js.context.alert('Hello from Dart via JavaScript.');
{% endprettify %}

Note:
Parameters and return values are intuitively passed by value for primitives and by reference for non-primitives. In the latter case, the references are automatically wrapped and unwrapped as proxies by the library.


## Creating JavaScript objects from Dart

Your Dart code can instantiate JavaScript classes
and create JavaScript maps and arrays.


### Instantiating classes

Given a proxy to a JavaScript constructor,
your Dart code can create JavaScript objects.
For example, if the JavaScript Google Maps API is available,
you can create a Map object like this:

{% prettify dart %}
var canvas = query('#map_canvas');
var googlemaps = js.context.google.maps;
var googlemap = new js.Proxy(googlemaps.Map, canvas);
{% endprettify %}

This code instantiates a JavaScript `google.maps.Map` object onto the given canvas and returns a proxy to Dart.  Note that `googlemaps.Map` is a proxy to the JavaScript constructor. The resulting `googlemap` is a proxy to the actual Google Map object in JavaScript.


### Creating maps and arrays

Use the top-level `map()` and `array()` functions to create JavaScript maps and arrays from their Dart equivalents.
For example, the following code
creates a JavaScript map and returns a Dart proxy to it.

{% prettify dart %}
var options = js.map({ 'zoom': 9,
                       'mapTypeId': googlemaps.MapTypeId.ROADMAP,
                       'center': new js.Proxy(googlemaps.LatLng, 47.6097, -122.3331) });
{% endprettify %}

Elements of a list or map are converted recursively.
For example, a Dart list of Dart lists is converted to a JavaScript list of JavaScript lists.
If a (top-level or nested) list or map contains a Dart object,
that object is converted to a proxy on the JavaScript side.
If a list or map contains a proxy to a JavaScript object,
it is unwrapped to the underlying JavaScript object.

In the example above, `options` is a proxy to
a JavaScript map with three keys&mdash;"zoom", "mapTypeId", and "center".
The "mapTypeId" key is mapped to
the JavaScript constant `googlemaps.MapTypeIdROADMAP`,
and the "center" key is mapped to a JavaScript `googlemaps.LatLng` object.

Converting lists and maps is especially useful for
configuring JavaScript objects from Dart.
For example:

{% prettify dart %}
googlemap.setOptions(options);
{% endprettify %}


## Calling Dart from JavaScript

An important aspect of interoperating with existing JavaScript libraries is enabling Dart functions to be called from JavaScript.
You can expose a Dart function to JavaScript by
converting the function to a Callback object.  For example:

{% prettify dart %}
js.context.handler = new js.Callback.once(display);
{% endprettify %}

The preceding code defines a top-level handler function in JavaScript
that forwards to the corresponding Dart callback.
The `Callback.once()` constructor indicates that
the Callback is executed only _once_.
Its argument is forwarded to the display() function.

For example, the following Dart code makes a JSONP request to Twitter.
The result is forwarded via the JavaScript handler to the Dart display() function.

{% prettify dart %}
var script = new ScriptElement();
script.src
 = 'http://search.twitter.com/search.json?q=dartlang&rpp=10&callback=handler';
document.body.nodes.add(script);
{% endprettify %}


## Managing proxy lifetimes

To avoid memory leaks,
you must manage the lifetime of Proxy and Callback objects.
To ease this task we use the concept of _scopes_.

By default, all proxies are locally scoped.
Code must enter a scope to create or use proxies.
When the code exits that scope,
any proxies created within that scope are automatically released
(and their underlying JavaScript or Dart objects
may be later garbage collected).
To execute Dart code within a scope,
use `scoped()`:

{% prettify dart %}
js.scoped(() {
  js.context.alert('Hello from Dart via JavaScript.');
});
{% endprettify %}

This example creates a proxy to the alert() function
and then invokes it.
That proxy is released once the function passed to `scoped()` is complete.

If a proxy must live beyond its local scope,
you can explicitly retain it
using `js.retain()`.

{% prettify dart %}
var googlemap;
js.scoped(() {
  var canvas = query('#map_canvas');
  var googlemaps = js.context.google.maps;
  googlemap = new js.Proxy(googlemaps.Map, canvas);
  js.retain(googlemap);
});
{% endprettify %}

In the preceding example,
only the `googlemap` proxy is valid once the scope is exited.
All other proxies are released.
The underlying JavaScript map cannot be garbage collected
until its proxy is explicitly released,
using `js.release()`.

{% prettify dart %}
js.release(googlemap);  // Allow googlemap to be garbage collected.
{% endprettify %}


## Managing callback lifetimes

Similarly, Callback objects to Dart functions must be released
so that the Dart functions can be garbage collected.

In general, most callbacks are executed only once
as in our Twitter-JSONP example from earlier:

{% prettify dart %}
js.context.handler = new js.Callback.once(display);
{% endprettify %}

The Callback.once() constructor conveniently handles this common case,
in which callbacks are automatically disposed of after a single invocation.

If your callback is executed multiple times,
use the Callback.many() constructor instead.

{% prettify dart %}
var callback = new js.Callback.many(display);
js.context.handler = callback;
{% endprettify %}

In this case, you can explicitly dispose of the callback:

{% prettify dart %}
callback.dispose();  // Allow the callback function to be garbage collected.
{% endprettify %}

If a callback is invoked from JavaScript after it's been disposed of,
an exception is thrown
because the backing closure may have been garbage collected.


## Examples

The examples at http://dart-lang.github.com/js-interop/example/
use publicly available JavaScript APIs
from Dart via the js library.
The Dart version is usually a port of an existing JavaScript sample.
All examples linked below run natively in Dartium or in Chrome via dart2js.  Support for other browsers is still underway.

In general, the Dart ports of these JavaScript samples
look remarkably like the original JavaScript.
Lifetime management of proxies and callbacks
is the primary added complexity during porting,
but the additional code is relatively small.

The js library currently prints the number of live proxies
(along with the total number ever allocated)
each time the code exits a scope.

    Proxy status :
     Dart objects Live : 1 (out of 4 ever allocated).
     JS objects Live : 4 (out of 32 ever allocated).

To avoid memory leaks,
a well designed application should have
a small, relatively constant number of live proxies.


### Google Maps

The Google Maps sample uses both a directions API to communicate with the server and a maps API to render a map.

- [Original JavaScript sample](https://google-developers.appspot.com/maps/documentation/javascript/examples/directions-panel)
- [Dart version](http://dart-lang.github.com/js-interop/example/google-maps/directions.html)
- [Dart source](https://github.com/dart-lang/js-interop/blob/master/example/google-maps/directions.dart)


### Google Charts

This demonstrates simple usage of the Google Charts API BubbleCharts.

- [Original JavaScript sample](https://developers.google.com/chart/interactive/docs/gallery/bubblechart)
- [Dart version](http://dart-lang.github.com/js-interop/example/google-chart/bubblechart.html)
- [Dart code](https://github.com/dart-lang/js-interop/blob/master/example/google-chart/bubblechart.dart)


### Twitter

The Twitter example demonstrates simple usage of the Twitter search API via JSONP and the js library:

- [Dart version](http://dart-lang.github.com/js-interop/example/twitter/twitter.html)
- [Dart code](https://github.com/dart-lang/js-interop/blob/master/example/twitter/twitter.dart)


## For more information

You can find out more from the GitHub project and the generated API documentation:

- [dart-lang/js-interop project](https://github.com/dart-lang/js-interop)
- [js API documentation](http://dart-lang.github.com/js-interop/docs/js.html)
