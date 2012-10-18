---
layout: default
title: "Target 1: Get Started"
description: "Download Dart and run two Dart applications"
has-permalinks: true
tutorial:
  id: gs-index
---

{% capture whats_the_point %}

* The Dart bundle has development tools, APIs, and samples.
* You can use Dart to create web apps and command-line.
* Run Dart Web apps directly in Dartium.
* Compile Dart apps to JavaScript for other browsers.
* Dart Editor can be your development hub.
* All Dart apps have a main function.
* Dart supports top-level functions.

{% endcapture %}

{% capture content %}

This target gets you ready
to begin writing Web apps in Dart.
You download the Dart software,
and use the Dart Editor to
create and run two small applications.

* [Download the Dart software bundle](#download-dart)
* [What did you get?](#what-did-you-get)
* [Start Dart Editor](#start-dart-editor)
* [What is a Dart application?](#what-is-app)
* [Create a command-line app](#create-cmd-line)
* [Run a command-line app](#run-cmd-line)
* [Create a web app](#create-web-app)
* [Run a web app in Dartium](#run-web-app)
* [main and other top-level functions](#top-level-functions)
* [File-naming Conventions](#file-names)
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

Unzip the file.
The resulting directory,
your *Dart installation directory*,
contains the following:

<div>
  <hr>
  <div class="row">
    <div class="span2">
    <img src="images/dart-editor-icon.png" alt="Dart Editor"/>
    </div>
    <div class="span7">
    Dart Editor is a powerful,
    lightweight, open source editor.
    With it you can create and edit files,
    manage the files for your project,
    look up APIs, debug your code,
    and control run-time conditions using named launches.
    </div>
  </div>
  <hr>
  <div class="row">
    <div class="span2">
    <img src="images/chromium.png" alt="Dartium"/>
    </div>
    <div class="span7">
    This is a special build of the Chromium web browser, 
    called Dartium, that has the Dart VM (virtual machine) embedded.
    You can run your apps directly in this browser,
    or use Dart Editor to do it for you,
    thereby stream-lining the build-test cycle.
    </div>
  </div>
  <hr>
  <div class="row">
    <div class="span2">
    <img src="images/dart-sdk-folder.png" alt="dart-sdk"/>
    </div>
    <div class="span7">
    The `dart-sdk` directory contains the Dart software development kit.
    Here you will find Dart libraries, such as `dart:core` and `dart:html`,
    that define APIs useful to all apps.
    Within, the `bin` directory contains several useful command-line tools,
    such as the Dart-to-JavaScript compiler,
    and the command-line version of the Dart VM.
    </div>
  </div>
  <hr>
  <div class="row">
    <div class="span2">
    <img src="images/samples-folder.png" alt="samples"/>
    </div>
    <div class="span7">
    The sample directory contains the complete source code
    for several Dart web applications.
    You can experiment with
    these examples in Dart Editor.
    </div>
  </div>
  <hr>
  <div class="row">
    <div class="span2">
    <img src="images/and-the-rest.png" alt="more folders"/>
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
![Dart Icon](/imgs/Dart_Logo_21.png).

Dart Editor displays a Welcome Page
in a tab in the **Editor pane**.
The following diagram highlights
the features you need to know about now.

![Dart Editor](images/dart-editor-items.png)

Send feedback button
: Allows you to share bugs and requests
directly with the Dart Editor team
as well as the larger Dart team.

Search box
: Searches every file in your **Files view** for the entered text.
Results for text searches are displayed in a **Search view**.
Within that view,
double-click a file to see it in the **Editor pane**.
All occurrences of the search string in the **Editor pane** are highlighted.

Run button
: Runs the application associated with the file
that is currently selected in the **Files view**.

New App button
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

##What is a Dart application? {#what-is-app}

Before you create a Dart application,
let's define the types of Dart applications
and how you can run them.

A Dart application has
at least one Dart source file
(a file with the `.dart` suffix)
and one of its Dart files must contain
a `main` function.
The `main` function
is the entry point for your application.

A Dart application is either
a command-line application or a web application.
You run command-line applications in the Dart VM from the command-line.
Web applications are hosted on a web page and run in a browser
(either directly or by compiling to JavaScript).

###Command-line applications

Dart command-line applications
run stand alone from the command line,
independent of a Web browser.
Command-line apps are often used
to provide server-side support to a Web app,
but they can also be scripts.

The Dart VM runs Dart code directly without intermediate compilation.

![Running a Command-line Application](images/dartvm-cmd-line.png)

Conveniently, you can run command-line apps
directly in Dart Editor with the click of a button.
Alternatively,
use the `dart` executable file
in the `dart-sdk/bin` directory.

###Web applications

Dart web applications run inside of a browser page.
In addition to a `.dart` file,
a Web app requires a `.html` file to host the app.
Often, a Web app provides the client-side
user interface for a server.

You can run your Dart Web app from Dart Editor
by clicking the Run button
![Dart Editor Run Button](images/run.png).
By default, Dart Editor invokes Dartium,
which has the Dart VM embedded in it
and loads your `.html` file,
which in turn loads your app.

![Running a Web Application](images/dartvm-web-app.png)

If you want to see your web app in a browser
that does not yet support Dart,
you can compile your Dart code to JavaScript
using the Dart-to-JavaScript compiler
and load the resulting `.js` file
into your browser of choice.
Dart Editor makes this easy with launches,
which you will learn about in the next target.

![Running a Web Application](images/dartvm-js.png)

The rest of this target steps you through
creating and running a command-line application
and then a web application.

##Create a command-line app {#create-cmd-line}

Follow these steps to create a command-line application:

<ol>
<li>
In Dart Editor, click the New Application button
<img src="images/newapp.png" alt="New App button"/>.
A dialog appears.

<img src="images/new-helloworld.png" alt="New Command-line Application"/>
</li>

<li markdown="1">
Type `helloworld` in the **Application Name** text box.
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
Dart Editor created a directory called `helloworld` and within
it a Dart source file named `helloworld.dart`.
The contents of
`helloworld.dart` is shown in the **Editor pane**.
You might recognize it as the canonical Hello World program.

![Dart Editor with Hello World](images/helloworld-files.png)

This program prints the text
`Hello, World!` to the standard output stream
using the `print` function,
which is provided by the `dart:core` library.
The functions and objects defined in the core library
are automatically available to all Dart applications.

##Run a command-line app {#run-cmd-line}

You can run `helloworld` in two ways:
from Dart Editor or from the command line.

###From Dart Editor
Make sure either the `helloworld` directory or the `helloworld.dart` file
is selected in the **Files view**,
then click the green Run button
![Dart Editor Run Button](images/run.png).

Dart Editor opens a new panel,
called the **Output view**,
and displays the output of the `helloworld` app.

![Hello World output](images/helloworld-output.png)

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

##Create a web app {#create-web-app}

Now let's create a web application.

<ol>
<li markdown="1">
As you did when creating a command-line application,
click the **New Application** button
<img src="images/newapp.png" alt="New App button"/>.
</li>

<li markdown="1">
Type `clickme` in the **Application Name** text box.
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

![New Application Dialog](images/new-click-me.png)

As before, Dart Editor creates a directory named after your application,
and a `.dart` file.
In addition, it also creates a `.html` file
and a `.css` file.
The HTML file contains the code necessary to include your Dart app
in a browser page.
The CSS file sets the styles
(for example, fonts and colors),
for the page and its elements.

![clickme app's files](images/click-me-files.png)

The `main` function contains two lines of code 
that puts text on the browser page
and registers an *event handler*,
a function that responds to user-generated events like a mouse click.
It uses APIs define in the `dart:html` library.

We are going to ignore the code for this application for now.
In the next target,
you will build a mini app from scratch,
creating the Dart source, the HTML source,
and the CSS source from scratch.
Afterward, you can re-visit the code for `clickme`.

##Run a web app in Dartium {#run-web-app}

To run `clickme` from Dart Editor,
make sure either the `clickme` directory or any of its files
is selected,
then click the green Run button
![Dart Editor Run Button](images/run.png).

Dart Editor invokes Dartium, which loads the `clickme` app's HTML file,
and thus, loads the app.

![clickme app running in Dartium](images/click-me-app.png)

When you click on 
**Click Me!**,
the text spins.

You can run Dart web applications in other browsers
by compiling to JavaScript.
You will do this in the next target,
when you learn about run-time configurations called launches.

##main and other top-level functions {#top-level-functions}

Dart lets you define _top-level_ functions,
that is, functions that are not encapsulated within a class or object.
You've already seen several top-level functions.
In all apps, the `main` function is a top-level function,
the Hello World example uses `print`,
a top-level function defined in `dart:core`,
and `clickme` declares a top-level function called `rotateText`.

A function has two parts: a _definition_ and a _declaration_.

![Function Parts](images/function-parts.png)

The definition is code contained
within a matching pair of curly braces
that defines the function's behavior.
The `milesToKM` function performs a simple arithmetic calculation
and returns the result.

The declaration sets the function name,
the data type of its return value,
and the number and type of its input arguments.

![Function Parts](images/declaration-parts.png)

This function takes a single argument.
Function can take multiple arguments,
in which case, the arguments are set apart by commas.

In our previous examples,
`main` does not have a return value
(as indicated by `void`)
and does not take any arguments
(as indicated by the empty parentheses),
but, like any other function, it could have both.

##File-naming conventions {#file-names}

When creating an application with Dart Editor,
you are asked to provide an application name.
By convention, application names,
and thus, the related files and directories, are lower case.

As you saw,
Dart Editor uses the application name for:

* the name of the app's directory
* the basename of the main Dart file
(the Dart file that contains the `main` function)
* the basename of the HTML file
* the basename of the CSS file

You should also follow these conventions.

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
* ??
{% endcomment %}

{% endcapture %}

{% include tutorial.html %}