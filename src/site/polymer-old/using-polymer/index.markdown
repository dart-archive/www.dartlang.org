---
layout: tutorial
title: "Use Polymer Elements"
description: "Use a Polymer element, such as a material design button or menu, in any Dart web app."
has-permalinks: true
tutorial:
  id: polymer/use-paper-elements
next: futures/
next-title: "Asynchronous Programming: Futures"
prev: shared-pkgs/
prev-title: "Install Shared Packages"
header:
  css: ["styles.css"]
---

{% capture whats_the_point %}

* Use Polymer elements in any Dart web app.
* Bind Dart data to Polymer elements using a custom container.

{% endcapture %}

{% capture sample_links %}

<p> This tutorial features the following examples:</p>
* simple_wrapper_element
* using_paper_elements

<p>
Don't have the source code?
<a href="https://github.com/dart-lang/dart-tutorials-samples/archive/master.zip">
  Download it.</a>
</a>

{% endcapture %}

{% capture content %}

<div class="tute-target-title">
<h1>{{page.title}}</h1>
<h3>Add custom elements to your web app.</h3>
</div>

Writing web apps is easier when you can use custom elements developed by others.
Custom elements can implement anything from buttons to containers to
authentication.
This tutorial shows you how to use Polymer elements,
featuring custom elements from the paper elements collection.

What are _custom elements_, _Polymer elements_, and _paper elements_?

