---
layout: default
title: "Polymer.dart"
description: "Standards-based web components:
custom elements, templates,
and data binding for Dart web apps. A Dart port of Polymer."
has-permalinks: true
---

{% include toc.html %}

<h1>
  {{page.title}}
  <img src="images/polymer-logo.svg" alt="Polymer logo"
       style="vertical-align:baseline" height="35">
</h1>

Use polymer.dart—a Dart port of [Polymer](http://www.polymer-project.org)—to
build structured, encapsulated, client-side web apps with Dart and
web components.

![Paper sampler on desktop](images/iconbutton-big.png){: .thinborder}
![Paper sampler on mobile](images/iconbutton-small.png)

With polymer.dart, you can:

* Use Polymer custom elements.
* Design your own HTML tags to encapsulate style, structure, and behavior.
* Create live, two-way bindings between Dart objects and DOM nodes.
* Use emerging web standards—Custom Elements, HTML Imports, Shadow DOM,
  and more—today.

<aside class="alert alert-info" markdown="1">
**Note:**
The code samples on this page reflect **polymer.dart 0.12.0**.
For information about polymer.dart versions, see the Versions tab on the
[polymer.dart pub page](https://pub.dartlang.org/packages/polymer).
</aside>


<hr>
## Installing polymer.dart

Get polymer.dart from [pub](http://pub.dartlang.org),
the Dart package hosting service. Add the following to
your `pubspec.yaml` file:

{% prettify yaml %}
dependencies:
  polymer: ">=0.12.0 <0.13.0"
{% endprettify %}

Then, run `pub get` to download the package and link it into your app.


<hr>
## Installing custom elements

You can use `pub` to get many polymer.dart custom elements.

First, edit your `pubspec.yaml` file.
Add a dependency for each package containing the custom elements
you want to use:

<!-- from polymer-dart/get_element/pubspec.yaml -->
{% prettify yaml %}
name: my_app
description: An application that uses core and paper elements
dependencies:
  polymer: ">=0.12.0 <0.13.0"
  [[highlight]]core_elements: ">=0.1.0 <0.2.0"[[/highlight]]
  [[highlight]]paper_elements: ">=0.1.0 <0.2.0"[[/highlight]]
{% endprettify %}

Next, run `pub get`.

<aside class="alert alert-info" markdown="1">
**Note:**
The [core_elements package](http://pub.dartlang.org/packages/core_elements)
provides Dart wrappers around the Polymer project's
[core elements](http://www.polymer-project.org/docs/elements/core-elements.html),
which are general-purpose UI and non-UI elements.
The [paper_elements package](http://pub.dartlang.org/packages/paper_elements)
wraps the project's
[paper elements](http://www.polymer-project.org/docs/elements/material.html)—elements that
adhere to Google's _material design_ guidelines.
**The core and paper elements are early access and still changing**.
</aside>


<hr>
## Using custom elements

To put a polymer.dart custom element into a web page,
the HTML file for the web page needs to:

* Include `platform.js` and `dart_support.js` near the top of the file,
  before any HTML imports
* Import the HTML file that defines the custom element
* Instantiate the element
* Initialize Polymer

Here's an example of using a `<paper-input>` element
from the paper_elements package:

<!-- from polymer-dart/get_element/web/index.html -->
{% prettify html %}
<!-- In an HTML file -->
<head>
  ...
  <script src="packages/web_components/platform.js"></script>
  <script src="packages/web_components/dart_support.js"></script>
  <link rel="import" href="[[highlight]]packages/paper_elements/paper_input.html[[/highlight]]">
  ...
</head>
<body unresolved>
  [[highlight]]<paper-input label="Type something..."></paper-input>[[/highlight]]
  ...
  <script type="application/dart">export 'package:polymer/init.dart';</script>
</body>
{% endprettify %}

<aside class="alert alert-info" markdown="1">
**Note:**
The `unresolved` attribute in the `<body>` tag
ensures that no Polymer custom elements display
before Polymer is ready.
</aside>

Some custom elements extend native HTML elements.
Instead of using a custom tag,
you instantiate one of these elements by adding an `is` attribute
to the native element.
For example, the fancy_button package
defines an element that extends the HTML `<button>` element.
To instantiate a fancy button,
instead of using `<fancy_button>`
you use this code:

{% prettify html %}
<button [[highlight]]is="fancy-button"[[/highlight]]>Click me</button>
{% endprettify %}

<hr>
## Creating custom elements

Along with the following code, check out the Dart tutorial
[Define a Custom Element](/docs/tutorials/polymer-intro/).
It shows you how to define, implement, and instantiate
a custom element.


### Define custom elements

Extend the lexicon of HTML with your own custom elements.

This sample shows a simple custom element. More advanced custom elements
can contain their own styles, custom behavior, attributes,
data binding, and more.

In each custom element, import `polymer.html` before the
&lt;polymer-element&gt; tag.

{% prettify html %}{% raw %}
<!-- hello_world.html -->
<link rel="import" href="../packages/polymer/polymer.html">
<polymer-element name="[[highlight]]hello-world[[/highlight]]" noscript>
  <template>
    <p>Hello from inside a custom element!</p>
  </template>
</polymer-element>
{% endraw %}{% endprettify %}


### Data binding

Synchronize DOM nodes and object models using live, two-way data binding.

In this sample, the `count` field of `ClickCounterElement` is
bound to the `{% raw %}{{count}}{% endraw %}` placeholder in the custom
element's `<template>`. When the `count` field changes, the text also
changes.

{% prettify html %}{% raw %}
<polymer-element name="click-counter">
  <template>
    <button on-click="{{increment}}">Click Me</button>
    <p>You clicked the button [[highlight]]{{count}}[[/highlight]] times.</p>
  </template>
  <script type="application/dart" src="click_counter.dart"></script>
</polymer-element>
{% endraw %}{% endprettify %}

{% prettify dart %}
import 'package:polymer/polymer.dart';
import 'dart:html';

@CustomTag('click-counter')
class ClickCounterElement extends PolymerElement {
  [[highlight]]@observable int count[[/highlight]] = 0;

  ClickCounterElement.created() : super.created();

  void increment(Event e, var detail, Node target) {
    count += 1;
  }
}
{% endprettify %}


### Custom attributes

Use attributes to configure the custom element.

In this sample, you can set the `volume` field of `VolumeNobElement`
using the custom `volume` attribute.
As in the previous example, the `volume` field
is also bound to a placeholder (`{% raw %}{{volume}}{% endraw %}`)
in the custom element's template.

{% prettify html %}{% raw %}
<polymer-element name="volume-nob">
  <template>
    <p>You turned the volume to {{volume}}.</p>
  </template>
  <script type="application/dart" src="volume_nob.dart"></script>
</polymer-element>
{% endraw %}{% endprettify %}

{% prettify dart %}
import 'package:polymer/polymer.dart';
import 'dart:html';

@CustomTag('volume-nob')
class VolumeNobElement extends PolymerElement {
  // @published means 'this is an attribute', and it is observable.
  [[highlight]]@published int volume[[/highlight]] = 0;

  VolumeNobElement.created() : super.created();
}
{% endprettify %}

Crank the volume like this:

{% prettify html %}
<volume-nob volume="11"></volume-nob>
{% endprettify %}


### Template conditionals

Control the UI with declarative conditionals in templates.

Template conditionals are part of the data binding infrastructure. If
`count` changes, the templates are automatically re-evaluated.

{% prettify html %}{% raw %}
<polymer-element name="click-counter">
  <template>
    <button on-click="{{increment}}">Click Me</button>
    <template [[highlight]]if="{{count <= 0}}"[[/highlight]]>
      <p>Click the button. It's fun!</p>
    </template>
    <template [[highlight]]if="{{count > 0}}"[[/highlight]]>
      <p>You clicked the button {{count}} times.</p>
    </template>
  </template>
  <script type="application/dart" src="click_counter.dart"></script>
</polymer-element>
{% endraw %}{% endprettify %}

{% prettify dart %}
import 'package:polymer/polymer.dart';
import 'dart:html';

@CustomTag('click-counter')
class ClickCounterElement extends PolymerElement {
  @observable int count = 0;

  ClickCounterElement.created() : super.created();

  void increment(Event e, var detail, Node target) {
    count += 1;
  }
}
{% endprettify %}


### Template loops

Loop through a collection, instantiating a template for every item in the
collection.

Template loops are part of the data binding infrastructure. If an item is
added or removed from `fruits`, the contents of `<ul>` are automatically
updated.

{% prettify html %}{% raw %}
<polymer-element name="fav-fruits">
  <template>
    <ul>
      <template [[highlight]]repeat="{{fruit in fruits}}"[[/highlight]]>
        <li>
          I like {{ fruit }}.
        </li>
      </template>
    </ul>
  </template>
  <script type="application/dart" src="fav_fruits.dart"></script>
</polymer-element>
{% endraw %}{% endprettify %}

{% prettify dart %}
import 'package:polymer/polymer.dart';

@CustomTag('fav-fruits')
class FavFruitsElement extends PolymerElement {
  final List [[highlight]]fruits = toObservable[[/highlight]](['apples', 'pears', 'bananas']);

  FavFruitsElement.created() : super.created();
}
{% endprettify %}

### Extending DOM elements

Subclass real DOM elements.

{% prettify html %}{% raw %}
<polymer-element name="fancy-button" [[highlight]]extends="button"[[/highlight]]>
  <template>
    <style>
    :host {
      background: pink;
    }
    </style>
    <content></content>
  </template>
  <script type="application/dart" src="fancy_button.dart"></script>
</polymer-element>
{% endraw %}{% endprettify %}

{% prettify dart %}{% raw %}
import 'package:polymer/polymer.dart';
import 'dart:html' show ButtonElement;

@CustomTag('fancy-button')
class FancyButton [[highlight]]extends ButtonElement with Polymer, Observable[[/highlight]] {
  FancyButton.created() : super.created() {
    polymerCreated();
  }
}
{% endraw %}{% endprettify %}

{% prettify html %}{% raw %}
<button [[highlight]]is="fancy-button"[[/highlight]]>Click me</button>
{% endraw %}{% endprettify %}


### More sample code

You can find lots of
[sample code for polymer.dart](https://github.com/dart-lang/dart-samples/tree/master/polymer_mini_samples/web).

{% comment %}
We used to point to https://github.com/sethladd/dart-polymer-dart-examples.
If we update that, point to it again.
Learn how to
[bind to a checkbox](https://github.com/sethladd/dart-polymer-dart-examples/tree/master/web/bind_to_checkbox),
[nest templates](https://github.com/sethladd/dart-polymer-dart-examples/tree/master/web/nested_if_inside_repeat),
[call a method on a custom element](https://github.com/sethladd/dart-polymer-dart-examples/tree/master/web/call_method_on_custom_element),
and much more. Please [let us know](https://github.com/sethladd/dart-polymer-dart-examples/issues?state=open) if you have a request for a sample.
{% endcomment %}

<hr>


## Tools

### Generating warnings

Polymer.dart offers a linter that reports syntax or usage warnings.
The linter can be connected to Dart Editor to display warnings directly
at the source.

Create a `build.dart` file at the root of your project:

{% prettify dart %}
import 'package:polymer/builder.dart';

void main(List<String> args) {
  lint(entryPoints: ['web/index.html'], options: parseOptions(args));
}
{% endprettify %}

Dart Editor runs `build.dart` after a file is saved, and
displays warnings from the linter.

<img src="polymer-warning-in-editor.png">

### Building

Use `pub build` to compile your polymer.dart app into JavaScript so that
it can run across the modern web. The build process also concatenates files
for faster loading.

First, add the polymer.dart _transformer_ to your `pubspec.yaml`. The
`transformers` section should go at the end of the file, after the
dependencies.

{% prettify yaml %}
transformers:
- polymer:
    entry_points: web/index.html
{% endprettify %}

Then, run `pub build` from the root of your project to generate a `build`
directory.

{% prettify bash %}
> pub build
{% endprettify %}

The `build` directory contains the HTML, JavaScript, and other assets
required to run the application. You can then deploy the `build` directory
to your favorite web server.

Learn more about [pub build](http://pub.dartlang.org/doc/pub-build.html).

<hr>

## Upgrading from Web UI

Polymer.dart is the next evolution of Web UI.

[Upgrading to polymer.dart from Web UI](upgrading-to-polymer-from-web-ui.html)
provides a non-exhaustive set of tips to help you upgrade.

<hr>

## Compatibility

Polymer.dart is tested against IE10, IE11, Safari 6, latest Chrome,
latest Firefox, and latest Chrome for Android.

The Dart team collaborates with the Polymer team to
ensure that polymer.dart elements and polyfills
(code that implements features not yet built into a web browser)
are fully compatible with Polymer.

<hr>

## Support

We actively encourage your feedback and questions.

* Ask your [how-to questions][so] on StackOverflow
* Join the [general discussion about polymer.dart][web-list] on our mailing
  list
* Send [feedback on the web components family of specifications][polymer-dev-list]
  to the polymer-dev mailing list
  (Not Dart specific.)
* Please file [bugs and feature requests][dartbug] for polymer.dart

<hr>

## Source code

Polymer.dart is open source. You can view the source to polymer.dart,
and its many component packages, at [dart.googlecode.com/](https://code.google.com/p/dart/source/browse/branches/bleeding_edge/dart/pkg/).
[Get the source](https://code.google.com/p/dart/wiki/GettingTheSource)
to inspect the code and contribute patches.


<hr>

## Tutorials

The [Dart tutorials](/docs/tutorials/) use polymer.dart:

[Define a Custom Element](/docs/tutorials/polymer-intro/)
: Provides a detailed introduction to using polymer.dart
  to create custom elements.

[Other examples](/docs/tutorials/polymer-intro/#what-next)
: Lists other tutorials with examples that use Polymer.

<hr>

## Additional reading

The cultured Dartisan studies the specifications and articles that cover
the lower-level primitives and features of the polymer.dart libraries.

### Polymer

* Read the documentation at [polymer-project.org](http://www.polymer-project.org/).
* Watch Matthew McNulty's [Introduction to Polymer](https://www.youtube.com/watch?v=8-Zq2KUN6jM)
  or the complete video of SFHTML5's
  [All About Polymer](http://www.meetup.com/sfhtml5/events/169452272/) event.

### Articles

* [HTML5Rocks - Shadow DOM 101](http://www.html5rocks.com/en/tutorials/webcomponents/shadowdom/)
* [HTML5Rocks - Shadow DOM 201: CSS and Styling](http://www.html5rocks.com/tutorials/webcomponents/shadowdom-201/)
* [HTML5Rocks - Shadow DOM 301: Advanced Concepts & DOM APIs](http://www.html5rocks.com/tutorials/webcomponents/shadowdom-301/)
* [HTML5Rocks - Custom Elements: Defining new elements in HTML](http://www.html5rocks.com/en/tutorials/webcomponents/customelements/)

### Specifications

Much of polymer.dart is built upon new and emerging web specifications.
Polymer.dart offers polyfills for the following features.

Heads up: These are specs written for implementors. Lots of details ahead.

[Custom elements][custom-elements-spec]
: A method for enabling the author to define and use new types of DOM elements.

[Shadow DOM][shadow-dom-spec]
: An encapsulation primitive for DOM subtrees. It provides a method of
establishing and maintaining functional boundaries between DOM trees and how
these trees interact with each other within a document, thus enabling better
functional encapsulation within the DOM.

[Template element][template-spec]
: A method for declaring inert DOM subtrees in HTML and manipulating them
to instantiate document fragments with identical contents.

[HTML Imports][html-imports-spec]
: A way to include and reuse HTML documents in other HTML documents.


[polymer]: http://www.polymer-project.org
[so]: http://stackoverflow.com/tags/dart
[web-list]: https://groups.google.com/a/dartlang.org/forum/#!forum/web
[polymer-dev-list]: https://groups.google.com/forum/?fromgroups=#!forum/polymer-dev
[dartbug]: http://dartbug.com/new
[custom-elements-spec]: https://dvcs.w3.org/hg/webcomponents/raw-file/tip/spec/custom/index.html
[shadow-dom-spec]: https://dvcs.w3.org/hg/webcomponents/raw-file/tip/spec/shadow/index.html
[html-imports-spec]: https://dvcs.w3.org/hg/webcomponents/raw-file/tip/spec/imports/index.html
[template-spec]: https://dvcs.w3.org/hg/webcomponents/raw-file/tip/spec/templates/index.html
