---
layout: default
title: "Target 6: Get Started with Web UI"
description: "Web UI provides web components, templates, data binding, and encapsulation."
has-permalinks: true
tutorial:
  id: get-started-web-ui
---

{% capture whats_the_point %}

* Web UI is an open-source package.
* Web UI provides web components for Dart apps.
* Other features support separation of data and presentation.
* Compile Web UI apps automatically in Dart Editor.
* Use data binding to sync Dart variables and UI elements.
* Attach event handlers to UI elements in HTML.
* Learn how watchers keep the UI and data in sync.

{% endcapture %}

{% capture content %}

The
<a href="http://pub.dartlang.org/packages/web_ui">Web UI package</a>
provides the tools and Dart code
that implement data binding, web components,
templates, and encapsulation.
To use these Web UI features,
you need to install the Web UI package in each application that uses it
and compile the project using the Web UI compiler.
To streamline the development process,
you can use Dart Editor to help set up your project,
install the package, and automate the build process.

This target begins by showing you how to set up a project to use Web UI.
Then this target describes how to use two features of the Web UI package.
Specifically, you will learn 
how to use data binding to embed mutable Dart data in your HTML page
and to declaratively attach event handlers to UI elements.

The next two targets,
<a href="/docs/tutorials/templates/">Target 7: Use &lt;template&gt;</a>
and
<a href="/docs/tutorials/custom-elements/">Target 8: Define a Custom DOM Tag</a>,
describe other features of the Web UI package.

