---
layout: default
title: "Get Started with Web UI"
description: "Web UI provides web components, templates, data binding, and encapsulation."
has-permalinks: true
tutorial:
  id: get-started-web-ui
next: templates
next-title: "Use Templates"
prev: shared-pkgs
prev-title: "Install Shared Packages"
---

{% capture whats_the_point %}

* Web UI is an open-source package.
* Web UI provides web components for Dart apps.
* Other features support separation of data and presentation.
* Compile Web UI apps automatically in Dart Editor.
* Use data binding to sync Dart variables and UI elements.
* Attach event handlers to UI elements in HTML.

{% endcapture %}

{% capture sample_links %}

<p>
Get the source code for the samples featured in this target:</p>

<ul>
  <li>
    <a href="https://github.com/dart-lang/dart-tutorials-samples/tree/master/web/target06/littleben"
       target="_blank">littleben</a>
  </li>
  <li>
    <a href="https://github.com/dart-lang/dart-tutorials-samples/tree/master/web/target06/shout"
       target="_blank">shout</a>
  </li>
  <li>
    <a href="https://github.com/dart-lang/dart-tutorials-samples/tree/master/web/target06/stopwatch"
       target="_blank">stopwatch</a>
  </li>
</ul>

{% endcapture %}

{% capture content %}

<div class="tute-target-title">
<h1>{{page.title}}</h1>
<h3>Declaratively create dynamic user interfaces.</h3>
</div>

<hr>

<aside class="alert" style="background-color:Lavender;color:SlateBlue">
  <font size="24">
  <i class="icon-bullhorn"> </i>
  </font>

  The Dart Web UI team recently
  <a href="https://groups.google.com/a/dartlang.org/forum/#!topic/web-ui/6laXXxRtA7k">announced</a>
  a port of the Polymer project:
  <a href="http://pub.dartlang.org/packages/polymer">polymer.dart</a>.

  We've converted most of the tutorial Web UI examples and compiled some
  <a href="https://github.com/dart-lang/dart-tutorials-samples/blob/master/web/to-polymer-notes.txt" target="_blank">notes</a>
  along the way.
  Here is the source code for the polymer versions of the three examples from this target:
  <ul>
    <li>
      <a href="https://github.com/dart-lang/dart-tutorials-samples/tree/master/web/target06-polymer/littleben_element"
         target="_blank">littleben_element</a>: version of littleben using a custom element
    </li>
    <li>
      <a href="https://github.com/dart-lang/dart-tutorials-samples/tree/master/web/target06-polymer/littleben_model"
         target="_blank">littleben_model</a>: version of littleben with a bound model
    </li>
    <li>
      <a href="https://github.com/dart-lang/dart-tutorials-samples/tree/master/web/target06-polymer/shout"
         target="_blank">shout</a>
    </li>
    <li>
      <a href="https://github.com/dart-lang/dart-tutorials-samples/tree/master/web/target06-polymer/stopwatch"
         target="_blank">stopwatch</a>
    </li>
  </ul>
</aside>

<hr>


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

