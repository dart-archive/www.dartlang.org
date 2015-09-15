---
layout: default
title: "Using Elements"
subsite: "Polymer.dart"
description: "How to use Polymer elements"
has-permalinks: true
---

{% include toc.html %}
{% include breadcrumbs.html %}

# {{ page.title }}

To use a Polymer element,
you first install the element's package.
Then your code can import the element and use it.


## Installing custom elements

You can use `pub` to get many polymer.dart custom elements.
First, edit your app's `pubspec.yaml` file.
Add a dependency for each custom element package
you want to use:

<!-- from polymer/get_element/pubspec.yaml -->
{% prettify yaml %}
name: my_app
description: An application that uses core and paper elements
dependencies:
  polymer: ">=0.15.1 <0.17.0"
  [[highlight]]core_elements: ">=0.6.0 <0.7.0"[[/highlight]]
  [[highlight]]paper_elements: ">=0.6.0 <0.7.0"[[/highlight]]
transformers:
- polymer
{% endprettify %}
{% comment %}
UPDATE version #s for polymer (and core and paper, if need be) each release
{% endcomment %}

Next, run `pub get`.

<aside class="alert alert-info" markdown="1">
**Note:**
The [core_elements package](https://pub.dartlang.org/packages/core_elements)
provides Dart wrappers around the Polymer project's
[core elements](http://www.polymer-project.org/docs/elements/core-elements.html),
which are general-purpose UI and non-UI elements.
The [paper_elements package](https://pub.dartlang.org/packages/paper_elements)
wraps the project's
[paper elements](http://www.polymer-project.org/docs/elements/material.html)—elements that
adhere to Google's _material design_ guidelines.
**The core and paper elements are early access and still changing**.
</aside>

## Using custom elements in HTML code

To put a polymer.dart custom element into a web page,
the HTML file for the web page needs to:

* **Import the HTML file that defines the custom element.**
  <br>
  For help with import paths, see
  [Imports and Your App's Directory Structure](/polymer-old/app-directories.html).
* **Instantiate the element.**
* **Initialize Polymer.**

<aside class="alert alert-info" markdown="1">
**Note:**
Before version 0.15.1 of polymer.dart, your page needed to explicitly include
`dart_support.js`. That is no longer true.
</aside>

Here's an example of using a `<paper-input>` element
from the paper_elements package:

<!-- from polymer/get_element/web/index.html -->
{% prettify html %}
<!-- In an HTML file -->
<head>
  ...
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

### Special case: Elements that extend native HTML elements

Some custom elements extend native HTML elements.
Instead of using a custom tag,
you instantiate one of these elements by adding an `is` attribute
to the native element.
For example, say the `fancy-button` element
extends the HTML `<button>` element.
To instantiate a fancy button,
instead of using `<fancy-button>`
you use this code:

{% prettify html %}
<button [[highlight]]is="fancy-button"[[/highlight]]>Click me</button>
{% endprettify %}

## Instantiating custom elements in Dart code 

To programmatically create a custom element,
you can use dart:html's `new Element.tag()` constructor.
For example, the following has the same effect as
`<paper-item></paper-item>`:

{% prettify dart %}
import 'dart:html';
...
PaperItem item = new Element.tag('paper-item');
{% endprettify %}

Some libraries provide no-argument constructors that call
`new Element.tag()` for you.
For example,
you can instantiate core and paper elements using code like this:

{% prettify dart %}
PaperItem item = new PaperItem();
{% endprettify %}

{% comment %}
TODO: Write test code for programmatically creating elements.
{% endcomment %}

Even if you always create a custom element programmatically,
you still need to register the element type
by importing it into an HTML file:
{% comment %}
You might eventually be able to register it in code only,
perhaps using Polymer.register()
(for example, `Polymer.register('paper-item', PaperItem)`).
{% endcomment %}

{% prettify html %}
<!-- In an HTML file -->
<link rel="import" href="packages/paper_elements/paper_input.html">
{% endprettify %}


### Special case: Elements that extend native HTML elements

When an element extends a native HTML element,
you must provide two arguments to `Element.tag()`:
the HTML element name, and the custom element name.
For example, the following has the same effect as
`<button is="fancy-button"></button>`:

{% prettify dart %}
import 'dart:html';
...
Element b = new Element.tag('button', 'fancy-button');
{% endprettify %}


## Using your own main() function

If you need to provide a `main()` function, you can.
However, because an HTML file can refer to only one Dart file,
your Dart file must replace the `init.dart` file and
contain code that initializes Polymer.

To swap in your Dart file, remove this line:

{% prettify html %}
<script type="application/dart">export 'package:polymer/init.dart';</script>
{% endprettify %}

Replace it with something like this:

{% prettify html %}
<script type="application/dart" src="main.dart"></script>
{% endprettify %}

Initialize Polymer in your Dart file's `main()` function,
using code like this:

{% prettify dart %}
import 'package:polymer/polymer.dart';

main() {
  initPolymer().run(() {
    // The rest of the code in the main method.
  });
}
{% endprettify %}

If you need to execute some code once Polymer has been completely initialized,
use `Polymer.onReady`, like this:

{% prettify dart %}
import 'package:polymer/polymer.dart';

main() {
  initPolymer().run(() {
    // Code that doesn't need to wait.
    Polymer.onReady.then((_) {
      // Code that executes after elements have been upgraded.
    });
  });
}
{% endprettify %}

{% comment %}
PENDING: Talk about the Polymer Zone,
and how everything within run executes within that zone.
{% endcomment %}


{% comment %}
## Passing values in attributes

Often custom elements allow you to set values using HTML attributes.
Attribute values are string values {PENDING: say more about types, conversion,...}.

Here's an example of specifying... 
{PENDING: something}.

{% prettify dart %}
{PENDING: code goes here}.
{% endprettify %}

Sometimes you need to pass more complicated values into a custom element,
such as objects or arrays.
Ultimately, it’s up to the element author to decide how to
decode values passed in as attributes,
but many Polymer elements understand attribute values that
are a JSON-serialized object or array.
For example:

{% prettify dart %}
<roster-list persons='[{"name": "John"}, {"name": "Bob"}]'></roster-list>
{% endprettify %}

You can find the expected type for each attribute listed in the
[Elements reference](http://www.polymer-project.org/docs/elements/).
If you pass the wrong type, it may be decoded incorrectly.

## WSOD

{% endcomment %}

## Examples of using elements

You can find sample code in the
[polymer-dart-patterns project](https://github.com/dart-lang/polymer-dart-patterns),
including examples of
[using core elements](https://github.com/dart-lang/polymer-dart-patterns/tree/master/web/core_elements).

{% comment %}

{PENDING: put examples here; where should we talk about the two main app structures - 
everything in a custom element, and the opposite}

{PENDING: Link to polymer docs for CSS stuff (e.g. shim-shadowdom):
https://www.polymer-project.org/docs/polymer/styling.html}
{% endcomment %}
