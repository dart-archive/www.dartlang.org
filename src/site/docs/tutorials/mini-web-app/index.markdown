---
layout: default
title: "Target 2: Build a Mini Web App"
description: "Describes the components of a basic Dart Web app."
has-permalinks: true
tutorial:
  id: mini-web-app
---

{% capture whats_the_point %}

* Dart Editor is an editor and a set of developer tools.
* All Dart apps require a top-level `main` function.
* A Dart Web app needs both a `.dart` file and an `.html` file.
* An `.html` file hosts your Web app in a browser page.
* Create structure to your app with the `document` object.
* Use a `.css` file to set styles for visible elements.
* Control run-time configurations with named launches.
* Compile to JavaScript to run in any browser.

{% endcapture %}

{% capture content %}

# {{ page.title }}

The Dart Web application you will create and run
in this Target is a bare bones, stripped-down application,
containing just enough code to
display text on a browser page.
It has even less code than the default Web app created by Dart Editor.
We've stripped it down to just the essentials
to illustrate core principles.

* [Create a new Dart app](#create-dart-app)
* [Using Dart Editor happiness](#dart-editor-happiness)
* [Code Walk-through of Mini App](#code-walk)
* [Understanding Basic HTML](#understand-html)
* [Create the HTML file](#create-html)
* [Introduction to the DOM](#dom-intro)
* [Run the mini web app](#run-mini)
* [Compile mini to JavaScript and run it](#mini-with-js)
* [Add a CSS file](#add-css)
{% comment %}
* [9-dart finish](#9-dart-finish)
{% endcomment %}

## Create a new Dart app {#create-dart-app}

In Dart Editor, create a new application called `mini`.
Even though you are creating a Web app,
unselect "Generate content for a basic web app".
We will be building the files we need from scratch.
Make sure that "Add Pub support" is also unselected
and click **Finish**.

![New App dialog window](images/new-app-mini.png)

Dart Editor creates a directory called `mini` and, within it,
a Dart source file named `mini.dart`
that contains the Dart code for a default command-line application.

{% comment %}
![After New App Created](images/new-app-files.png)
{% endcomment %}

##Using Dart Editor happiness {#dart-editor-happiness}

In this step,
use Dart Editor
to modify the source code
to look like this:

{% highlight dart %}
import 'dart:html';
void main() {
  query('#RipVanWinkle').text = 'Wake up, sleepy head!';
}
{% endhighlight %}

You might notice that Dart Editor
is busy processing the code as you type.
Dart Editor is doing code-completion and API lookup.

Errors
: Begin typing the first line of code,
the `import` directive,
and stop just after you type the first single quotation mark.
You will see a small red 'x'
in the gutter on the left side of the **Editor pane**.
This means that Dart Editor has detected an error.
Hover the mouse over the red 'x' and 
an error message will be displayed in a tooltip:
{% highlight dart %}
Unexpected token 'ILLEGAL' (expected 'STRING')
{% endhighlight %}
Finish typing the complete line of code and the red 'x' disappears.

Warnings
: Delete the line of code with `print` and start typing
`query(` stopping just after you type the first parenthesis
and before you type '#RipVanWinkle'.
A small yellow warning symbol appears in the left-hand gutter.
The tooltip says:
{% highlight dart %}
missing argument of type String
{% endhighlight %}
Finish typing the line.

API Lookup
: Now hover the mouse over the word `query`,
Dart Editor displays the signature for that function in a tooltip:
{% highlight dart %}
Element query(String selector)
{% endhighlight %}
`query` is a top-level function
defined in the Dart HTML library.

Finish your edits,
and save the file with **File > Save**.

##Code Walk-through of Mini App {#code-walk}

Let's take a look at this mini Dart program.

####Importing Libraries

![Code Walk-through of mini.dart](images/0-mini-code-walk-through.png)

The `import` directive imports the specified library,
making available to your program
all of the classes and functions
in that library.
In this example, the program imports
Dart's HTML library,
which contains the classes needed
for programming the DOM.
This library is HTML5-compliant.
Generally speaking,
all Dart Web apps need the Dart HTML library.
Key classes include Document, Element,
List\<Element> (a list containing elements),
and Window.

####The main function

![Code Walk-through of mini.dart](images/1-mini-code-walk-through.png)

This app's `main` function contains a single
line of code that is a little like a run-on sentence
with multiple things happening one after another.
Let's de-construct it.

####Identifiers and String Literals

![Code Walk-through of mini.dart](images/3-mini-code-walk-through.png)

Text between single quotes
defines a string literal.
Our code uses two.
You can also use double quotes.

Strings are a built-in type in Dart.
They support expression evaluation,
concatenation, and multi-line strings.

{% comment %}
[XX: probably should show examples of the above]
{% endcomment %}

####Query and QueryAll

![Code Walk-through of mini.dart](images/2-mini-code-walk-through.png)

`query` is a top-level function declared in the HTML library
that gets objects from the browser page.
Our program uses `query` along with the HTML identifier "RipVanWinkle"
to get a paragraph element that is defined on the HTML side.
You will see this 
when you create the HTML file for this Web app.
{% comment %}
[XX: what's the deal with the hash mark? it's in .dart, but not in .html?]
HTML identifiers begin with a hash mark.
{% endcomment %}

The argument to `query` identifies the page element.
The selector can be an ID, like it is in this example,
or it can be any CSS selector,
such as class, attribute, or tag-type.
You'll learn more about CSS below.

Another useful function for getting elements from the browser page
is `queryAll`,
which returns multiple page elements via
a list of elements--`List<Element>`--all
of which match the provided selector.

####Text Property of an Element

![Code Walk-through of mini.dart](images/4-mini-code-walk-through.png)

The highlighted code refers to the text property
of the RipVanWinkle paragraph element.

{% comment %}
[XX: is that true? is it a property? anything else I need to say here]
{% endcomment %}

![Code Walk-through of mini.dart](images/5-mini-code-walk-through.png)

And finally it sets the text property
to the string "Wake up, sleepy head!",
with the effect of displaying the message
within the area on the browser page provided for the Web app.

## Understanding basic HTML {#understand-html}

To display a Web app on a browser page,
you need an HTML file to host the Web app.

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
The example below shows several common presentational tags:

{% comment %}
[XX: show resulting text side-by-side with this]
{% endcomment %}

{% highlight html %}
<i>Italic</i> text is for titles.
Use <b>bold</b> text for emphasis.
<code>Code</code> text is usually set in a fixed-width font.
{% endhighlight %}

Hyper-text markup tags let you link to another page,
include images, or include apps.
In the next step,
we'll see an example of a hyper-text markup tag
for including a Dart app.

## Create an HTML File {#create-html}

Now, let's create the HTML for your mini Web app.

In Dart Editor, select **File > New File**.
Follow convention and use the application name
for the file's basename and the `.html` suffix: `mini.html`.
The Dart Editor auto-fills the file with some default HTML code.
There is more code than is necessary,
so replace the default contents with the following,
slightly simplified, HTML.

{% highlight html %}
<!DOCTYPE html>

<html>
  <head>
    <title>A Minimalist Web App</title>
  </head>

  <body>
    <p id="RipVanWinkle"></p>
    <script type="application/dart" src="mini.dart"></script>
    <script src="http://dart.googlecode.com/svn/branches/bleeding_edge/dart/client/dart.js"></script>
  </body>
</html>
{% endhighlight %}

You can see the use of the `head`, `title`, `body`, `p` tags.
And there, in the paragraph tag,
is the identifier "RipVanWinkle"
that the Dart code used
as an argument to `query` to get the paragraph element.

`id="RipVanWinkle"`
is an example of an HTML _attribute_.
Attributes provide extra detail for a page element.
The `id` attribute provides a document-wide identifier.
Another useful attribute is `class`,
which you can use to classify elements.

A script is another structural element whose
content is defined by a client-side script.
The HTML code above has two.
The first includes the Dart mini app.
It uses two attributes: `type` indicates the type of the script.
`application/dart` is a new type created by the Dart team,
which is currently supported by Dartium.
The `src` attribute provides the URL to the source file of the script.
In this case, the Dart source file `mini.dart` that you created earlier.
The Dart file should be in the same directory as the HTML file.

{% comment %}
[XX: is the following true?]
The second use of the `script` tag provides the URL
for the Dart VM written in JavaScript.
{% endcomment %}

Finish your edits and save the file with **File > Save**.

This diagram summarizes the connection
between `mini.dart` and `mini.html`.

![HTML Dart and DOM](images/dart-html-connect.png)

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

In addition to the `query` and `queryAll` functions,
a Dart Web app has a top-level document object
created automatically by the Dart VM,
which is a reference to the document object in the DOM.
You can refer to it with the name `document`
anywhere in your Dart Web app.
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

{% comment %}
[XX: attributes, properties, nodes, elements]
{% endcomment %}

## Run the mini Web app {#run-mini}

In Dart Editor,
make sure that one of `mini`'s files or the directory is selected,
and then click the Run button
![Dart Editor's run button](images/run.png).

Dart Editor invokes Dartium
and loads `mini.html` in it.

You should see this greeting:

![Mini app's output](images/mini-output.png).

##Compile Mini to JavaScript and Run it {#mini-with-js}

You can create various run-time scenarios for your Dart app
using *launches* in Dart Editor.
A launch specifies run-time configurations,
such as whether to compile to JavaScript
or what browser to use.

You have been unwittingly using launches in Dart Editor
when you ran the default applications in the previous Target.
Dart Editor automatically creates a default launch
when you run an application for the first time.

In this section,
you will create a launch for `mini` app that compiles the app to
JavaScript and runs it in the default system browser.

####Three Launch Types

A command-line launch runs in Dart Editor in
the **Output view**.
If your app is a command-line app (a `.dart` file with no `.html` file)
Dart Editor automatically creates a command-line launch
with the name of the `.dart` file that contains the `main` function.

A Dartium launch runs in a Chromium window invoked by Dart Editor.
If your app is a Web app
Dart Editor automatically creates a Dartium launch
with the name of the `.html` file that includes the Dart app.

You must explicitly create a Dart JavaScript launch
to create a run-time configuration that compiles
your Web app to JavaScript and then runs it in a browser.
Let's do that now.

####Create a Launch

Step One:
: In Dart Editor, bring up the *Manage Launches* dialog window
either with **Run->Manage Launches**
or by clicking the wee arrow to the right of the
run button
![Dart Editor's run button](images/run.png).

You should see a launch in the panel to the left called `mini.html`.
Dart Editor created this launch automatically
when you ran the app in the previous step.

Step Two:
: To create a new launch click
the New Launch button
[XX: insert icon image here].
A menu pops up providing you with three choices:

* Dart Command-line launch
* Dart JavaScript launch
* Dartium launch

Step Three:
: Select **Dart JavaScript Launch**.

The dialog window adjusts to present the appropriate options
for your selection.

Step Four:
: Name the launch.
Type 'mini using JavaScript' in the first text box.
This is the name of your launch.
It is recommended that the launch name reflect
the important aspects of its configuration.
In this case, the launch name specifies the app name
and that it's a JavaScript launch.
If the launch specified a browser, such as FireFox,
you might name the launch 'mini using JavaScript in FireFox'.

Step Five:
: The launch target is the HTML file `mini.html`.
Type in the pathname or browse to the file.

Step Six:
: Click **Apply**.

The named launch should now appear in the menu under the run button.

####Run the Launch

To run the launch, simply select it from the menu.
This time, Dart Editor
creates a JavaScript file,
invokes the default system browser
and loads the JavaScript file into it.
The output should look the same.

##Add a CSS File {#add-css}

Most HTML uses CSS--cascading style sheets--to define
_styles_ that set the appearance of page elements.
For example,
you might create a paragraph style 
for code samples that set the code in an outlined box,
shaded in gray, using a fixed-width font.

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

Now edit `mini.html`, adding the line shown in bold below:
[XX: how do I show a line in bold?]

{% highlight dart %}
<!DOCTYPE html>

<html>
  <head>
    <title>A Minimalist Web App</title>
    <link rel="stylesheet" href="mini.css">
  </head>
  <body>
    <p id="RipVanWinkle"></p>
    <script type="application/dart" src="mini.dart"></script>
    <script src="http://dart.googlecode.com/svn/branches/bleeding_edge/dart/client/dart.js"></script>
  </body>
</html>
{% endhighlight %}

Save your files and run the app again.

![Mini output with CSS](images/mini-output-with-css.png)

[XX: describe link tag]
[XX: talk about IDs]
[XX: blah blah blah about CSS styles]

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
