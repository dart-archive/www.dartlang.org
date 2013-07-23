---
layout: default
title: "Target 7: Use &lt;template&gt;"
description: "Use template loops and conditionals for declarative UI creation."
has-permalinks: true
tutorial:
  id: web-ui-templates
next: custom-elements
next-title: "Define a Custom DOM Tag"
prev: web-ui
prev-title: "Get Started with Web UI"
---

{% capture whats_the_point %}

* The Web UI package implements templates in HTML.
* You can conditionally activate DOM elements declaratively.
* Use template loops to create UI elements from a Dart Iterable.

{% endcapture %}

{% capture sample_links %}

<p>
Get the source code for the samples featured in this target:</p>

<ul>
  <li>
    <a href="https://github.com/dart-lang/dart-tutorials-samples/tree/master/web/target07/adlibitum"
       target="_blank">adlibitum</a>
  </li>
  <li>
    <a href="https://github.com/dart-lang/dart-tutorials-samples/tree/master/web/target07/simplehangman"
       target="_blank">simplehangman</a>
  </li>
  <li>
    <a href="https://github.com/dart-lang/dart-tutorials-samples/tree/master/web/target07/hangman"
       target="_blank">hangman</a>
  </li>
</ul>

{% endcapture %}

{% capture content %}

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
  Here is source code for the polymer versions of the three examples from this target:
  <ul>
    <li>
      <a href="https://github.com/dart-lang/dart-tutorials-samples/tree/master/web/target07-polymer/adlibitum"
         target="_blank">adlibitum</a>
    </li>
    <li>
      <a href="https://github.com/dart-lang/dart-tutorials-samples/tree/master/web/target07-polymer/simplehangman"
         target="_blank">simplehangman</a>
    </li>
    <li>
      <a href="https://github.com/dart-lang/dart-tutorials-samples/tree/master/web/target07-polymer/hangman"
         target="_blank">hangman</a>
    </li>
  </ul>
</aside>

<hr>

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
The next target,
<a href="/docs/tutorials/custom-elements/">Target 8: Define a Custom DOM Tag</a>,
covers custom elements
and how to use templates to define their structure.

