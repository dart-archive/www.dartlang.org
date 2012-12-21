---
layout: default
title: "Target 6: Embed Live Data in HTML"
description: "Web UI provides an MDV framework and web components."
has-permalinks: true
tutorial:
  id: this-should-be-unique
---

{% capture whats_the_point %}

* Web UI combines the ideas from web components and MDV.
* Web UI is an open-source package.
* Compile Web UI apps automatically in Dart Editor.
* Use data binding to sync Dart variables and UI elements.
* Watchers keep Dart and the UI in sync.

{% endcapture %}

{% capture content %}

<div id="under-construction" markdown="1">
<h3> <i class="icon-wrench"> </i> Under construction </h3>

This is a draft.
Your kindly worded
<a
 href="http://code.google.com/p/dart/issues/entry?template=Tutorial%20feedback"
 target="_blank">
comments and suggestions
</a>
are appreciated.
Thank you for your patience.

</div>

The
<a href="http://pub.dartlang.org/packages/web_ui">Web UI package</a>
provides the tools and Dart code
that implement web components
and templating features such as data binding,
and template expressions, loops and conditionals.

This target covers two features of the Web UI package:

* embedding Dart data into your web page
* keeping the UI and its embedded Dart data in sync

But first, it shows you how to use Dart Editor
to install the Web UI package in a new application
and how to set up background compilation in Dart Editor so that
your edit/refresh/test cycle is efficient.

