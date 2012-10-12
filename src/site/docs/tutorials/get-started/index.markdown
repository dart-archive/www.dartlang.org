---
layout: default
title: "Target 1: Get Started"
description: "Download Dart and run two Dart applications"
has-permalinks: true
tutorial:
  id: gs-index
---

{% capture whats_the_point %}

* All Dart apps have a main function.
* Run Dart Web apps in Dartium.
* Compile Dart apps to JavaScript for other browsers.
* Use Dart to write command-line apps also.
* Dart Editor is a full-function editor.

{% endcapture %}

{% capture content %}

When you have completed this Target,
you will have successfully downloaded the Dart software,
used the Dart Editor to
create and run two small applications,
and will be ready to begin writing Web apps in Dart.

* [Download the Dart software bundle](#download-dart)
* [What did you get?](#what-did-you-get)
* [What is a Dart application?](#what-is-app)
* [Start Dart editor](#start-dart-editor)
* [Create a command-line app](#create-cmd-line)
* [main and other top-level functions](#top-level-functions)
* [Run a command-line app](#run-cmd-line)
* [Create a web app](#create-web-app)
* [Run a web app in Dartium](#run-web-app)
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
page and download the Dart software for your system.
Be sure to download the package under **Everything you need**
because you will be using Dart Editor
throughout this tutorial.

##What did you get? {#what-did-you-get}

The Dart download is a complete Dart development environment
that includes Dart Editor and other tools,
libraries, and sample programs.

<div>
  <hr>
  <div class="row">
    <div class="span2">
    <img src="images/dart-editor-icon.png"/>
    </div>
    <div class="span7">
    Dart Editor is a powerful,
    lightweight, open source editor.
    With it you can create and edit files,
    manage the files for your project,
    look up API, debug your code,
    and control run-time conditions using named launches.
    </div>
  </div>
  <hr>
  <div class="row">
    <div class="span2">
    <img src="images/chromium.png"/>
    </div>
    <div class="span7">
    Your download contains a special build of the chromium web browser, 
    called Dartium, that includes the Dart VM.
    When you run a web app in Dart Editor,
    it launches Dartium and loads your app.
    </div>
  </div>
  <hr>
  <div class="row">
    <div class="span2">
    <img src="images/dart-sdk-folder.png"/>
    </div>
    <div class="span7">
    This directory contains the complete Dart Software Development Kit.
    Here you will find Dart libraries, such as dart.core and dart.html,
    that define APIs useful to all apps.

    Within, the bin directory contains several useful command-line tools,
    such as the Dart->JavaScript compiler,
    and the command-line version of the Dart VM.
    </div>
  </div>
  <hr>
  <div class="row">
    <div class="span2">
    <img src="images/samples-folder.png"/>
    </div>
    <div class="span7">
    The samples directory contains the source code
    for several Dart web applications.
    You can investigate and run these complete examples
    directly from the Welcome page in Dart Editor.
    </div>
  </div>
  <hr>
  <div class="row">
    <div class="span2">
    <img src="images/and-the-rest.png"/>
    </div>
    <div class="span7">
    You will notice there are some other directories
    in the dart installation directory.
    You can ignore them for now. 
    </div>
  </div>
  <hr>
</div>

##What is a Dart application? {#what-is-app}

A Dart application is comprised of
at least one Dart source file
(a file with the `.dart` suffix)
and the `main` function,
which is the entry point for your application.
You run Dart applications with
the Dart VM (Virtual Machine),
which can run from the command-line
or can be embedded in another program,
like a web browser.

There are two kinds of Dart applications:

A _command-line application_

: runs stand-alone from the command line,
independent of a Web browser.
The Dart VM runs Dart code directly without intermediate compilation.

![Running a Command-line Application](images/dartvm-cmd-line.png)

Command-line apps are often used
to provide server-side support to a Web app.

Dart is a general-purpose,
object-oriented language
with support for files, directories,
sockets and even web-servers.
You can use Dart for full end-to-end applications,
such as server-side scripts,
stand-alone applications and servers.

Conveniently, you can run command-line apps
directly in Dart Editor with the click of a button.
Alternatively,
use the `dart` executable file
in the `dart-sdk/bin` directory.

A _Web application_

: runs inside of a browser page.
In addition to a `.dart` file,
a Web app requires a `.html` file to host the app.
Often, a Web app provides the client-side
user interface for a server.

Dart Web applications are HTML5-compliant applications.
HTML5 is a descriptive markup language
for structuring and presenting content on the Web.
Modern browsers model the structure of
a Web app with a tree-node structure
defined by the Document Object Model (DOM).

You can run your Dart Web app from Dart Editor
by clicking the run button.
Though you can configure various run-time environments,
by default, Dart Editor invokes Dartium,
which has the Dart VM embedded in it,
and loads your `.html` file,
which in turn loads your app.

![Running a Web Application](images/dartvm-web-app.png)

If you want to see your Web app in a browser
that does not yet support Dart,
you can compile your Dart code to JavaScript
using the Dart->JavaScript tool
and load the resulting `.js` file
into your browser of choice.

![Running a Web Application](images/dartvm-js.png)

Dartboard's primary objective is to teach you how to
write Dart Web apps.
It provides enough information about HTML5 and the DOM
to get you successfully programming Web apps in Dart,
but does not cover them exhaustively.

Let's run a couple of apps
that are created automatically by Dart editor.

## Start Dart editor {#start-dart-editor}

Invoke Dart Editor by double-clicking its icon
in your Dart installation directory 
![Dart Editor icon](images/dart-editor-icon.png)

Here's a diagram showing you the features
you need to know about now:

![Dart Editor](images/dart-editor-items.png)

Send feedback button
: allows you to share bugs and requests directly
with the Dart Editor team as well as the larger Dart team.

Search box
: searches every file in your **Files view** for the entered text.
Results for text searches come up in a **Search view**.
Within that view,
double-click a file to see it in the **Editor pane**.
All occurrences of the search string in the **Editor pane** are highlighted.

Run button
: runs the application associated with the file
that is currently selected in the **Files view**.

New App button
: creates a directory and, within it,
the files for a new application.
Alternatively, you can use the
**File > New Application** menu item
or the **Create a new application** button
on the Welcome page.

Files view
: shows a hierarchical view of your Dart applications
and their associated files.
Double-click a file in the **Files view** to see its contents
in the Editor pane.
NOTE: if you just single-click on a file in the **Files view**,
the file is selected,
but NOT necessarily displayed in the **Editor pane**.
You must double-click the file.

Editor pane
: provides the basic editing functionality you'd expect,
plus features such as Dart code completion,
API browsing, and support for refactoring.

##Create a command-line app {#create-cmd-line}

Follow these steps to create an application:

Step One:
: In Dart Editor, click the New Application button
![New App button](images/newapp.png).
A dialog appears.

![New Application Dialog](images/new-helloworld.png)

Step Two:
: Type `helloworld` in the **Application Name** text box.

Step Three:
: A command-line application does not need
the extra files required by a Web app,
so unselect **Generate content for a basic Web app**.
Also unselect **Add Pub support**.

Step Four:
: Click **Finish**.
Notice in the **Files view** that
Dart Editor created a directory called `helloworld` and within
it a Dart source file named `helloworld.dart`.
The contents of
`helloworld.dart` is shown in the **Editor pane**.
You might recognize it as the canonical Hello World program.

![Dart Editor with Hello World](images/helloworld-files.png)

By convention:

* filenames are lower-case
* the name of the app's directory is the name of the application
* an app's directory contains all of the files related to the app
* the `main` function is contained in the main file of the app
* the main app file is named after the application and has the `.dart`
  suffix
* a Web app also has an HTML file with the `.html` suffix
  and whose basename is the application name

Dart Editor does all of this by default
when you create a new application.

##main and other top-level functions {#top-level-functions}

Dart allows you to define _top-level_ functions,
that is, functions that are not encapsulated within a class or object.
`main` is a top-level function.
Every Dart application _must_ have exactly on `main` function.
It is the entry point for your application
whether a command-line app or a browser app.

A function has two parts: a _declaration_ and a _definition_.

The declaration sets the function name,
the return type, and the list of arguments.
In this example,
`main` does not have a return value
(as indicated by `void`)
and it does not take any arguments
(as indicated by the empty parentheses),
but, like any other function, it could have both.

The definition of a function is contained
within a matching pair of curly braces.
In our example, `main` contains a single
line of code that
prints the text `Hello,World!` to the standard output stream.
using the `print` function.
`print` is top-level function
provided by the `dart.core` library.
The functions and objects defined in the core library
are automatically available to all Dart applications.

##Run a command-line app {#run-cmd-line}

Now run your command-line application.
Make sure either the `helloworld` directory or the `helloworld.dart` file
is selected in the **Files view**, then click the green run button.

Dart Editor opens a panel at the bottom of its window,
called the **Output view** and displays
the output of the `helloworld` app.

![Hello World output](images/helloworld-output.png)

You can also run the application from the command-line in a terminal window.
The Dart VM is in the `dart-sdk/bin` directory
in your dart installation.
{% comment %}
[XX: could probably help them set the path]
{% endcomment %}
Presuming that you have added this directory to your `$PATH` environment
variable, you can run the Dart VM as follows:

{% highlight dart %}

% dart helloworld.dart
Hello, World!
%

{% endhighlight %}

##Create a web app {#create-web-app}

Now let's create a Web application.
As before, click the **New Application** button
![New App button](images/newapp.png).

Type `clickme` in the **Application Name** text box.
This time you are creating a Web app,
so select "Generate content for a basic Web app".
Again leave "Add Pub support" unselected.
Click **Finish**.

![New Application Dialog](images/new-click-me.png)

As before, Dart Editor creates a directory named after your application,
and a `.dart` file.
In addition, it also creates a `.html` file
and a `.css` file.
The HTML file contains the code necessary to include your Dart app
in a browser page.
The CSS file sets the styles,
(for example, fonts and colors,)
for the page and its elements.

![clickme app's files](images/click-me-files.png)

{% comment %}
[XX: what to talk about
in this code?
again with the main function. wave hands. import dart.html]
{% endcomment %}

We are going to ignore the code for this application for now.
In the next Target,
you will build a Web app and learn how the files fit together,
how an app runs in a browser,
and what its underlying structure is.

##Run a web app in Dartium {#run-web-app}

To run `clickme`,
make sure either the `clickme` directory or any of its files
is selected,
then click the green run button.

Dart Editor invokes Dartium and loads the `clickme` app.

![clickme app running in Dartium](images/click-me-app.png)

When you click on 
**Click Me!** 
the text spins.

In the next Target,
you will learn how to create a 
run-time configuration, called a _launch_,
that compiles an app to JavaScript
and runs it in the default system browser.

{% comment %}
##9-dart finish {#9-dart-finish}

[XX: think of good questions]

Should be able to answer questions about these:

* key files of a cmd-line app
* key files of a web app
* how to create an app in Dart Editor
* how to run an app in Dart Editor
* main function
* print function
* etc
{% endcomment %}

{% endcapture %}

{% include tutorial.html %}