* [Using conditional instantiation](#using-conditional-instantiation)
* [Using iteration with templates](#using-iteration-with-templates)
* [Using iteration with other elements](#as-attributes)
* [Other resources](#other-resources)

##Using conditional instantiation

In the example application running below,
you provide six words to fill in the blanks of a hidden text.
Try it! Type six items into the input fields.
The results appear only after you have entered a value for all six items.
After you've entered all six items, delete one. The paragraph disappears.

<iframe class="running-app-frame"
        style="height:300px;width:300px;"
        src="http://dart-lang.github.com/dart-tutorials-samples/web/target07/adlibitum/web/out/adlibitum.html">
</iframe>

You can find the complete source code for this sample on github at
<a href="https://github.com/dart-lang/dart-tutorials-samples/tree/master/web/target07/adlibitum" target="_blank">adlibitum</a>.

The sample uses a template conditional
to display the paragraphs under the input fields.

![Paragraph elements are conditionally instantiated](images/template-conditional.png)

The value of each input field is bound to an observable Dart String
using two-way data binding as described in the
<a href="/docs/tutorials/web-ui/">previous target</a>.
The binding keeps the value of each input field in sync with
the value of a Dart string as the user types.

![Two-way data binding in adlibitum sample](images/adlib-databinding.png)

The paragraph underneath the six input fields appears
if all input fields have a value.
Together, a template conditional in the HTML code
and an observable boolean getter in the Dart code
determine when to display the paragraph.
The Dart code contains a getter called `show`
that returns true if all of the fields have a value
or false if one or more is empty.
Observables determine that `show` depends on the six strings,
and notify a change on `show` if any strings change.

![HTML code for a conditionally instantiated template](images/html-ifcode.png)

The template is declared with the &lt;template&gt; tag.
The template tag has an `instantiate` attribute,
which contains the expression
that determines whether the template should be activated or deactivated.

The instantiate attribute takes the form `if exp`,
where `exp` is a valid Dart expression
that evaluates to either true or false.
In this example,
the expression is a call to a top-level getter.
When the expression is true,
the contents of the template are instantiated.
Otherwise, any elements that were previously instantiated
are removed from the DOM.

In this example,
the conditional template just contains simple paragraph elements
in which some of the text is bound to the values in input fields.

##Using iteration with templates

The sample running below
is a simplified version of the children's hangman game.
Try it! Type letters in the field to guess the word.

<iframe class="running-app-frame"
        style="height:250px;width:300px;"
        src="http://dart-lang.github.com/dart-tutorials-samples/web/target07/simplehangman/web/out/simplehangman.html">
</iframe>

You can find the complete source code for this sample on github at
<a href="https://github.com/dart-lang/dart-tutorials-samples/tree/master/web/target07/simplehangman" target="_blank">simplehangman</a>.

The hangman example uses template iteration in two places:
to reveal the correctly guessed letters in the
hyphenated version of the hidden word
and to display the list of incorrectly guessed letters.

![Two uses of template iteration](images/template-loop.png)

The Dart code creates two lists,
one for the hyphenated word and one for the incorrectly guessed letters.
Each list contains strings.
Each string contains a single hyphen or letter.
The program calls `toObservable()` on each list
to make Web UI track changes to the list.

{% prettify dart %}
List<String> hyphens      = toObservable(answerHyphenated.split(''));
List<String> wrongletters = toObservable(new List());
{% endprettify %}

In the HTML code,
a template loop iterates over the list named `hyphens`
to reveal each letter of the word when it is correctly guessed.
Another template loop iterates over the list named `wrongletters`
to display the incorrectly guessed letters.

{% prettify html %}
<template iterate="character in hyphens"> {% raw %}{{character}}{% endraw %} </template>
...
<template iterate="wrongchar in wrongletters"> {% raw  %}{{wrongchar}}{% endraw %} </template>
{% endprettify %}

When the user types a character,
the event handler for the input field either adds a letter to `wrongletters`
or reveals a letter in `hyphens`.
Because these lists are observable,
a change causes the associated template loop
to re-evaluate and to update the UI.
The following diagram shows the relationship between
the Dart code, the HTML code, and the UI
that manages the list of incorrectly guessed letters.

![Using template loops to display a list of strings](images/wrongletters-detail.png)

The &lt;template&gt; tag has an attribute called `iterate`.
The value of this attribute takes the form 
<code><em>loopvar</em> in <em>iterable</em></code>,
where _iterable_ is a Dart expression that evaluates to an
<a href="http://api.dartlang.org/dart_core/Iterable.html"
   target="_blank">Iterable</a>
object.
The template iterates over the iterable object
and assigns each value to _loopvar_,
a new variable that is in scope for the body of the template iterate element.
The HTML code for this example
uses one-way data binding to embed
the value of `wrongchar` in the page,
thus displaying a list of characters.

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

<iframe class="running-app-frame"
        style="height:250px;width:350px;"
        src="http://dart-lang.github.com/dart-tutorials-samples/web/target07/hangman/web/out/hangman.html">
</iframe>

You can find the complete source code for this sample on github at
<a href="https://github.com/dart-lang/dart-tutorials-samples/tree/master/web/target07/hangman" target="_blank">hangman</a>.

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
    List<String> row = gallows[i].split("");
    hangmandisplay[i] = toObservable(row);
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
the observables are re-evaluated and
the gallows UI is updated.

##Other resources

<ul>
  <li>
    Another use of the &lt;template&gt; tag
    is to define the contents of a custom element.
    The next target,
    <a href="/docs/tutorials/custom-elements/">Define a Custom DOM Tag</a>,
    provides an example that converts numbers based on a simple ratio.
  </li>
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
