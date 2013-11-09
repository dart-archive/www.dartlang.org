---
layout: default
title: "Get Started"
description: "Get Dart and run two Dart applications"
has-permalinks: true
tutorial:
  id: get-started
js:
- url: /js/os-switcher.js
  defer: true
- url: /js/editor-downloads-analytics.js
  defer: true
- url: /js/editor-version.js
  defer: true
next: connect-dart-html/
next-title: "Connect Dart & HTML"
prev: 
prev-title: "Home"
---

{% capture whats_the_point %}

* The Dart bundle has development tools, APIs, and samples.
* You can use Dart for web apps and command-line apps.
* Run Dart web apps directly in Dartium.
* Compile Dart apps to JavaScript for other browsers.
* All Dart apps have a main() function.
* Dart supports top-level functions.

{% endcapture %}

{% capture sample_links %}

This tutorial features two examples
provided by Dart Editor:

* helloworld
* clickme

{% endcapture %}

{% capture content %}

<div class="tute-target-title">
<h1>{{page.title}}</h1>
<h3>Get Dart. Run two apps.</h3>
</div>

This tutorial gets you ready
to begin writing web apps in Dart.
Here you will download the Dart software,
and use Dart Editor to
create and run two small applications.

* [Download the Dart software bundle](#download-dart)
* [What did you get?](#what-did-you-get)
* [Start Dart Editor](#start-dart-editor)
* [About Dart applications](#what-is-app)
* [Create a command-line app](#create-cmd-line)
* [Run a command-line app](#run-cmd-line)
* [Create a web app](#create-web-app)
* [Run a web app](#run-web-app)
* [About the HTML, CSS, and Dart triumvirate](#source-files)
* [About main() and other top-level functions](#top-level-functions)
* [About file naming conventions](#file-names)
* [Other resources](#other-resources)
* [What next?](#what-next)

##Download the Dart software bundle {#download-dart}

Get Dart.
The Dart download includes Dart Editor,
which you'll be using
throughout this tutorial.

<div align="center">
  {% include downloads/_dart-editor.html buttonclass="btn btn-primary btn-lg" %}
</div>

<p>
  The Dart tools
  work in recent versions of
  {% include os-choices.html %}
</p>

<aside class="alert alert-info">
  <b>Note:</b> The Dart tools <b>do not support Windows XP</b>.
</aside>


##What did you get? {#what-did-you-get}

Unzip the file.
The resulting directory,
your *Dart installation directory*,
contains the following:

<div>
  <hr>
  <div class="row">
    <div class="col-md-2">
    <img class="scale-img-max" src="images/dart-editor-icon.png"
         width="77" height="93" alt="Dart Editor"/>
    </div>
    <div class="col-md-7">
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
    <div class="col-md-2">
    <img class="scale-img-max" src="images/chromium.png"
         width="81" height="89" alt="Dartium, a special Chromium build"/>
    </div>
    <div class="col-md-7">
    This is a special build of the Chromium web browser, 
    called Dartium, that has the Dart VM (virtual machine) embedded.
    You can run your apps directly in this browser,
    or use Dart Editor to do it for you,
    thereby streamlining the build-test cycle.
    </div>
  </div>
  <hr>
  <div class="row">
    <div class="col-md-2">
    <img class="scale-img-max" src="images/dart-sdk-directory.png"
         width="86" height="94" alt="dart-sdk directory"/>
    </div>
    <div class="col-md-7">
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
    <div class="col-md-2">
    <img class="scale-img-max" src="images/samples-directory.png"
         width="81" height="91" alt="samples directory"/>
    </div>
    <div class="col-md-7">
    The samples directory contains the complete source code
    for several Dart web applications.
    You can experiment with
    these examples in Dart Editor.
    </div>
  </div>
  <hr>
  <div class="row">
    <div class="col-md-2">
    <img class="scale-img-max" src="images/and-the-rest.png"
         width="81" height="71" alt="more directories"/>
    </div>
    <div class="col-md-7">
    You might notice some other directories
    in the Dart installation directory.
    You can ignore them for now. 
    </div>
  </div>
  <hr>
</div>

## Start Dart Editor {#start-dart-editor}

Invoke Dart Editor by double-clicking its icon
in your Dart installation directory
<img class="scale-img-max" src="/imgs/Dart_Logo_21.png"
     width="21" height="21" alt="Dart Editor icon">.

Dart Editor displays its Welcome Page
in a tab in the **Editor pane**.
The following diagram highlights
some of the features of the editor.

<img class="scale-img-max" src="images/dart-editor-items.png"
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
or the **Create an application** button
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

Problems pane
: Displays warning and error messages.

<aside class="alert alert-info">
<b> Problems? </b>
See <a href="/tools/editor/troubleshoot.html">Troubleshooting Dart Editor</a>.
</aside>

##About Dart applications {#what-is-app}

At minimum, a Dart application has

* one Dart source file&mdash;a
  file with the .dart suffix that contains Dart code
* one top-level main() function.
  This is the entry point for your application.

There are two kinds of Dart applications:
command-line applications and web applications.
A command-line application is a standalone program
that you run in the Dart VM from the command-line in a terminal window.
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

<img class="scale-img-max" src="images/dartvm-cmd-line.png"
     alt="Run a command-line application without compilation">

Conveniently, you can run command-line apps
directly in Dart Editor with the click of the Run button
<img class="scale-img-max" src="images/run.png" width="16" height="16"
     alt="Run button">.
Alternatively,
use the Dart VM tool
in the `dart-sdk/bin` directory in your Dart installation directory.

###Web applications

Dart web applications run inside of a browser page.
In addition to a Dart file,
a web app requires an HTML file to host the app.
Often, a web app provides the client-side
user interface for a server.

You can run your Dart web app from Dart Editor
by clicking the Run button
<img class="scale-img-max" src="images/run.png" width="16" height="16"
     alt="Run button">.
By default, Dart Editor will invoke Dartium,
which has the Dart VM embedded in it,
and loads your HTML file,
which in turn loads your app.

<img class="scale-img-max" src="images/dartvm-web-app.png"
     alt="Run a web application directly in a Dart-savvy browser">

If you want to see your web app in a browser
that does not yet support Dart,
you can compile your Dart code to JavaScript
using the Dart-to-JavaScript compiler,
which is in the `dart-sdk/bin` directory in your Dart installation directory.
You then load the resulting JavaScript file
into your browser of choice.
Dart Editor provides a convenient menu option for
running web apps as JavaScript.

<img class="scale-img-max" src="images/dartvm-js.png"
     alt="Run a web application by compiling to JavaScript">

The rest of this tutorial steps you through
creating and running first a command-line application
and then a web application.

##Create a command-line app {#create-cmd-line}

In Dart Editor, choose **File->New Application** from the menu
or click the New Application button
<img class="scale-img-max" src="images/newapp.png" width="17" height="16" alt="New App button"/>.
A dialog appears that looks like this:

<img class="scale-img-max" src="images/new-helloworld.png"
     alt="Create a new command-line application"/>

<ol>
<li markdown="1">
Type `helloworld` in the **Application Name** text field.
By convention, application names are lowercase.
This name is used for the app's directory
and the basename for the files it creates.
</li>

<li markdown="1">
Type or browse to the directory where you want to save the files.
By default, Dart Editor creates a new directory named `dart`
in your home directory.
</li>

<li markdown="1">
Select **Generate sample content**.
Dart Editor generates sample code
appropriate for the type of application you are creating.
For a command-line application,
the sample code implements the standard 'Hello World' program.
</li>

<li markdown="1">
Select **Command-line application** from the list.
</li>

<li markdown="1">
Click **Finish**.
</li>
</ol>

Dart Editor creates a directory for the application
and boilerplate files for a small command-line app.
The **Files view** displays
the file hierarchy for the application.

<img class="scale-img-max" src="images/helloworld-files.png"
     alt="Dart Editor with new command-line app files"/>

Some of the files and directories in the helloworld application
include the following:

helloworld
: Contains boilerplate files and directories for a
simple command-line app.

pubspec.yaml
: Declares which libraries
your application needs.
The `packages` directories contain those libraries.
The `pubspec.lock` file specifies the version numbers
of the libraries on which the application depends.

bin
: Contains the source files for the application.
The main source file for this example is `helloworld.dart`.

helloworld.dart
: Contains the Dart source code for this app.

The **Editor pane** shows
the contents of `helloworld.dart`.
The program prints
'Hello, World!' to the standard output stream
using the print() function,
which is provided by the dart:core library.
The functions and objects defined in the core library
are automatically available to all Dart applications.

##Run a command-line app {#run-cmd-line}

To run the helloworld app from Dart Editor:

* Select the helloworld.dart file in the **Files view**.
* Click the Run button
<img class="scale-img-max" src="images/run.png" width="16" height="16"
     alt="Run button">.

Dart Editor opens a new panel,
called the **Output view**,
and displays the output of the helloworld app.

<img class="scale-img-max" src="images/helloworld-output.png"
     alt="Dart Editor with helloworld output view"/>

##Create a web app {#create-web-app}

Now let's create a web application.
As you did when creating a command-line application,
click the **New Application** button
<img class="scale-img-max" src="images/newapp.png" width="17" height="16" alt="New App button"/>.
Name the application `clickme`.
This time you are creating a web app,
so select **Web application** from the list
in the New Application dialog window:

<img class="scale-img-max" src="images/new-click-me.png"
     alt="Create a new web application"/>

Dart Editor creates the directory and files needed
for a boilerplate web application.

<img class="scale-img-max" src="images/click-me-files.png"
     alt="Dart Editor with new web application files"/>

As before, the directory is named after your application.
So is the Dart source file that contains the main() function.
In addition, Dart Editor creates an HTML file that hosts the app.

The main() function in the clickme app
contains Dart code 
that puts text on the browser page
and registers an *event handler*&mdash;a function
that responds to user-generated events like a mouse click.
This code uses API defined in the dart:html library.

In the next tutorial,
you will build a mini app from scratch,
creating the Dart source, the HTML source,
and the CSS source yourself.
Afterward, you can re-visit the code for clickme.

##Run a web app {#run-web-app}

To run the clickme app from Dart Editor:

* Select `clickme.html`.
* Click the Run button
<img class="scale-img-max" src="images/run.png" width="16" height="16"
     alt="Run button">.

Dart Editor invokes Dartium providing it with
the URL for the clickme app's HTML file.
Dartium loads the clickme app's HTML file
and the embedded app, which looks like this:

<iframe class="running-app-frame"
        style="height:510px;width:500px;"
        src="examples/clickme/clickme.html">
</iframe>

###Run as JavaScript

You can run Dart web applications in other browsers
by compiling to JavaScript.
Dart Editor provides a convenient menu option for doing so.
Right click on `clickme.html`
and select **Run as JavaScript** from the menu.

<img class="scale-img-max" src="images/run-as-javascript-screenshot.png"
     alt="Run a web app as JavaScript"/>

Dart Editor compiles the app to JavaScript and
invokes your default browser,
which runs the app.

##About the HTML, CSS and Dart triumvirate {#source-files}

Typically three files&mdash;an HTML file, a Dart file,
and a CSS file&mdash;together implement a Dart web application.
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
HTML sets up the initial document tree
and specifies element types, classes, and IDs,
which allow HTML, CSS, and Dart programs to refer to the same elements.

CSS, which stands for Cascading Style Sheets, describes the appearance
of the elements within a document.
CSS controls many aspects of formatting:
type face, font size, color, background color,
borders, margins, and alignment, to name a few.

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

The two apps you've seen in this tutorial have other top-level functions.
The Hello World example calls print(),
a top-level function defined in dart:core.
And the clickme app defines a top-level function called reverseText().

A function declaration
has two parts: a _signature_ and a _body_.

<img class="scale-img-max" src="images/function-parts.png"
     alt="Two parts of a function, the signature and the body"/>

The signature sets the function name,
the data type of its return value,
and the number and type of its input arguments.

<img class="scale-img-max" src="images/signature-parts.png"
     alt="The parts of a function signature"/>

The body is the code that defines the function's behavior.
It usually appears between curly braces ({_code_}).
If the body is a single expression, then you
can skip the braces and use the => shorthand:

{% prettify dart %}
double milesToKM(double miles) => miles/0.62;
{% endprettify %}

The milesToKM() function performs a simple arithmetic calculation
and returns the result.

This function takes a single argument.
Functions can take multiple arguments,
in which case the arguments are set apart by commas.

##About file naming conventions {#file-names}

When creating an application with Dart Editor,
you are asked to provide an application name.
By convention, application names,
and thus, the related files and directories, are lowercase.

As you saw,
Dart Editor uses the application name for:

* the name of the app's directory
* the basename of the main Dart file
(the Dart file that contains the main() function)
* the basename of the primary HTML file
* the basename of the primary CSS file

You should also follow these conventions
when creating applications outside of Dart Editor.

##Other resources

<ul>
  <li>
    <a href="/docs/dart-up-and-running/contents/ch04-tools-editor.html">Dart Editor</a>,
    an excerpt from
    <a href="/docs/dart-up-and-running/">Dart: Up and Running</a>,
    provides details about using Dart Editor.
    The excerpt includes, for example,
    how to set up run-time environments,
    how to use power features such as autocompletion,
    debugging, refactoring,
    and so on.
  </li>
  <li>
    The <a href="/docs/">Programmer's Guide</a>
    points you to docs, articles,
    and other resources to help you as you create,
    test, and deploy Dart code.
  </li>
</ul>

##What next?

* Get the code for all of the Dart tutorials samples.
  <a href="https://github.com/dart-lang/dart-tutorials-samples/archive/master.zip">
  Download the ZIP file</a>, unzip it,
  and open `dart-tutorials-samples` in Dart Editor.

* Go to the next tutorial, [Connect Dart & HTML](/docs/tutorials/connect-dart-html/),
which steps you through writing a tiny web app from scratch.

{% endcapture %}

{% include tutorial.html %}
