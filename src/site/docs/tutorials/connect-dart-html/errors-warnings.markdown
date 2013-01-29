---
layout: default
title: "What Is Dart Editor Trying to Tell Me?"
description: "Errors and warnings and code completions"
has-permalinks: true
tutorial:
  id: errors-warnings
---

{% capture back_to %}
<a href="index.html" style="font-size: 9pt">2: Connect Dart &amp; HTML</a>
{% endcapture %}

{% capture whats_the_point %}

* Dart Editor reports errors and warnings.
* Errors are either run-time or compile-time.
* Warnings are hints that your code might not work.

{% endcapture %}

{% capture content %}

As you type, Dart Editor processes the text,
analyzing it for errors and performing code completion.
The sections below show you a few of the errors and
warnings you might see.
They also show you how to use Dart Editor's code completion help.

Follow along with the instructions as you transform
the code for the default helloworld command-line app into this code:

{% prettify dart %}
import 'dart:html';
void main() {
  query('#RipVanWinkle').text = 'Wake up, sleepy head!';
}
{% endprettify %}

##Errors
Place the text cursor before the 'v' in void,
and begin typing the first line of code,
the `import` directive,
and stop just after you type the first quotation mark.

<img src="images/error-editor-screenshot.png"
     alt="Dart Editor error">

You will see a small red 'x'
in the gutter on the left side of the **Editor pane**.
This means that Dart Editor has detected an error.
When you point to the red 'x',
a tooltip displays a helpful error message.

<img src="images/error-tooltip-screenshot.png"
     alt="Dart Editor error tooltip">

This particular error is syntactic.
The single quote starts a string literal,
which is left uncompleted.
Errors can be either compile-time or run-time.
Compile-time errors prevent your program from running at all.
Run-time errors result in exceptions.

Finish typing the complete line of code including the semi-colon (;)
and the red 'x' disappears.

<aside class="alert" markdown="1">
**Tip:** Save your file with **File > Save**.
In some versions of Dart Editor,
you need to save the file and start typing again
before a newly imported library is detected.
</aside>

##Warnings

Now delete the line of code that calls print(),
and start typing the function call to query().
Stop after you type the first parenthesis.
Note that Dart Editor helpfully provides a matching parenthesis.
Note also that Dart Editor displays
a yellow warning symbol in the gutter.

<img src="images/warning-editor-screenshot.png"
     alt="Dart Editor warning">

In the background, Dart Editor does API lookup.
Dart Editor recognizes the top-level query() function
from the Dart HTML library,
but it has detected a possible problem.
Point the mouse at the yellow warning sign and 
a helpful warning message will be displayed in a tooltip:

<img src="images/warning-tooltip-screenshot.png"
     alt="Dart Editor warning tooltip">

Dart Editor is telling you that query() requires
a string argument and you have not yet provided one.
Warnings are hints that your code might not work,
but they don't prevent your program from executing.

##Code completion

Continue typing, entering '#RipVanWinkle'
as the argument to the query() function,
and stop after you type the period.
Dart Editor displays a menu with auto-complete suggestions
based on the context.
You can also bring up the menu by typing **Ctl+Space**.

<img src="images/query-api-lookup.png"
     alt="Lookup query in Dart libraries in Dart Editor">

Scroll down and choose text, or just type it in.

Finish your edits,
and save the file with **File > Save**.

<div class="row">
  <div class="span3">
  <a href="index.html"><i class="icon-chevron-left"> </i> Back to Target 2</a>
  </div>
</div>

{% endcapture %}

{% include tutorial-sidebar.html %}
