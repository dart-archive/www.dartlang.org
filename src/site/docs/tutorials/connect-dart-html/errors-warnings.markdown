---
layout: default
title: "What is Dart Editor trying to tell me?"
description: "Errors and Warnings and Code Completions"
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

As you type, Dart Editor processes the text
analyzing it for errors and performing code completion.
The sections below show you a few of the errors and
warnings you might see
and also how to use Dart Editor's code completion help.
Use this program to follow along:

{% highlight dart %}
import 'dart:html';
void main() {
  query('#RipVanWinkle').text = 'Wake up, sleepy head!';
}
{% endhighlight %}

##Errors
Begin typing the first line of code,
the `import` directive,
and stop just after you type the first single quotation mark.

<img src="images/error-editor-screenshot.png"
     alt="Dart Editor error">

You will see a small red 'x'
in the gutter on the left side of the **Editor pane**.
This means that Dart Editor has detected an error.
Hover the mouse over the red 'x' and 
a helpful error message is displayed in a tooltip:

<img src="images/error-tooltip-screenshot.png"
     alt="Dart Editor error tooltip">

This particular error is syntactic.
The single quote starts a string literal,
which is left uncompleted.
Errors can be either compile-time or run-time.
Compile-time errors prevent your program from running at all.
Run-time errors result in exceptions.

Finish typing the complete line of code and the red 'x' disappears.

##Warnings

**Tip:** Save your file with **File > Save**.
In some versions of Dart Editor,
you need to save the file and start typing again
before a newly imported library is detected.

Now delete the line of code that calls print().
And start typing the function call to query().
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
Hover the mouse over the yellow warning sign and 
a helpful warning message will be displayed in a tooltip:

<img src="images/warning-tooltip-screenshot.png"
     alt="Dart Editor warning tooltip">

Dart Editor is telling you that query() requires
a string argument and you have not yet provided one.
Warnings are hints that your code might not work
but do not prevent your program from executing.

##Code completion

Continue typing, entering '#RipVanWinkle'
as the argument to the query() function,
and stop after you type the period.
Dart Editor displays a menu with auto-complete suggestions
based on the context.
You can also invoke the menu by typing **Ctl+Space**.

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
