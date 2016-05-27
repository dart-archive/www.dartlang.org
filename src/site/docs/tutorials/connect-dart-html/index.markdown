---
layout: tutorial
title: "Connect Dart &amp; HTML"
description: "Shows basic scaffolding of a Dart web app"
has-permalinks: true
tutorial:
  id: connect-dart-html
next: add-elements/
next-title: "Add Elements to the DOM"
prev: get-started/
prev-title: "Get Started"
---

{% capture whats_the_point %}

* DartPad lets you write a simple Dart web app without HTML boilerplate.
* A Dart web app has Dart, HTML, and (usually) CSS code.
* Compile a web app's Dart code to JavaScript to run the app in any modern browser.
* An HTML file hosts your Dart code in a browser page.
* The DOM models a browser page in a tree/node structure.
* Use querySelector() with an ID to get an element from the DOM.
* CSS selectors are patterns used to select matching elements in the DOM.
* Use CSS rules to style elements.

{% endcapture %}

{% capture sample_links %}

<p>
This tutorial features these examples:</p>
* mini
* mini_with_style

<p>
Don't have the source code?
<a href="https://github.com/dart-lang/dart-tutorials-samples/archive/master.zip">
  Download it.
</a>

{% endcapture %}

{% capture content %}

<div class="tute-target-title">
<h1>{{page.title}}</h1>
<h3>Write a mini Dart app.</h3>
</div>

To write a Dart web app,
you need to understand
several topics&mdash;the DOM tree, nodes, elements,
HTML, and the Dart language and libraries.

The interdependencies are circular,
but we have to begin somewhere,
so we begin with a simple HTML file,
which introduces the DOM tree and nodes.
From there,
you build a bare bones, stripped-down
Dart application
that contains just enough code to
dynamically put text on the page from the Dart side.

Though simple,
this example shows you how to connect a Dart
app to an HTML page and
one way that a Dart app can interact with items on the page.
These concepts provide the foundation
for more interesting and useful web apps.

