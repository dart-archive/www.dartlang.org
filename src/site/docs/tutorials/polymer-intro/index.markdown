---
layout: tutorial
title: "Define a Custom Element"
description: "Create a custom HTML element using Polymer."
has-permalinks: true
tutorial:
  id: polymer-intro
next: futures/
next-title: "Use Future-Based APIs"
prev: shared-pkgs/
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
<a href="https://pub.dartlang.org/packages/polymer#versions">polymer.dart 0.12.</a>.
</aside>

<aside class="alert alert-info">
  Custom elements are one feature of
<a href="http://www.polymer-project.org/"
   target="_blank">Polymer</a>,
a new type of library for the web based on Web Components.
<a href="http://www.dartlang.org/polymer-dart/"
   target="_blank">Polymer.dart</a>
is the Dart implementation of Polymer.
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
* [Deploying an app that uses Polymer](#deploying-an-app-that-uses-polymer)
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
        src="examples/stopwatch/web/index.html">
</iframe>

Here's how to use this custom element in an HTML page:

* Include the `packages/web_components/platform.js` script.
* Include the `packages/web_components/dart_support.js` script.
* Import the HTML file that has the custom element definition
  (`tute_stopwatch.html`).
* Use the name of the element as an HTML tag
  (`<tute-stopwatch>`).
* Initialize Polymer, which you can do using Polymer's
  `init.dart` file.

For example:

{% prettify html %}
<script src="packages/web_components/platform.js"></script>
<script src="packages/web_components/dart_support.js"></script>
<link rel="import" href="tute_stopwatch.html">
...
<tute-stopwatch></tute-stopwatch>

<script type="application/dart">export 'package:polymer/init.dart';</script>
{% endprettify %}

The counting text, the three buttons along with their actions,
and the style are all contained within the custom element.
The definition of the custom element encapsulates and
hides the implementation details,
which as the user of the element, you care nothing about.

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
    It imports script files for Polymer, and the HTML file for the
    custom element. It instantiates the custom element.
  </dd>
  <dt>
    tute_stopwatch.html
  </dt>
  <dd>
    The HTML code that defines the custom element.
    It imports the HTML file for Polymer.
  </dd>
  <dt>
    tute_stopwatch.dart
  </dt>
  <dd>
    The Dart class that implements the custom element.
  </dd>
</dl>

The following diagram shows the structure of the example
app and its use of custom elements:

* <span style="background: rgb(235, 205, 255);">
  Include the platform polyfills</span>
* <span style="background: rgb(254, 237, 156);">
  Import Polymer</span>
* <span style="background: rgb(190, 249, 221);">
  Import custom element definition</span>
* <span style="background: rgb(190, 215, 255);">
  Define, implement, and instantiate custom element by name</span>
* <span style="background: rgb(235,220,201);">
  Initialize Polymer</span>
* <span style="background: rgb(254, 193, 231);">
  Associate Dart class with custom element definition</span>

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

<ul markdown="1"> 
  <li markdown="1">
In the application's `pubspec.yaml` file,
add the package to the list of dependencies
by adding the package name, `polymer`, to the list.

  <pre>
name: stopwatch
description: A sample application
dependencies:
  <b>polymer: "&gt;=0.12.0 &lt;0.13.0"</b>
  </pre>
  </li>

<aside class="alert alert-warning">
<b>Important:</b>
YAML is whitespace-sensitive,
so take care to indent the package name as shown.
</aside>

  <li markdown="1">
Run `pub get`,
which recursively installs the polymer.dart package
and all the packages that it depends on.
If you are using Dart Editor,
when you save pubspec.yaml
the editor automatically runs `pub get` for you.
If you are using command-line tools,
you can use the command `pub get`.
  </li>
</ul>

##Including Polymer.dart in your application {#bootstrap}

To use Polymer.dart features such as custom elements,
you need to include Polymer in both
the HTML side and the Dart side of your app.

<aside class="alert alert-warning">
<b>Important:</b>
Unlike other Dart web apps,
Polymer apps have no <tty>main()</tty> function
and do not use <tty>packages/browser/dart.js</tty>.
</aside>

* In the HTML file for each custom element,
  import `packages/polymer/polymer.html`
  at the top of the file, before any &lt;polymer-element&gt; tag:

  <pre>
...
<b>&lt;link rel="import" href="packages/polymer/polymer.html"></b>
&lt;polymer-element name="tute-stopwatch">
...
  </pre>

* In your Dart code, import the Polymer library:

  <pre>
import 'dart:html';
import 'dart:async';
<b>import 'package:polymer/polymer.dart';</b>
...
  </pre>

* In the primary HTML file, include the `packages/web_components/platform.js`
  and `packages/web_components/dart_support.js` scripts at the top of the
  &lt;head&gt; tag, before any HTML imports:

  <pre>
&lt;head&gt;
  ...
  <b>&lt;script src="packages/web_components/platform.js">&lt;/script>
  &lt;script src="packages/web_components/dart_support.js">&lt;/script></b>
  ...
&lt;/head&gt;
  </pre>

##Instantiating a custom element {#instantiating}

For most custom elements, you create an instance
using the name of the custom element,
just as you would any normal HTML tag.
In this example, the tag name is `tute-stopwatch`.

<img class="scale-img-max" src="images/polymer-instance-create.png"
     alt="Instantiate a custom element with a custom tag">

Using best practices,
the custom element definition is in a separate file.
Use `link [rel="import"]` to import the HTML definition file as shown.

Instantiating a <em>type extension custom element</em>—a
custom element that inherits from a native element—is slightly different.
For this kind of custom element,
you use the native element name—for example, `li`—and
then add an `is` attribute that specifies the custom element name.
For example, here's how you instantiate a my-li element
that extends the <li> element:

<!-- Code is from polymer_list/web/index.html -->
<pre>
<b>&lt;li is="my-li"></b> Item #2 (custom list item) <b>&lt;/li></b>
</pre>

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
  <script type="application/dart" src="tute_stopwatch.dart"></script>
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
    The script type for custom elements must be
    "application/dart".
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
| `{``{`<em><code>expression</code></em>`}}` | Uses a Polymer syntax to [bind Dart data](#data-binding) to the HTML page. The double curly braces are commonly known as a "double mustache". |
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

Classes that back Polymer elements are usually subclasses of PolymerElement,
but they don't have to be.
They can extend any other HtmlElement subclass,
but they must follow a couple of rules:

* Implement
  <a href="https://api.dartlang.org/apidocs/channels/stable/dartdoc-viewer/polymer/polymer.Polymer">Polymer</a> and
  <a href="https://api.dartlang.org/observe/observe.Observable">Observable</a>.
  The easiest approach is to use Polymer and Observable as mixins.
* Provide a constructor named
  <code><em>CustomElement</em>.created()</code>
  that invokes `super.created()` and
  (if using Polymer as a mixin) `polymerCreated()`.

As an example, here's the code for a custom subclass of
[LIElement](https://api.dartlang.org/apidocs/channels/stable/dartdoc-viewer/dart-dom-html.LIElement):

{% prettify dart %}
@CustomTag('my-li')
class MyListElement extends LIElement with Polymer, Observable {  
  MyListElement.created() : super.created() {
    polymerCreated();
  }
}
{% endprettify %}

{% comment %}
[xx: more about PolymerElement]
{% endcomment %}

##Overriding life-cycle methods {#life-cycle-methods}

Your custom element's backing class can respond to life-cycle milestones
by overriding [life-cycle methods](#life-cycle-methods).
For example, the TuteStopwatch class overrides the `attached()`
method&mdash;which is called when the element is inserted
into the DOM&mdash;to initialize the app.

The `start()` method is an event handler for the **Start** button.
The event handler is declaratively connected to the button.
Refer to [Setting up event handlers declaratively](#event-handlers) to see how.


A custom element has a constructor and three life-cycle methods
that it can override:

|---|---|
| <code><em>CustomElement</em>.created()</code> | The constructor used when creating an instance of a custom element. |
| `attached()` | Called when an instance of a custom element is inserted into the DOM. (Previously named `enteredView`.) |
| `detached()` | Called when an instance of a custom element is removed from the DOM. (Previously named `leftView`.) |
| `attributeChanged()` | Called when an attribute, such as `class`, of an instance of the custom element is added, changed, or removed. |
{: .table}

You can implement the constructor,
if necessary,
and override any of the life-cycle methods.
The constructor or overriding method
*must* call the superclass constructor or method first.

The Stopwatch app overrides the `attached()` method because it
needs a reference to each of the three buttons
so that it can enable and disable them.
When a tute-stopwatch custom element is inserted into the DOM
the buttons have been created, so the references to them
will be available when the attached() method is called.

{% prettify dart %}
void attached() {
  super.attached();
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
{: .table}

{% comment %}
Add back the filter row when the syntax has settled down.
| `{``{``myFilter()}}` | Data filtering. |

Here's a relevant discussion:
https://groups.google.com/a/dartlang.org/forum/#!msg/web/W23NZoLjb7U/1331Id4vl7EJ
{% endcomment %}

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
startButton = getShadowRoot('tute-stopwatch').querySelector('#startbutton');
stopButton = getShadowRoot('tute-stopwatch').querySelector('#stopbutton');
resetButton = getShadowRoot('tute-stopwatch').querySelector('#resetbutton');
{% endprettify %}

Call `getShadowRoot()` with the name of the custom element.
The `getShadowRoot()` method returns the shadow root element
for this instance of the specified element.
Use `querySelector()` with a CSS selector to get the element(s) of interest.

Note that this code uses `querySelector()` to get each button by ID.
By querying the shadow root object rather than the DOM,
you are guaranteed to get the objects from within the custom element,
not from anywhere else on the page.
{% endcomment %}

##Styling a custom element {#scoped-css} 

You can optionally include CSS styles for your custom element
that apply only to the contents of the custom element.

<img class="scale-img-max" src="images/css-styling.png"
     alt="Scoped CSS styling">

`:host` refers to the custom element itself and has the lowest specificity.
This allows users to override your styling from the outside.
You can style elements within the custom element using
the appropriate selectors for those elements.
You don't need to worry about naming conflicts on the page.
Any CSS selectors used within the &lt;style&gt; section
apply only to those elements within the template.

For further details about styling custom elements,
refer to
[A Guide to Styling Elements](http://www.polymer-project.org/articles/styling-elements.html)


##Deploying an app that uses Polymer

To convert your app to JavaScript
that you can deploy to the web,
you need to use the Polymer transformers.
You can test your app's JavaScript version using
either Dart Editor's **Run as JavaScript** command
or the `pub serve` command.
To produce deployable files,
use the `pub build` command.

###Specifying transformers

Add a `transformers` entry to your app's `pubspec.yaml` file
to specify the Polymer transformers:

{% prettify yaml %}
...
dependencies:
  polymer: ">=0.12.0 <0.13.0"
transformers:
- polymer
{% endprettify %}

By default, Polymer assumes that all HTML files under `web` can be
_entry points_—files that define pages to be served,
rather than elements to be included in pages.
You can use an `entry_points` field to limit the HTML files that
the Polymer transformers process.
For example:

{% prettify yaml %}
...
transformers:
- polymer:
    entry_points: web/index.html
{% endprettify %}

<aside class="alert alert-warning">
<b>Important:</b>
YAML is whitespace-sensitive,
so take care to indent the <tty>entry_points</tty> field as shown.
</aside>

For more information on using the Polymer transformers, see the
[Polymer package documentation](http://pub.dartlang.org/packages/polymer).

###Testing the JavaScript version

If you're using Dart Editor,
you can test the JavaScript version in your default web browser
by right-clicking your app's main file
(for example, web/index.html)
and choosing **Run as JavaScript**.
Dart Editor runs the Polymer transformers,
compiles your app to JavaScript,
and opens a browser tab for your running app.
You can copy the URL from that tab into any other browser
that you'd like to test.

Alternatively, run `pub serve`
on the command line,
from the app's top directory.
That command runs the transformers
and starts up an HTTP server to serve the app.
The command's output gives you a URL that you can
copy and paste into a browser window.
If you change the app's files and reload the window,
you see the updated version of the app.

{% comment %}
Update for 1.5, when Dart Editor will use pub serve more natively.
What's the effect of that?
Dart Editor already appears to run the polymer transformers.
{% endcomment %}

###Generating JavaScript files

When you're ready to generate files,
run `pub build`—either at the command line or
using Dart Editor—to
generate the files your app needs
to run in any modern browser.
The generated files appear in the
`build` directory, alongside your `pubspec.yaml` file.


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