This target begins by showing you how to set up a project to use Web UI,
including how to install the package.
(If you are unfamiliar with packages, the previous target,
<a href="/docs/tutorials/packages/">Install Shared Packages</a>,
has details.)
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
* [Binding the value of an element to a Dart variable](#two-way-data-binding)
* [About template expressions](#template-expressions)
* [Binding event handlers](#binding-event-handlers)
* [Other resources](#other-resources)

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
Call the project `webui_click_counter`.

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
Dart Editor displays the **Overview** panel,
which provides a handy UI for viewing and modifying the pubspec file.
You can use the **Source**
tab at the bottom of the window to view
the pubspec.yaml source code.
</li>

<li markdown="1">
Add the Web UI package to the list of dependencies
by adding the Web UI package name,
`web_ui`, to the list.
Click **Add...** in the **Overview** panel,
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
For example: `web_ui: >=0.4.1 <0.4.2`.
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

<li markdown="1">
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

The web app running below uses one-way data binding.
The Dart code computes the current time and
formats it into a String.
The HTML code embeds the value of that Dart String
into the HTML using the data binding feature provided by the Web UI package.
Use one-way data binding
when the value of the bound expression (here, a Dart string)
can change only in the Dart code.

<iframe class="running-app-frame"
        style="height:100px;width:300px;"
        src="http://dart-lang.github.com/dart-tutorials-samples/web/target06/littleben/web/out/littleben.html">
</iframe>

You can find the complete source code for this sample on github at
<a href="https://github.com/dart-lang/dart-tutorials-samples/tree/master/web/target06/littleben" target="_blank">littleben</a>.

On the HTML side, the code uses a _template expression_
to embed the value of the String `currentTime` into the page.
In this example,
the expression is simply the name of a Dart variable
and it appears as part of an element's text property.
A template expression is specified
with a double pair of curly brackets,
which enclose the expression to be evaluated:
<code>&#123;&#123;expression&#125;&#125;</code>.
Notice that it looks like a natural part of the HTML code.

![One-way data binding in the littleben app](images/little-ben-dart.png)

On the Dart side,
the String `currentTime` is marked with `@observable`.
This marker causes the Web UI compiler to generate
the code needed to keep the HTML page in sync with this variable.
To use `@observable`,
the Dart code must import the Web UI package.

{% comment %}
@observable marks the variable as observable.
If the variable points to a different object,
you'll know thanks to @observable.
However, if the internal value of the variable changes
(like, list contents), @observable doesn't help you.
You'll need to also say
"I want to observe list contents" with toObservable().
{% endcomment %}

The value of `currentTime` changes every second
thanks to a periodic
<a href="http://api.dartlang.org/dart_async/Timer.html" target="_blank">Timer</a>
object.
When the string changes,
the HTML page gets updated automatically.

This sample also uses the
<a href="http://api.dartlang.org/dart_core/DateTime.html" target="_blank">DateTime</a>
class to get the current time.

##Binding the value of an element to a Dart variable {#two-way-data-binding}

Using the Web UI package's two-way data binding feature,
you can bind the value of an element,
typically an &lt;input&gt; element,
to the value of a Dart variable.

Try it! Type in the input field in the example running below.

<iframe class="running-app-frame"
        style="height:230px;width:300px;"
        src="http://dart-lang.github.com/dart-tutorials-samples/web/target06/shout/web/out/shout.html">
</iframe>

You can find the complete source code for this sample on github at
<a href="https://github.com/dart-lang/dart-tutorials-samples/tree/master/web/target06/shout" target="_blank">shout</a>.

The value of the text field is bound to a Dart string called `shoutThis`.
The string is declared
and marked with `@observable`
in the Dart code.
The string is bound to the input field in the HTML code
using the `bind-value` attribute.
As you type, the value of the string in the Dart program changes.
To demonstrate the change,
the UI displays variations of the string using several
one-way bound template expressions.

This is called two-way binding because the string can be changed
on the HTML-side when the user types,
or programmatically by the Dart code
(although you must be careful doing this.)

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
And you can use `bind-selected-index` with select element.

##About template expressions {#template-expressions}

A template expression can be any valid Dart expression
and is formed with double curly brackets: &#123;&#123;expression&#125;&#125;.
The expression is evaluated and converted to a string.
These are the template expressions used by the shout example:

![Examples of valid template expressions](images/expressions.png)

| Expression | Description |
|---|---|
| &#123;&#123;shoutThis.length&#125;&#125; | Gets the length of the string. The returned value is an integer that gets converted to a string. |
| &#123;&#123;shoutThis.toUpperCase()&#125;&#125; | Calls a string function that converts the string to upper case letters. Note that toUpperCase() returns a new string; it does NOT change the value of shoutThis. |
| &#123;&#123;(... ? ... : ... )&#125;&#125; | Uses the conditional ternary operator; if the entered value is longer than 5 characters, a substring is displayed. |
| &#123;&#123;palindrome&#125;&#125; | Calls a top-level getter named palindrome, defined in shout.dart, that creates a palindrome from the entered value. |
{: .table}

![Palindrome getter uses but does NOT modify shoutThis](images/palindrome-func.png)

The palindrome getter does NOT modify shoutThis.
If it did, it would create a situation in which an infinite loop is possible.
The Web UI system has a protection against infinite loops;
it detects if the values don't converge
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

Try it! Click the buttons to start, stop, and reset the stop watch.

<iframe class="running-app-frame"
        style="height:175px;width:205px;"
        src="http://dart-lang.github.com/dart-tutorials-samples/web/target06/stopwatch/web/out/stopwatch.html">
</iframe>

You can find the complete source code for this sample on github at
<a href="https://github.com/dart-lang/dart-tutorials-samples/tree/master/web/target06/stopwatch" target="_blank">stopwatch</a>.

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

##Other resources

<ul>
  <li> Check out
       <a href="/docs/cookbook/">
       <i class="icon-food"> </i> Dart Cookbook</a>.
       You'll find several
    <a href="/docs/cookbook/#web-ui">Web UI recipes</a>.
  </li>
  <li>
    Sigmund Cherem's article,
    <a href="/articles/dart-web-components/">Web UI Package</a>,
    contains several interactive examples on the page
    and the corresponding source code.
  </li>
</ul>

{% endcapture %}

{% include tutorial.html %}
