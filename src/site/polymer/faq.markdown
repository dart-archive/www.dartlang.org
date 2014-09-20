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


## Generating polymer code with pub run

### Q. How do I generate a new polymer element?

{% prettify lang-sh %}
pub run polymer:new_element element-name [-o output_dir]
{% endprettify %}

Your current directory must be the top directory of a package that
has a `pubspec.yaml` file listing `polymer` as a dependency.

For example:

{% prettify lang-sh %}
> cd my_polymer_app
> less pubspec.yaml
...
dependencies:
    polymer: ">=0.14.0 <0.15.0"
...
> pub run polymer:new_element knitting-chart -o lib
{% endprettify %}


### Q. How do I generate a new polymer entry point?

{% prettify lang-sh %}
pub run polymer:new_entry path_to_entry_point
{% endprettify %}

Your current directory must be the top directory of a package that
has a `pubspec.yaml` file listing `polymer` as a dependency.

For example:

{% prettify lang-sh %}
> cd my_polymer_app
> less pubspec.yaml
...
dependencies:
    polymer: ">=0.14.0 <0.15.0"
...
> pub run polymer:new_entry web/index.html
{% endprettify %}

## Using polymer.dart from Dart code

### Q. How do I instantiate a polymer element?

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

Inside that Dart file, import polymer and call `initPolymer().run()`.
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


## Differences between the JavaScript and Dart versions of polymer

This section covers some of the differences.
You might find more in
[issue 936](https://github.com/dart-lang/www.dartlang.org/issues/936).

### Q. Where can I see JavaScript and Dart examples of the same polymer app?

Try these:

* The core elements sampler
  * [JavaScript](https://github.com/Polymer/core-elements/blob/master/demo.html)
  * [Dart](https://github.com/dart-lang/core-elements/tree/master/example/demo.html)
* The paper elements sampler
  * [JavaScript](https://github.com/Polymer/paper-elements/blob/master/demo.html)
  * [Dart](https://github.com/dart-lang/paper-elements/blob/master/example/demo.html)
{% comment %}
* The [polymer project tutorial](http://www.polymer-project.org/docs/start/tutorial/intro.html) app
  * [JavaScript](https://github.com/Polymer/polymer-tutorial/tree/master/finished)
  * [Dart](https://github.com/marycampione/polymer_paper_example)
{% endcomment %}

{% comment %}
The Dart apps use the `pub` tool to create `packages` usually follow
[pub package layout conventions](/tools/pub/package-layout.html),
which define standard directories such as
`example`, `lib`, and `web`.
{% endcomment %}


### Q. How do you declare a polymer class?

In JavaScript
: Use `Polymer(...)`.

In Dart
: Annotate a class (usually a subclass of PolymerElement)
with `@CustomTag('name')`.


### Q. How do you create an attribute that corresponds to a field?

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

### Q. How do you make an expression show in the HTML?

Use bindings.

### Q. When the value of an expression changes, how do you reflect that in the UI?

In JavaScript
: It's completely automatic. All fields in JavaScript are automatically
  observed when they are used in binding expressions. Note, however, that
  binding expressions are not in the full JavaScript expression language.
  In fact, the binding expression language in Polymer.js is almost identical
  to the one in polymer.dart, except for the difference in
  [specifying multiple arguments to a filter](#q-how-do-you-specify-multiple-arguments-to-a-filter).

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

### Q. How do I use a published property in CSS?

Annotate the property with `@PublishedProperty(reflect: true)`.


### Q. How do you make an attribute that corresponds to a field that is visible to CSS and other DOM APIs?

In JavaScript
: Put it in the `publish` object and include the `reflect:true` value. 

In Dart
: Annotate the field as `@PublishedProperty(reflect: true)`.


### Q. How do you specify multiple arguments to a filter?

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
[PENDING: show the JS equivalent, like the previous answers.]
{% endcomment %}


## Source code

### Q. Where is the source code for polymer.dart?

It's currently in the
[Dart project](https://code.google.com/p/dart/) under
[pkg/polymer](https://code.google.com/p/dart/source/browse/#svn%2Fbranches%2Fbleeding_edge%2Fdart%2Fpkg%2Fpolymer).
We plan to move it into its own github repo soon.


### Q. Where is the source code for core and paper elements?

The Dart projects for the core and paper elements are on GitHub under
[dart-lang/core-elements](https://github.com/dart-lang/core-elements) and
[dart-lang/paper-elements](https://github.com/dart-lang/paper-elements).
