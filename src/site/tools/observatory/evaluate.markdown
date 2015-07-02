---
layout: default
title: "Evaluating Expressions"
description: "Observatory's Evaluate feature lets you enter expressions to be evaluated by your application in real time."
header: 
  css: ["observatory.css"]
---

# {{ page.title }}

{% include breadcrumbs.html %}

<h4>Contents</h4>
<ol class="toc">
  <li> <a href="#overview">Overview</a> </li>
  <li> <a href="#example-1">Example 1: Restarting an application </a> </li>
  <li> <a href="#example-2">Example 2: Querying and setting variables</a> </li>
  <li> <a href="#example-3">Example 3: Defining a closure on the fly</a> </li>
</ol>

## Overview {#overview}

A text field, with an **Evaluate** button, appears in several
screens in Observatory's UI.  It looks like the following:

<img src="images/EvaluateTextField.png" alt="a text field with an Evaluate button">

When you see this text field, you can enter
a Dart expression to be evaluated in the running application
_in real time_.  You can _query_ the app, or you can _modify_ it.
Even if an application has exited, you can use this text field
to start it again if you have specified the `--pause-isolates-on-exit` option
when starting Observatory.
(To see how to restart an app, see [Example 1](#example-1).)

<aside class="alert alert-info" markdown="1">
**Tip:** When the **1-line** radio button is selected, you can enter
a single line of Dart code and press Enter to evaluate the code.

When the **N-line** radio button is selected, focus stays in the text
box when you press Enter and the cursor moves to the next line.
In N-line mode, you can change the size of the text box by clicking and
dragging the lower right corner of the box.
</aside>

You can enter any valid expression into the text field.
The [Dart Language specification](/docs/spec/) has a section
on what constitutes a valid expression. If the expression is
not valid, an error message displays.

The scope of the evaluation depends on where you are in Observatory's UI:

* From any [isolate screen](screens.html#isolate-screen),
  you can evaluate expressions in the context of the root library
  of that isolate.
* From any [library screen](screens.html#library-screen),
  you can evaluate expressions in the context of that library.
* From any [class screen](screens.html#class-screen),
  you can evaluate expressions in the context of that class.
  For example, you might query or change the value of a static class variable.
* From any [instance screen](screens.html#instance-screen),
  you can evaluate expressions in the context of that instance.

While the scope is different in these situations, the process of
evaluation is the same.

## Example 1: Restarting an application {#example-1}

You can restart an  application by entering `main()`
into the expression evaluation field in either the root
[isolate screen](screens.html#isolate-screen),
or the [library screen](screens.html#library-screen).
If the main method requires any arguments, enter those as well.

<aside class="alert alert-info" markdown="1">
**Note:** This tip applies only to standalone apps.
A web app doesn't exit until the browser's tab has closed.
</aside>

The `main` method of the following example accepts an optional argument to
determine how many times it should print the "Hello World" string.
The default is one time.

{% prettify Dart %}
void main(List<String> args) {
  var num;
  if (args.length==0) num = 1;
  else num=int.parse(args[0]);

  for (int i = 0;i < num; i++) {
    print("Hello, World!");
  }
  print("That's all!\n");
}
{% endprettify %}

Launch the app and open Observatory.

The following output prints to the console when `main(['3'])`, followed by
`main(['5'])`, is entered into the isolate's expression evaluation field:

{% prettify none %}
Observatory listening on http://127.0.0.1:61852
Hello, World!
That's all!

Isolate helloworld.dart$main-316431991 paused before exiting. Use Observatory to release it.
Hello, World!
Hello, World!
Hello, World!
That's all!

Hello, World!
Hello, World!
Hello, World!
Hello, World!
Hello, World!
That's all!
{% endprettify %}

## Example 2: Querying and setting variables {#example-2}

You can use the expression evaluation field to examine and set the value
of variables in real time.

The following sample program defines several top-level variables:

{% prettify dart %}
String str="Howdy!";
double db, db2;
List aList=[1, 2, 3];

void main() {
    // ...
}
{% endprettify %}

Launch the app and open Observatory.

The [library screen](screens.html#library-screen) shows
the following:

{% prettify none %}
variables (4)
    static String str    "Howdy!"
    static double db     null
    static double db2    null
    static List aList    _GrowableList(3)
{% endprettify %}

Use the expression evaluation field to modify the variables.
Some examples are:

{% prettify dart %}
str = "Hola!"

db = 10.3

db2 = db

aList.add(15)
{% endprettify %}

While the variable values have changed, note that the variable
summary does not refresh
([issue 18856](https://github.com/dart-lang/sdk/issues/18856)).
Click the variable name to see the updated value.

## Example 3: Defining a closure on the fly

With a little planning, you can use the evaluate expression field to
write brand new code that immediately executes. For example, you can
use this feature to print logging information.

This technique requires some minimal setup in your code. You must:

* Define a closure variable.
* Inside a work loop, test the closure variable. If the variable
  is non-null, then execute it.

A _closure_ is a function object. To learn more, read
[Lexical Closures](/docs/dart-up-and-running/ch02.html#lexical-closures).

<aside class="alert alert-info" markdown="1">
**Note:** Be aware that modifying your code can crash the application.
</aside>

The following example defines a closure variable named `closureFoo`.
The code then iterates in an endless loop, increasing the value of a top-level
counter variable.

{% prettify dart %}
var closureFoo;
int counter = 0;

void main() {

  while (true) {
    if (closureFoo != null) {
      closureFoo();
    }
    counter++;
  }
}
{% endprettify %}

Launch the app and open Observatory.

Enter closure code into the expression evaluation field in either the
root [isolate screen](screens.html#isolate-screen) screen,
or the [library screen](screens.html#library-screen).

The following example defines the `closureFoo` function to print
the value of the counter:

{% prettify dart %}
closureFoo = (){print(counter);}
{% endprettify %}

As soon as the expression is evaluated, the output prints to the console:

{% prettify sh %}
13903954684
13903954685
13903954686
13903954687
13903954688
13903954689
13903954690
{% endprettify %}

You can change the definition of `closureFoo`. For example, the following
code prints only even counter values:

{% prettify dart %}
closureFoo=() {if (counter.isEven) { print(counter); } }
{% endprettify %}

The output changes immediately:

{% prettify sh %}
115296439424
115296439426
115296439428
115296439430
115296439432
115296439434
115296439436
{% endprettify %}

To disable the closure code, reset the closure variable to null in the
expression evaluation field:

{% prettify dart %}
closureFoo = null
{% endprettify %}

The output immediately stops.

{% include observatory_new_fyi.html %}

{% include observatory_footer.html %}

