---
layout: default
title: "Target 2: Connect Dart & HTML"
description: "Shows basic scaffolding of a Dart web app"
has-permalinks: true
tutorial:
  id: connect-dart-html
---

{% capture whats_the_point %}

* The DOM models a browser page in a tree-node structure.
* The Document object is at the root of the tree.
* A Dart web app needs both a Dart file and an HTML file.
* An HTML file hosts your web app in a browser page.
* Use query() to get page elements.
* Control run-time configurations with named launches.
* Compile to JavaScript to run in any browser.
* Use CSS to set styles for visible elements.

{% endcapture %}

{% capture code_links %}
<ul>
<li>
   <a href="examples/mini/mini.dart">mini.dart</a>
</li>
<li>
   <a href="examples/mini/mini.html">mini.html</a>
</li>
<li>
   <a href="examples/mini/mini.css">mini.css</a>
</li>
<li>
   <a href="examples/mini/mini-with-css.html">mini-with-css.html</a>
</li>
</ul>
{% endcapture %}

{% capture content %}

To write a Dart web app,
you need to have basic understanding of
several topics--the DOM, Elements, Nodes,
HTML, Dart language and libraries,
and Dart Editor.

The interdependencies are circular,
but we have to begin somewhere,
so we begin with a simple HTML file,
which introduces the DOM and page elements.
From there,
you build a bare bones, stripped-down
Dart application
that contains just enough code to
put text on the page from the Dart side.
Though simple,
this example shows you how to connect a Dart
app to an HTML page and
one way that a Dart app can interact with elements on the page.
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

The DOM is a conceptual model
that represents a document and its structural elements
as objects in a tree.
The document object sits at the root of the tree.
Its children are nodes,
which might in turn have children.

HTML files contain code that describes a document.
When an HTML file is loaded into a browser,
the browser interprets the HTML and displays
the document in a window.

![Basic DOM Tree](images/basic-html-dom.png)

For example,
the HTML file shown in the diagram,
describes a document with head and body elements.
The head element contains the page title.
The body element contains a header and a paragraph.
You can't see the head and body sections
on the browser page,
but they are part of the structure of the document.

Later,
you will create an HTML file similar to this one,
but which embeds an executable script
written in Dart using HTML's `script` tag.
Through functions and classes provided by the Dart HTML library,
an embedded Dart program
can query the DOM for objects
that represent the elements on the page
and then interact with them.
Dart code can also manipulate the DOM tree by
inserting and deleting elements.

Let's take special note of the paragraph tag:

![HTML Paragraph Tag](images/html-paragraph.png)

This defines a paragraph element with an _attribute_
and a _property_.
Here, `id` is the identifier of the element
and should be unique.
The value of `id` is `RipVanWinkle`.
The text between the beginning and ending tags
is the _text property_ of a paragraph element.

You'll see these in use later.

## Create a new Dart app {#create-dart-app}

In Dart Editor, create a new application called `mini`.
Unselect **Generate content for a basic web app**.
We will be building the files we need from scratch.
Make sure that **Add Pub support** is also unselected
and click **Finish**.

![New App dialog window](images/new-app-mini.png)

Dart Editor creates a directory called `mini` and, within it,
a Dart source file named `mini.dart`
that contains the Dart code for a default command-line application.

![After New App Created](images/new-app-files.png)

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

![Dart Editor Error](images/error-editor-screenshot.png)

You will see a small red 'x'
in the gutter on the left side of the **Editor pane**.
This means that Dart Editor has detected an error.
Hover the mouse over the red 'x' and 
a helpful error message is displayed in a tooltip:

![Dart Editor Error Tooltip](images/error-tooltip-screenshot.png)

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

Now delete the line of code that calls `print()`.
And start typing the function call to `query()`.
Stop after you type the first parenthesis.
Note that Dart Editor helpfully provides a matching parenthesis.
Note also that Dart Editor displays
a yellow warning symbol in the gutter.

![Dart Editor Warning](images/warning-editor-screenshot.png)

