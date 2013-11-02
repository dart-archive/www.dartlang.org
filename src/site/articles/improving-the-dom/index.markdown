---
layout: article
title: "Improving the DOM"
rel:
  author: bob-nystrom
description: "Learn how Dart's HTML library improves the browser programming experience."
has-permalinks: true
article:
  written_on: 2011-10-01
  updated_on: 2013-03-10
  collection: libraries-and-apis
---

{% include toc.html %}

# {{ page.title }}

<em>Written by Bob Nystrom<br />
October 2011 (updated March 2013)</em>

One of the great opportunities a new language gives you is a chance to also
define a cleaner set of APIs for users. When it comes to coding in a browser,
that API is the DOM. The DOM API that JavaScripters suffer is creaking under the
weight of history and technological ballast such as XML.

## Simpler names

The simplest changes were just cleaning up some painful names.
`HTMLElement` is just `Element` and we've dropped
`HTML` from most of the type names when it makes sense. Instead of
`childNodes` and `elements` we have `nodes` and
`children`. `ownerDocument` is just `document`.
We've tried to optimize names so that the things you use the most are the most
terse.

When's the last time you use `XMLHttpRequest` to actually, you
know, request XML? We thought so. So we've renamed `XMLHttpRequest`
to `HttpRequest`.

We've also made the capitalization of names for DOM types more consistent.
All names containing acronyms with greater than two letters always use
camelCase for capitalization, like
`CssStyleSheet` (previously known as CSSStyleSheet).

## Better querying

One area where the DOM has a bunch of baggage is finding elements. Today's
DOM has a pile of methods for finding stuff.
All of this piled up before <a href="http://jquery.com/">jQuery</a> appeared
on a mountaintop to give us the revelation that <em>Thou Shalt Find Nodes By
Using CSS Selectors</em>. With the One True Way in hand, we've stripped it
down to just two (!) methods: `query()` and `queryAll()`.

<div class="row">
  <div class="span6">

{% prettify javascript %}
// Old:
getElementsById()
getElementsByTagName()
getElementsByName()
getElementsByClassName()
querySelector()
querySelectorAll()
document.links
document.images
document.forms
document.scripts
formElement.elements
selectElement.options
{% endprettify %}

  </div>

  <div class="span6">

{% prettify dart %}
// New:
query()
queryAll()
{% endprettify %}

  </div>
</div>

<div class="row">
  <div class="span6">

{% prettify javascript %}
// Old:
elem.getElementById('foo');
elem.getElementsByTagName('div');
elem.getElementsByName('foo');
elem.getElementsByClassName('foo');
elem.querySelector('.foo .bar');
elem.querySelectorAll('.foo .bar');
{% endprettify %}

  </div>
  <div class="span6">

<!--- BEGIN(element_query) -->{% prettify dart %}
// New:
elem.query('#foo');
elem.queryAll('div');
elem.queryAll('[name="foo"]');
elem.queryAll('.foo');
elem.query('.foo .bar');
elem.queryAll('.foo .bar');
{% endprettify %}<!--- END(element_query) -->

  </div>
</div>

## Real collections

