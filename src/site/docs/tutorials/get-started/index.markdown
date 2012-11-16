---
layout: default
title: "Target 1: Get Started"
description: "Get Dart and run two Dart applications"
has-permalinks: true
tutorial:
  id: get-started
---

{% capture whats_the_point %}

* The Dart bundle has development tools, APIs, and samples.
* You can use Dart for web apps and command-line apps.
* Run Dart web apps directly in Dartium.
* Compile Dart apps to JavaScript for other browsers.
* All Dart apps have a main() function.
* Dart supports top-level functions.

{% endcapture %}

{% capture content %}

This target gets you ready
to begin writing web apps in Dart.
Here you will download the Dart software,
and use the Dart Editor to
create and run two small applications.

* [Download the Dart software bundle](#download-dart)
* [What did you get?](#what-did-you-get)
* [Start Dart Editor](#start-dart-editor)
* [About Dart applications](#what-is-app)
* [Create a command-line app](#create-cmd-line)
* [Run a command-line app](#run-cmd-line)
* [Create a web app](#create-web-app)
* [Run a web app in Dartium](#run-web-app)
* [About the HTML, CSS and Dart triumvirate](#source-files)
* [About main() and other top-level functions](#top-level-functions)
* [About file naming Conventions](#file-names)

##Download the Dart software bundle {#download-dart}

Go to the
[Downloads and Source](/downloads.html)
page and download the Dart software for your computer.
Be sure to download the package under **Everything you need**
because you will be using Dart Editor
throughout this tutorial.

##What did you get? {#what-did-you-get}

Unzip the file.
The resulting directory,
your *Dart installation directory*,
contains the following:

<div>
  <hr>
  <div class="row">
    <div class="span2">
    <img src="images/dart-editor-icon.png"
         width="77" height="93" alt="Dart Editor"/>
    </div>
    <div class="span7">
    Dart Editor is a powerful,
    lightweight, open source editor.
    With it you can create and edit files,
    manage the files and directories for your project,
    look up APIs, debug your code,
    and control runtime conditions using named launches.
    </div>
  </div>
  <hr>
  <div class="row">
    <div class="span2">
    <img src="images/chromium.png"
         width="81" height="89" alt="Dartium, a special Chromium build"/>
    </div>
    <div class="span7">
    This is a special build of the Chromium web browser, 
    called Dartium, that has the Dart VM (virtual machine) embedded.
    You can run your apps directly in this browser,
    or use Dart Editor to do it for you,
    thereby streamlining the build-test cycle.
    </div>
  </div>
  <hr>
  <div class="row">
    <div class="span2">
    <img src="images/dart-sdk-directory.png"
         width="86" height="94" alt="dart-sdk directory"/>
    </div>
    <div class="span7">
    The dart-sdk directory contains the Dart software development kit.
    Here you will find Dart libraries, such as dart:core and dart:html,
    that define APIs useful to all apps.
    Within, the bin directory contains several useful command-line tools,
    such as the Dart-to-JavaScript compiler,
    and the command-line version of the Dart VM.
    </div>
  </div>
  <hr>
  <div class="row">
    <div class="span2">
    <img src="images/samples-directory.png"
         width="81" height="91" alt="samples directory"/>
    </div>
    <div class="span7">
    The samples directory contains the complete source code
    for several Dart web applications.
    You can experiment with
    these examples in Dart Editor.
    </div>
  </div>
  <hr>
  <div class="row">
    <div class="span2">
    <img src="images/and-the-rest.png"
         width="81" height="71" alt="more directories"/>
    </div>
    <div class="span7">
    You might notice there are some other directories
    in the Dart installation directory.
    You can ignore them for now. 
    </div>
  </div>
  <hr>
</div>

## Start Dart Editor {#start-dart-editor}

Invoke Dart Editor by double-clicking its icon
in your Dart installation directory
<img src="/imgs/Dart_Logo_21.png"
     width="21" height="21" alt="Dart Editor icon">.

Dart Editor displays its Welcome Page
in a tab in the **Editor pane**.
The following diagram highlights
the features you need to know about now.

<img src="images/dart-editor-items.png"
     alt="Dart Editor's basic features">

Send feedback button
: Allows you to share bugs and requests
directly with the Dart Editor team
as well as the larger Dart team.

Search field
: Searches every file in your **Files view** for the entered text.
Results for text searches are displayed in a **Search view**.
Within that view,
double-click a file to see it in the **Editor pane**.
All occurrences of the search string in the **Editor pane** are highlighted.

Run button
: Runs the application associated with the file
that is currently selected in the **Files view**.

New application button
: Creates a directory and, within it,
the files for a new application.
Alternatively, you can use the
**File > New Application** menu item
or the **Create a new application** button
on the Welcome page.

Files view
: Shows a hierarchical view of your Dart applications
and their associated files.
Double-click a file in the **Files view** to see its contents
in the **Editor pane**.
If you single-click a file in the **Files view**,
the file is selected,
but not necessarily displayed in the **Editor pane**.
You must double-click the file.

Editor pane
: Provides the basic editing functionality you'd expect,
plus features such as Dart code completion,
API browsing, and support for refactoring.
The first time you use Dart Editor,
it shows the Welcome Page in the Editor pane,
which provides quick access to Dart resources
and some nifty samples.
The Welcome Page is also available under the **Tools** menu.

##About Dart applications {#what-is-app}

At minimum, a Dart application has

* one Dart source file&mdash;a
  file with the .dart suffix that contains Dart code
* one top-level main() function.
  This is the entry point for your application.
  main() is typically in a Dart source file whose basename is the app name.

There are two kinds of Dart applications:
command-line applications and web applications.
A command-line application is a standalone program
that you run in the Dart VM from the command-line.
Web applications are hosted on a web page and run in a browser
(either directly in a browser that supports Dart
or by compiling to JavaScript).

###Command-line applications

Dart command-line applications
run standalone from the command-line,
independent of a web browser.
Command-line apps are often used
to provide server-side support to a web app,
but they can also be scripts.

The Dart VM runs Dart code directly without intermediate compilation.

<img src="images/dartvm-cmd-line.png"
     alt="Run a command-line application without compilation">

Conveniently, you can run command-line apps
directly in Dart Editor with the click of the Run button
<img src="images/run.png" width="16" height="16"
     alt="Run button">.
Alternatively,
use the Dart VM tool
in the dart-sdk/bin directory in your Dart installation directory.

###Web applications

Dart web applications run inside of a browser page.
In addition to a .dart file,
a web app requires a .html file to host the app.
Often, a web app provides the client-side
user interface for a server.

You can run your Dart web app from Dart Editor
by clicking the Run button
<img src="images/run.png" width="16" height="16"
     alt="Run button">.
By default, Dart Editor will invoke Dartium,
which has the Dart VM embedded in it,
and loads your .html file,
which in turn loads your app.

<img src="images/dartvm-web-app.png"
     alt="Run a web application directly in a Dart-savvy browser">

If you want to see your web app in a browser
that does not yet support Dart,
you can compile your Dart code to JavaScript
using the Dart-to-JavaScript compiler,
which is in the dart-sdk/bin directory in your Dart installation directory.
You then load the resulting .js file
into your browser of choice.
Dart Editor makes this easy with launches,
which you will learn about in the next target.

<img src="images/dartvm-js.png"
     alt="Run a web application by compiling to JavaScript">

The rest of this target steps you through
creating and running first a command-line application
and then a web application.

##Create a command-line app {#create-cmd-line}

In Dart Editor, click the New Application button
<img src="images/newapp.png" width="15" height="16" alt="New App button"/>.
A dialog appears.

Follow these steps to create a command-line application:
<img src="images/new-helloworld.png"
     alt="Create a new command-line application"/>

<ol>
<li markdown="1">
Type helloworld in the **Application Name** text field.
By convention, application names are lower case.
This name is used for the app's directory
and the basename for the files it creates.
</li>

<li markdown="1">
Type or browse to the directory where you want to save the files.
By default, Dart Editor creates a new directory named dart
in your home directory.
</li>

<li markdown="1">
A command-line application does not need
the extra HTML and CSS files required by a web app,
so unselect **Generate content for a basic web app**.
</li>

<li markdown="1">
We are not working with public packages in this example,
so unselect **Add Pub support**.
</li>

<li markdown="1">
Click **Finish**.
</li>
</ol>

Dart Editor creates a new command-line app.
That is, it creates a new directory and a Dart source file
containing the top-level main () function.
The file hierarchy is displayed in the **Files view**.
The command-line app directory is called helloworld and
the source file is named helloworld.dart.

<img src="images/helloworld-files.png"
     alt="Dart Editor with new command-line app files"/>

The contents of helloworld.dart is shown in the **Editor pane**.
You might recognize it as the canonical Hello World program.

This program prints
`Hello, World!` to the standard output stream
using the print() function,
which is provided by the dart:core library.
The functions and objects defined in the core library
are automatically available to all Dart applications.

##Run a command-line app {#run-cmd-line}

Make sure either the helloworld directory or the helloworld.dart file
is selected in the **Files view**,
then click the Run button
<img src="images/run.png" width="16" height="16"
     alt="Run button">.

Dart Editor opens a new panel,
called the **Output view**,
and displays the output of the helloworld app.

<img src="images/helloworld-output.png"
     alt="Dart Editor with helloworld output view"/>

##Create a web app {#create-web-app}

Now let's create a web application.
As you did when creating a command-line application,
click the **New Application** button
<img src="images/newapp.png" width="15" height="16" alt="New App button"/>.
This time you are creating a web app,
so select **Generate content for a basic web app**.

<img src="images/new-click-me.png"
     alt="Create a new web application"/>

Dart Editor creates the directory and files needed
for a boilerplate web application.

<img src="images/click-me-files.png"
     alt="Dart Editor with new web application files"/>

As before, the directory is named after your application.
So is the Dart source file that contains the main() function.
In addition, Dart Editor creates an HTML file and a CSS file.

The main() function in the clickme app
contains Dart code 
that puts text on the browser page
and registers an *event handler*&mdash;a function
that responds to user-generated events like a mouse click.
This code uses API defined in the Dart HTML library.

In the next target,
you will build a mini app from scratch,
creating the Dart source, the HTML source,
and the CSS source yourself.
Afterward, you can re-visit the code for clickme.

##Run a web app in Dartium {#run-web-app}

To run clickme from Dart Editor,
make sure either the clickme directory or any of its files
is selected,
then click the Run button
<img src="images/run.png" width="16" height="16"
     alt="Run button">.

Dart Editor invokes Dartium, which loads the clickme app's HTML file,
and thus, loads the app.

<img src="images/click-me-app.png"
     alt="clickme app running in Dartium"/>

When you click the text, it reverses itself.

You can run Dart web applications in other browsers
by compiling to JavaScript.
You will do this in the next target,
when you learn about runtime configurations called launches.

<a name="source-files">
<h2><img src="../new-icon.png" width="48" height="48">About the HTML, CSS and Dart triumvirate</h2>

Typically three files, the HTML file, the Dart file, and the CSS file,
together implement a Dart web application.
Each is written in a different language
and each is responsible for a different aspect of the program:

| Language | Purpose |
|---|---|
| HTML | Describes the content of the document (the page elements in the document and the structure) |
| CSS | Governs the appearance of page elements |
| Dart | Implements the interactivity and dynamic behavior of the program |
{: .table}

HTML is a language for describing web pages.
Using tags, HTML sets up the initial page structure,
puts elements on the page,
and embeds any scripts for page interactivity.
It also establishes names and types for page elements,
called CSS selectors,
which allow HTML, CSS and Dart programs to refer to the same elements.

CSS, Cascading Style Sheets, describe the appearance
(the look and formatting) of the elements within a document.
CSS controls many aspects of formatting:
type face, font size, color, background color,
borders, margins, an alignment, to name a few.

Dart code is embedded into an HTML file as a script.
A Dart program can
respond to events such as mouse clicks,
manipulate the elements on a web page dynamically,
and can save information.

##About main() and other top-level functions {#top-level-functions}

Dart lets you define _top-level_ functions,
that is, functions that are not encapsulated within a class or object.
All apps have at least one top-level function,
namely the main() function.

The two apps you've seen in this target have other top-level functions.
The Hello World example calls print(),
a top-level function defined in dart:core.
And the clickme app defines a top-level function called reverseText().

A function declaration
has two parts: a _signature_ and a _body_.

<img src="images/function-parts.png"
     alt="Two parts of a function, the signature and the body"/>

The signature sets the function name,
the data type of its return value,
and the number and type of its input arguments.

<img src="images/declaration-parts.png"
     alt="The parts of a function declaration"/>

The body is code contained
within a matching pair of curly braces
that defines the function's behavior.
The milesToKM() function performs a simple arithmetic calculation
and returns the result.

This function takes a single argument.
Functions can take multiple arguments,
in which case, the arguments are set apart by commas.

In our previous examples,
main() does not have a return value
(as indicated by void)
and does not take any arguments
(as indicated by the empty parentheses),
but, like any other function, it could have both.

##About file naming conventions {#file-names}

When creating an application with Dart Editor,
you are asked to provide an application name.
By convention, application names,
and thus, the related files and directories, are lower case.

As you saw,
Dart Editor uses the application name for:

* the name of the app's directory
* the basename of the main Dart file
(the Dart file that contains the main() function)
* the basename of the primary HTML file
* the basename of the primary CSS file

You should also follow these conventions
when creating applications outside of Dart Editor.

<div class="row">
  <div class="span3">
  <a href="/docs/tutorials/"><i class="icon-chevron-left"> </i> Home</a>
  </div>
  <div class="span3">
<a href="http://code.google.com/p/dart/issues/entry?template=Tutorial%20feedback"
 target="_blank">
<i class="icon-comment"> </i>
Send feedback
</a>
  </div>
  <div class="span3">
  <a href="/docs/tutorials/connect-dart-html/" class="pull-right">Connect Dart &amp; HTML <i class="icon-chevron-right"> </i></a>
  </div>
</div>

{% endcapture %}

{% include tutorial.html %}