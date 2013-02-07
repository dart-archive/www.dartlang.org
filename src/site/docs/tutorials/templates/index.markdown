---
layout: default
title: "Target 7: Use &lt;template&gt;"
description: "Use template loops and conditionals for declarative UI creation."
has-permalinks: true
tutorial:
  id: web-ui-templates
---

{% capture whats_the_point %}

* The Web UI package implements templates in HTML.
* You can conditionally activate DOM elements declaratively.
* Use template loops to create UI elements from a Dart Iterable.

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

The Web UI package implements the &lt;template&gt; tag,
which you can use directly in your HTML.
Templates define UI elements that are instantiated
only under specific circumstances.
You can use templates to define the structure of a custom element,
to instantiate UI elements based on a boolean condition,
or to repeat UI elements by iterating over a Dart Iterable object.

This target covers
template conditionals and loops,
both of which provide a declarative way
to add and remove UI elements.
The next target covers custom elements
and using templates to define their structure.

* [Using conditional instantiation](#using-conditional-instantiation)
* [Using template iteration](#using-template-iteration)
* [Using iteration with other elements](#as-attributes)
* [Further examples](#further-examples)

##Using conditional instantiation

In the example application running below,
you provide six words to fill in the blanks of a hidden text.
Try it! Type six items into the input fields.
The results appear only after you have entered a value for all six items.
After you've entered all six items, delete one. The paragraph disappears.

<iframe style="border-style:solid;border-width:1px;border-radius:7px;background-color:WhiteSmoke;height:300px;padding:5px"
        src="http://dart-lang.github.com/dart-tutorials-samples/web/target07/adlibitum/web/out/adlibitum.html">
</iframe>

The sample uses template conditionals to display the paragraphs
under the input fields.

![Paragraph elements are conditionally instantiated](images/template-conditional.png)

The value of each input field is bound to a Dart String
using two-way data binding as described in the
<a href="/docs/tutorials/web-ui/">previous target</a>.
The Web UI system keeps
the Dart Strings in sync with the value of the input field
as the user types.

![Two-way data binding in adlibitum sample](images/adlib-databinding.png)

Each input field uses the same Dart function,
called verify(),
to handle change events that occur when the user types in it.
If all input fields have a value,
the event handler sets a Dart boolean variable called `show` to true.

![Set show to true when all input fields completed](images/show-results.png)

The HTML code uses the value of `show` to determine
whether to instantiate the paragraph elements defined within the template
or to remove the elements if they were previously instantiated.

![HTML code for a conditionally instantiated template](images/html-ifcode.png)

The template is declared with the &lt;template&gt; tag.
The template tag has an `instantiate` attribute,
which contains the expression
that determines the condition under which the template
is activated or deactivated.
In this example, it's a simple boolean value, but it could be any
valid Dart expression that evaluates to true or false.

In this example,
the template contains simple paragraph elements
in which some of the text is bound to the values in input fields.

The instantiate attribute takes the form `if exp`,
where `exp` is a valid Dart expression
that evaluates to either true or false.
When the expression is true,
the contents of the template are instantiated.
Otherwise, any elements that were previously instantiated
are removed from the DOM.

The expression is evaluated every time the watchers are dispatched.
The watchers are dispatched after each change event
fired by any of the six input fields.
Note that all of the watchers are dispatched for all events,
not just the watcher related
to the specific input field that fired the event.

You can find the complete source code to the adlibitum example here:

<ul>
  <li>
<a href="http://raw.github.com/dart-lang/dart-tutorials-samples/master/web/target07/adlibitum/web/adlibitum.html"
   target="_blank">adlibitum.html</a>
  </li>
  <li>
<a href="http://raw.github.com/dart-lang/dart-tutorials-samples/master/web/target07/adlibitum/web/adlibitum.dart"
   target="_blank">adlibitum.dart</a>
  </li>
</ul>

##Using template iteration

The sample running below
is a simplified version of the children's hangman game.
Try it! Type letters in the field to guess the word.

<iframe style="border-style:solid;border-width:1px;border-radius:7px;background-color:WhiteSmoke;height:250px;padding:5px"
        src="http://dart-lang.github.com/dart-tutorials-samples/web/target07/simplehangman/web/out/simplehangman.html">
</iframe>

The hangman example uses template iteration in two places:
to display the hyphenated version of the hidden word
and to display the list of incorrectly guessed letters.

![Two uses of template iteration](images/template-loop.png)

In each case,
the set of letters (or hyphens) is contained in a List of Strings
in the Dart program,
where each string contains a single letter (or hyphen).
By iterating over Dart 
<a href="http://api.dartlang.org/dart_core/Iterable.html"
   target="_blank">Iterable</a>
objects like these lists of strings,
template loops allow you to declaratively
repeat UI elements based on that data.

The simplehangman program stores the incorrectly guessed
letters in a list of strings called `wrongletters`.
The program creates the empty list when it begins.

{% prettify dart %}
List<String> wrongletters = new List();
{% endprettify %}

The template loop 
used to display the incorrectly guessed letters
is written in the HTML file as follows:

{% prettify html %}
<p id="wrong"><template iterate="wrongchar in wrongletters"> {% raw  %}{{wrongchar}}{% endraw %} </template></p>
{% endprettify %}

The &lt;template&gt; tag has an attribute called `iterate`,
whose value is an expression that takes the form `identifier in collection`.
`collection` is an expression that evaluates to a Dart
<a href="http://api.dartlang.org/dart_core/Collection.html"
   target="_blank">Collection</a>
object.
The template iterates over the collection assigning each value to `identifier`,
a new variable that is in scope for the body of the iterate element.
In our example, the collection is `wrongletters`&mdash;a list of strings.
The identifier `wrongchar` is used as part of the text in the body
of a simple paragraph element.

The `wrongletters` list of strings is populated based on input from the user.
The input field has a change event handler function, checkit(),
that is called for each letter the user types into the input field.
The checkit() function determines whether or not the letter is correct.
If it is not,
the String containing the letter is added to the `wrongletters` list.

This diagram shows you the connections between the HTML code,
the Dart code, and the user interface.

![Using template loops to display a list of strings](images/wrongletters-detail.png)

As the user continues to guess incorrect letters,
the UI is kept up-to-date with the list by the Web UI package
through its binding mechanism
because the template is bound to the Dart list `wrongletters`.

The template loop that manages
the display of hyphens and correctly guessed letters is similar
and can be found in the complete source files for this sample:

<ul>
  <li>
<a href="http://raw.github.com/dart-lang/dart-tutorials-samples/master/web/target07/simplehangman/web/simplehangman.html"
   target="_blank">simplehangman.html</a>
  </li>
  <li>
<a href="http://raw.github.com/dart-lang/dart-tutorials-samples/master/web/target07/simplehangman/web/simplehangman.dart"
   target="_blank">simplehangman.dart</a>
  </li>
</ul>

##Using iteration with other elements {#as-attributes}

The simplehangman example used the iterate attribute on a template node.
You can use `template iterate` as an attribute on any type of element.
This is particularly useful in tables
because you cannot use templates in tables.
In the future, the Web UI team intends to remove the extra `template`
attribute, and you will be able to use just `iterate` directly
on elements as well as on templates.

Here's a new version of the hangman example.
Try it! Guess the word.

<iframe style="border-style:solid;border-width:1px;border-radius:7px;background-color:WhiteSmoke;height:250px;width:350px;padding:5px"
        src="http://dart-lang.github.com/dart-tutorials-samples/web/target07/hangman/web/out/hangman.html">
</iframe>

The gallows is displayed using a table.
The table uses `template iterate` as an attribute on
the table body and on the table row to
display the characters in the hangman display.

![Using template loops with tables](images/loops-and-tables.png)

The data for the gallows is contained on the Dart side
in a list of lists called `hangmandisplay`.
Each sublist is a list of strings, each of which
contains a single character.
So each string represents a cell in the table.
The top-level function setUpHangmanGrid() populates
the list of lists with this code:

{% prettify dart %}
List<List> hangmandisplay;

void setUpHangmanGrid() {
  var gallows = [  '+---+  ',
                  '\|      ',
                  '\|      ',
                  '\|      ',
                  '\|      ' ];
  hangmandisplay = new List(gallows.length);
  
  for (int i = 0; i < gallows.length; i++) {
    List<String> row = gallows[i].splitChars();
    hangmandisplay[i] = row;
  }
}
{% endprettify %}

To create the table in HTML,
one template loop iterates over of the hangmandisplay list of lists,
using each sublist for a row in the table.
The second template loop iterates over each sublist (a list of strings)
using each string for a cell in the table.

![Detail of using template loops with tables](images/table-loop-detail.png)

`hangmandisplay` is the Dart data to iterate over.
`row` and `cell` are both temporary loop variables.

The contents of the hangmandisplay are changed programmatically
for each incorrectly guessed letter in a top-level function called
revealnewbodypart().

When the user guesses a letter,
the change event handler is called.
If the guess is incorrect,
the contents of the hangmandisplay are modified.
As a result of the change event,
the watchers are dispatched and the gallows UI is updated.

You can find the complete source code for this version
of the hangman sample here:

<ul>
  <li>
<a href="http://raw.github.com/dart-lang/dart-tutorials-samples/master/web/target07/hangman/web/hangman.html"
   target="_blank">hangman.html</a>
  </li>
  <li>
<a href="http://raw.github.com/dart-lang/dart-tutorials-samples/master/web/target07/hangman/web/hangman.dart"
   target="_blank">hangman.dart</a>
  </li>
</ul>

##Further examples {#further-examples}

<ul>
  <li>
    Sigmund Cherem's article,
    <a href="/articles/dart-web-components/">Web UI Package</a>,
    contains several interactive examples on the page
    and the corresponding source code.
  </li>
  <li>
    Another use of the &lt;template&gt; tag
    is to define the contents of a custom element.
    The next target,
    <a href="/docs/tutorials/custom-elements/">Define a Custom DOM Tag</a>,
    provides an example that converts numbers based on a simple ratio.
</li>
</ul>

<div class="row">
  <div class="span3">
  <a href="/docs/tutorials/web-ui/"><i class="icon-chevron-left"> </i> Get Started with Web UI</a>
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
