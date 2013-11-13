---
layout: default
title: "Define a Custom Element"
description: "Create a custom HTML element using Polymer."
has-permalinks: true
tutorial:
  id: polymer-intro
next: fetchdata
next-title: "Fetch Data Dynamically"
prev: shared-pkgs
prev-title: "Install Shared Packages"
---

{% capture whats_the_point %}

* Polymer.dart is the next evolution of Web UI.
* Everything in Polymer.dart is an element.
* Custom elements provide semantically meaningful encapsulation.
* Use Polymer.dart to build custom elements.
* Bind Dart data to HTML elements.
* Declaratively bind event handlers to elements.

{% endcapture %}

{% capture sample_links %}

<p> This tutorial features this example:</p>
* stopwatch

<p>
Don't have the source code?
<a href="https://github.com/dart-lang/dart-tutorials-samples/archive/master.zip">
  Download it.
</a>

{% endcapture %}

{% capture content %}

<div class="tute-target-title">
<h1>{{page.title}}</h1>
<h3>Create a custom HTML element using Polymer</h3>
</div>

A custom element is an HTML element you can define yourself,
encapsulating appearance and/or behavior
within semantically meaningful HTML.

<aside class="alert">
<strong>Version Note:</strong> The code sample and the content
of this tutorial are compatible with
<a href="https://pub.dartlang.org/packages/polymer#versions">polymer.dart 0.8.7</a>.
</aside>

<aside class="alert alert-info">
  Custom elements are one feature of
<a href="http://www.polymer-project.org/"
   target="_blank">Polymer</a>,
a new type of library for the web based on Web Components.
<a href="http://www.dartlang.org/polymer-dart/"
   target="_blank">Polymer.dart</a>
is the Dart implementation of Polymer.
(Note: Polymer supersedes Web UI.)
</aside>