A custom element, as defined by
[WebComponents.org](http://webcomponents.org/),
is an HTML element that
encapsulates appearance or behavior or both
within semantically meaningful HTML.
Custom elements are an important feature of Polymer,
a JavaScript library for creating Web Components.
The Dart implementation of Polymer is called
Polymer Dart, sometimes referred to as _polymer.dart_.

You can create your own custom Polymer element,
or you can use a ready-made element. Polymer provides
a basic set of components, called the
[paper elements collection](https://elements.polymer-project.org/browse?package=paper-elements)
that embody [material design](https://github.com/dart-lang/polymer-dart/wiki)
principles.

<aside class="alert alert-info" markdown="1">
**Version note:**
The code sample and the content of this tutorial are compatible with
[Polymer 1.0](https://pub.dartlang.org/packages/polymer#versions).
</aside>

* [Installing Polymer Dart](#getting-polymer-dart)
* [Using a Polymer element](#using-a-polymer-element)
* [Using data bindings](#using-data-bindings)
* [Naming conventions](#naming-conventions)
* [Other resources](#other-resources)
* [What next?](#what-next)

## Installing Polymer Dart {#getting-polymer-dart}

To use the features provided by Polymer Dart,
you need to install several dependencies.
If you are unfamiliar with installing packages, refer to
[Install Shared Packages](/docs/tutorials/shared-pkgs),
which describes the process in detail.

To install Polymer Dart:

<ol markdown="1">
  <li markdown="1">
In the application's `pubspec.yaml` file,
add the following packages to the list of dependencies:

{% prettify yaml %}
name: 'using_paper_elements'
description: A simple web app that uses paper elements.
dependencies:
  [[highlight]]polymer_elements: ^1.0.0-rc.1[[/highlight]]
  [[highlight]]polymer: ^1.0.0-rc.11[[/highlight]]
  [[highlight]]web_components: ^0.12.0[[/highlight]]
  [[highlight]]reflectable: ^0.3.3[[/highlight]]
  browser: ^0.10.0
{% endprettify %}

  </li>

  <li markdown="1">
Add the `polymer` transformer. This isn't absolutely
required if you are only _using_ a paper element, but
it will produce a more optimized version of the app.

{% prettify yaml %}
transformers:
[[highlight]]- polymer:[[/highlight]]
    [[highlight]]entry_points: web/index.html[[/highlight]]
{% endprettify %}

<aside class="alert alert-warning">
<b>Important:</b>
YAML is whitespace-sensitive,
so take care to indent the package name as shown.
</aside>

  </li>

  <li markdown="1">
Run `pub get` from the top of your application package
to recursively install these packages
and all the packages that they depend on.
  </li>

</ol>

## Using a Polymer element {#using-a-polymer-element}

The following code
shows how to include a paper button in your web app.

{% prettify dart %}
import [[highlight]]'dart:html';[[/highlight]]
import [[highlight]]'package:polymer_elements/paper_button.dart';[[/highlight]]
import [[highlight]]'package:polymer/polymer.dart';[[/highlight]]

main() async {
  [[highlight]]await initPolymer();[[/highlight]]

  [[highlight]]querySelector('paper-button').on['tap'].listen((_)[[/highlight]] {
    print('Button tapped!');
  });
}
{% endprettify %}
<div class="filename">index.dart</div>

{% prettify html %}
<html>
  <head>
    ...
    [[highlight]]<script defer src="packages/web_components/webcomponents-lite.js"></script>[[/highlight]]
    <script defer src="index.dart" type="application/dart"></script>
    <script defer src="packages/browser/dart.js"></script>
  </head>

  <body>
    ...
      [[highlight]]<paper-button raised>[[/highlight]]Click me[[highlight]]</paper-button>[[/highlight]]
    ...
  </body>
</html>
{% endprettify %}
<div class="filename">index.html</div>

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

To summarize, in the Dart code, you:

* Import `polymer:dart`.
* If you need to use APIs like `querySelector()`, import `dart:html`.
* Import the HTML file that has the element definition
  (`package:polymer_elements/paper_button.dart`).
* Initialize Polymer asynchronously (`await initPolymer()`).
  This should be the first line in your `main()` function.
* Use `querySelector()` to retrieve a handle to the element in the DOM.
  Register an event handler to listen for changes.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

The `on['tap'].listen` code registers a callback for the `tap` action.

<aside class="alert alert-info" markdown="1">
**Note:**
The `tap` event is recommended because it's
faster than the `click` event.
</aside>

In the HTML code, you:

* Include `<script>` tags for the JavaScript and Dart code.
* Use the name of the element as an HTML tag
  (`<paper-button>button text</paper-button>`).

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

---

**Try it!**
The demo running below, `using_paper_elements`,
uses four off-the-shelf paper elements:
a button, a checkbox, a text field, and a pulldown menu.
When the user interacts with any of these widgets,
a message is printed to the browser's console.

Bring up the console for your browser (on Chrome, use
**View > Developer > JavaScript Console**)
to view the messages as you interact with the widgets.

<iframe class="running-app-frame"
        style="height:250px; width:80%;"
        src="examples/using_paper_elements/web/index.html">
</iframe>

[View the complete source](https://github.com/dart-lang/dart-tutorials-samples/tree/master/polymer/using_paper_elements).

## Using data bindings

The previous example tracks changes to the UI by
calling `querySelector()` to get a handle to a DOM
element, and registering an event handler on that element.
But perhaps you would prefer tie the widgets in the UI to a data model
so that when one changes, the other automatically updates.
You can accomplish this using _bindings_.

Bindings can be either one way or two way:

* In a one-way binding, data is copied from an expression into the UI.
* In a two-way binding, data is copied from an expression into the UI.
  Additionally, when the value changes in the UI,
  the change is copied to the corresponding property in the Dart code.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

To define one-way binding between the model and the UI,
use "double mustache" syntax in the HTML code:

{% prettify html %}{% raw %}
{{expression}}
{% endraw %}{% endprettify %}

To learn how to make a two-way binding, see
[Property change notification and two-way binding](https://github.com/dart-lang/polymer-dart/wiki/data-binding-syntax#property-change-notification-and-two-way-binding).

To use bindings with a Polymer element, such as a paper element,
you must wrap that element in a custom Polymer element.
The [simple_wrapper_element](https://github.com/dart-lang/dart-tutorials-samples/tree/master/polymer/simple_wrapper_element)
example creates a custom Polymer element with two-way binding
on the `text` property.
The element's behavior is defined in the `reverseText()`
function&mdash;Polymer calls the Dart function to update the value in the UI.
The following shows the relevant code for the custom Polymer element
(`text-reverser`).

{% prettify html %}{% raw %}
<dom-module id="text-reverser">
  <template>
    ...
    <paper-input label="Type something..." [[highlight]]value="{{text}}"[[/highlight]]></paper-input>
    <p>
      Text: <span>[[highlight]]{{text}}[[/highlight]]</span><br />
      Reversed: <span>[[highlight]]{{reverseText(text)}}[[/highlight]]</span>
    </p>
  </template>
</dom-module>
{% endraw %}{% endprettify %}
<div class="filename">text-reverser.html</div>

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

{% prettify dart %}
@PolymerRegister('text-reverser')
class TextReverser extends PolymerElement {
  [[highlight]]@property[[/highlight]]
  [[highlight]]String text;[[/highlight]]
  TextReverser.created() : super.created();
  [[highlight]]@reflectable[[/highlight]]
  String [[highlight]]reverseText(String text)[[/highlight]] {
    return text.split('').reversed.join('');
  }
}
{% endprettify %}
<div class="filename">text-reverser.dart</div>

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

For more information, see
[Data Binding Syntax](https://github.com/dart-lang/polymer-dart/wiki/data-binding-syntax).

Another way to implement binding is by using _auto-binding templates_.
You create a specialized template, called a _template repeater_,
that binds to an array. An advantage to this approach is that the
app doesn't need the `reflectable` transformer. For more information, see
[Data Binding Helper Elements](https://github.com/dart-lang/polymer-dart/wiki/data-binding-helper-elements).

## Naming conventions

Sometimes a reference to a Polymer element uses a hyphen,
other times it uses an underscore,
and other times it uses a mix of upper and lower case letters.
What gives?

Polymer follows the naming conventions set by
[web components](http://webcomponents.org/):
a custom element's name must contain at least one hyphen
(`<text-reverser>`).

However, hyphens aren't allowed in Dart filenames or library names.
Underscores replace hyphens in these situations
(`text_reverser.html`, `text_reverser.dart`,
`simple_wrapper_element.lib.text_reverser`).

Finally, Dart classes names are
[UpperCamelCase](https://www.dartlang.org/articles/style-guide/#names),
by convention (`TextReverser`).

## Other resources

Use the following resources to learn more about Polymer:

* The
<a href="https://github.com/dart-lang/polymer-dart/wiki"
   target="_blank">1.0 Developer Guide</a>
   provides information specific to the Dart port of the Polymer project.

* The
<a href="https://github.com/dart-lang/polymer-dart/wiki/migration-guide"
   target="_blank">Migration Guide</a>
   has useful information if you have code from
   a beta version of Polymer Dart.

* The Polymer project website,
<a href="http://www.polymer-project.org/"
   target="_blank">polymer-project.org</a>,
   contains information about the Polymer project as a whole,
   including information on
   <a href="https://elements.polymer-project.org/browse?package=paper-elements"
      target="_blank">paper elements</a>.

* The
  [Add Elements to the DOM](/docs/tutorials/add-elements/)
  tutorial has more information on how to use `querySelector()`
  to access the DOM.

## Examples

Learn about creating custom Polymer elements  with the following examples:

<dl markdown="1">

<dt markdown="1">
[polymer_list](https://github.com/dart-lang/dart-tutorials-samples/tree/master/polymer/polymer_list)
</dt>
<dd markdown="1">
A custom Polymer element modifies the behavior of a standard list
item (`<li>`) element.
</dd>

<dt markdown="1">
[simple_wrapper_element](https://github.com/dart-lang/dart-tutorials-samples/tree/master/polymer/simple_wrapper_element)
</dt>
<dd markdown="1">
A custom Polymer element wraps a standard `paper_input` element
and binds the data model to the UI.
</dd>

<dt markdown="1">
[slambook](https://github.com/dart-lang/dart-tutorials-samples/tree/master/polymer/slambook)
</dt>
<dd markdown="1">
A client/server example customizes a form element (`<form>`)
and implements two-way data binding to bind the data model to the UI.
{% comment %}
  This example is used in the "forms" tutorial.
  This example is updated, but the tutorial is not yet updated,
  so I'm not going to mention that fact yet.
{% endcomment %}
</dd>

<dt markdown="1">
[stopwatch](https://github.com/dart-lang/dart-tutorials-samples/tree/master/polymer/stopwatch)
</dt>
<dd markdown="1">
A custom Polymer element overrides the `attached` and
`detached` lifecycle callback functions to implement a basic stopwatch.
</dd>

<dt markdown="1">
[TodoMVC](https://github.com/dart-lang/sample-todomvc-polymer/)
</dt>
<dd markdown="1">
A Polymer Dart implementation of a to-do list.
</dd>

</dl>

# What next?

The next tutorial,
[Asynchronous Programming: Futures](/docs/tutorials/futures/),
shows you how to write non-blocking code using Dart's async/await
mechanism, or using the Future API.

{% endcapture %}

{% include tutorial.html %}
