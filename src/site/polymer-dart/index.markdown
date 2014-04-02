---
layout: default
title: "Polymer.dart"
description: "Standards-based web components:
custom elements, templates,
and data binding for Dart web apps. A Dart port of Polymer."
has-permalinks: true
---

<style>

.features h2 {
  color: gray;
}

.features i {
  font-size: 5em;
}

ol {
  margin-left: 11px;
}

hr {
  margin: 44px 0;
}

.jumbotron h1 {
  margin-bottom: 22px;
}

</style>

<div class="jumbotron">
      <h1> {{page.title}} </h1>
      <p>
        Build structured, encapsulated, client-side web apps with Dart and
        web components.<br>
        <em>A Dart port of
        <a href="http://www.polymer-project.org">Polymer</a>.</em>
      </p>
</div>

<div markdown="1">

<div class="col-md-4" markdown="1">

<div class="bs-sidebar hidden-print" data-spy="affix"
    data-offset-top="310" data-offset-bottom="350" role="complementary"
    markdown="1">

1. ToC
{:toc .toc .nav .bs-sidenav}

</div>

</div>

<div class="col-md-8" markdown="1">

## Features

Polymer.dart is a port of _Polymer Foundation_
and _Polymer Core_.

<div class="row features">

<div class="col-md-4 text-center">

<i class="fa fa-code"> </i>

<h2 class="no-permalink">Custom tags</h2>

Design your own HTML tags to encapsulate
style, structure, and behavior.

</div>

<div class="col-md-4 text-center">

<i class="fa fa-exchange"> </i>

<h2 class="no-permalink">Data binding</h2>

Create live, two-way bindings between Dart objects and DOM nodes.

</div>

<div class="col-md-4 text-center">

<i class="fa fa-check"> </i>

<h2 class="no-permalink">Standards</h2>

Use emerging web standards, today.

</div>

</div>

<hr>

## Examples

Along with this code, check out the Dart tutorial
[Define a Custom Element](/docs/tutorials/polymer-intro/).
It shows you how to define, implement, and instantiate
a custom element.

### Custom elements

Extend the lexicon of HTML with your own custom elements.

This sample shows a simple custom element. More advanced custom elements
can contain their own styles, custom behavior, attributes,
data binding, and more.

This HTML code defines a custom element:

{% prettify html %}{% raw %}
<!-- hello_world.html -->
<polymer-element name="[[highlight]]hello-world[[/highlight]]" noscript>
  <template>
    <p>Hello from inside a custom element!<p>
  </template>
</polymer-element>
{% endraw %}{% endprettify %}

This HTML code _uses_ the custom element:

{% prettify html %}
<head>
  <link rel="import" href="[[highlight]]hello_world.html[[/highlight]]">
  <script type="application/dart">export 'package:polymer/init.dart';</script>
  <script src="packages/browser/dart.js"></script>
</head>

<body>
  [[highlight]]<hello-world></hello-world>[[/highlight]]
</body>
{% endprettify %}


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

In this sample, the `count` field of `ClickCounterElement` is
bound to the `{% raw %}{{count}}{% endraw %}` placeholder in the custom
element's `<template>`. When the `count` field changes, the text also
changes.

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
    .fancy {
      color: pink;
    }
    </style>
    <span class="fancy"><content></content></span>
  </template>
  <script type="application/dart" src="fancy_button.dart"></script>
</polymer-element>
{% endraw %}{% endprettify %}

{% prettify dart %}{% raw %}
import 'package:polymer/polymer.dart';
import 'dart:html';

@CustomTag('fancy-button')
class FancyButton [[highlight]]extends ButtonElement with Polymer, Observable[[/highlight]] {
  FancyButton.created() : super.created() {
    polymerCreated();
  }
}
{% endraw %}{% endprettify %}

{% prettify html %}{% raw %}
<button [[highlight]]is="fancy-button"[[/highlight]]></button>
{% endraw %}{% endprettify %}

### Packaging