* [An example](#an-example)
* [Installing Polymer.dart](#getting-polymer-dart) 
* [Including Polymer.dart in your application](#bootstrap)
* [Instantiating a custom element](#instantiating) 
* [Defining a custom element](#define-element) 
* [Providing a template for the custom element](#providing-a-template) 
* [Providing a script for the custom element](#providing-a-script) 
* [Overiding life-cycle methods](#life-cycle-methods)
* [Using data binding](#data-binding) 
* [Setting up event handlers declaratively](#event-handlers) 
* [Styling a custom element](#scoped-css)
* [Other resources](#other-resources)
* [What next?](#what-next)

##An example

In the example running below,
the LemonChiffon area outlined in black
is a custom element implemented using Polymer.

<strong>Try it!</strong>
Start and stop the stopwatch.
Reset the stopwatch to 00:00 using the **Reset** button.

<iframe class="running-app-frame"
        style="height:220px;width:230px;"
        src="examples/stopwatch/out/web/index.html">
</iframe>

To place this custom element on an HTML page,
import the file with the custom element definition
and use the name of the element as an HTML tag:

{% prettify html %}
<link rel="import" href="tute_stopwatch.html">
...
<tute-stopwatch></tute-stopwatch>
{% endprettify %}

The counting text, the three buttons along with their actions,
and the style are all contained within the custom element.
The definition of the custom element encapsulates and
hides the implementation details,
which as the user of the element, you care nothing about.

When you use developer tools to inspect the element,
you see just the custom element's begin and end tags.

<img class="scale-img-max" src="images/dev-tools-dom.png"
     alt="Custom element encapsulates its contents">

With custom elements, you can easily create new kinds of elements
that have semantically meaningful tags and that are easy to share,
reuse, and read.

###Overview of the example files

Three main source files implement the Stopwatch example:

<dl>
  <dt>
    index.html
  </dt>
  <dd>
    The primary HTML file for the app.
    Includes the Polymer bootstrap script and instantiates the custom element.
  </dd>
  <dt>
    tute_stopwatch.html
  </dt>
  <dd>
    The HTML code that defines the custom element.
  </dd>
  <dt>
    tute_stopwatch.dart
  </dt>
  <dd>
    The Dart class that implements the custom element.
  </dd>
</dl>

The following diagram shows the structure of the example
app and its use of custom elements.

<img class="scale-img-max" src="images/connections.png"
     alt="The connections between Dart and HTML">

##Installing Polymer.dart {#getting-polymer-dart}

To use the features provided by Polymer.dart,
you need to install the Polymer package.
If you are unfamiliar with installing packages,
refer to
<a href="/docs/tutorials/shared-pkgs/">Install Shared Packages</a>,
which describes the process in detail.

In brief, to install the Polymer package:

* In the application's `pubspec.yaml` file,
add the package to the list of dependencies
by adding the package name, `polymer`, to the list.
YAML is whitespace-sensitive,
so take care to indent the package name as shown:

  <img class="scale-img-max" src="images/sample-pubspec.png"
     alt="Sample pubspec file with polymer dependency">

* Run `pub install`,
which recursively installs the polymer.dart package
and all the packages that it depends on.
If you are using Dart Editor,
when you save pubspec.yaml
the editor automatically runs `pub install` for you.
If you are using command line tools,
you can run it with the command `pub install`.

##Including Polymer.dart in your application {#bootstrap}

To use Polymer.dart features such as custom elements,
you need to include Polymer in both
the HTML side and the Dart side of your app.

* In the primary HTML file for your app,
import `package:polymer/init.dart` within a &lt;script&gt; tag
in the &lt;head&gt; section.
This script contains the `main()` function
for the app and initializes Polymer.

  <img class="scale-img-max" src="images/init-script.png"
     alt="Include the Polymer init script">

* In the primary HTML file for your app,
include the `packages/browser/dart.js` bootstrap script
in the &lt;head&gt; section.

  <img class="scale-img-max" src="images/bootstrap-script.png"
     alt="Include the Polymer bootstrap script">

* In your Dart code, import the Polymer library:

  <img class="scale-img-max" src="images/polymer-library.png"
     alt="Import the Polymer library">

##Instantiating a custom element {#instantiating}

To create an instance of a custom element,
use the name of the custom element just as you would any normal HTML tag.
In this example, the tag name is `tute-stopwatch`.

<img class="scale-img-max" src="images/polymer-element-instantiation.png"
     alt="Instantiate a custom element with a custom tag">

Using best practices,
the custom element definition is in a separate file.
Use `link [rel="import"]` to import the HTML definition file as shown.

##Defining a custom element {#define-element} 

The definition for the &lt;tute-stopwatch&gt; element is
in tute_stopwatch.html.
A custom element definition should be in its own
source file so that it can be included by other files.
An HTML file that contains the definition for a custom element
does not need &lt;html&gt;, &lt;head&gt;, or &lt;body&gt; tags.

To define a custom element,
use the &lt;polymer-element&gt; tag and provide a name.

{% prettify html %}
<polymer-element name="tute-stopwatch">
  ...
</polymer-element>
{% endprettify %}

A custom element name must have at least one hyphen (`-`).
We advise using an identifiable prefix to 
avoid naming conflicts with elements shared by others
and to help identify the project from which the element originates.
For example, for tutorial custom elements, we use the prefix `tute`.

Within the &lt;polymer-element&gt; tag,
you can provide a template (appearance) and a script (behavior).
UI widgets, like our Stopwatch example,
typically have both a template and a script,
but neither is required.
A custom element with a script and no template is purely functional.
A custom element with a template and no script is purely visual.

{% prettify html %}
<polymer-element name="tute-stopwatch">
  <template>
    ...
  </template>
  <script type="application/dart" src="tute_stopwatch.dart">
  </script>
</polymer-element>
{% endprettify %}

<dl>
  <dt> &lt;template&gt; </dt>
  <dd>
    Describes the custom element's structure&mdash;its user interface.
    The template comprises any valid HTML code within the &lt;template&gt; tag.
    When the custom element is instantiated,
    the instance is created from the template.
    The template can include CSS styles within a &lt;style&gt; tag.
  </dd>

  <dt> &lt;script&gt; </dt>
  <dd markdown="1"> Specifies a Dart script.
    For custom elements, the Dart script is a Dart class
    that implements the behavior of the element.
    The class typically overrides some
    life-cycle methods and provides event handlers
    that join the UI with its programmatic behavior.
    In this example, the script is in tute_stopwatch.dart.
  </dd>
</dl>

##Providing a template for the custom element {#providing-a-template}

Here's the template code for the tute-stopwatch element:

<img class="scale-img-max" src="images/template-code.png"
     alt="The template code for the tute-stopwatch element">

The tute-stopwatch template uses a &lt;style&gt; tag, which is optional.
These styles are scoped; they affect only
the appearance of the custom element and the elements it contains.
More about scoped CSS in [Styling a custom element](#scoped-css).

The rest of the code within the &lt;template&gt; tag
is normal HTML, with two exceptions:

|---|---|
| `{``{``counter}}` | Uses a Polymer syntax to [bind Dart data](#data-binding) to the HTML page. The double curly braces are commonly known as a "double mustache". |
| `on-click` | Uses Polymer [declarative event mapping](#event-handlers), which allows you to set up event handlers for a UI element. `on-click` sets up an event handler for mouse clicks. Polymer has mappings for other event types, such as `on-input` for changes to text fields. |
{: .table}

Let's take a look at the structure of the Dart code
before we get into the details of data binding, event handlers,
and scoped CSS.

##Providing a script for the custom element {#providing-a-script}

On the Dart side, a class implements the behavior of the custom element.
You associate the Dart class with the custom element using the `@CustomTag`
annotation and the name of the custom element.

<img class="scale-img-max" src="images/polymer-element-definition.png"
     alt="Two parts to a custom element definition">

This diagram gives an overview of the TuteStopwatch class:

<img class="scale-img-max" src="images/dart-script-code.png"
     alt="The script code for the tute-stopwatch element">

Any Dart class that backs a Polymer element must subclass PolymerElement.

{% comment %}
[xx: more about PolymerElement]
{% endcomment %}

The class can respond to life-cycle milestones
by overriding [life-cycle methods](#life-cycle-methods).
For example, the TuteStopwatch class overrides the `enteredView()`
method&mdash;which is called when the element is inserted
into the DOM&mdash;to initialize the app.

The `start()` method is an event handler for the **Start** button.
The event handler is declaratively connected to the button.
Refer to [Setting up event handlers declaratively](#event-handlers) to see how.

##Overriding life-cycle methods {#life-cycle-methods}

A custom element has four life-cycle methods
that it can override:

|---|---|
| `created()` | Called when an instance of a custom element is created. |
| `enteredView()` | Called when an instance of a custom element is inserted into the DOM. |
| `leftView()` | Called when an instance of a custom element is removed from the DOM. |
| `attributeChanged()` | Called when an attribute, such as `class`, of an instance of the custom element is added, changed, or removed. |
{: .table}

You can override any of these life-cycle methods.
The overriding method
*must* call the super class method first.

The Stopwatch app overrides the `enteredView()` method because it
needs a reference to each of the three buttons
so that it can enable and disable them.
When a tute-stopwatch custom element is inserted into the DOM
the buttons have been created, so the references to them
will be available when the enteredView() method is called.

{% prettify dart %}
void enteredView() {
  super.enteredView();
  startButton = $['startButton'];
  stopButton = $['stopButton'];
  resetButton = $['resetButton'];
      
  stopButton.disabled = true;
  resetButton.disabled = true;
}
{% endprettify %}

The code uses _automatic node finding_, a Polymer feature,
to get a reference to each button.
Every node in a custom element that is tagged with an `id` attribute
can be referenced by its ID using the syntax: `$['ID']`.

##Using data binding {#data-binding}

In the HTML definition of a custom element,
use double curly brackets to embed Dart data into the webpage.
In your Dart code, use the `@observable` annotation
to mark the embedded data.
Here, the data is a string called `counter`.

<img class="scale-img-max" src="images/one-way-data-binding.png"
     alt="One-way data binding">

The tute-stopwatch element uses a periodic
<a href="https://api.dartlang.org/dart_async/Timer.html" target="_blank">Timer</a>
to fire an event every second.
When the Timer fires, it calls the `updateTimer()` method,
which modifies the `counter` string.
Polymer takes care of updating the HTML page with the new string.

This type of binding is called _one-way data binding_
because the data can change only on the Dart side.
Polymer also supports two-way data binding.
In two-way data binding, when data changes on the HTML side&mdash;for example
with an input element&mdash;the value in the Dart code changes to match.
For more information about two-way binding,
plus examples of using it with a variety of
HTML5 widgets, check out the Forms tutorial section
[Two-way data binding using Polymer](/docs/tutorials/forms/#binding-data).

You can use expressions within the double curly brackets.
<a href="http://pub.dartlang.org/packages/polymer_expressions"
   target="_blank">Polymer expressions</a>
provide the default syntax. Examples of allowable expressions include:

|---|---|
| `{``{``myObject.aProperty}}` | Property access. |
| `{``{``!empty}}` | Operators, like the logical not operator. |
| `{``{``myList[3]}}` | List indexing. |
| `{``{``myFilter()}}` | Data filtering. |
{: .table}

##Setting up event handlers declaratively {#event-handlers}

This example has three buttons, each
with an event handler that is written in Dart,
but attached to the button declaratively from HTML.

<img class="scale-img-max" src="images/click-handler.png"
     alt="Declaratively attach a click handler">

In HTML, use the `on-click` attribute
to attach a mouse click handler to an HTML element.
The value of the attribute must be the name of a method
in the class that implements the custom element.
When the user clicks the button, the specified method is called
with three parameters:

* An
<a href="https://api.dartlang.org/dart_html/Event.html" target="_blank">Event</a>
that contains information about the event,
such as its type and when it occurred.

* The _detail_ object can provide additional, event-specific information.

* The <a href="https://api.dartlang.org/dart_html/Node.html" target="_blank">Node</a>
that fired the event&mdash;the **Start** button in this case.

You can attach event handlers for other kinds of events.
For example, you can use `on-input` to handle events
for input text elements when the text changes.

Refer to
[Declarative event mapping](http://www.polymer-project.org/polymer.html#declarative-event-mapping)
for further details.

{% comment %}
##Querying the shadow root {#in-the-shadows}

The Shadow DOM is key to encapsulation.
The DOM subtree for a custom element is
hidden from outside of the custom element.

<img class="scale-img-max" src="images/shadow-dom.png"
     alt="Shadow DOM for tute-stopwatch custom element">

You can programmatically get items from the Shadow DOM
by querying a custom element's _shadow root_&mdash;a
special node from which an instance of a custom element is rendered.

{% prettify dart %}
startButton = getShadowRoot('tute-stopwatch').query('#startbutton');
stopButton = getShadowRoot('tute-stopwatch').query('#stopbutton');
resetButton = getShadowRoot('tute-stopwatch').query('#resetbutton');
{% endprettify %}

Call `getShadowRoot()` with the name of the custom element.
The `getShadowRoot()` method returns the shadow root element
for this instance of the specified element.
Use `query()` with a CSS selector to get the element(s) of interest.

Note that this code uses `query()` to get each button by ID.
By querying the shadow root object rather than the DOM,
you are guaranteed to get the objects from within the custom element,
not from anywhere else on the page.
{% endcomment %}

##Styling a custom element {#scoped-css} 

You can optionally include CSS styles for your custom element
that apply only to the contents of the custom element.

<img class="scale-img-max" src="images/css-styling.png"
     alt="Scoped CSS styling">

The `@host` rule allows you to target and style an element internally,
from within its definition.
The `:scope` pseudo-class refers to the custom element itself.
The only selectors that work within `@host` are those contained
in the host element itself.
So you don't need to worry about naming conflicts on the page.
Any CSS selectors within the template need to be unique only within the template.

For further details about styling custom elements,
refer to
[A Guide to Styling Elements](http://www.polymer-project.org/articles/styling-elements.html)

##Other resources

Use these other resources to learn more about Polymer:

* The
<a href="http://www.dartlang.org/polymer-dart/"
   target="_blank">Polymer.dart</a> homepage provides information
   specific to the Dart port of the Polymer project.

* The Polymer project website
<a href="http://www.polymer-project.org/"
   target="_blank">polymer-project.org</a>
   contains information about the Polymer project as a whole.

##What next?

[Two-way data binding with Polymer](/docs/tutorials/forms/#binding-data)
in the tutorial about forms shows how to use two-way data binding
with various types of input elements such as text fields, color pickers,
and so on.

Check out these other tutorial examples that use Polymer:

* its_all_about_you
* slambook
* count_down

The next tutorial,
[Fetch Data Dynamically](/docs/tutorials/fetchdata/),
shows you how to fetch data
and use JSON to encode and decode
that data.

{% endcapture %}

{% include tutorial.html %}
