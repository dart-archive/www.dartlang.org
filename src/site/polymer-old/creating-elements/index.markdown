---
layout: default
title: "Creating Elements"
subsite: "Polymer.dart"
description: "How to create your own custom polymer.dart elements"
has-permalinks: true
---

{% include toc.html %}
{% include breadcrumbs.html %}

# {{ page.title }}

To create a polymer.dart custom element,
you use three flavors of code:

* HTML, to define the element tag and contents
* Dart (optional), to define the element's behavior
* CSS (optional), to define the element's appearance

## A simple custom element

You can write an HTML element with just a bit of HTML code.

<!-- hello_world.html -->
{% prettify html %}
<link rel="import" href="../packages/polymer/polymer.html">
<polymer-element name="hello-world" noscript>
  <template>
    <p>Hello from inside a custom element!</p>
  </template>
</polymer-element>
{% endprettify %}

Each custom element must
import `polymer.html` before the `<polymer-element>` tag.


## Data binding

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


## Custom attributes

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


## Template conditionals

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


## Template loops

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

## Extending DOM elements

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


## More sample code

You can find more sample code in the
[polymer-dart-patterns project](https://github.com/dart-lang/polymer-dart-patterns).

{% comment %}
We used to point to https://github.com/sethladd/dart-polymer-dart-examples
and then to https://github.com/dart-lang/dart-samples/tree/master/polymer_mini_samples/web, but they're obsolete.
{% endcomment %}