* [About using the Web UI package](#about-web-ui)
* [Install the Web UI package](#install-web-ui)
* [Set up background compilation in Dart Editor](#set-up)
* [Embedding mutable data in a web page](#one-way-data-binding)
* [About watchers](#about-watchers)
* [Dispatching the watchers](#watching)
* [Importing the watcher library](#import-library)
* [Binding a Dart variable to an element's value](#two-way-data-binding)
* [About template expressions](#template-expressions)
* [Watch this space](#more-to-come)
* [Further examples](#further-examples)

##About using the Web UI package {#about-web-ui}

You can think of the Web UI library
as an extension of the HTML and Dart languages.
You can use Web UI features,
such as templating and web components,
directly in your HTML and Dart code
as naturally as you can use standard HTML and Dart.
To run your application,
you must compile your project using the Web UI compiler called `dwc`.
The compiler translates your code into standard scripts
and generates new files,
which you can convert to JavaScript or run in Dartium.

![Compiling your program with Web UI packages](images/webui-compile.png)

In this way,
Web UI provides an extra
layer between your code and the browser platform,
seamlessly providing you with new browser features like
web components and templating.

You can set up Dart Editor to automate the compilation process.
Dart Editor will detect changes to your project files
and automatically compile in the background.
With Dart Editor at the center of your development cycle,
you can edit, compile, and run your application
quickly and easily.

##Install the Web UI package {#install-web-ui} 

To use the Web UI libraries you need to install it
in each application that uses it.
This section assumes that you have read
the previous target,
<a href="/docs/tutorials/packages/">Install Shared Packages</a>,
and are familiar with the process
of installing packages.
Therefore instructions given here are brief
and specific to this project.

In Dart Editor:

* Create a new project using **File > New Application**
and select both **Generate content for a basic web app** and
**Add Pub support**. Call it `littleben`.

* Open the `pubspec.yaml` file, which is
in the top-level directory of your project.

* Edit the dependencies list in pubspec.yaml 
by adding the Web UI package name,
`web_ui`, to the list.
YAML is whitespace-sensitive
so take care to indent the package name as shown:

![Sample pubspec file with web_ui dependency](images/sample-pubspec.png)

<aside class="alert" markdown="1">
<strong>Note:</strong>
If you include a version constraint,
instead of using `any`,
your code will be less likely to break
because of new releases of the packages.
For example: `web_ui:  >=0.2.9 < 0.2.10`.
You can proactively upgrade to new versions when you are ready.
Check the web-UI package
<a href="https://github.com/dart-lang/web-ui/blob/master/CHANGELOG.md">
CHANGELOG</a>
to see what version of web_ui 
works with the version of the SDK you are running.
</aside>

* Select pubspec.yaml and install the package by
choosing **Tools > Pub Install** from the menu.
This recursively installs the web_ui package
and all the packages that it depends on.
The diagram below shows the file hierarchy for your application
after the package installation:

![The littleben application with web_ui installed](images/app-with-pkgs.png)

* The application files are in a directory called `web`.
To run the app, select web/littleben.html and click the Run button
<img src="images/run.png" width="16" height="16" alt="Run button">.
You will see the standard boilerplate application created by Dart Editor.
Later in this target,
you will modify this application to use
data binding&mdash;a feature necessary to web components and templates.

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

{% highlight dart %}
import 'package:web_ui/component_build.dart';
import 'dart:io';

void main() {
  build(new Options().arguments, ['web/littleben.html']);
}
{% endhighlight %}

build.dart refers to the application's primary HTML file `web/littleben.html`.
The pathname is specified relative to the build.dart file.

![build.dart file names the project's main HTML file](images/build-dart-file.png)
</li>

<li markdown="1">
Modify littleben.html to include `type=text/javascript` as
an attribute to the second script tag:

![Add type attribute to script tag in littleben.html](images/add-type-attribute.png)
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
Generally speaking you can ignore the files in the `out` directory.
</li>

<li markdown="1">
Run your app as you normally would:
select the original HTML file, web/littleben.html,
and click the Run button
<img src="images/run.png" width="16" height="16"
     alt="Run button">.
Dart Editor redirects to run the generated file in the web/out directory.

![Running web/littleben.html](images/run-app.png)

With background compilation set up in Dart Editor,
you can be certain that you are always running
the most up-to-date version of your app.
</li>

<li markdown="1">
Edit & Refresh.
As you work, you continue to edit your original project files.
Do not modify the files in web/out because the compiler will overwrite them.

Let's modify the Dart and HTML code 
so you can see the background compiler in action.

In Dart Editor, replace the contents of littleben.html
and littleben.dart with the code from the following files.
<ul>
  <li>
<a href="http://raw.github.com/dart-lang/dart-tutorials-samples/master/web/target06/littleben/web/littleben.html"
   target="_blank">littleben.html</a>
  </li>
  <li>
<a href="http://raw.github.com/dart-lang/dart-tutorials-samples/master/web/target06/littleben/web/littleben.dart"
   target="_blank">littleben.dart</a>
  </li>
</ul>

Save your changes and watch the lower right corner of Dart Editor.
A small progress bar appears and disappears quickly.
(Too quickly for me to get a screenshot of it. Sorry about that.)
The Web UI compiler runs in the background
and regenerates the files in web/out.
Run the new version of the littleben app;
it displays the current time:

![Little Ben shows the current time](images/little-ben-running.png)
</li>
</ol>

##Embedding mutable data in a web page {#one-way-data-binding}

The littleben application uses a feature from
the Web UI package called one-way data binding
to embed the value of a Dart variable into the HTML page.

On the Dart side,
littleben's main() function gets the current time using the
<a href="http://api.dartlang.org/dart_core/Date.html" target="_blank">Date</a>
class from the dart:core library.
The top-level function called formatTime(),
which is defined in littleben.dart,
formats the hours, minutes, and seconds
into a top-level String variable called currentTime.

On the HTML side, the code uses a _template expression_
to embed the value of the String currentTime into the page.
A template expression is specified
with a double pair of curly brackets,
which enclose the expression to be evaluated:
<code> &#123;&#123;expression&#125;&#125; </code>
Notice that it looks like a natural part of the HTML code.

In our example,
the expression is the name of a Dart variable
and it appears as part of an element's text attribute.
The following diagram shows the HTML code, the Dart code,
and a screenshot of the running app.

![One-way data binding in the littleben app](images/little-ben-dart.png)

The Web UI system uses a system of _watchers_ to sync the UI with the data.
When the watchers are dispatched,
the template expressions are evaluated
and the UI gets updated.

##About watchers {#about-watchers}

The Web UI system attaches a watcher to every template expression.
A watcher's job is to update the UI when the value of
its template expression changes.
But watchers are passive; rather like teenagers,
they will do their chores only when reminded.
So either your code or the Web UI system
must remind the watchers to check for changes to the Dart data.
The Web UI system dispatches the watchers automatically
for situations when it is possible or likely
that one or more expressions have changed.

One of these situations
in which the Web UI system automatically dispatches the watchers
is when the main() function completes.
In the littleben app,
the main() function executes straight through and then stops.
So the &#123;&#123;currentTime&#125;&#125; expression is evaluated
and rendered once.

The sequence is as follows:
{% comment %}
[XX: there should be a diagram in all of this webUI/watcher bizness,
but I have not figured out what it should be]
{% endcomment %}

1. The littleben app sets the string currentTime in its main() function.
1. The main() function completes its execution.
1. The Web UI system dispatches the watchers.
1. The watcher of the currentTime data recognizes the data change...
1. ...evaluates the expression...
1. ...and fires an event that updates the UI.
1. The current time appears on the page.

The littleben app displays the current time when it starts up.
It would be more interesting
if the time continually updated like a clock,
like this:

<iframe style="border-style:solid;border-width:1px;border-radius:7px;background-color:WhiteSmoke;height:100px;padding:5px"
        src="http://dart-lang.github.com/dart-tutorials-samples/web/target06/littleben/web/out/littleben.html">
</iframe>

The next section shows you the code for the app running above.

##Dispatching the watchers {#watching}

Modify
<a href="http://raw.github.com/dart-lang/dart-tutorials-samples/master/web/target06/littleben-with-watchers/web/littleben.dart">littleben.dart</a>
with the changes highlighted in the following diagram:

![littleben.dart with watchers added](images/littleben-with-watcher.png)

1. Add two import directives,
one to import dart:html (for the
<a href="http://api.dartlang.org/dart_html/Window.html" target="_blank">Window</a>
class) and one to import
the watcher library from the web_ui package
(more about the `as` clause below).
1. Change the code within the main() function.
1. Add the updateTime() function.

The main() function sets a timer using window.setInterval().
The timer calls the updateTime() function every second (1000 milliseconds).
Like the previous version of the program's main() function,
the code in updateTime() gets the current time, formats it,
and sets the currentTime string to that value.
New is the call to watchers.dispatch().

![littleben.dart with watchers added](images/updatetime.png)

This program must dispatch the watchers explicitly
because the Web UI layer does not
automatically dispatch watchers for window interval events.

If you comment out the watchers.dispatch() call,
the currentTime string is still updated every second,
but the UI is not updated.
In that case,
if you refresh the page, the current time will be updated
because the Web UI layer dispatches the watchers
for window refresh events.

Although it can be useful to access watchers directly,
as just shown in the littleben app,
the Web UI system does a good job
of dispatching watchers in scenarios where it is likely necessary.
For example,
when using a template expression bound to a DOM element's value,
the watcher is dispatched when the element's value changes.
Also, a watcher is automatically dispatched
when an element's event handler is called.

##Importing the watcher library {#import-library}

The watcher library is part of the Web UI package.
It provides functions and classes
that watch template expressions and help keep the UI in sync.
The dispatch() function is a top-level function in the
watcher library that activates all the watchers
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

##Binding a Dart variable to an element's value {#two-way-data-binding}

This section discusses a sample application called shout.
Use these links to find the complete source code:
<ul>
  <li>
<a href="http://raw.github.com/dart-lang/dart-tutorials-samples/master/web/target06/shout/web/shout.html"
   target="_blank">shout.html</a>
  </li>
  <li>
<a href="http://raw.github.com/dart-lang/dart-tutorials-samples/master/web/target06/shout/web/shout.dart"
   target="_blank">shout.dart</a>
  </li>
</ul>

Using the Web UI package's two-way data binding feature,
you can bind the value of an element to the value of a Dart variable.
In the shout example, running below,
the value of the text field is bound to a Dart string called shoutThis.
As you type, the value of shoutThis is updated,
the watchers are dispatched, and the UI gets updated.

<div>
<iframe style="border-style:solid;border-width:1px;border-radius:7px;background-color:WhiteSmoke;height:230px;padding:5px"
        src="http://dart-lang.github.com/dart-tutorials-samples/web/target06/shout/web/out/shout.html">
</iframe>
</div>

When you type in the input field,
the Web UI system,
which intercedes in the event handling mechanism,
dispatches the watchers to evaluate the expression and update the UI.

To do so, specify the `bind-value` attribute on an element.
For example, this line of code
binds the value of a text field to a Dart string called `shoutThis`:

{% highlight dart %}
<input type="text" bind-value="shoutThis" placeholder="Shout This!">
{% endhighlight %}

The following example code
uses an input field whose value is bound to a Dart string.
That Dart string is used in various template expressions
on the HTML page.
The UI is updated as the user types.

![An input field using two-way data binding](images/shoutthis.png)

##About template expressions {#template-expressions}

A template expression can be any valid Dart expression.
The expression is evaluated and converted to a string.
The shoutthis example uses several template expressions.

* &#123;&#123;shoutThis.length&#125;&#125; gets the length of the string.
The returned value is an integer that gets converted to a string.
* &#123;&#123;shoutThis.toUpperCase()&#125;&#125;
calls a string function that converts the string to upper case letters.
Note that toUpperCase() returns a new string;
it does NOT change the value of shoutThis.
* The third expression uses the conditional ternary operator;
if the entered value is longer than 5 characters,
a substring is displayed.

![Examples of valid template expressions](images/expressions.png)

* The last expression calls a top-level
function named palindrome(), which is defined in shoutthis.dart,
that creates a palindrome from the entered value.

![Palindrome() function uses but does NOT modify shoutThis](images/palindrome-func.png)

The palindrome() function does NOT modify shoutThis.
If it did, it would create an infinite loop situation.
The Web UI system has a protection against infinite loops;
it detects if the watchers don't converge
and stops the loop after several iterations.
However, this is simply a protection and not a feature you should rely on.

Use caution!
You should use expressions that are practically side-effect free.

##Watch this space {#more-to-come}

Soon to come:
We will be adding coverage of template conditionals and template loops.

{% comment %}

xx: where can template expressions appear?
bind-value, anywhere in a text attribute,
as the value of a named attribute (which is the Dart var name
as with the ratio example)

##Using conditionals and loops and other exciting things {#conditionals}

xx
{% endcomment %}

##Further examples {#further-examples}

<ul>
<li>
  Sigmund Cherem's article,
  <a href="/articles/dart-web-components/">Web UI Package</a>,
  contains several interactive examples on the page
  and the corresponding source code.
</li>
{% comment %}
<li>
  The next target shows you how to create a custom DOM type
  using the web components features of the Web UI package.
</li>
{% endcomment %}
</ul>

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
  <a href="/docs/tutorials/custom-elements/" class="pull-right">Define a Custom DOM Tag <i class="icon-chevron-right"> </i> </a>
  </div>
</div>

{% endcapture %}

{% include tutorial.html %}