In the background, Dart Editor does API lookup.
Dart Editor recognizes the top-level `query()` function
from the Dart HTML library,
but it has detected a possible problem.
Hover the mouse over the yellow warning sign and 
a helpful warning message will be displayed in a tooltip:

![Dart Editor Warning Tooltip](images/warning-tooltip-screenshot.png)

Dart Editor is telling you that `query()` requires
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

####Code Completion

Continue typing, entering `'#RipVanWinkle'`
as the argument to the `query()` function,
and stop after you type the period.
Dart Editor displays a menu with auto-complete suggestions
based on the context.
You can also invoke the menu by typing **Ctl+Space**.

![Query API Lookup](images/query-api-lookup.png)

Scroll down and choose `text`, or just type it in.

Finish your edits,
and save the file with **File > Save**.

{% endcomment %}

##About the Dart source code {#about-dart-code}

Let's step through the code.

###Importing libraries

The `import` directive imports the specified library,
making all of the classes and functions
in that library
available to your program.

![Code Walk-through of mini.dart](images/0-mini-code-walk-through.png)

In this example, the program imports
Dart's HTML library,
which contains the classes and functions for programming the DOM.
Generally speaking, all Dart web apps need the Dart HTML library.
Key classes include `Document`, `Element`,
`List<Element>` (a list containing elements), and `Window`.

###Using the query() function

This app's `main()` function contains a single
line of code that is a little like a run-on sentence
with multiple things happening one after another.
Let's deconstruct it.

![Code Walk-through of mini.dart](images/2-mini-code-walk-through.png)

`query()` is a top-level function provided by the Dart HTML library
that gets an object from the DOM.
More specifically,
it returns a Dart `Element` object
that is bound to the requested object in the DOM.

![Code Walk-through of mini.dart](images/3-mini-code-walk-through.png)

The argument to `query()`, a string,
is a CSS selector that identifies the object.
CSS selectors can be classes, identifiers, attributes, etc.
In this case `#RipVanWinkle` 
is a unique ID for a paragraph element
that is set in the HTML file.

Another useful function for getting elements from the DOM
is `queryAll()`,
which returns multiple page elements via
a list of elements--`List<Element>`--all
of which match the provided selector.

###Modifying the text property of an element

![Code Walk-through of mini.dart](images/4-mini-code-walk-through.png)

The highlighted code refers to the text property
of the element returned by `query()`.
All Dart Elements have a text property.

![Code Walk-through of mini.dart](images/5-mini-code-walk-through.png)

The equal operator sets the text property of the paragraph element
to the string "Wake up, sleepy head!",
thereby displaying the text on the browser page.

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

## Create the HTML File {#create-html}

Now, let's create an HTML file to host the little app you just created.

<ol>
<li markdown="1">
In Dart Editor, select **File > New File**.
A dialog window appears.

![Create New HTML File](images/new-html-file.png)

</li>
<li markdown="1">
Browse to the `mini` directory.
</li>
<li markdown="1">
Type `mini.html` in the file name text box.
This follows convention: the basename is
the same as the application name
and it uses `.html` suffix.
</li>
<li markdown="1">
Click **Finish**.
</li>

<li markdown="1">
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
</li>

<li markdown="1">
Finish your edits and save the file with **File > Save**.
</li>
</ol>

##About the HMTL source code {#about-html-code}

This HTML code is similar to the code you saw above.
Again, you can see the use of the `head`, `title`, `body`,
and `p` tags.
And there, in the paragraph tag,
is the identifier "RipVanWinkle"
that your Dart app used
as an argument to `query()` to get the paragraph element.

New here is the use of the `script` tag.
A script's content is defined by a client-side script.
The HTML code above has two scripts.

![Including Dart apps in HTML](images/script-tags.png)

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

![HTML Dart and DOM](images/dart-html-connect.png)

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

![The DOM tree for mini app](images/DOMTree.png)

As you saw with the "RipVanWinkle" paragraph element,
these objects can be retrieved from within the Dart code
and modified, thereby changing the browser page.