Reuse and share custom elements with
[pub](https://www.dartlang.org/docs/dart-up-and-running/contents/ch04-tools-pub.html),
the Dart package manager.

{% prettify bash %}{% raw %}
> pub get fancy_button
{% endraw %}{% endprettify %}

{% prettify html %}{% raw %}
<head>
  <link [[highlight]]rel="import"[[/highlight]]
    href="packages/fancy_button/fancy_button.html">
</head>
<body>
  <button [[highlight]]is="fancy-button"[[/highlight]]>Click me!</button>
</body>
{% endraw %}{% endprettify %}


### More sample code

You can find lots and lots of snippets and
[sample code for polymer.dart](https://github.com/sethladd/dart-polymer-dart-examples).
Learn how to
[bind to a checkbox](https://github.com/sethladd/dart-polymer-dart-examples/tree/master/web/bind_to_checkbox),
[nest templates](https://github.com/sethladd/dart-polymer-dart-examples/tree/master/web/nested_if_inside_repeat),
[call a method on a custom element](https://github.com/sethladd/dart-polymer-dart-examples/tree/master/web/call_method_on_custom_element),
and much more. Please [let us know](https://github.com/sethladd/dart-polymer-dart-examples/issues?state=open) if you have a request for a sample.

<hr>

## Installation

Get polymer.dart from [pub](http://pub.dartlang.org),
the Dart package hosting service. Add the following to
your `pubspec.yaml` file:

    dependencies:
      polymer: any

Then, run `pub get` to download the package and link it into your app.

View the [polymer.dart pub page](http://pub.dartlang.org/packages/polymer)
to learn more.

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

Polymer.dart is tested against IE9, IE10, Safari 6, latest Chrome,
latest Firefox, and latest Chrome for Android.

The Dart team collaborates with the Polymer team to
ensure that polymer.dart elements and polyfills
(code that implements features not yet built into a web browser)
are fully compatible with Polymer.

<hr>

## Support

We actively encourage your feedback and questions.

* Ask your [how-to questions][so] on StackOverflow
* Join the [general discussion about polymer.dart][web-ui-list] on our mailing
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

## Status

Polymer.dart is a work in progress, just like Polymer.

### Web UI parity

Web UI is the precursor to polymer.dart. We believe Polymer.dart
is at feature-parity with Web UI.

### Polymer parity

One of our goals is to make all of Polymer available
to Dart developers.

| Feature | Parity with Polymer
|--
| Custom Elements | Tracking
| Shadow DOM | Tracking
| Observers | Tracking
| Node.bind() | Tracking
| Template Binding | Tracking
| HTML imports | Tracking
| Polymer Expressions | Tracking
| [Polymer Core](https://github.com/Polymer/polymer) | Tracking
| Pointer events | Not started
| Web animations | Not started
| [Polymer base elements](https://github.com/Polymer/polymer-elements) | [Community effort](https://github.com/ErikGrimes/polymer_elements)
| [Polymer UI elements](https://github.com/Polymer/polymer-ui-elements) | [Community effort](https://github.com/ErikGrimes/polymer_ui_elements)
{: .table}

<hr>

## Tutorials

[Define a Custom Element](/docs/tutorials/polymer-intro/),
part of the
[Dart tutorials](/docs/tutorials/),
provides a detailed introduction to using Polymer.dart to create
custom elements.
You can also check out the other
[examples](/docs/tutorials/polymer-intro/#what-next)
in the tutorials that use Polymer.

<hr>

## Additional reading

The cultured Dartisan studies the specifications and articles that cover
the lower-level primitives and features of the polymer.dart libraries.

### Polymer

* Read Polymer's [guiding principles](http://www.polymer-project.org/#guiding-principles)
* Watch the [Hello, Polymer!](http://www.youtube.com/watch?v=irGDN5Ysi_A)
  video featuring some of the lead members of Polymer.

### Articles

* [HTML5Rocks - Shadow DOM 101](http://www.html5rocks.com/en/tutorials/webcomponents/shadowdom/)
* [HTML5Rocks - Shadow DOM 201: CSS and Styling](http://www.html5rocks.com/tutorials/webcomponents/shadowdom-201/)
* [HTML5Rocks - Shadow DOM 301: Advanced Concepts & DOM APIs](http://www.html5rocks.com/tutorials/webcomponents/shadowdom-301/)
* [Custom elements - defining new elements in HTML](http://www.html5rocks.com/en/tutorials/webcomponents/customelements/)

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


</div>

</div>

[polymer]: http://www.polymer-project.org
[so]: http://stackoverflow.com/tags/dart
[web-ui-list]: https://groups.google.com/a/dartlang.org/forum/#!forum/web-ui
[polymer-dev-list]: https://groups.google.com/forum/?fromgroups=#!forum/polymer-dev
[dartbug]: http://dartbug.com/new
[custom-elements-spec]: https://dvcs.w3.org/hg/webcomponents/raw-file/tip/spec/custom/index.html
[shadow-dom-spec]: https://dvcs.w3.org/hg/webcomponents/raw-file/tip/spec/shadow/index.html
[html-imports-spec]: https://dvcs.w3.org/hg/webcomponents/raw-file/tip/spec/imports/index.html
[template-spec]: https://dvcs.w3.org/hg/webcomponents/raw-file/tip/spec/templates/index.html
