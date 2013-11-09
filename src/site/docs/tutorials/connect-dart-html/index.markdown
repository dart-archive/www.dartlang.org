---
layout: default
title: "Connect Dart &amp; HTML"
description: "Shows basic scaffolding of a Dart web app"
has-permalinks: true
tutorial:
  id: connect-dart-html
next: add-elements/
next-title: "Add Elements to the DOM"
prev: get-started/
prev-title: "Get started"
---

{% capture whats_the_point %}

* The DOM models a browser page in a tree/node structure.
* An HTML file hosts your Dart code in a browser page.
* Use query() with an ID to get an element from the DOM.
* Compile to JavaScript to run in any modern browser.
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
you need to have basic understanding of
several topics&mdash;the DOM tree, nodes, elements,
HTML, Dart language and libraries,
and Dart Editor.

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
These concepts
provide the foundation
for more interesting and useful web apps.

* [About the DOM](#dom-intro)
* [Create a new Dart app](#create-dart-app)
* [Edit the HTML file](#create-html)
* [About the HTML source code](#about-html-code)
* [Edit Dart source code](#dart-editor-happiness)
* [About the Dart source code](#about-dart-code)
* [Summary of HTML and Dart connections](#summary)
* [Run the mini web app](#run-mini)
* [Give the app some style with CSS](#add-css)
* [About CSS selectors](#about-css-selectors)
* [Other resources](#other-resources)
* [What next?](#what-next)

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
or even insert an entire sub-tree of nodes.

## Create a new Dart app {#create-dart-app}

The application you write in this tutorial is a web application.
Web applications use code from the `browser` package
to run inside of a browser,
so you need to start with the supporting files and packages
even for the smallest web app.

In Dart Editor, create a new web application
like you did in the previous tutorial,
[Get Started](/docs/tutorials/get-started/).
Name the app `mini`.

<img class="scale-img-max" src="images/new-app-mini.png"
     alt="New Application dialog window">

##Edit the HTML file {#create-html}

When Dart Editor created the application,
it created boilerplate HTML code.
Double click `mini.html` to open it.
Then replace the code with the following,
simplied HTML.

{% prettify html %}
<!DOCTYPE html>

<html>
  <head>
    <title>A Minimalist App</title>
  </head>
  
  <body>
    <p id="RipVanWinkle">
      RipVanWinkle paragraph.
    </p>
    <script type="application/dart" src="mini.dart"></script>
    <script src="packages/browser/dart.js"></script>
  </body>
</html>
{% endprettify %}

Finish your edits and save the file with **File > Save**.

##About the HTML source code {#about-html-code}

This HTML code is similar to the simple HTML code in the
various diagrams earlier in this tutorial.
Again, you can see the use of the \<head>, \<title>, \<body>,
and \<p> tags.
And there, in the paragraph tag,
is an identifier "RipVanWinkle".
The Dart code you create in the next step uses this ID
to get the paragraph element.

<img class="scale-img-max" src="images/html-id.png"
     alt="Using an ID in HTML">

Notice the use of the `script` tag.
The source for a script is provided by a client-side file.
The HTML code above has two scripts.

<img class="scale-img-max" src="images/script-tags.png"
     alt="Including Dart apps in HTML">

The first script includes your mini app.
The `type` attribute specifies that the script has
the type `application/dart`,
which is a new type created by the Dart team.
Currently, only the Dartium build of Chromium supports
`application/dart`.
The `src` attribute provides the URL to the source file of the script.
In this case, it is the Dart source file `mini.dart`,
which you provide in the next step.
The Dart file should be in the same directory as its host HTML file.

The second `script` tag is
a bootstrap script that takes care of turning on the Dart VM,
as well as compatibility with non-Dart browsers.

##Edit Dart source code {#dart-editor-happiness}

Open `mini.dart` and modify the source code
to look like this:

{% prettify dart %}
import 'dart:html';
void main() {
  query('#RipVanWinkle').text = 'Wake up, sleepy head!';
}
{% endprettify %}

##About the Dart source code {#about-dart-code}

Let's step through the code.

###Importing libraries

The import directive imports the specified library,
making all of the classes and functions
in that library
available to your program.

<img class="scale-img-max" src="images/0-mini-code-walk-through.png"
     alt="Import Dart HTML library">

This program imports Dart's HTML library,
which contains key classes and functions for programming the DOM.
Key classes include:

| Dart class | Description |
|---|---|
| <a href="https://api.dartlang.org/dart_html/Node.html" target="_blank">Node</a> | Implements a Dart Node. |
| <a href="https://api.dartlang.org/dart_html/Element.html" target="_blank">Element</a> | A subclass of Node, implements a web page element. |
| <a href="https://api.dartlang.org/dart_html/Document.html" target="_blank">Document</a> | Another subclass of Node. Implements the document object. |
{: .table}

The Dart core library contains another useful class,
<a href="https://api.dartlang.org/dart_core/List.html" target="_blank">List</a>,
a parameterized class that can specify the type of its members.
An instance of Element keeps its list of child Elements
in a List\<Element>.

###Using the query() function

This app's main() function contains a single
line of code that is a little like a run-on sentence
with multiple things happening one after another.
Let's deconstruct it.

query() is a top-level function provided by the Dart HTML library
that gets an Element object from the DOM.

<img class="scale-img-max" src="images/3-mini-code-walk-through.png"
     alt="An example of querying for a DOM object by its ID">

The argument to query(), a string,
is a CSS selector that identifies the object.
Most commonly CSS selectors specify classes, identifiers, or attributes.
We'll look at these in a little more detail later,
when we add a CSS file to the mini app.
In this case RipVanWinkle is the unique ID for a paragraph element
declared in the HTML file
and #RipVanWinkle specifies that ID.

<img class="scale-img-max" src="images/2-mini-code-walk-through.png"
     alt="ID attribute from HTML file">

Another useful function for getting elements from the DOM
is queryAll(),
which returns multiple Element objects via
a list of elements&mdash;List<Element>&mdash;all
of which match the provided selector.

###Setting the text of an Element

In the DOM, the text of a page element is contained
in a child node, specifically, a Text node.
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

<img class="scale-img-max" src="images/4-mini-code-walk-through.png"
     alt="Text node child of the paragraph">

However, if the text node has styles (and thus a subtree),
getting text and then setting it immediately is likely
to change the DOM, as a result of losing subtree information.
Often, as with our RipVanWinkle example,
this simplification has no adverse effects.

The assignment operator (=) sets the text
of the Element returned by the query() function
to the string "Wake up, sleepy head!".

<img class="scale-img-max" src="images/5-mini-code-walk-through.png"
     alt="Set the text node, thereby changing the text on the page">

This causes the browser to immediately re-render
the browser page containing this app, thus
dynamically displaying the text on the browser page.

##Summary of HTML and Dart connections {#summary}

This diagram summarizes the connections
between `mini.dart` and `mini.html`.

<img class="scale-img-max" src="images/dart-html-connect.png"
     alt="The connection between the HTML file and the Dart file">

##Run the mini web app {#run-mini}

In Dart Editor,
select `mini.html` and then click the Run button
<img class="scale-img-max" src="images/run.png" width="16" height="16"
     alt="Run button">.
Dart Editor invokes Dartium
and loads `mini.html` in it.
Below is mini app running in a frame.
The app displays the text provided by Dart code,
namely "Wake up, sleepy head!",
not the text provided in the HTML file.

<iframe class="running-app-frame"
        style="height:150px;width:300px;"
        src="examples/mini/mini.html">
</iframe>

The Dart web app changed
the text in the browser window dynamically at runtime.
Of course, placing text on a browser page
and doing nothing else
could be accomplished with straight HTML.
This little app only shows you how to make a connection
from a Dart app to a browser page.

##Give the app some style with CSS {#add-css}

Most HTML uses cascading style sheets (CSS) to define _styles_
that control the appearance of page elements.
Let's customize the CSS for the mini app.

In Dart Editor, edit the file named `mini.css`
and replace the contents of the file with
the following CSS code:

{% prettify dart %}
#RipVanWinkle {
  font-size: 20px;
  font-family: 'Open Sans', sans-serif;
  text-align: center;
  margin-top: 20px;
  background-color: SlateBlue;
  color: Yellow;  
}
{% endprettify %}

This defines a style
for the page element
with the ID RipVanWinkle.
To use this style sheet,
edit `mini.html` and add the line shown in bold below:

<img class="scale-img-max" src="images/html-with-css.png"
     alt="HTML with CSS">

Save your files and run the app again.

Below is the revised mini app,
which is slightly more colorful
but still neither interactive nor interesting.

<iframe class="running-app-frame"
        style="height:150px;width:300px;"
        src="examples/mini_with_style/mini_with_style.html">
</iframe>

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
because you use them with query() and queryAll()
to get matching elements from the DOM.
Most often Dart programs use ID selectors with query()
and class selectors with queryAll().

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

<aside class="alert">
  <strong>Tip:</strong>
As you saw,
mini app used a CSS selector,
the ID #RipVanWinkle,
even when there was no CSS file.
You do not need a CSS file for a Dart program.
Nor do you need a CSS file to use CSS selectors.
CSS selectors are established in the HTML file
and used by the Dart program 
to select matching elements.
</aside>

Let's look at the CSS code for mini app.
The CSS file for the mini app has one CSS rule in it.
A CSS rule has two main parts: a selector and a set of declarations.

<img class="scale-img-max" src="images/css-rule-explained.png"
     alt="The parts of a CSS rule">

In mini app, the selector #RipVanWinkle is an ID selector,
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

<ul>
  <li>
    <a href="/docs/dart-up-and-running/">Dart: Up and Running</a>
    provides thorough coverage of the Dart language, libraries, and tools.
    If a topic is not covered explicitly here,
    you can find the information you need there.
  </li>
  <li>
    <a href="/docs/dart-up-and-running/contents/ch04-tools-editor.html">Dart Editor</a>,
    an excerpt from <em>Dart: Up and Running</em>,
    provides details about using Dart Editor.
    The excerpt includes, for example,
    how to use Dart Editor's power features such as autocompletion and refactoring,
    how to set up different run-time environments, and so on.
  </li>
  <li>
    Also, check out
    <a href="/docs/cookbook/">
    <i class="icon-food"> </i> Dart Cookbook</a>,
    where you'll find many recipes about
    manipulating the DOM and using CSS.
    The cookbook also has recipes about basic Dart data types,
    such strings, lists, maps, and numbers.
  </li>
</ul>

##What next?

The next tutorial, [Add Elements to the DOM](/docs/tutorials/add-elements/),
shows you how to dynamically change the HTML page
by adding elements to the DOM.

{% endcapture %}

{% include tutorial.html %}
