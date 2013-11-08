---
layout: default
title: "Upgrading to Polymer.dart from Web UI"
description: "Learn tips for upgrading your Web UI app to Polymer.dart."
has-permalinks: true
---

# {{ page.title }}

Here is a non-exhaustive list of tips for developers upgrading from
Web UI to [polymer.dart](/polymer-dart/).

Do you have other tips for upgrading? Please send us a
[pull request](https://github.com/dart-lang/dartlang.org)
for this page, or email your tips to
[web-ui@dartlang.org](https://groups.google.com/a/dartlang.org/forum/#!forum/web-ui).
Thanks in advance!

### Getting Started

* We recommend creating a component for your "application" HTML page.
  Polymer believes that everything is a component.
  - This enables Polymer-style event binding, which only works inside a
    polymer-element's template.
  - This also sets up data binding to your component's fields, and turns on
    [Polymer Expressions](http://pub.dartlang.org/packages/polymer_expressions)
    in bindings.

* You can place `<template>` elements on the main HTML page, but they will *not*
  be bound to the main library's scope. Polymer.dart does not support binding
  to a library scope, but you can instantiate a template by setting the
  [model](http://api.dartlang.org/docs/releases/latest/dart_html/Element.html#model)
  to a Dart object.
  
  The template of a polymer element *will* be instantiate automatically with
  itself as the model, providing convenient access to its fields, exactly like
  Web UI.

* To create an app that works when compiled to JavaScript, you need to first
  build it. See the
  [deploy_to_javascript](https://github.com/sethladd/dart-polymer-dart-examples/tree/master/web/deploy_to_javascript)
  and its `build.dart` file. Notice the `--deploy` argument.

### Custom Elements

* Use `<polymer-element>` instead of `<element>`.

* The `extends` attribute on polymer-element is optional. If you use it,
  you should use the form of `<div is="my-element">`. If you omit the
  `extends` attribute, you are safe to use `<my-element>`.

  If you extend a DOM element, you must also extend that element type
  in your Dart class for the custom element.

* The `constructor` attribute on polymer-element is no longer used.

* If your custom element does not have a corresponding Dart class,
  put a `noscript` attribute on `<polymer-element>`.

* The Dart class for the custom element must _registered_.
  An easy way to register your class is to use the
  `@CustomTag('element-name')` annotation.
  Alternatively, you can register it manually by calling
  `registerPolymerElement`.

* You **must** call `super.created()` in your `created()` named constructor.
  It is recommended to call the super methods
  from `enteredView` and `leftView` as well, if you
  are inheriting from another custom element.

* Go through `shadowRoot` to find nodes inside of your custom element.
  If the node has an ID, you can use "automatic node finding" like
  this: `$['the-id']` (which returns the element).

* The `apply-author-styles` attribute (which used to be on the
  `<polymer-element>` tag)
  is now retrieved as a getter property on the class for the custom element.
  e.g.:

    class MyElement extends PolymerElement {
       bool get applyAuthorStyles => true;
       // ...
    }

* Declarative event handing only works inside of a custom element.
  Also, instead of `on-click="doFoo()"`, drop the parens and use
  {% raw %}'on-click="{{doFoo}}"'.{% endraw %}

* Hyphenated custom attributes are no longer supported. You can now
  write: `<foo-bar myPropertyName="{{expr}}">`.

### Data Binding

* Objects **must** be Observable to have changes detected. See the
  [observe](http://api.dartlang.org/docs/releases/latest/observe.html)
  library for more information.

* Data binding expressions are now
  [Polymer Expressions](http://pub.dartlang.org/packages/polymer_expressions)
  instead of Dart expressions. Polymer Expressions are a powerful data binding
  language which offers null safety and convenient filterting operations.

* Getters are no longer observable. Instead, use
  [onPropertyChange](http://api.dartlang.org/docs/releases/latest/observe.html#onPropertyChange) and
  [notifyProperty](http://api.dartlang.org/docs/releases/latest/observe.html#notifyProperty)
  in the `created` callback to let the system know that the computed getter has
  changed whenever its dependencies have changed. You can use other helpers from
  the observe library too, such as
  [PathObserver](http://api.dartlang.org/docs/releases/latest/observe/PathObserver.html)
  and [ListPathObserver](http://api.dartlang.org/docs/releases/latest/observe/ListPathObserver.html).

* The name of the modified
  [field](http://api.dartlang.org/docs/releases/latest/observe/PropertyChangeRecord.html#field)
  is now a Symbol instead of a String.

* Null is treated as false in `template if` expressions.
  Non-null and non-false values are treated as true.
  There are known issues with this, please track
  [issue 13044](https://code.google.com/p/dart/issues/detail?id=13044).

* The `iterate` attribute no longer exists on template, use `repeat` instead.

* Polymer.dart does not support the `instantiate` attribute on the template
  tag. To instantiate a template, simply bind a model to it, and ensure the
  template has a `bind` attribute.

  If you were using `instantiate` with a conditional, use `if`.

* All data binding expressions in Polymer.dart require `{{ }}`, including
  template `if` and `repeat`.
  - Old Web UI: `template instantiate="some boolean"`.
  - New Polymer.dart: `template if="{{some boolean}}"`.

* You no longer need `bind-` when binding to an input field. Instead, do this:
  `<input type="text" value="{{foo}}">`.

### Tips from the community

Matthew Butler shared some tips for upgrading from Web UI to Polymer.

* [Upgrading from Web UI to Polymer, part 1](http://blog.butlermatt.me/?p=13)
* [Upgrading from Web UI to Polymer, part 2](http://blog.butlermatt.me/?p=35)