In JavaScript, the DOM collection types are different from the built-in
Array type, which trips users up when methods they use on one aren't available
on the other. For Dart, we've cleaned that up. Methods like
`children`, `nodes`, and `queryAll()` return
_actual_
Dart [lists](http://api.dartlang.org/docs/releases/latest/dart_core/List.html),
[maps](http://api.dartlang.org/docs/releases/latest/dart_core/Map.html),
and [sets](http://api.dartlang.org/docs/releases/latest/dart_core/Set.html).

{% prettify dart %}
// From dart:html
List<Element> queryAll(String selector);

// On Element:
Map<String, String> attributes

List<Element> children

CssClassSet classes // CssClassSet implements Set<String>

Map<String, String> dataset

List<Node> nodes
{% endprettify %}

Building on top of Dart's collection types lets us get rid of a bunch of
special-case methods too. Instead of a bunch of methods on `Element`
for working with attributes, we just made `attributes` a map:

<div class="row">
  <div class="span6">

{% prettify javascript %}
// Old:
elem.hasAttribute('name');
elem.getAttribute('name')
elem.setAttribute('name', 'value');
elem.removeAttribute('name');
{% endprettify %}

  </div>

  <div class="span6">

<!--- BEGIN(element_attributes) -->{% prettify dart %}
// New:
elem.attributes.containsKey('name');
elem.attributes['name'];
elem.attributes['name'] = 'value';
elem.attributes.remove('name');
{% endprettify %}<!--- END(element_attributes) -->

  </div>
</div>

Likewise, by making `nodes` and `children`
full-featured collections, we can get rid of a bunch of methods on
`Element` and `Node`:

<div class="row">
  <div class="span6">

{% prettify javascript %}
// Old:
elem.hasChildNodes();
elem.firstChild();
elem.appendChild(child);
{% endprettify %}

  </div>

  <div class="span6">

<!--- BEGIN(element_nodes) -->{% prettify dart %}
// New:
elem.nodes.isEmpty;
elem.nodes[0];
elem.nodes.add(child);
{% endprettify %}<!--- END(element_nodes) -->

  </div>
</div>

## Constructors

In order to create new instances of DOM types, in traditional web programming
you're forced to go through
factory methods on the document.

Dart is a _class-based_ object-oriented language. We have constructors,
and we like constructors.

<div class="row">
  <div class="span6">

{% prettify javascript %}
// Old:
document.createElement('div');
{% endprettify %}

  </div>

  <div class="span6">

<!--- BEGIN(element_constructors) -->{% prettify dart %}
// New:
new DivElement();
new ButtonElement();
new InputElement(); 
new InputElement(type: 'checkbox');
new TableElement();
new StyleElement();
{% endprettify %}<!--- END(element_constructors) -->

  </div>
</div>

Most of the HTML elements have constructors. For example:

* `new ButtonElement()`
* `new InputElement()` or `new InputElement(type: 'checkbox')`
* `new TableElement()`
* `new StyleElement()`
* Many more

You can even construct an element, and its children,
from an HTML snippet. Here's an example:

<!--- BEGIN(element_table) -->{% prettify dart %}
TableElement table = new Element.html(
    '<table><tr><td>Hello <em>Dart!</em></table>');
{% endprettify %}<!--- END(element_table) -->

Dart's [named constructors](/docs/dart-up-and-running/contents/ch02.html#ch02-constructors-named)
make it easier to conjure up DOM objects in a
variety of ways.

## Events

Events are perhaps the biggest change, and I think the most useful one. We've
cleaned up how event handlers are bound. The DOM has two ways of working with
events. The old way is that you can bind a single handler by setting one of the
`on___` properties on the element directly. (For mysterious reasons, these are
named `allinlowercase` unlike the rest of the DOM.)

The more modern way is by using `addEventListener()` and
`removeEventListener()`. That safely allows multiple listeners
for the same event, which is great, but it's painfully verbose. You also
identify the event type by its string name, which is error-prone and doesn't
play nice with the type system.

**We've simplified things.** We killed all of the `on___` properties
on Element and then used the
[Stream API](http://api.dartlang.org/docs/releases/latest/dart_async/Stream.html)
for a unified event model. For each of the known
event types, there is a property on that class: `onClick`,
`onMouseDown`, etc. Each of those properties is a Stream object
that can register listeners and dispatch events.

Here's an example:

<div class="row">
  <div class="span6">

{% prettify javascript %}
// Old:
elem.addEventListener('click',
    (event) => print('click!'), false);

elem.removeEventListener(
    'click', listener);
{% endprettify %}

  </div>
  <div class="span6">

<!--- BEGIN(element_listen) -->{% prettify dart %}
// New:
var subscription = elem.onClick.listen(
    (event) => print('click!'));

subscription.cancel();
{% endprettify %}<!--- END(element_listen) -->

  </div>
</div>

If you know you're going to handle one-and-only-one event, you can
use `onEvent.first.then()`, which converts a Stream into a single event
that returns a Future.

<!--- BEGIN(handleMouseDown) -->{% prettify dart %}
void handleMouseDown(e) {
  // Gets the first mouse up event, then automatically unregisters!
  elem.onMouseUp.first.then((event) => doCoolStuff());
}
{% endprettify %}<!--- END(handleMouseDown) -->

On the off chance that you _do_ want to register a dynamically-named
event, or work with events generically, we also put a subscript operator on
[Events](http://api.dartlang.org/docs/releases/latest/dart_html/Events.html):

<div class="row">
  <div class="span6">

{% prettify javascript %}
// Old:
elem.addEventListener(
    'some' + 'name',
    (event) => print('dynamic!'),
    false);
{% endprettify %}

  </div>
  <div class="span6">

<!--- BEGIN(element_listen_dynamic) -->{% prettify dart %}
// New:
elem.on['dynamiceventname'].listen(
    (event) => print('dynamic!'));
{% endprettify %}<!--- END(element_listen_dynamic) -->

  </div>
</div>

Usage of the Stream API for events is not limited to Elements.
For example, Document has `onReadyStateChange`,
`onSelectionChange`, and more.

## No more vendor prefixes

Vendor prefixes have a mildly contentious history on the web. Originally
a way for browser vendors to experiment with features, over time some
vendor-prefixed properties became de-facto standards due to wide deployment and
misinterpretation by developers.

**Dart hides vendor prefixes!** No more explicit cross-browser code to enable
a feature across implementations. Dart's HTML library takes care of it for you.

Here's one example for `getUserMedia`:

<div class="row">
  <div class="span6">

{% prettify javascript %}
// Traditionally:
navigator.getMedia = ( navigator.getUserMedia ||
                       navigator.webkitGetUserMedia ||
                       navigator.mozGetUserMedia ||
                       navigator.msGetUserMedia);
{% endprettify %}

  </div>
  <div class="span6">

{% prettify dart %}
// With Dart:
window.navigator.getUserMedia(audio:true, video: true) ...
{% endprettify %}

  </div>
</div>

Here's `indexedDB`:

<div class="row">
  <div class="span6">

{% prettify javascript %}
window.indexedDB = window.indexedDB ||
                   window.mozIndexedDB ||
                   window.webkitIndexedDB ||
                   window.msIndexedDB;
{% endprettify %}

  </div>
  <div class="span6">

{% prettify dart %}
// With Dart:
window.indexedDB.open(...)
{% endprettify %}

  </div>
</div>

## Future-based APIs

Ah, callbacks. Sigh. Traditional web programming was littered with callback
functions as a way to write asynchronous programs. However, as apps scaled up in
complexity and number of lines of code, nested (sometimes, deeply nested)
callback functions created hard-to-read programs and hard-to-follow logic.
There's even an entire site called [Callback Hell](http://callbackhell.com/)
with mitigation strategies.

Dart introduced the Future class for encapsulated, object-oriented asynchronous
results. A Future represents a value that is computed and returned in the future
(in a future event loop iteration). With the Future class baked into the
platform, Dart's HTML libraries can remove the callbacks and instead return a
Future.

Compare and contrast `getUserMedia`'s traditional interface and
its new Future-based interface from Dart:

<div class="row">
  <div class="span6">

{% prettify javascript %}
// Traditionally:
navigator.getMedia = ( navigator.getUserMedia ||
                       navigator.webkitGetUserMedia ||
                       navigator.mozGetUserMedia ||
                       navigator.msGetUserMedia);

navigator.getMedia (
 
   // constraints
   {
      video: true,
      audio: true
   },
 
   // successCallback
   function(localMediaStream) {
      var video = document.querySelector('video');
      video.src = window.URL.createObjectURL(localMediaStream);
      video.onloadedmetadata = function(e) {
         // Do something with the video here.
      };
   },
 
   // errorCallback
   function(err) {
    console.log("The following error occured: " + err);
   }
 
);
{% endprettify %}

  </div>
  <div class="span6">

<!--- BEGIN(element_get_user_media) -->{% prettify dart %}
// With Dart:
window.navigator.getUserMedia(audio:true, video: true)
  .then((stream) {
    var video = new VideoElement()
      ..autoplay = true
      ..src = Url.createObjectUrl(stream)
      ..onLoadedMetadata.listen((e) => print(e));
    document.body.append(video);
  })
  .catchError(reportIssue);
{% endprettify %}<!--- END(element_get_user_media) -->

  </div>
</div>

Here is IndexedDB, all Future-ized:

<div class="row">
  <div class="span6">

{% prettify javascript %}
// Traditionally:
window.indexedDB = window.indexedDB ||
                   window.mozIndexedDB ||
                   window.webkitIndexedDB ||
                   window.msIndexedDB;

var request = window.indexedDB.open("MyTestDatabase");
request.onerror = function(event) {
  // Do something with request.errorCode!
};
request.onsuccess = function(event) {
  // Do something with request.result!
};
request.onupgradeneeded = function(event) { 
   // Update object stores and indices .... 
};

// on success...
db.transaction("customers")
  .objectStore("customers")
  .get("444-44-4444")
  .onsuccess = function(event) {
  alert("Name for SSN 444-44-4444 is " + event.target.result.name);
};
{% endprettify %}

  </div>
  <div class="span6">

<!--- BEGIN(element_indexdb) -->{% prettify dart %}
// With Dart:
window.indexedDB.open(dbName, version: version,
  onUpgradeNeeded: (e) {
    Database db = e.target.result;
    if (!db.objectStoreNames.contains(storeName)) {  
      db.createObjectStore(storeName);
    }
  })
  .then((db) {
    var txn = db.transaction("customers", "readwrite");
    var store = txn.objectStore("customers");
    return store.getObject("444-44-4444");
  })
  .then((obj) => displayObject(obj))
  .catchError((e) => reportError(e));
{% endprettify %}<!--- END(element_indexdb) -->

  </div>
</div>

Futures show up in many more places, especially where callbacks were
previously used.

## More granular libraries

The original DOM libraries all live in the same namespace. This means WebGL and
SVG have to share names with elements and events. This forced namespacing into
the class and function names. For example, all class names for SVG were prefixed
with, you guessed it, "SVG".

Dart supports real libraries, so it can take large sections of the DOM
interface and give it a proper namespace. This makes `dart:html` more
lightweight, too.

We started with `dart:svg`, which puts all the SVG classes together and removes
the SVG prefix from the class names. We didn't stop with SVG. Dedicated DOM
libraries include:

* `dart:indexed_db`
* `dart:web_audio`
* `dart:web_sql`
* `dart:svg`

We anticipate more libraries to be created over time.

## Cross-browser consistency in HTML APIs
{: #cross-browser-consistency}

When was the last time you had to write browser-specific variations of your
code so that your website would behave similarly on each browser?
Probably the last time you wrote code for the web!

Dart strives to provide consistency in behavior across browsers so that you
don't have to worry about these details. While this is still a work in
progress, you will probably find yourself worrying less about browser
specifics when using the Dart HTML libraries.

One such example is the `KeyboardEventController` class, which
provides better support for keyboard events on international keyboard
variants. Another example is `requestAnimationFrame()`, which
does the right thing even if the browser hasn't implemented the function.

## Cascaded DOM construction
{: #cascades}

Building DOM elements, complete with IDs, classes, event listeners, and more,
can lead to cumbersome and repetative blocks of code.

Some libraries, like jQuery, popularized _method chaining_ as a way to
simplify code. However, the API must be designed for chaining by returning
_this_ from every method, which is not always appropriate nor possible.

Luckily, Dart has _method cascades_, a language feature to help simplify
builder-type APIs like the DOM.

<div class="row">
  <div class="span6">

{% prettify dart %}
// Without cascades:
var button = new ButtonElement();
button.id = 'register';
button.classes.add('important');
button.text = 'Click to Register';
button.onClick.listen((e) => registerAccount());
{% endprettify %}

  </div>
  <div class="span6">

<!--- BEGIN(element_cascades) -->{% prettify dart %}
// With cascades:
var button = new ButtonElement()
  ..id = 'register'
  ..classes.add('important')
  ..text = 'Click to Register'
  ..onClick.listen((e) => registerAccount());
{% endprettify %}<!--- END(element_cascades) -->

  </div>
</div>


## Want to know more?
{: #know-more}

Check out the
[dart:html API docs](http://api.dartlang.org/docs/releases/latest/dart_html.html).

Speaking of browser programming, you might be interested in our
[Web UI](/articles/dart-web-components/)
libraries that build on Web Components and provide live, two-way data binding.