* [About using the Web UI package](#about-web-ui)
* [Create a new application with Web UI installed](#create-new)
* [Install the Web UI package in an existing web application](#install-web-ui)
* [Set up background compilation in Dart Editor](#set-up)
* [Embedding data in a web page with one-way data binding](#one-way-data-binding)
* [About watchers](#about-watchers)
* [Dispatching watchers](#watching)
* [Importing the watcher library](#import-library)
* [Binding the value of an element to a Dart variable](#two-way-data-binding)
* [About template expressions](#template-expressions)
* [Binding event handlers](#binding-event-handlers)
* [Further examples](#further-examples)

##About using the Web UI package {#about-web-ui}

You can use Web UI features directly in your HTML code
as naturally as you use standard HTML.
In fact, some of the Web UI syntax looks like regular HTML tags,
so you could think of the Web UI library as extending the HTML language.

Before you can run an app that uses Web UI,
you must compile the app using the Web UI compiler `dwc`.
The compiler translates the Web UI code
into standard HTML and Dart scripts
and includes the code that implements the Web UI features.
You run the compiled version of the app as you normally would
using the Dart VM or by converting it to JavaScript.

![Compiling your program with Web UI packages](images/webui-compile.png)

In this way,
Web UI provides an extra
layer between your code and the browser platform,
seamlessly providing you with new browser features like
web components and templates.

You can set up Dart Editor to automate the compilation process
for projects that use the Web UI library.
Dart Editor detects changes to your project files
and automatically compiles in the background.
With Dart Editor at the center of your development cycle,
you can create, edit, compile, and run your application
with Web UI quickly and easily.

##Create a new application with Web UI installed {#create-new}

The easiest way to begin using the Web UI package
is to create a new application in Dart Editor.

<ol>
<li markdown="1">
In Dart Editor,
create a new project using **File > New Application**.
In the window that appears,
select **Generate sample content** and
in the list beneath it,
select
**Web application (using the web_ui library)**.
Call the project `webui-click-counter`.

![Create a new application using the Web UI library](images/create-with-web-ui.png)
</li>

<li markdown="1">
Dart Editor creates a directory
and the source files for your project.
Dart Editor also automatically runs `pub install`
to resolve the package dependencies
and install all of the necessary packages including the Web UI package.
Finally, Dart Editor builds the project&mdash;that is,
it compiles the application code
together with the Web UI library code&mdash;
and puts the final version in the `out` directory.

![Sample Web UI application](images/new-app-files.png)
</li>

<li markdown="1">
Select `webui_click_counter.html` and click the Run button
<img src="images/run.png" width="16" height="16" alt="Run button">.
The app uses the custom element and data binding
features from the Web UI package to
implement the button and display the number of clicks.
</li>

<li>
You can use this sample application as the basis for your
Web UI application.
</li>
</ol>

##Install the Web UI package in an existing Web application {#install-web-ui} 

If you already have an application to which you would like to add Web UI,
you need to set up the package dependencies
and install the Web UI package libraries into your project.
This section assumes that you have read
the previous target,
<a href="/docs/tutorials/packages/">Install Shared Packages</a>,
and are familiar with the process
of installing packages.

<ol>
<li markdown="1">
In Dart Editor,
open an existing project.
For the example here,
we're using the default sample application
generated by Dart Editor
when you create a new web application
without Web UI support.
Later in this target,
you will modify this application to use
data binding&mdash;a feature necessary to web components and templates.

![Open an existing web application](images/open-existing-app.png)
</li>

<li markdown="1">
Open the pubspec.yaml file, which is
in the top-level directory of your project.
By default,
Dart Editor displays the Overview panel,
which provides a handy UI for viewing and modifying the pubspec file.
You can use the **Source**
tab at the bottom of the window to view
the pubspec.yaml source code.
</li>

<li markdown="1">
Add the Web UI package to the list of dependencies
by adding the Web UI package name,
`web_ui`, to the list.
Click the **Add...** in the Overview panel,
or add the package name
to the dependencies list directly in the pubspec.yaml source.
YAML is whitespace-sensitive
so take care to indent the package name as shown:

![Sample pubspec file with web_ui dependency](images/sample-pubspec.png)

<aside class="alert" markdown="1">
<strong>Note:</strong>
If you include a version constraint,
instead of using `any`,
your code will be less likely to break
because of new releases of the package.
For example: `web_ui:  >=0.2.9 < 0.2.10`.
You can proactively upgrade to new versions when you are ready.
Check the Web UI package
<a href="https://github.com/dart-lang/web-ui/blob/master/CHANGELOG.md">
CHANGELOG</a>
to see what version of the package
works with the version of the SDK you are running.
</aside>
</li>

<li markdown="1">
Select pubspec.yaml, and install the package by
choosing **Tools > Pub Install** from the menu.
This recursively installs the web_ui package
and all the packages that it depends on.
The diagram below shows the file hierarchy for your application
after the package installation:

![The littleben application with web_ui installed](images/app-with-pkgs.png)
</li>

<li>
In the `littleben` sample,
the application files are in a directory called `web`.
To run the app, select the main host HTML file,
web/littleben.html,
and click the Run button
<img src="images/run.png" width="16" height="16" alt="Run button">.
</li>
</ol>

##Set up background compilation in Dart Editor {#set-up}

Applications that use features from the Web UI package must be compiled.
You can set up Dart Editor to automatically compile
your project when any of its files change.
Once you have background compilation set up,
your edit/refresh/test cycle within Dart Editor will be quick and easy.

<ol>
<li markdown="1">
Create a file called `build.dart` in the same directory as pubspec.yaml.
In this case, that's the project's top-level directory.
Replace the auto-generated code with the following:

{% prettify dart %}
import 'package:web_ui/component_build.dart';
import 'dart:io';

void main() {
  build(new Options().arguments, ['web/littleben.html']);
}
{% endprettify %}

build.dart refers to the application's primary HTML file `web/littleben.html`.
The pathname is specified relative to the build.dart file.

![build.dart file names the project's main HTML file](images/build-dart-file.png)
</li>

<li markdown="1">
Make sure build.dart is selected and click
<img src="images/run.png" width="16" height="16"
     alt="Run button">.
After a beat, a directory named `out` appears under the web directory.

![Output from build.dart](images/after-build-dart.png)

Your project is now set up for background compilation.
Every time Dart Editor detects that you changed a file in your project,
it uses the Web UI compiler
to compile your project and update the files in web/out.
Generally speaking you can ignore the files in the `web/out` directory.
When you run your app,
Dart Editor runs these files automatically.
</li>

<li markdown="1">
Run your app as you normally would:
select the original HTML file, web/littleben.html,
and click the Run button
<img src="images/run.png" width="16" height="16"
     alt="Run button">.
Dart Editor runs the generated file in the web/out directory.

![Running web/littleben.html](images/run-app.png)

With background compilation set up in Dart Editor,
you can be certain that you are always running
the most up-to-date version of your app.
</li>

<li markdown="1">
Edit & Refresh.
As you work, you continue to edit your original project files.
Do not modify the files in web/out because the compiler will overwrite them.
</li>
</ol>

##Embedding data in a web page with one-way data binding {#one-way-data-binding}

Get the source files for the littleben sample.
<ul>
  <li>
<a href="https://github.com/dart-lang/dart-tutorials-samples/tree/master/web/target06/littleben" target="_blank">littleben</a>
  </li>
</ul>

Run the app; it displays the current time:

![Little Ben shows the current time](images/little-ben-running.png)

The littleben application uses a feature from
the Web UI package called one-way data binding
to embed the value of a Dart variable into the HTML page.
In this case,
the Dart variable is a String containing the current time
formatted in a standard way.

On the Dart side,
littleben's main() function gets the current time using the
<a href="http://api.dartlang.org/dart_core/DateTime.html" target="_blank">DateTime</a>
class from the dart:core library.
The littleben.dart file contains
a top-level function called formatTime(),
which formats the hours, minutes, and seconds
into a top-level String variable called currentTime.

On the HTML side, the code uses a _template expression_
to embed the value of the String currentTime into the page.
In this example,
the expression is simply the name of a Dart variable
and it appears as part of an element's text property.
The following diagram shows the HTML code, the Dart code,
and a screenshot of the running app.

![One-way data binding in the littleben app](images/little-ben-dart.png)

A template expression is specified
with a double pair of curly brackets,
which enclose the expression to be evaluated:
<code>&#123;&#123;expression&#125;&#125;</code>.
Notice that it looks like a natural part of the HTML code.

This is called one-way data binding because
the data can only change on the Dart side.
When the data changes in the Dart program,
the UI updates to reflect the change.
The Web UI code uses a system of _watchers_ to sync the UI with the data.
When watchers are dispatched,
the template expressions are evaluated
and the UI gets updated.

##About watchers {#about-watchers}

The Web UI code attaches a watcher to every template expression.
A watcher's job is to update the UI when the value of
its template expression changes.
But watchers are passive;
rather like teenagers,
they do their job only when reminded.
So either your code or the Web UI code
must dispatch watchers to check for changes to the Dart data.

Normally, you don't have to worry about dispatching watchers
because the Web UI code dispatches them automatically
for common situations when Dart data is likely to have changed.
For example, after mouse clicks, after changes to an input field,
and for certain window events, like window-refresh.

One of the situations in which the Web UI code dispatches watchers
is when an app's main() function completes.
This comes to play in the littleben app,
whose main() function executes straight through and then stops.
That means the &#123;&#123;currentTime&#125;&#125; expression
is evaluated and rendered once.

{% comment %}
[XX: there should be a diagram in all of this webUI/watcher bizness,
but I have not figured out what it should be]
{% endcomment %}

1. The littleben app sets the string currentTime in its main() function.
1. The main() function completes its execution.
1. The Web UI code dispatches watchers.
1. The watcher of the currentTime data recognizes the data change...
1. ...evaluates the expression...
1. ...and fires an event that updates the UI.
1. The current time appears on the page.

The littleben app displays the current time when it starts up.
It would be more interesting if the time continually updated like a clock:

<iframe style="border-style:solid;border-width:1px;border-radius:7px;background-color:WhiteSmoke;height:100px;padding:5px"
        src="http://dart-lang.github.com/dart-tutorials-samples/web/target06/littleben_clock/web/out/littleben_clock.html">
</iframe>

The next section discusses the code for the app running above.

##Dispatching watchers {#watching}

You can find the code for a version of the littleben app
that updates the display of the current time every second in
<a href="http://raw.github.com/dart-lang/dart-tutorials-samples/master/web/target06/littleben_clock/web/littleben_clock.dart"
   target="_blank">littleben_clock.dart</a>.
The diagram below highlights the differences
between the original, static version and the new, dynamic version:

![littleben_clock.dart with explicit call to dispatch watchers](images/littleben-with-watcher.png)

1. Add two import directives,
one to import dart:async (for the
<a href="http://api.dartlang.org/dart_async/Timer.html" target="_blank">Timer</a>
class) and one to import
the watcher library from the web_ui package
(more about the `as` clause below).
1. Change the code within the main() function.
1. Add the updateTime() function.

The main() function sets a timer using a periodic Timer object.
The timer calls the updateTime() function every second.
The updateTime() function is similar to the
main() function in the previous version;
it gets the current time, formats it,
and sets the currentTime string to that value.
New is the call to watchers.dispatch().

![littleben.dart with watchers added](images/updatetime.png)

This program must dispatch watchers explicitly
because the Web UI layer does not
automatically dispatch watchers for timer events.
If you comment out the watchers.dispatch() call,
the currentTime string changes in the Dart code every second,
but the UI is not updated.
In this case, to see the time change,
you can refresh the page&mdash;watchers are dispatched
for window refresh events.

The Web UI code dispatches watchers in many scenarios,
so often you don't have to worry about doing so explicitly in your code.
But if your code is not working as you expected,
try adding a call to watchers.dispatch().

##Importing the watcher library {#import-library}

The watcher library is part of the Web UI package.
It provides functions and classes
that watch template expressions and help keep the UI in sync.
The dispatch() function is a top-level function in the
watcher library that activates all watchers
attached to template expressions in an application.
You can use it explicitly in your programs when necessary
as you saw in the littleben app.

Notice the import directive used by the littleben app
to import the watcher library:

![Importing a library with a prefix](images/import-with-prefix.png)

The `as` clause helps to avoid name collisions
by specifying a prefix for the library.
You use the library prefix to qualify names in your program.
For example, by importing the watcher library
with the prefix `watchers`,
the code calls watchers.dispatch()
instead of simply dispatch().

![Calling a function with a library prefix](images/function-with-prefix.png)

##Binding the value of an element to a Dart variable {#two-way-data-binding}

This section discusses a sample app called shout.
Use these links to find the source code:
<ul>
  <li>
<a href="http://raw.github.com/dart-lang/dart-tutorials-samples/master/web/target06/shout/web/shout.html"
   target="_blank">shout.html</a>
  </li>
  <li>
<a href="http://raw.github.com/dart-lang/dart-tutorials-samples/master/web/target06/shout/web/shout.dart"
   target="_blank">shout.dart</a>
  </li>
  <li>
<a href="http://raw.github.com/dart-lang/dart-tutorials-samples/master/web/target06/shout/build.dart"
   target="_blank">build.dart</a> (For building the app with Web UI)
  </li>
</ul>

Using the Web UI package's two-way data binding feature,
you can bind the value of an element to the value of a Dart variable.
Try it! Type in the input field in the example running below.
The value of the field is bound to a Dart string.
As you type, the string changes and the UI changes in response.

<div>
<iframe style="border-style:solid;border-width:1px;border-radius:7px;background-color:WhiteSmoke;height:230px;padding:5px"
        src="http://dart-lang.github.com/dart-tutorials-samples/web/target06/shout/web/out/shout.html">
</iframe>
</div>

In the shout example,
the value of the text field is bound to a Dart string called `shoutThis`.
The string is declared in the Dart code
and bound to the input field in the HTML code.
This is called two-way binding because the string can be changed
on the HTML-side when the user types,
or programmatically by the Dart code (although you must be careful doing this.)
Watchers keep them in sync.
When you type in the input field,
the Web UI code,
which intercedes in the event handling mechanism,
automatically dispatches watchers to evaluate the expression
and update the UI.

![An input field using two-way data binding](images/shoutthis.png)

To bind data to the value of an element,
specify the `bind-value` attribute on an element in the HTML code.
For example, this is the code from the shout example that
binds the value of the text field to the shoutThis string:

{% prettify dart %}
<input type="text" bind-value="shoutThis" placeholder="Shout This!">
{% endprettify %}

You can use `bind-value` with different kinds of input elements,
text areas, and select elements (drop-down lists.)
Also, you can use `bind-checked` with radio button elements and checkboxes.
And you can use `bind-selectedIndex` with select element.

To show that the shoutThis string changes in concert with the input field,
the shout example uses several *template expressions* in the HTML code,
each of which displays some variation of the string.

##About template expressions {#template-expressions}

A template expression can be any valid Dart expression
and is formed with double curly brackets: &#123;&#123;expression&#125;&#125;.
The expression is evaluated and converted to a string.
These are the template expressions used by the shout example:

![Examples of valid template expressions](images/expressions.png)

* &#123;&#123;shoutThis.length&#125;&#125; gets the length of the string.
The returned value is an integer that gets converted to a string.
* &#123;&#123;shoutThis.toUpperCase()&#125;&#125;
calls a string function that converts the string to upper case letters.
Note that toUpperCase() returns a new string;
it does NOT change the value of shoutThis.
* The third expression uses the conditional ternary operator;
if the entered value is longer than 5 characters,
a substring is displayed.
* The last expression calls a top-level
function named palindrome(), which is defined in shout.dart,
that creates a palindrome from the entered value.

![Palindrome() function uses but does NOT modify shoutThis](images/palindrome-func.png)

The palindrome() function does NOT modify shoutThis.
If it did, it would create a situation in which an infinite loop is possible.
The Web UI system has a protection against infinite loops;
it detects if watchers don't converge
and stops the loop after several iterations.
However, this is simply a protection and not a feature you should rely on.

Use caution!
You should use expressions that are practically side-effect free.

##Binding event handlers

The Web UI package provides a declarative way
to bind Dart event handlers to UI elements.
Each button in the stopwatch example below
has an event handler for responding to mouse clicks.
The event handlers are bound to the button in the HTML code
and implemented in Dart.

<iframe style="border-style:solid;border-width:1px;border-radius:7px;background-color:WhiteSmoke;height:175px;padding:5px"
        src="http://dart-lang.github.com/dart-tutorials-samples/web/target06/stopwatch/web/out/stopwatch.html">
</iframe>

Here's the code that sets the mouse click handler for the **Start** button.

![Set event handlers directly in HTML code](images/event-handler.png)

Event handlers are declared using attributes,
where the attribute name specifies the event type
using a hyphenated form of the Dart event name beginning with `on-`.
The buttons in the example specify event handlers for mouse clicks
using `on-click`.

Other common events 
are double-click events (`on-double-click`)
and change events on input fields (`on-change`).
See the API docs for 
<a href="http://api.dartlang.org/dart_html/Element.html"
   target="_blank">Element</a>
for a complete list of event names.
{% comment %}
Events classes are planned to change
and this section will need updating.
{% endcomment %}

The attribute value is a Dart expression that usually
specifies a function call.
In the stopwatch example,
the startwatch() mouse click handler
is declared void and takes no arguments.
If the event handler needed information about the event that occurred,
it could accept an Event argument.
The event handler binding
in that case would be written `on-click="startwatch($event)"`.
The function would be declared `void startwatch(Event e)`.

After the handler completes,
watchers are dispatched
so they can sync the UI with any data that has changed.

You can find the complete code for the stopwatch example,
and thus the code for all of the mouse click handlers, here:

<ul>
  <li>
<a href="http://raw.github.com/dart-lang/dart-tutorials-samples/master/web/target06/stopwatch/web/stopwatch.html"
   target="_blank">stopwatch.html</a>
  </li>
  <li>
<a href="http://raw.github.com/dart-lang/dart-tutorials-samples/master/web/target06/stopwatch/web/stopwatch.dart"
   target="_blank">stopwatch.dart</a>
  </li>
  <li>
<a href="http://raw.github.com/dart-lang/dart-tutorials-samples/master/web/target06/stopwatch/build.dart"
   target="_blank">build.dart</a> (For building the app with Web UI)
  </li>
</ul>

##Further examples

Sigmund Cherem's article,
<a href="/articles/dart-web-components/">Web UI Package</a>,
contains several interactive examples on the page
and the corresponding source code.

<div class="row">
  <div class="span3">
  <a href="/docs/tutorials/packages/"><i class="icon-chevron-left"> </i> Install Shared Packages</a>
  </div>
  <div class="span3">
<a href="http://code.google.com/p/dart/issues/entry?template=Tutorial%20feedback"
 target="_blank">
<i class="icon-comment"> </i>
Send feedback
</a>
  </div>
  <div class="span3">
  <a href="/docs/tutorials/templates/" class="pull-right">Use &lt;template&gt; <i class="icon-chevron-right"> </i> </a>
  </div>
</div>

{% endcapture %}

{% include tutorial.html %}
