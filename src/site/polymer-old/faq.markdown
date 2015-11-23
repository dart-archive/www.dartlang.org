---
layout: default
title: Frequently Asked Questions (FAQ)
short-title: FAQ
subsite: "Polymer.dart"
description: "FAQ and other tips for using polymer.dart."
has-permalinks: true
---

{% include breadcrumbs.html %}

# {{ page.title }}

This page answers common questions about polymer.dart.
Don't count on the headings or content remaining the same;
much of this will move out into formal documentation.

{% include default_toc.html %}


## The basics

### Q. What documentation exists for polymer.dart?

On www.dartlang.org:

* [Polymer.dart](/polymer-old/)
  * [Using Elements](/polymer-old/using-elements/)
  * [Building Single Page Apps using Polymer.dart](/polymer-old/spa/)
  * [Imports and Your App’s Directory Structure](/polymer-old/app-directories.html)
  * [Creating Elements](/polymer-old/creating-elements/)
  * [Upgrading to Polymer.dart from Web UI](/polymer-old/upgrading-to-polymer-from-web-ui.html)
  * [Reference](/polymer-old/reference/)
    * [Error Messages](/polymer-old/reference/error-messages/)
    * [Release Notes](/polymer-old/reference/release-notes/)

{% comment %}
{ TODO: autogenerate that list. Put it somewhere more visible.}
{% endcomment %}

On www.dartdocs.org, the API doc home for packages:

* [polymer API reference](http://www.dartdocs.org/documentation/polymer/latest/index.html#polymer/polymer)
* [core_elements API reference](http://www.dartdocs.org/documentation/core_elements/latest/)
* [paper_elements API reference](http://www.dartdocs.org/documentation/paper_elements/latest/)

On pub.dartlang.org:

* [polymer package](https://pub.dartlang.org/packages/polymer)
* [core_elements package](https://pub.dartlang.org/packages/core_elements)
* [paper_elements package](https://pub.dartlang.org/packages/paper_elements)


### Q. In which browsers can polymer.dart apps run?

Transformed, compiled polymer.dart code
is tested against IE10, IE11, Safari 6, latest Chrome,
latest Firefox, and latest Chrome for Android.
Polymer.dart apps run natively,
with no transformation or compilation needed,
in [Dartium](/tools/dartium/).

The Dart team collaborates with the Polymer team to
ensure that polymer.dart elements and polyfills
(code that implements features not yet built into a web browser)
are fully compatible with Polymer.

### Q. How do I change my Web UI app to use polymer.dart?

Polymer.dart is the next evolution of Web UI.
[Upgrading to Polymer.dart from Web UI](upgrading-to-polymer-from-web-ui.html)
provides a non-exhaustive set of tips to help you upgrade.


## Generating polymer.dart code

### Q. How do I generate a new element?

{% prettify sh %}
pub run polymer:new_element element-name [-o output_dir]
{% endprettify %}

Your current directory must be the top directory of a package that
has a `pubspec.yaml` file listing `polymer` as a dependency.

For example:

{% prettify sh %}
> cd my_polymer_app
> less pubspec.yaml
...
dependencies:
    polymer: ">=0.15.1 <0.17.0"
...
> pub run polymer:new_element knitting-chart -o lib
{% endprettify %}
{% comment %}
UPDATE version each release
{% endcomment %}


### Q. How do I generate a new entry point?

{% prettify sh %}
pub run polymer:new_entry path_to_entry_point
{% endprettify %}

Your current directory must be the top directory of a package that
has a `pubspec.yaml` file listing `polymer` as a dependency.

For example:

{% prettify sh %}
> cd my_polymer_app
> less pubspec.yaml
...
dependencies:
    polymer: ">=0.15.1 <0.17.0"
...
> pub run polymer:new_entry web/index.html
{% endprettify %}
{% comment %}
UPDATE version each release
{% endcomment %}

## Using polymer.dart from Dart code

### Q. How do I instantiate a Polymer element?

Use the `new Element.tag()` constructor.
For example, the following has the same effect as
`<paper-item></paper-item>`:

{% prettify dart %}
PaperItem item = new Element.tag('paper-item');
{% endprettify %}

If the element extends a native HTML element,
then you must use two arguments:
the HTML element name, and the custom element name.
For example, the following has the same effect as
`<button is="fancy-button"></button>`:

{% prettify dart %}
Element b = new Element.tag('button', 'fancy-button');
{% endprettify %}

Some custom elements expose a factory constructor that does this.
For example, the following works and is supported:

{% prettify dart %}
new PaperItem();
{% endprettify %}

However, the developer of the custom element had to provide that
constructor. If the constructor is not available, you'll get an
error. In that situation, you will need to use `new Element.tag` instead.

{% comment %}
PENDING: write test for this
{% endcomment %}

### Q. How do I initialize an app if I have a main() function?

Remove the following line:

{% prettify html %}
<script type="application/dart">export 'package:polymer/init.dart';</script>
{% endprettify %}

In its place, add a reference to the Dart file that
contains your `main()` function:

{% prettify html %}
<script type="application/dart" src="main.dart"></script>
{% endprettify %}

Inside that Dart file, import polymer.dart and call `initPolymer().run()`.
For example:

{% prettify dart %}
import 'package:polymer/polymer.dart';

main() {
  initPolymer().run(() {
    // Code here is in the polymer Zone, which ensures that
    // @observable properties work correctly.
    Polymer.onReady.then((_) {
      // Elements have been upgraded.
    });
  });
}
{% endprettify %}


## Differences between the JavaScript and Dart versions of Polymer

This section covers some of the differences.
You might find more in
[issue 936](https://github.com/dart-lang/www.dartlang.org/issues/936).

### Q. Where can I see JavaScript and Dart examples of the same Polymer app?

Try these:

* The core elements sampler
  * [JavaScript](https://github.com/Polymer/core-elements/blob/master/demo.html)
  * [Dart](https://github.com/dart-lang/core-elements/tree/master/example/demo.html)
* The paper elements sampler
  * [JavaScript](https://github.com/Polymer/paper-elements/blob/master/demo.html)
  * [Dart](https://github.com/dart-lang/paper-elements/blob/master/example/demo.html)
{% comment %}
* The [Polymer project tutorial](http://www.polymer-project.org/docs/start/tutorial/intro.html) app
  * [JavaScript](https://github.com/Polymer/polymer-tutorial/tree/master/finished)
  * [Dart](https://github.com/marycampione/polymer_paper_example)
{% endcomment %}

{% comment %}
The Dart apps use the `pub` tool to create `packages` usually follow
[pub package layout conventions](/tools/pub/package-layout.html),
which define standard directories such as
`example`, `lib`, and `web`.
{% endcomment %}


### Q. How do I declare a Polymer class?

In JavaScript
: Use `Polymer(...)`.

In Dart
: Annotate a class (usually a subclass of PolymerElement)
with `@CustomTag('name')`.


### Q. How do I create an attribute that corresponds to a field?

In JavaScript
: Use <code>attributes="<em>name</em>"</code> in HTML or, in JavaScript,
  put it in the `publish` object.

In Dart
: Annotate the field as `@published`.


### Q. What's the difference between one-way, two-way and one-time bindings?

* In a `one-way` binding, data is copied from an expression into HTML.
* In a `two-way` binding, an HTML attribute can update the value of
  an expression in code.
* In a `one-time` binding, any changes after the HTML is created are
  not reflected in the UI.
* In a `normal binding`, the UI is updated when changes to the 
  expression are detected.

{% comment %}
{PENDING: Either compare JS & Dart ways of doing things,
or move this to another section.}
{% endcomment %}


### Q. How do I make an expression show in the HTML?

Use bindings.

{% comment %}
{PENDING: Be more helpful, specific.
Either compare JS & Dart ways of doing things,
or move this to another section.}
{% endcomment %}

### Q. When the value of an expression changes, how can the UI reflect that?

In JavaScript
: It's completely automatic. All fields in JavaScript are automatically
  observed when they are used in binding expressions. Note, however, that
  binding expressions are not in the full JavaScript expression language.
  In fact, the binding expression language in Polymer.js is almost identical
  to the one in polymer.dart, except for the difference in
  [specifying multiple arguments to a filter](#q-how-do-i-specify-multiple-arguments-to-a-filter).

In Dart
: By marking some fields with the `@observable` annotation.
  All fields can be used in expressions of any kind (one-way, one-time,
  two-way). However, if they have no annotation, there are no automatic
  updates to the UI. The binding behaves as if it is a one-time binding
  even for normal bindings, although the value is set on the expression
  if it is used as a two-way binding. Adding the `@observable`
  annotation means that you get auto updates: the UI is updated with
  the latest value from the code whenever the code expression changes.

### Q. How do I move complex expressions out of HTML into my code?

In JavaScript
: Use the `computed` block.

In Dart
: Use `@ComputedProperty`.

### Q: How do I bind a property to an attribute?

Annotate the property with `@published`.

{% comment %}
{PENDING: Either compare JS & Dart ways of doing things,
or move this to another section.}
{% endcomment %}

### Q. How do I use a published property in CSS?

Annotate the property with `@PublishedProperty(reflect: true)`.

{% comment %}
{PENDING: Either compare JS & Dart ways of doing things,
or move this to another section.}
{% endcomment %}

### Q. How do I make an attribute that corresponds to a field that is visible to CSS and other DOM APIs?

In JavaScript
: Put it in the `publish` object and include the `reflect:true` value. 

In Dart
: Annotate the field as `@PublishedProperty(reflect: true)`.


### Q. How do I specify multiple arguments to a filter?

In JavaScript
:  {% prettify javascript %}
    a.b.c | d(2)
    d: function(x, y) { return x + y; }
    {% endprettify %}

In Dart
:  Polymer.dart filters can have only one argument,
   so implement the filter as a function that returns a closure over
   any additional argument.

  {% prettify dart %}
    a.b.c | d(2)
    d: (y) => (x) => x + y;
    {% endprettify %}

### Q. What's the difference between auto-binding and auto-binding-dart?

`auto-binding-dart` requires that you set a model programatically.
See the discussion in
[this code review](https://codereview.appspot.com/122590043/diff2/30001:50001/example/core_icon.html?context=10&column_width=80).

{% comment %}
{PENDING: Either compare JS & Dart ways of doing things,
or move this to another section.}
{% endcomment %}


## Source code

### Q. Where is the source code for polymer.dart?

The polymer.dart project is on GitHub under
[dart-lang/polymer-dart](https://github.com/dart-lang/polymer-dart).


### Q. Where is the source code for core and paper elements?

The Dart projects for the core and paper elements are on GitHub under
[dart-lang/core-elements](https://github.com/dart-lang/core-elements) and
[dart-lang/paper-elements](https://github.com/dart-lang/paper-elements).


## The technologies behind polymer.dart

### Q. Where can I learn about the original Polymer project?

* Read the documentation at [polymer-project.org](http://www.polymer-project.org/).
* Watch Matthew McNulty's [Introduction to Polymer](https://www.youtube.com/watch?v=8-Zq2KUN6jM)
  or the complete video of SFHTML5's
  [All About Polymer](http://www.meetup.com/sfhtml5/events/169452272/) event.

### Q. What articles discuss the web technologies behind Polymer?

* [HTML5Rocks - Shadow DOM 101](http://www.html5rocks.com/en/tutorials/webcomponents/shadowdom/)
* [HTML5Rocks - Shadow DOM 201: CSS and Styling](http://www.html5rocks.com/tutorials/webcomponents/shadowdom-201/)
* [HTML5Rocks - Shadow DOM 301: Advanced Concepts & DOM APIs](http://www.html5rocks.com/tutorials/webcomponents/shadowdom-301/)
* [HTML5Rocks - Custom Elements: Defining new elements in HTML](http://www.html5rocks.com/en/tutorials/webcomponents/customelements/)

### Q. Which web specifications is Polymer built upon?

Much of Polymer is built upon new and emerging web specifications.
Polymer offers polyfills for the following features.

Heads up: These are specs written for implementers. Lots of details ahead.

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
[custom-elements-spec]: https://dvcs.w3.org/hg/webcomponents/raw-file/tip/spec/custom/index.html
[shadow-dom-spec]: https://dvcs.w3.org/hg/webcomponents/raw-file/tip/spec/shadow/index.html
[html-imports-spec]: https://dvcs.w3.org/hg/webcomponents/raw-file/tip/spec/imports/index.html
[template-spec]: https://dvcs.w3.org/hg/webcomponents/raw-file/tip/spec/templates/index.html
