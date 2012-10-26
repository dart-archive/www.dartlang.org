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
* You can use Dart to create web apps and command-line apps.
* Run Dart web apps directly in Dartium.
* Compile Dart apps to JavaScript for other browsers.
* All Dart apps have a main() function.
* Dart supports top-level functions.

{% endcapture %}

{% capture code_links %}
<ul>
<li>
   <a href="examples/helloworld/helloworld.dart.txt" target="_blank">
      helloworld.dart</a>
</li>
<li>
   <a href="examples/clickme/clickme.dart.txt" target="_blank">
      clickme.dart</a>
</li>
<li>
   <a href="examples/clickme/clickme.html.txt" target="_blank">
      clickme.html</a>
</li>
<li>
   <a href="examples/clickme/clickme.css.txt" target="_blank">
      clickme.css</a>
</li>
</ul>
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
* [Two kinds of Dart applications](#what-is-app)
* [Create a command-line app](#create-cmd-line)
* [Run a command-line app](#run-cmd-line)
* [Create a web app](#create-web-app)
* [Run a web app in Dartium](#run-web-app)
* [About main() and other top-level functions](#top-level-functions)
* [About string literals](#strings)
* [About file naming Conventions](#file-names)
{% comment %}
* [9-dart finish](#9-dart-finish)
{% endcomment %}

##Download the Dart software bundle {#download-dart}

{% comment %}
[XX: instead of sending them away,
I would prefer to have the download buttons and instructions here]
{% endcomment %}

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
     width="606" height="410" alt="Dart Editor's basic features">

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

##Two kinds of Dart applications {#what-is-app}

A Dart application has
at least one Dart source file
(a file with the .dart suffix)
and one of its Dart files must contain
a main() function.
The main() function
is the entry point for your application.

There are two kinds of Dart applications:
command-line applications and web applications.
You run command-line applications in the Dart VM from the command-line.
Web applications are hosted on a web page and run in a browser
(either directly in a browser that supports Dart
or by compiling to JavaScript).

###Command-line applications

Dart command-line applications
run stand alone from the command-line,
independent of a web browser.
Command-line apps are often used
to provide server-side support to a web app,
but they can also be scripts.

The Dart VM runs Dart code directly without intermediate compilation.

<img src="images/dartvm-cmd-line.png" width="489" height="109"
     alt="Run a command-line application without compliation">

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

<img src="images/dartvm-web-app.png" width="581" height="251"
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

<img src="images/dartvm-js.png" width="613" height="270"
     alt="Run a web application by compiling to JavaScript">

The rest of this target steps you through
creating and running first a command-line application
and then a web application.

##Create a command-line app {#create-cmd-line}

Follow these steps to create a command-line application:

<ol>
<li>
In Dart Editor, click the New Application button
<img src="images/newapp.png" width="15" height="16" alt="New App button"/>.
A dialog appears.

<img src="images/new-helloworld.png" width="524" height="366"
     alt="Create a new command-line application"/>
</li>

<li markdown="1">
Type helloworld in the **Application Name** text field.
</li>

<li markdown="1">
A command-line application does not need
the extra files required by a web app,
so unselect **Generate content for a basic web app**.
Also unselect **Add Pub support**.
</li>

<li markdown="1">
Click **Finish**.
</li>
</ol>

Notice in the **Files view** that
Dart Editor created a directory called helloworld and within
it a Dart source file named helloworld.dart.
The contents of
helloworld.dart is shown in the **Editor pane**.
You might recognize it as the canonical Hello World program.

<img src="images/helloworld-files.png" width="604" height="282"
     alt="Dart Editor with new command-line app files"/>

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

<img src="images/helloworld-output.png" width="562" height="337"
     alt="Dart Editor with helloworld output view"/>

{% comment %}
###From the Command-line
You can also run the application from the command-line in a terminal window.
The Dart VM is in the `dart-sdk/bin` directory
in your Dart installation directory.
{% comment %}
[XX: could probably help them set the path]
{% endcomment %}
Presuming that you have added 
`dart-sdk/bin` to your `$PATH` environment variable,
you can run the Dart VM as follows:

{% highlight dart %}

% dart helloworld.dart
Hello, World!
%

{% endhighlight %}
{% endcomment %}

##Create a web app {#create-web-app}

Now let's create a web application.

<ol>
<li markdown="1">
As you did when creating a command-line application,
click the **New Application** button
<img src="images/newapp.png" width="15" height="16" alt="New App button"/>.
</li>

<li markdown="1">
Type clickme in the **Application Name** text field.
</li>

<li markdown="1">
This time you are creating a web app,
so select **Generate content for a basic web app**.
Again leave **Add Pub support** unselected.
</li>

<li markdown="1">
Click **Finish**.
</li>
</ol>

<img src="images/new-click-me.png" width="523" height="284"
     alt="Create a new web application"/>

As before, Dart Editor creates a directory named after your application,
and a .dart file.
In addition, it also creates a .html file
and a .css file.
The HTML file contains the code necessary to include your Dart app
in a browser page.
The CSS file sets the styles
for the page and its elements,
(for example, fonts and colors).

<img src="images/click-me-files.png" width="589" height="293"
     alt="Dart Editor with new web application files"/>

The main() function contains two lines of code 
that puts text on the browser page
and registers an *event handler*,
a function that responds to user-generated events like a mouse click.
It uses APls defined in the Dart HTML library.

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

<img src="images/click-me-app.png" width="335" height="341"
     alt="clickme app running in Dartium"/>

When you click the text
**Click me!**,
it spins.

You can run Dart web applications in other browsers
by compiling to JavaScript.
You will do this in the next target,
when you learn about runtime configurations called launches.

##About main() and other top-level functions {#top-level-functions}

Dart lets you define _top-level_ functions,
that is, functions that are not encapsulated within a class or object.
You've already seen several top-level functions.
In all apps, the main() function is a top-level function.
The Hello World example uses print(),
a top-level function defined in dart:core.
And the clickme ap defines a top-level function called rotateText().

A function has two parts: a _declaration_ and a _definition_.

<img src="images/function-parts.png" width="359" height="66"
     alt="Two parts of a function"/>

The declaration sets the function name,
the data type of its return value,
and the number and type of its input arguments.

<img src="images/declaration-parts.png" width="369" height="150"
     alt="The parts of a function declaration"/>

The definition is code contained
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

##About string Literals {#strings}

Text between single quotes
defines a string literal.
You can also use double quotes.
Strings are a built-in type in Dart.
They support expression evaluation,
concatenation, and multi-line strings.

{% comment %}
[XX: elaborate about multi-line strings, etc.]
{% endcomment %}

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

You should also follow these conventions.

{% comment %}
##9-dart finish {#9-dart-finish}

[XX: think of good questions]

Should be able to answer questions about these:

* key files of a cmd-line app
* key files of a web app
* how to create an app in Dart Editor
* how to run an app in Dart Editor
* main() function
* print() function
* ??
{% endcomment %}

{% endcapture %}

{% include tutorial.html %}