* [About the Dart, HTML, and CSS triumvirate](#source-files)
* [About the DOM](#dom-intro)
* [Create a new Dart app](#create-dart-app)
* [Edit the HTML source code](#create-html)
* [About the HTML source code](#about-html-code)
* [Edit the Dart source code](#dart-editor-happiness)
* [About the Dart source code](#about-dart-code)
* [HTML and Dart connections](#summary)
* [Give the app some style with CSS](#add-css)
* [About CSS selectors](#about-css-selectors)
* [Other resources](#other-resources)
* [What next?](#what-next)


##About the Dart, HTML, and CSS triumvirate {#source-files}

If you've used
<a href="{{site.custom.dartpad.direct-link}}" target="_blank">DartPad</a>,
you've already seen the DART, HTML, and CSS tabs
that let you write the code for a web app.
Each of these three languages
is responsible for a different aspect of the web app.

| Language | Purpose |
|---|---|
| Dart | Implements the interactivity and dynamic behavior of the web app |
| HTML | Describes the content of the web app's page (the elements in the document and the structure) |
| CSS | Governs the appearance of page elements |
{: .table}

A Dart program can
respond to events such as mouse clicks,
manipulate the elements on a web page dynamically,
and save information.
Before the web app is deployed,
the Dart code must be compiled into JavaScript code.

HTML is a language for describing web pages.
Using tags, HTML sets up the initial page structure,
puts elements on the page,
and embeds any scripts for page interactivity.
HTML sets up the initial document tree
and specifies element types, classes, and IDs,
which allow HTML, CSS, and Dart programs to refer to the same elements.

CSS, which stands for _Cascading Style Sheets_, describes the appearance
of the elements within a document.
CSS controls many aspects of formatting:
type face, font size, color, background color,
borders, margins, and alignment, to name a few.


##About the DOM {#dom-intro}

The Document Object Model (DOM)
represents the structure of a web document as a tree of nodes.
When an HTML file is loaded into a browser,
the browser interprets the HTML
and displays the document in a window.
The following diagram shows a simple HTML file and
the resulting web browser page in Chrome.

<img class="scale-img-max" src="images/simple-html.png"
     alt="A simple HTML file and its resulting web page">

HTML uses tags to describe the document.
For example, the simple HTML code above
uses the \<title> tag for the page title,
\<h1> for a level-one header,
and \<p> for a paragraph.
Some tags in the HTML code,
such as
\<head> and \<body>,
are not visible on the web page,
but do contribute to the structure of the document.

In the DOM,
the document object sits at the root of the tree
(it has no parent).
Different kinds of nodes in the tree
represent different kinds of objects in the document.
For example, the tree has page elements,
text nodes, and attribute nodes.
Here is the DOM tree for the simple HTML file above.

<img class="scale-img-max" src="images/simple-dom-tree.png"
     alt="The DOM tree for a simple HTML file">

Notice that some tags, such as the \<p> paragraph tag,
are represented by multiple nodes.
The paragraph itself is an element node.
The text within the paragraph is a text node
(and in some cases, might be a subtree containing many nodes).
And the ID is an attribute node.

Except for the root node, each node in the tree has exactly one parent.
Each node can have many children.

An HTML file defines the initial structure of a document.
Dart or JavaScript can dynamically modify that document
by adding, deleting, and modifying the nodes in the DOM tree.
When the DOM is changed,
the browser immediately re-renders the window.

<img class="scale-img-max" src="images/dynamic-dart.png"
     alt="A Dart program can dynamically change the DOM">

The diagram shows a small Dart program that makes
a modest change to the DOM by dynamically
changing a paragraph's text.
A program could add and delete nodes,
or even insert an entire subtree of nodes.


## Create a new Dart app {#create-dart-app}

1. Go to <a href="{{site.custom.dartpad.direct-link}}" target="_blank">DartPad</a>.
2. Click the **New Pad** button to undo any changes you might have made
   the last time you visited DartPad.

<aside class="alert alert-info" markdown="1">
**Note:**
These instructions feature DartPad,
which hides some of the HTML boilerplate code.
If you want to use any other editor,
then we recommend starting with a small Dart web app sample
and modifying the non-script tags inside the \<body> section.
[HTML and Dart connections](#connections) shows the full HTML code.
</aside>

##Edit the HTML source code {#create-html}

1. Click **HTML**, at the upper left of DartPad.
   The view switches from Dart code to the (non-existent) HTML code.

2. Add the following HTML code:

   {% prettify html %}
   <p id="RipVanWinkle">
     RipVanWinkle paragraph.
   </p>
   {% endprettify %}

3. Click **HTML OUTPUT** to see how a browser would render your HTML.


##About the HTML source code {#about-html-code}

This HTML code is similar to the HTML code in the
various diagrams earlier in this tutorial,
but it's even simpler.

In DartPad you need only the tags you really care about—in
this case, \<p>.
You don't need surrounding tags such as
\<html> and \<body>.
Because DartPad knows where your Dart code is,
you don't need a \<script> tag.

<aside class="alert alert-info" markdown="1">
**Note:**
[HTML and Dart connections](#connections) shows the full HTML code
that you need to run your web app outside of DartPad.
</aside>

The paragraph tag has the identifier "RipVanWinkle".
The Dart code you create in the next step uses this ID
to get the paragraph element.

{% comment %}
PENDING: cover this somewhere.

Notice the use of the `script` tag.
The source for a script is provided by a client-side file.
The HTML code above has two scripts.

The first script includes your mini app.
The `type` attribute specifies that the script has
the type `application/dart`,
which is a new type created by the Dart team.
Only the Dartium build of Chromium supports `application/dart`.
The `src` attribute provides the URL to the source file of the script.
In this case, it is the Dart source file `main.dart`,
which you provide in the next step.
The Dart file should be in the same directory as its host HTML file.

The second `script` tag is
a bootstrap script that takes care of turning on the Dart VM,
as well as compatibility with non-Dart browsers.
{% endcomment %}


##Edit the Dart source code {#dart-editor-happiness}

1. Click **DART**, at the upper right of DartPad.
   The view switches from HTML code to Dart code.

2. Change the Dart code to the following:

   {% prettify dart %}
   import 'dart:html';

   void main() {
     querySelector('#RipVanWinkle').text = 'Wake up, sleepy head!';
   }
   {% endprettify %}

3. Click **Run** to execute your code.

The text in the HTML OUTPUT tab changes to "Wake up, sleepy head!"


##About the Dart source code {#about-dart-code}

Let's step through the Dart code.

###Importing libraries

The import directive imports the specified library,
making all of the classes and functions
in that library
available to your program.

<pre class="prettyprint lang-dart allow-scroll">
<a href="#" class="dart-popover" data-toggle="popover" data-html="true" data-trigger="hover focus" data-content="Imports Dart's HTML classes and functions">import 'dart:html';</a>
</pre>

This program imports Dart's HTML library,
which contains key classes and functions for programming the DOM.
Key classes include:

| Dart class | Description |
|---|---|
| <a href="https://api.dartlang.org/dart_html/Node.html" target="_blank">Node</a> | Implements a DOM node. |
| <a href="https://api.dartlang.org/dart_html/Element.html" target="_blank">Element</a> | A subclass of Node; implements a web page element. |
| <a href="https://api.dartlang.org/dart_html/Document.html" target="_blank">Document</a> | Another subclass of Node; implements the document object. |
{: .table}

The Dart core library contains another useful class:
<a href="https://api.dartlang.org/dart_core/List.html" target="_blank">List</a>,
a parameterized class that can specify the type of its members.
An instance of Element keeps its list of child Elements
in a List\<Element>.

###Using the querySelector() function

This app's main() function contains a single
line of code that is a little like a run-on sentence
with multiple things happening one after another.
Let's deconstruct it.

querySelector() is a top-level function provided by the Dart HTML library
that gets an Element object from the DOM.

<pre class="prettyprint lang-dart allow-scroll">
<a href="#" class="dart-popover" data-toggle="popover" data-html="true" data-trigger="hover focus" data-content="Returns the matching Element">querySelector('#RipVanWinkle')</a>.text = 'Wake up, sleepy head!';
</pre>

The argument to querySelector(), a string,
is a CSS selector that identifies the object.
Most commonly CSS selectors specify classes, identifiers, or attributes.
We'll look at these in more detail later,
when we add a CSS file to the mini app.
In this case, RipVanWinkle is the unique ID for a paragraph element
declared in the HTML file,
and #RipVanWinkle specifies that ID.

<pre class="prettyprint lang-dart allow-scroll">
querySelector(<a href="#" class="dart-popover" data-toggle="popover" data-html="true" data-trigger="hover focus" data-content="ID from HTML file">'#RipVanWinkle'</a>).text = 'Wake up, sleepy head!';
</pre>

Another useful function for getting elements from the DOM
is querySelectorAll(),
which returns multiple Element objects via
a list of elements&mdash;List<Element>&mdash;all
of which match the provided selector.

###Setting the text of an Element

In the DOM, the text of a page element is contained
in a child node, specifically, a text node.
In the following diagram,
the node containing the string
"RipVanWinkle paragraph."
is a text node.

<img class="scale-img-max" src="images/paragraph-dom.png"
     alt="DOM tree for a paragraph element">

More complex text,
such as text with style changes or
embedded links and images,
would be represented with a subtree of text nodes and other objects.

In Dart,
you can simply use the Element `text` property,
which has a getter
that walks the subtree of nodes for you and extracts their text.

<pre class="prettyprint lang-dart allow-scroll">
querySelector('#RipVanWinkle')<a href="#" class="dart-popover" data-toggle="popover" data-html="true" data-trigger="hover focus" data-content="Convenience API to the Element's text">.text</a> = 'Wake up, sleepy head!';
</pre>

However, if the text node has styles (and thus a subtree),
getting text and then setting it immediately is likely
to change the DOM, as a result of losing subtree information.
Often, as with our RipVanWinkle example,
this simplification has no adverse effects.

The assignment operator (=) sets the text
of the Element returned by the querySelector() function
to the string "Wake up, sleepy head!".

<pre class="prettyprint lang-dart allow-scroll">
querySelector('#RipVanWinkle').text <a href="#" class="dart-popover" data-toggle="popover" data-html="true" data-trigger="hover focus" data-content="Dynamically changes the DOM">=</a> 'Wake up, sleepy head!';
</pre>

This causes the browser to immediately re-render
the browser page containing this app, thus
dynamically displaying the text on the browser page.


##HTML and Dart connections {#connections}

The Dart web app changed
the text in the browser window dynamically at runtime.
Of course, placing text on a browser page
and doing nothing else
could be accomplished with straight HTML.
This little app only shows you how to make a connection
from a Dart app to a browser page.

In DartPad, the only visible connection between
the Dart code and the HTML code
is the RipVanWinkle ID.

<img class="scale-img-max" src="images/dart-html-connect.png"
     alt="The RipVanWinkle ID is used by both Dart and HTML">

To run your app outside of DartPad,
you need to make another connection between the HTML and Dart code:
you must add \<script> tags to the HTML
to tell the browser where to find the Dart code.
You must also add other HTML markup
to provide additional page information and structure
that the browser requires.

{% comment %}
PENDING: We should include or link to instructions
on how to convert a DartPad app into one you can run in the browser.
{% endcomment %}

Here's the full HTML code for this app,
assuming that the Dart code is in a file named `main.dart`:

<pre class="prettyprint lang-dart allow-scroll">
&lt;!DOCTYPE html>

&lt;html>
  &lt;head>
    &lt;title>A Minimalist App&lt;/title>
  &lt;/head>

  &lt;body>
    &lt;p id="RipVanWinkle">
      RipVanWinkle paragraph.
    &lt;/p>

    <a href="#" class="dart-popover" data-toggle="popover" data-html="true" data-trigger="hover focus" data-content="Specifies the location of the Dart code">&lt;script type="application/dart" src="main.dart">&lt;/script></a>
    <a href="#" class="dart-popover" data-toggle="popover" data-html="true" data-trigger="hover focus" data-content="Enables the browser to use the Dart code">&lt;script src="packages/browser/dart.js">&lt;/script></a>
  &lt;/body>
&lt;/html>
</pre>

The two \<script> tags are the only Dart-specific parts of this added HTML.
They tie the Dart code into the page,
telling the browser where to find the Dart code
and what to do with it.

The next diagram summarizes all the connections
between the Dart and HTML code.

<img class="scale-img-max" src="images/dart-html-connect-full.png"
     alt="The connection between the HTML file and the Dart file">


##Give the app some style with CSS {#add-css}

Most HTML uses cascading style sheets (CSS) to define _styles_
that control the appearance of page elements.
Let's customize the CSS for the mini app.

1. Click **CSS**.
   The view switches from Dart code to the (non-existent) CSS code.

2. Add the following CSS code:

   {% prettify none %}
   #RipVanWinkle {
     font-size: 20px;
     font-family: 'Open Sans', sans-serif;
     text-align: center;
     margin-top: 20px;
     background-color: SlateBlue;
     color: Yellow;
   }
   {% endprettify %}

The display under HTML OUTPUT immediately changes
to reflect the new styles,
which apply only to the page element
that has the ID RipVanWinkle.


##About CSS selectors {#about-css-selectors}

IDs, classes, and other information about elements
are established in HTML.
Your Dart code can use this information
to get elements using a CSS selector&mdash;a pattern
used to select matching elements in the DOM.
CSS selectors allow the CSS, HTML, and Dart code
to refer to the same objects.
Commonly, a selector specifies an ID,
an HTML element type,
a class, or an attribute.
Selectors can also be nested.

CSS selectors are important in Dart programs
because you use them with querySelector() and querySelectorAll()
to get matching elements from the DOM.
Most often Dart programs use ID selectors with querySelector()
and class selectors with querySelectorAll().

Here are some examples of CSS selectors:

| Selector type | Example | Description |
|---|---|
| ID selector | #RipVanWinkle | Matches a single, unique element |
| HTML element | p | Matches all paragraphs |
| HTML element | h1 | Matches all level-one headers |
| Class | _.classname_ | Matches all items with the class _classname_  |
| Asterisk | * | Matches all elements |
| Attribute | input[type="button"] | Matches all button input elements |
{: .table}

<aside class="alert alert-info">
<strong>Tip:</strong>
As you saw,
the mini app used a CSS selector,
the ID #RipVanWinkle,
even when there was no CSS file.
You do not need a CSS file for a Dart program.
Nor do you need a CSS file to use CSS selectors.
CSS selectors are established in the HTML file
and used by the Dart program
to select matching elements.
</aside>

Let's look at the CSS code for the mini app.
The CSS file for the mini app has one CSS rule in it.
A CSS rule has two main parts: a selector and a set of declarations.

<img class="scale-img-max" src="images/css-rule-explained.png"
     alt="The parts of a CSS rule">

In the mini app, the selector #RipVanWinkle is an ID selector,
as signaled by the hash tag (#);
it matches a single, unique element with the specified ID,
our now tired RipVanWinkle paragraph element.
RipVanWinkle is the ID in the HTML file.
It is referred to in the CSS file and in the Dart code
using a hash tag(#).
Classnames are specified in the HTML file without a period (.)
and referred to in the CSS file and in Dart code with a period (.).

Between the curly brackets of a CSS rule is
a list of declarations,
each of which ends in a semi-colon (;).
Each declaration specifies a property and its value.
Together the set of declarations define the _style sheet_
for all matching elements.
The style sheet is used to set the appearance
of the matching element(s) on the web page.

<img class="scale-img-max" src="images/css-property-value.png"
     alt="A declaration specifies an attribute and its value">

The CSS rule for the RipVanWinkle paragraph
specifies several properties;
for example, it sets the text color to Yellow.

##Other resources

{% comment %}
PENDING: Link to WebStorm docs? DartPad docs?
{% endcomment %}

* <a href="/docs/dart-up-and-running/">Dart: Up and Running</a>
  provides thorough coverage of the Dart language and libraries.
* <a href="/tools/">Dart Tools</a>
  lists IDEs and editors that have Dart plugins.

##What next?

The next tutorial, [Add Elements to the DOM](/docs/tutorials/add-elements/),
shows you how to dynamically change the HTML page
by adding elements to the DOM.

{% endcapture %}

{% include tutorial.html %}
