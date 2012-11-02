---
layout: default
title: "Target 2: Connect Dart & HTML"
description: "Shows basic scaffolding of a Dart web app"
has-permalinks: true
tutorial:
  id: connect-dart-html
---

{% capture whats_the_point %}

* The DOM models a browser page in a tree structure.
* The Document object is at the root of the tree.
* A Dart web app needs both a Dart file and an HTML file.
* An HTML file hosts your Dart code in a browser page.
* Use query() to get DOM elements.
* Control run-time configurations with named launches.
* Compile to JavaScript to run in any modern browser.
* Use CSS to set styles for visible elements.

{% endcapture %}

{% capture content %}

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
* [Edit Dart source code](#dart-editor-happiness)
* [About the Dart source code](#about-dart-code)
* [Create the HTML file](#create-html)
* [About the HTML source code](#about-html-code)
* [Run mini app](#run-mini)
* [Create a JavaScript launch](#mini-with-js)
* [Add a CSS file](#add-css)
{% comment %}
* [9-dart finish](#9-dart-finish)
{% endcomment %}

##About the DOM {#dom-intro}

The Document Object Model (DOM)
represents the structure of a web document as a tree of nodes.
When an HTML file is loaded into a browser,
the browser interprets the HTML
and displays the document in a window.
The following diagram shows a simple HTML file and
the resulting web browser page in Chrome.

<img src="images/simple-html.png"
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

<img src="images/simple-dom-tree.png"
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
Dart or JavaScript can dynamically modify that document by
by adding, deleting, and modifying the nodes in the DOM tree.
When the DOM is changed,
the browser immediately re-renders the window.

<img src="images/dynamic-dart.png"
     alt="A Dart program can dynamically change the DOM">

The diagram shows a small Dart program that makes
a modest change to the DOM by dynamically
changing a paragraph's text.
A program could add and delete nodes,
or even insert an entire sub-tree of nodes.

## Create a new Dart app {#create-dart-app}

In Dart Editor, create a new application called mini.
Unselect **Generate content for a basic web app**.
You will be building the files you need from scratch.
Make sure that **Add Pub support** is also unselected.

<img src="images/new-app-mini.png"
     alt="New Application dialog window">

Dart Editor creates a directory called mini and, within it,
a Dart source file named mini.dart
that contains the Dart code for a default command-line application.

<img src="images/new-app-files.png"
     alt="After new application created">

##Edit Dart source code {#dart-editor-happiness}

Use Dart Editor
to modify the source code
to look like this:

{% highlight dart %}
import 'dart:html';
void main() {
  query('#RipVanWinkle').text = 'Wake up, sleepy head!';
}
{% endhighlight %}

{% comment %}
####Errors
As you type, Dart Editor processes the text.
For example, begin typing the first line of code,
the `import` directive,
and stop just after you type the first single quotation mark.

<img src="images/error-editor-screenshot.png"
     alt="Dart Editor error">

You will see a small red 'x'
in the gutter on the left side of the **Editor pane**.
This means that Dart Editor has detected an error.
Hover the mouse over the red 'x' and 
a helpful error message is displayed in a tooltip:

<img src="images/error-tooltip-screenshot.png"
     alt="Dart Editor error tooltip">

This particular error is syntactic.
The single quote starts a string literal,
which is left uncompleted.
Errors can be either compile-time or run-time.
Compile-time errors prevent your program from running at all.
Run-time errors result in exceptions.

Finish typing the complete line of code and the red 'x' disappears.

####Warnings

**Tip:** Save your file with **File > Save**.
In some versions of Dart Editor,
you need to save the file and start typing again
before a newly imported library is detected.

Now delete the line of code that calls print().
And start typing the function call to query().
Stop after you type the first parenthesis.
Note that Dart Editor helpfully provides a matching parenthesis.
Note also that Dart Editor displays
a yellow warning symbol in the gutter.

<img src="images/warning-editor-screenshot.png"
     alt="Dart Editor warning">

In the background, Dart Editor does API lookup.
Dart Editor recognizes the top-level query() function
from the Dart HTML library,
but it has detected a possible problem.
Hover the mouse over the yellow warning sign and 
a helpful warning message will be displayed in a tooltip:

<img src="images/warning-tooltip-screenshot.png"
     alt="Dart Editor warning tooltip">

Dart Editor is telling you that query() requires
a string argument and you have not yet provided one.
Warnings are hints that your code might not work
but do not prevent your program from executing.

[XX Kathy sez 10/17/12
but they might just be the editor not knowing as much as you do
An example: if you know a query will return a certain kind of element,
you might get a warning when you treat it as that kind of element
(i think)
warnings also might just be fyi kinds of things
e.g. if you instantiate a class that has abstract methods,
it might or might not be ok.
I think warnings are more "this could be a problem,
so I'm letting you know, but it might be ok"

We mention it in chapter 2 (which you might be referring to):
Dart tools can report two kinds of errors: warnings and errors.
Warnings are just hints that your code might not work,
but they don’t prevent your program from executing.
Errors can be either compile-time or run-time.
A compile-time error prevents the code from executing at all;
a run-time error results in an exception “Exceptions” on page 32 being 
raised while the code executes.
ignore the overly verbose xref... we're fixing that
]

####Code completion

Continue typing, entering '#RipVanWinkle'
as the argument to the query() function,
and stop after you type the period.
Dart Editor displays a menu with auto-complete suggestions
based on the context.
You can also invoke the menu by typing **Ctl+Space**.

<img src="images/query-api-lookup.png"
     alt="Lookup query in Dart libraries in Dart Editor">

Scroll down and choose text, or just type it in.

Finish your edits,
and save the file with **File > Save**.

{% endcomment %}

##About the Dart source code {#about-dart-code}

Let's step through the code.

###Importing libraries

The import directive imports the specified library,
making all of the classes and functions
in that library
available to your program.

<img src="images/0-mini-code-walk-through.png"
     alt="Import Dart HTML library">

This program imports Dart's HTML library,
which contains the classes and functions for programming the DOM.
Generally speaking, all Dart web apps need the Dart HTML library.
Key classes include:

| Dart Class | Description |
|---|---|
| <a href="http://api.dartlang.org/dart_html/Node.html">Node</a> | Implements a Dart Node. |
| <a href="http://api.dartlang.org/dart_html/Element.html">Element</a> | A subclass of Node, implements a web page element. |
| <a href="http://api.dartlang.org/dart_html/Document.html">Document</a> | Another subclass of Node. Implements the document object. |
{: .table}

The Dart core library contains another useful class,
<a href="http://api.dartlang.org/dart_core/List.html">List</a>,
a parameterized class that can specify the type of its members.
The Element class keeps its list of child Elements
in a List\<Element>, a list that can contain only Element objects.

###Using the query() function

This app's main() function contains a single
line of code that is a little like a run-on sentence
with multiple things happening one after another.
Let's deconstruct it.

query() is a top-level function provided by the Dart HTML library
that gets an Element object from the DOM.

<img src="images/3-mini-code-walk-through.png"
     alt="Query for a DOM object by its ID">

The argument to query(), a string,
is a CSS selector that identifies the object.
CSS selectors can be classes, identifiers, attributes, etc.
In this case #RipVanWinkle 
is a unique ID for a paragraph element
that is set in the HTML file.

<img src="images/2-mini-code-walk-through.png"
     alt="ID attribute from HTML file">

Another useful function for getting elements from the DOM
is queryAll(),
which returns multiple Element objects via
a list of elements--List<Element>&mdash;all
of which match the provided selector.

###Setting the text of an Element

In the DOM, the text of a page element is contained
in a child node, specifically, a Text node.
In the following diagram,
"RipVanWinkle paragraph."
is a text node.

<img src="images/paragraph-dom.png"
     alt="DOM tree for a paragraph element">

More complex text,
such as text with style changes or
embedded links and images,
would be represented with a subtree of text nodes and other objects.

In Dart,
for convenience and to simplify code,
instead of walking a subtree of nodes to get
a page element's text,
you can use the Element class's getter and setter `.text`.

<img src="images/4-mini-code-walk-through.png"
     alt="Text node child of the paragraph">

Often, as with our RipVanWinkle example,
this simplification has no adverse effects.
Do know, however, that with more complex situations
getting text and then setting it immediately
will likely change the text.

The equal operator sets the text
of the Element returned by the query() function
to the string "Wake up, sleepy head!".

<img src="images/5-mini-code-walk-through.png"
     alt="Set the text node, thereby changing the text on the page">

This causes the browser to immediately re-render
the browser page containing this app
dynamically displaying the text on the browser page.

{% comment %}
## Understanding basic HTML {#understand-html}

To display a web app on a browser page,
you need an HTML file to host the web app.

HTML is a markup language that describes a browser page using tags.
Tags are special identifiers that appear between angle brackets.
When an HTML file is loaded into a browser,
the browser interprets the tags and displays the page as appropriate.
Tags can describe structural elements,
presentational information,
or hyper-text markup.

Tags usually come in pairs.
For example, consider:

{% highlight html %}
<title>The Page Title</title>
{% endhighlight %}

This HTML code creates a structural element--a title--whose
text is **The Page Title**.
Most browsers display the page title
in the window header of the browser page.
Here are some other oft-used structural tags:

{% highlight html %}
<h1>A Level-One Header</h1>
<h2>A Level-Two Header</h2>
<h6>Up to Six Levels</h6>
<head>A header section at the top of the browser page.</head>
<body>The main body of the browser page</body>
<p>A paragraph</p>
<!--A comment -->
{% endhighlight %}

Presentational tags describes the appearance of text.
Generally, you would use CSS to change the appearance
of text on the browser page,
rather than HTML tags.
We'll cover CSS in the next Target.

Hyper-text markup tags let you link to another page,
include images, or include apps.
In the next step,
we'll see an example of a hyper-text markup tag
for including a Dart app.
{% endcomment %}

## Create the HTML file {#create-html}

Now, let's create an HTML file to host the little app you just created.
In Dart Editor, select **File > New File**.
A dialog window appears.

<img src="images/new-html-file.png"
     alt="Create new HTML file">

<ol>
<li markdown="1">
Browse to the mini directory and select it.
</li>
<li markdown="1">
Type mini.html in the file name text box.
This follows convention: the basename is
the same as the application name
and it uses .html suffix.
</li>
<li markdown="1">
Click **Finish**.
</li>
</ol>

The Dart Editor auto-fills the file with some default HTML code.
There is more code than is necessary,
so replace the default contents with the following,
slightly simplified, HTML.

{% highlight html %}
<!DOCTYPE html>

<html>
  <head>
    <title>A Minimalist App</title>
  </head>

  <body>
    <p id="RipVanWinkle"></p>
    <script type="application/dart" src="mini.dart"></script>
    <script src="http://dart.googlecode.com/svn/branches/bleeding_edge/dart/client/dart.js"></script>
  </body>
</html>
{% endhighlight %}

Finish your edits and save the file with **File > Save**.

##About the HMTL source code {#about-html-code}

This HTML code is similar to the simple HTML code in the
various diagrams earlier in this target.
Again, you can see the use of the \<head>, \<title>, \<body>,
and \<p> tags.
And there, in the paragraph tag,
is the identifier "RipVanWinkle"
that the Dart code you created in the previous step uses
as an argument to query() to get the paragraph element.

New here is the use of the `script` tag.
A script's content is defined by a client-side script.
The HTML code above has two scripts.

<img src="images/script-tags.png"
     alt="Including Dart apps in HTML">

The first includes your mini app.
It uses two attributes: `type` indicates the type of the script.
`application/dart` is a new type created by the Dart team,
which is currently supported by Dartium.
The `src` attribute provides the URL to the source file of the script.
In this case, it is the Dart source file `mini.dart` that you created earlier.
The Dart file should be in the same directory as its host HTML file.

The second `script` tag is
a bootstrap script that takes care of turning on the Dart VM,
as well as compatibility with non-Dart browsers.

This diagram summarizes the connection
between `mini.dart` and `mini.html`.

<img src="images/dart-html-connect.png"
     alt="The connection between the HTML file and the Dart file">

{% comment %}
##Introduction to the DOM {#dom-intro}

DOM stands for Document Object Model and is both
a conceptual model and an API implemented by browsers
for representing and manipulating a page and the elements on it.

The DOM represents the HTML page as a tree-node structure.
At the top of the tree is the _document_ object,
that is, every page has a document object at its root.
The document has children,
each of which represents an element on the page
and might, in turn, have children.

The DOM creates a tree of page elements based on the HTML source code.
Here's the DOM tree for the HTML code you wrote for `mini` app.
(The DOM tree includes at least the elements shown in the diagram.
It may have more.)

<img src="images/DOMTree.png"
     alt="The DOM tree for mini app">

As you saw with the "RipVanWinkle" paragraph element,
these objects can be retrieved from within the Dart code
and modified, thereby changing the browser page.

In addition to the query() and queryAll() functions,
a Dart web app has a top-level document object
created automatically by the Dart VM,
which is a reference to the document object in the DOM.
You can refer to it with the name `document`
anywhere in your Dart web app.
`document` has the type Document,
a class provided by the Dart HTML library.

Document inherits from two key classes in the HTML library:
Node and Element.
Node provides the functions needed to manage
the tree-node structure of the document.
Element represents an HTML page element.
With it you can get and set attributes,
manage its appearance,
and register event handlers.

Specific types of page elements inherit from Element,
for example, ParagraphElement, TitleElement,
and HeadElement.
{% endcomment %}

{% comment %}
[XX: attributes, properties, nodes, elements]
{% endcomment %}

## Run the mini web app {#run-mini}

In Dart Editor,
make sure that one of `mini`'s files or the directory is selected,
and then click the Run button
<img src="images/run.png" width="16" height="16"
     alt="Run button">.

Dart Editor invokes Dartium
and loads `mini.html` in it.

<img src="images/mini-output.png"
     alt="Mini app running in Dartium">

The Dart web app changed
the text in the browser window dynamically at runtime.
Of course, placing static text on a browser page
and doing nothing else
could be accomplished with straight HTML.
This little app only shows you how to make a connection
from a Dart app to a browser page.

##Create a JavaScript launch {#mini-with-js}

You can create various runtime scenarios for your Dart app
using *launches* in Dart Editor.
A launch specifies a runtime configuration,
such as whether to compile to JavaScript
or what browser to use.

In this section,
you will create a launch for mini that first compiles the app to
JavaScript and then runs it in the default system browser.

<ol>
<li markdown="1">
In Dart Editor,
click the wee arrow to the right of the run button
<img src="images/run.png" width="16" height="16"
     alt="Run button">.
A menu appears:

<img src="images/manage-launches-menu.png"
     alt="Manage launches menu">

You have been unwittingly using launches when running
the samples so far.
The menu item mini.html is a launch that Dart Editor
automatically created
when you ran the application for the first time
in the previous section.
</li>

<li markdown="1">
Select **Manage launches** from the menu
to bring up the **Manage Launches** dialog.
</li>

<li markdown="1">
Now, click the new launch button
<img src="images/new-launch-button.png" width="28" height="22"
     alt="New launch button">.
A menu appears that gives you three options:

<img src="images/new-launch-menu.png"
     alt="New launch menu with three options">

A command-line launch runs in Dart Editor in
the **Output view**.
If your app is a command-line app (a `.dart` file with no `.html` file)
Dart Editor automatically creates a command-line launch
with the name of the `.dart` file that contains the main() function.

A Dartium launch runs in a Chromium window invoked by Dart Editor.
If your app is a web app,
Dart Editor automatically creates a Dartium launch
with the name of the `.html` file that includes the Dart app.

You must explicitly create a Dart JavaScript launch
to create a runtime configuration that compiles
your web app to JavaScript and then runs it in a browser.
</li>

<li markdown="1">
Select **Dart JavaScript launch**.
The dialog window adjusts to present the appropriate options
for your selection.
</li>

<li markdown="1">
Name the launch by typing `mini-with-js` in the first text box.

<img src="images/new-js-launch.png"
     alt="Create a launch that compiles to JavaScript">

It is recommended that the launch name reflect
the important aspects of its configuration.
In this case, the launch name specifies the app name
and that it's a JavaScript launch.
If the launch specified a browser, such as FireFox,
you might name the launch `mini-with-js-in-firefox`.
</li>

<li markdown="1">
The launch target is the HTML file `mini.html`.
Browse to the file.
</li>

<li markdown="1">
Click **Apply**.
The named launch should now appear
in the list to the left of the window.

<img src="images/mini-with-js-item.png"
     alt="New named launch in the list of launches">

</li>

<li markdown="1">
To run the launch,
click the Run button at the bottom right of the window.
Or select it from the Run menu on the main Dart Editor window.

This time, Dart Editor
creates a JavaScript file,
invokes the default system browser
and loads the JavaScript file into it.
The output should look the same.
</li>

</ol>

##Add a CSS file {#add-css}

Most HTML uses cascading style sheets to define _styles_
that control the appearance of page elements.
For example,
you might create a special paragraph style 
for showing code samples in an outlined box
using a fixed-width font.

Let's create a simple CSS file for the mini app.

In Dart Editor, create a file named mini.css
in your mini directory with the following text:

{% highlight dart %}
#RipVanWinkle {
  font-size: 20px;
  font-family: 'Open Sans', sans-serif;
  text-align: center;
  margin-top: 20px;
  background-color: #SlateBlue;
  color: #Yellow;  
}
{% endhighlight %}

This creates a style sheet for the page element
with the ID RipVanWinkle.
The style sheet sets the font,
centers the text,
and sets the text and background color.

To use this style sheet,
edit mini.html and add the line shown in bold below:

<img src="images/html-with-css.png"
     alt="HTML with CSS">

Save your files and run the app again.

<img src="images/mini-output-with-css.png"
     alt="Mini app running in Dartium with CSS styles in effect">

{% comment %}
##9-dart finish {#9-dart-finish}

[XX: think of good questions]

Should be able to answer these questions:

* how to create an app in Dart Editor
* how to run an app in Dart Editor
* how to create a named launch
* how to run in JavaScript
* DOM: document object, 
* relationship between HTML, Dart, DOM
* dart.html library
* and another
* and another
{% endcomment %}

<TD><a href="/docs/tutorials/get-started/" style="float:left;">Previous</a></TD>
<TD><a href="/docs/tutorials/add-elements/" style="float:right;">Next</a></TD>

{% endcapture %}

{% include tutorial.html %}