In addition to the `query()` and `queryAll()` functions,
a Dart web app has a top-level document object
created automatically by the Dart VM,
which is a reference to the document object in the DOM.
You can refer to it with the name `document`
anywhere in your Dart web app.
`document` has the type `Document`,
a class provided by the Dart HTML library.

`Document` inherits from two key classes in the HTML library:
`Node` and `Element`.
`Node` provides the functions needed to manage
the tree-node structure of the document.
`Element` represents an HTML page element.
With it you can get and set attributes,
manage its appearance,
and register event handlers.

Specific types of page elements inherit from Element,
for example, `ParagraphElement`, `TitleElement`,
and `HeadElement`.
{% endcomment %}

{% comment %}
[XX: attributes, properties, nodes, elements]
{% endcomment %}

## Run the mini web app {#run-mini}

In Dart Editor,
make sure that one of `mini`'s files or the directory is selected,
and then click the Run button
![Dart Editor's run button](images/run.png).

Dart Editor invokes Dartium
and loads `mini.html` in it.

![Mini app's output](images/mini-output.png).

##Create a JavaScript launch {#mini-with-js}

You can create various run-time scenarios for your Dart app
using *launches* in Dart Editor.
A launch specifies a run-time configuration,
such as whether to compile to JavaScript
or what browser to use.

In this section,
you will create a launch for `mini` app that compiles the app to
JavaScript and runs it in the default system browser.

<ol>
<li markdown="1">
In Dart Editor,
click the wee arrow to the right of the run button
![Dart Editor's run button](images/run.png).
A menu appears:

![Manage launches menu](images/manage-launches-menu.png)

You have been unwittingly using launches when running
the samples so far.
The menu item `mini.html` is a launch that Dart Editor
automatically created
when you ran the application for the first time.
</li>

<li markdown="1">
Select **Manage launches** from the menu
to bring up the **Manage Launches** dialog.
</li>

<li markdown="1">
Now, click the new launch button
![Manage launches menu](images/new-launch-button.png)

A menu appears that gives you three options:

![Manage launches menu](images/new-launch-menu.png)

A command-line launch runs in Dart Editor in
the **Output view**.
If your app is a command-line app (a `.dart` file with no `.html` file)
Dart Editor automatically creates a command-line launch
with the name of the `.dart` file that contains the `main` function.

A Dartium launch runs in a Chromium window invoked by Dart Editor.
If your app is a web app,
Dart Editor automatically creates a Dartium launch
with the name of the `.html` file that includes the Dart app.

You must explicitly create a Dart JavaScript launch
to create a run-time configuration that compiles
your web app to JavaScript and then runs it in a browser.
</li>

<li markdown="1">
Select **Dart JavaScript launch**.
The dialog window adjusts to present the appropriate options
for your selection.
</li>

<li markdown="1">
Name the launch by typing `mini-with-js` in the first text box.

![Manage JavaScript launch](images/create-new-js-launch.png)

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

![New launch in launch list](images/mini-with-js-item.png)
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

##Add a CSS File {#add-css}

Most HTML uses cascading style sheets to define _styles_
that control the appearance of page elements.
For example,
you might create a paragraph style 
to show code samples in an outlined box
using a fixed-width font.

Let's create a simple CSS file for the `mini` app.

In Dart Editor, create a file named `mini.css`
in your `mini` directory with the following text:

{% highlight dart %}
#RipVanWinkle {
  font-size: 20px;
  font-family: 'Open Sans', sans-serif;
  text-align: center;
  margin-top: 20px;
  background-color: #6A5ACD;
  color: #FFFF00;  
}
{% endhighlight %}

This creates a style sheet for the page element
with the ID `RipVanWinkle`.
The style sheet changes the font,
centers the text,
and sets the text and background color.

To use this style sheet,
edit `mini.html` and add the line shown in bold below:

![HTML with CSS](images/html-with-css.png)

Save your files and run the app again.

![Mini output with CSS](images/mini-output-with-css.png)

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

{% endcapture %}

{% include tutorial.html %}