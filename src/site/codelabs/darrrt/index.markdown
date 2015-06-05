---
layout: tutorial
title: "Avast, Ye Pirates: Write a Web App"
description: "Take your first step to learning Dart fast."
snippet_img: images/piratemap.jpg
has-permalinks: true
tutorial:
  id: trydart
header:
  css: ["/codelabs/darrrt/darrrt.css"]
---

# {{ page.title }}

<!-- Devon's final version:
  https://dartpad.dartlang.org/778dc0945330263cf7c7 -->
<!-- initial Dartpad version:
  https://dartpad.dartlang.org/48c51101261818c66083 -->
<!-- https://gist.github.com/Sfshaza/48c51101261818c66083 -->

In this code lab,
you use DartPad to build a pirate badge generator from a skeleton app.
The sample app provides a brief look at some Dart language and library features.
This code lab assumes that you have some programming experience.

<strong>Build this app!</strong>

xxx: This is an older version of the app. I haven't updated it yet.
  This is currently hosted from the examples/ directory, but that
  should probably be changed... to GitHub, maybe.

<iframe class="running-app-frame"
        style="height:220px;width:550px;"
        src="examples/6-piratebadge/piratebadge.html">
</iframe>

<hr>

<div class="piratemap" markdown="1" style="min-height:325px">

## Map

* [Step 0: Get acquainted with the sample code](#set-up)
* [Step 1: Run the skeleton app](#step-one)
* [Step 2: Add an input field](#step-two)
* [Step 3: Add a button](#step-three)
* [Step 4: Create a class](#step-four)
* [What next?](#whatnext)
* [Summary and resources](#resources)

</div>

xxx: The following steps have been removed from this code lab:

* Step 5: Save to local storage
* Step 6: Read names from JSON file using HttpRequest
* Step 7: Build and run the app

These features are not yet supported in DartPad. The code in the dartpad-darrrt
branch has not yet been updated to remove steps 5 and 6. NOTE: we should
find a way to add async/await back into this code lab.

<hr>

xxx: I have filed some bugs that you may want to be aware of:

* [430: Pasted code into DartPad needs manual formatting](https://github.com/dart-lang/dart-pad/issues/430)
* [431: Add a reset button](https://github.com/dart-lang/dart-pad/issues/431)
* [432: Undo is broken](https://github.com/dart-lang/dart-pad/issues/432)

##Step 0: Get acquainted with the sample code {#set-up}

The code for this code lab lives on GitHub in the
[one-hour-codelab repo](https://github.com/dart-lang/one-hour-codelab/tree/dartpad-darrrt).
(xxx: currently, in the "dartpad-darrrt" branch)

You can
[view the sample code directly on GitHub](https://github.com/dart-lang/one-hour-codelab/tree/dartpad-darrrt)
or you can download it.

### <i class="fa fa-anchor"> </i> Look at the one-hour-codelab sample.

<div class="trydart-step-details" markdown="1">
The files used by this code lab live in the `darrrt` directory.
Each numbered directory under `darrrt` contains the code for
the corresponding step in this code lab, when that step is complete.

`1-blankbadge`
: Skeleton app

`2-inputnamebadge`
: Adds an input field for typing a pirate name

`3-buttonbadge`
: Adds a button which pre-fills the text field

`4-classbadge`
: Creates a class to represent, and generate, a pirate name

xxx - Step 4 may become the final step.

`6-piratebadge`
: Final version of the app

</div>

<div class="row"> <div class="col-md-7" markdown="1">

</div> <div class="col-md-5" markdown="1">

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

<hr>

##Step 1: Run the skeleton app {#step-one}

In this step, you run the skeleton version of the app in DartPad.

### <i class="fa fa-anchor"> </i> Run the app in DartPad.

DartPad is an interactive web app that lets you immediately play with
Dart in your browser without having to download or install any software,
or do any special setup. It just works!

The following screen shot shows DartPad's UI. This example
contains an intentional error to show you how DartPad handles problems
that it detects:

<img src="images/AnnotatedDartPad.png" alt="A screen shot of DartPad running the skeleton version of the client code">

The code appears on the left under the **DART**, 
**HTML**, and **CSS** tabs, respectively.
The **HTML OUTPUT** appears on the right and
the **CONSOLE** tab shows any console output.
You can always re-start the app using the **Run** button.
If the analysis server detects any errors, they are printed
at the bottom of the screen.

<a href="https://dartpad.dartlang.org/48c51101261818c66083" target="_blank">Launch the skeleton app</a>

Click the **Run** button.
You should see a TO DO comment above a red and white name badge.

<hr>

### <i class="fa fa-anchor"> </i> Review the code.

<div class="trydart-step-details" markdown="1">
Get familiar with the HTML and the Dart code for the skeleton version of
the app.
</div>

<div class="trydart-step-details" markdown="1">
#### index.html
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details" markdown="1">
{% prettify html %}
<h1>Pirate badge</h1>

[[highlight]]<div class="widgets">[[/highlight]]
  [[highlight]]TO DO: Put the UI widgets here.[[/highlight]]
[[highlight]]</div>[[/highlight]]
<div class="badge">
  <div class="greeting">
    Arrr! Me name is
  </div>
  <div class="name">
    [[highlight]]<span id="badgeName"> </span>[[/highlight]]
  </div>
</div>
{% endprettify %}

</div>
<div class="trydart-filename">index.html</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* During this code lab,
  all the changes you make to `index.html` are within
  the &lt;div&gt; element identified with the class `widgets`.

* In later steps,
  the &lt;span&gt; element with the ID `badgeName`
  is programmatically updated by the Dart code
  based on user input.

</div> </div>

<div class="trydart-step-details" markdown="1">
#### main.dart
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
[[highlight]]void main() {[[/highlight]]
  [[highlight]]// Your app starts here.[[/highlight]]
[[highlight]]}[[/highlight]]
{% endprettify %}
</div>
<div class="trydart-filename">main.dart</div>

</div> <div class="col-md-5" markdown="1">

* This file contains the single entry point for the app&mdash;the
  `main()` function.

* The `main()` function is a top-level function.

* A top-level variable or function is one that is declared outside
  a class definition.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}
</div> </div>

<hr>

##Step 2: Add an input field {#step-two}

In this step, you add an input field to the app.
As the user types into the text field,
the Dart code updates the badge from the value of the text field.

### <i class="fa fa-anchor"> </i> Edit index.html.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

Replace the "TO DO" line in the HTML code with the &lt;input&gt; tag.

{% prettify html %}
...
<div class="widgets">
  [[highlight]]<div>[[/highlight]]
    [[highlight]]<input type="text" id="inputName" maxlength="15">[[/highlight]]
  [[highlight]]</div>[[/highlight]]
</div>
...
{% endprettify %}
</div>
<div class="trydart-filename">index.html</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* The ID for the input element is `inputName`.
Dart uses CSS selectors, such as `#inputName`,
to get elements from the DOM.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

### <i class="fa fa-anchor"> </i> Edit main.dart.

<div class="trydart-step-details" markdown="1">

Import the `dart:html`
library at the top of the file
(below the copyright).

</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details" markdown="1">

{% prettify dart %}
[[highlight]]import 'dart:html';[[/highlight]]
{% endprettify %}
</div>

<div class="trydart-filename">main.dart</div>

</div> <div class="col-md-5" markdown="1">

* This imports _all_ classes and other resources from dart:html.

* The dart:html library contains the classes for all DOM element types,
  in addition to functions for accessing the DOM.

* Later you'll use import with the `show` keyword,
  which imports only the specified classes.

* DartPad helpfully warns you that the import is unused.
  Don't worry about it. You'll fix it in the next step.

</div> </div>

<div class="trydart-step-details" markdown="1">

<hr>

Register a function to handle input events on the input field.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details" markdown="1">

{% prettify dart %}
void main() {
  [[highlight]]querySelector('#inputName').onInput.listen(updateBadge);[[/highlight]]
}
{% endprettify %}
</div>

<div class="trydart-filename">main.dart</div>

</div> <div class="col-md-5" markdown="1">

* The `querySelector()` function, defined in
  dart:html, gets the specified element from the DOM.
  Here, the code uses the selector `#inputName`
  to specify the input field.

* The object returned from `querySelector()` 
  _is_ the DOM element object.

* Mouse and keyboard events are served over a stream.

* A Stream provides an asynchronous sequence of data.
  Using the `listen()` method, a stream client
  registers a callback function that gets called when
  data is available.

* `onInput.listen()` listens to the text field's event stream for input events.
  When such an event occurs, `updateBadge()` is called.

* An input event occurs when the user presses a key.

* You can use either single or double quotes to create a string.

* DartPad warns you that the function doesn't exist.
  Let's fix that now.

</div> </div>

<div class="trydart-step-details" markdown="1">

<hr>

Implement the event handler as a top-level function.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details" markdown="1">

{% prettify dart %}
...

[[highlight]]void updateBadge(Event e) {[[/highlight]]
  [[highlight]]querySelector('#badgeName').text = e.target.value;[[/highlight]]
[[highlight]]}[[/highlight]]
{% endprettify %}
</div>

<div class="trydart-filename">main.dart</div>

</div> <div class="col-md-5" markdown="1">

* This function sets the text of the `badgeName` element from the value of the input field.

* `Event e` is the argument to the updateBadge function.
  The argument's name is `e`; its type is `Event`.

* You can tell that `updateBadge()` is an event handler because
  its parameter is an `Event` object.

* The element that generated the event, the input field, is `e.target`.

* DartPad prints the warning: The getter 'value' is not defined for the
  class 'EventTarget'. You fix that in the next step.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

<div class="trydart-step-details" markdown="1">

<hr>

Fix the warning message.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details" markdown="1">

{% prettify dart %}
...

void updateBadge(Event e) { 
  querySelector('#badgeName').text = [[highlight]](e.target as InputElement)[[/highlight]].value;
}
{% endprettify %}
</div>

<div class="trydart-filename">main.dart</div>

</div> <div class="col-md-5" markdown="1">

* In this example, `e.target` is the input element
  that generated the event.

* The `as` keyword typecasts `e.target` to an
  `InputElement` to silence warnings from DartPad.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>


### <i class="fa fa-anchor"> </i> Test the app.

<div class="trydart-step-details" markdown="1">

Click the **Run** button.

Type in the input field to see the input displayed in the name badge.

#### Problems?

Check your code against the files in `2-inputnamebadge`.

xxx: These links go to the master, not the dartpad-darrrt  branch.
     (Fewer links to fix later.)

* [index.html](https://github.com/dart-lang/one-hour-codelab/blob/master/2-inputnamebadge/web/index.html)

* [main.dart](https://github.com/dart-lang/one-hour-codelab/blob/master/2-inputnamebadge/web/main.dart)
</div>

<hr> 

##Step 3: Add a button {#step-three}

In this step, you add a button to the app.
The button is enabled when the text field contains no text.
When the user clicks the button,
the app puts the name `Anne Bonney` on the badge.

### <i class="fa fa-anchor"> </i> Edit index.html.

<div class="trydart-step-details" markdown="1">
Add the &lt;button&gt; tag below the input field.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify html %}
...
<div class="widgets">
  <div>
    <input type="text" id="inputName" maxlength="15">
  </div>
  [[highlight]]<div>[[/highlight]]
    [[highlight]]<button id="generateButton">Aye! Gimme a name!</button>[[/highlight]]
  [[highlight]]</div>[[/highlight]]
</div>
...
{% endprettify %}
</div>

<div class="trydart-filename">index.html</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* The button has the ID `generateButton` so
the Dart code can get the element.

</div> </div>

### <i class="fa fa-anchor"> </i> Edit main.dart.

<div class="trydart-step-details" markdown="1">
Below the import, declare a top-level variable to hold the `ButtonElement`.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
import 'dart:html';

[[highlight]]ButtonElement genButton;[[/highlight]]
{% endprettify %}
</div>

<div class="trydart-filename">main.dart</div>

</div> <div class="col-md-5" markdown="1">

* ButtonElement is one of many different kinds of DOM elements
provided by the dart:html library.

* Variables, including numbers, initialize to null if no value is provided.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

<div class="trydart-step-details" markdown="1">

<hr>

Wire up the button with an event handler.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
void main() {
  querySelector('#inputName').onInput.listen(updateBadge);
  [[highlight]]genButton = querySelector('#generateButton');[[/highlight]]
  [[highlight]]genButton.onClick.listen(generateBadge);[[/highlight]]
}
{% endprettify %}
</div>

<div class="trydart-filename">main.dart</div>

</div> <div class="col-md-5" markdown="1">

* `onClick` registers a mouse click handler.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

<div class="trydart-step-details" markdown="1">

<hr>

Add a top-level function that changes the name on the badge.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
...

[[highlight]]void setBadgeName(String newName) {[[/highlight]]
  [[highlight]]querySelector('#badgeName').text = newName;[[/highlight]]
[[highlight]]}[[/highlight]]
{% endprettify %}
</div>

<div class="trydart-filename">main.dart</div>

</div> <div class="col-md-5" markdown="1">

* The function updates the HTML page with a new name.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

<div class="trydart-step-details" markdown="1">

<hr>

Implement the click handler for the button.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
...

[[highlight]]void generateBadge(Event e) {[[/highlight]]
  [[highlight]]setBadgeName('Anne Bonney');[[/highlight]]
[[highlight]]}[[/highlight]]
{% endprettify %}
</div>

<div class="trydart-filename">main.dart</div>

</div> <div class="col-md-5" markdown="1">

* This function sets the badge name to `Anne Bonney`.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

<div class="trydart-step-details" markdown="1">

<hr>
Modify `updateBadge()` to call `setBadgeName()`.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
void updateBadge(Event e) {
  [[highlight]]String inputName =[[/highlight]] (e.target as InputElement).value;
  [[highlight]]setBadgeName(inputName);[[/highlight]]
}
{% endprettify %}
</div>

<div class="trydart-filename">main.dart</div>

</div> <div class="col-md-5" markdown="1">

* Assign the input field's value to a local string.

</div></div>


<div class="trydart-step-details" markdown="1">

<hr>

Add a skeleton if-else statement to `updateBadge()`.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
void updateBadge(Event e) {
  String inputName = (e.target as InputElement).value;
  setBadgeName(inputName);
  [[highlight]]if (inputName.trim().isEmpty) {[[/highlight]]
    [[highlight]]// To do: add some code here.[[/highlight]]
  [[highlight]]} else {[[/highlight]]
    [[highlight]]// To do: add some code here.[[/highlight]]
  [[highlight]]}[[/highlight]]
}
{% endprettify %}
</div>

<div class="trydart-filename">main.dart</div>

</div> <div class="col-md-5" markdown="1">

* The `String` class has useful functions and properties 
for working with string data,
such as `trim()` and `isEmpty`.

* String comes from the `dart:core` library,
which is automatically imported into every Dart program.

* Dart has common programming language constructs like `if`-`else`.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Now fill in the if-else statement to modify the button as needed.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
void updateBadge(Event e) {
  String inputName = (e.target as InputElement).value;
  setBadgeName(inputName);
  if (inputName.trim().isEmpty) {
    [[highlight]]genButton..disabled = false[[/highlight]]
             [[highlight]]..text = 'Aye! Gimme a name!';[[/highlight]]
  } else {
    [[highlight]]genButton..disabled = true[[/highlight]]
             [[highlight]]..text = 'Arrr! Write yer name!';[[/highlight]]
  }
}
{% endprettify %}
</div>

<div class="trydart-filename">main.dart</div>

</div> <div class="col-md-5" markdown="1">

<ul markdown="1">
<li markdown="1">The cascade operator (`..`) allows you to perform
   multiple operations on the members of a single object. 
</li>
<li markdown="1"> The `updateBadge()` code uses the cascade operator
   to set two properties on the button element.
   The result is the same as this more verbose code:

{% prettify dart %}
genButton.disabled = false;
genButton.text = 'Aye! Gimme a name!';
{% endprettify %}
</li>
</ul>

</div></div>


### <i class="fa fa-anchor"> </i> Test the app.

<div class="trydart-step-details" markdown="1">

Click the **Run** button.

Type in the input field.
Remove the text from the input field.
Click the button.

#### Problems?

Check your code against the files in `3-buttonbadge`.

xxx: These links go to the master, not the dartpad-darrrt  branch.
     (Fewer links to fix later.)

* [index.html](https://github.com/dart-lang/one-hour-codelab/blob/master/3-buttonbadge/web/index.html)

* [main.dart](https://github.com/dart-lang/one-hour-codelab/blob/master/3-buttonbadge/web/main.dart)

</div>

<hr>

##Step 4: Create a PirateName class {#step-four}

In this step, you change only the Dart code.
You create a class to represent a pirate name.
When created, an instance of this class
randomly selects a name and appellation from a list,
or optionally you can provide a name
and an appellation to the constructor.

### <i class="fa fa-anchor"> </i> Edit main.dart.

<div class="trydart-step-details" markdown="1">
Add an import to the top of the file.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
import 'dart:html';

[[highlight]]import 'dart:math' show Random;[[/highlight]]
{% endprettify %}
</div>

<div class="trydart-filename">main.dart</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* Using the `show` keyword,
you can import only the classes, functions, or properties you need.

* `Random` provides a random number generator.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Add a class declaration to the bottom of the file.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
...

[[highlight]]class PirateName {
}[[/highlight]]
{% endprettify %}
</div>

<div class="trydart-filename">main.dart</div>

</div> <div class="col-md-5" markdown="1">

* The class declaration provides the class name.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Create a class-level Random object.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
class PirateName {
  [[highlight]]static final Random indexGen = new Random();[[/highlight]]
}
{% endprettify %}
</div>

<div class="trydart-filename">main.dart</div>

</div> <div class="col-md-5" markdown="1">

* `static` defines a class-level field. That is,
the random number generator is shared with all
instances of this class.

* Use `new` to call a constructor.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Add two instance variables to the class,
one for the first name and one for the appellation.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
class PirateName {
  static final Random indexGen = new Random();
  [[highlight]]String _firstName;[[/highlight]]
  [[highlight]]String _appellation;[[/highlight]]
}
{% endprettify %}
</div>

<div class="trydart-filename">main.dart</div>

</div> <div class="col-md-5" markdown="1">

* Private variables start with underscore (`_`).
  Dart has no `private` keyword.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Create two static lists within the class
that provide a small collection of names and appellations to choose from.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
class PirateName {
  ...
  [[highlight]]static final List names = [[[/highlight]]
    [[highlight]]'Anne', 'Mary', 'Jack', 'Morgan', 'Roger', 'Bill', 'Ragnar',[[/highlight]]
    [[highlight]]'Ed', 'John', 'Jane'[[/highlight]]
  [[highlight]]];[[/highlight]]
  [[highlight]]static final List appellations = [[[/highlight]]
    [[highlight]]'Jackal', 'King', 'Red', 'Stalwart', 'Axe', 'Young', 'Brave',[[/highlight]]
    [[highlight]]'Eager', 'Wily', 'Zesty'[[/highlight]]
  [[highlight]]];[[/highlight]]
}
{% endprettify %}
</div>

<div class="trydart-filename">main.dart</div>

</div> <div class="col-md-5" markdown="1">

* `final` variables cannot change.

* Lists are built into the language.
These lists are created using list literals.

* The `List` class provides the API for lists.

</div></div>


<div class="trydart-step-details" markdown="1">

<hr>

Provide a constructor for the class.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
class PirateName {
  ...
  [[highlight]]PirateName({String firstName, String appellation}) {[[/highlight]]
    [[highlight]]if (firstName == null) {[[/highlight]]
      [[highlight]]_firstName = names[indexGen.nextInt(names.length)];[[/highlight]]
    [[highlight]]} else {[[/highlight]]
      [[highlight]]_firstName = firstName;[[/highlight]]
    [[highlight]]}[[/highlight]]
    [[highlight]]if (appellation == null) {[[/highlight]]
      [[highlight]]_appellation =[[/highlight]]
          [[highlight]]appellations[indexGen.nextInt(appellations.length)];[[/highlight]]
    [[highlight]]} else {[[/highlight]]
      [[highlight]]_appellation = appellation;[[/highlight]]
    [[highlight]]}[[/highlight]]
  [[highlight]]}[[/highlight]]
}
{% endprettify %}
</div>

<div class="trydart-filename">main.dart</div>

</div> <div class="col-md-5" markdown="1">

* Constructors have the same name as the class.

* The parameters enclosed in curly brackets (`{` and `}`)
are optional, named parameters.

* The `nextInt()` function gets a new random integer
from the random number generator.

* Use square brackets (`[` and `]`) to index into a list.

* The `length` property returns the number of items in a list.

* The code uses a random number as an index into the list.

</div> </div>

<div class="trydart-step-details" markdown="1">

<hr>

Provide a getter for the pirate name.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
class PirateName {
  ...
  [[highlight]]String get pirateName =>[[/highlight]]
    [[highlight]]_firstName.isEmpty ? '' : '$_firstName the $_appellation';[[/highlight]]
}
{% endprettify %}
</div>

<div class="trydart-filename">main.dart</div>

</div><div class="col-md-5" markdown="1">

* Getters are special methods that provide read access to an object’s properties.

* The ternary operator `?:` is short-hand for an if-then-else statement.

* String interpolation
(`'$_firstName the $_appellation'`)
lets you easily build strings from other objects.

* The fat arrow (` => expr; `) syntax is a shorthand for `{ return expr; }`.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Override the toString() method.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
class PirateName {
  ...
  [[highlight]]String toString() => pirateName;[[/highlight]]
}
{% endprettify %}
</div>

<div class="trydart-filename">main.dart</div>

</div><div class="col-md-5" markdown="1">

* Because the Object implementation of `toString()` doesn't give much
  information, many classes override `toString()`.

* When you call `print(anObject)` for any non-String, it prints the value
  returned by `anObject.toString()`.

* Overriding `toString()` can be especially helpful for debugging or logging.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Modify the function `setBadgeName()` to use a PirateName instead of a String:
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
void setBadgeName([[highlight]]PirateName[[/highlight]] newName) {
  querySelector('#badgeName').text = newName[[highlight]].pirateName[[/highlight]];
}
{% endprettify %}
</div>

<div class="trydart-filename">main.dart</div>

</div><div class="col-md-5" markdown="1">

* This code calls the getter to get the PirateName as a string.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Change `updateBadge()` to generate a PirateName based on the input field value.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
void updateBadge(Event e) {
  String inputName = (e.target as InputElement).value;
  
  [[highlight]]setBadgeName(new PirateName(firstName: inputName));[[/highlight]]
  ...
}
{% endprettify %}
</div>

<div class="trydart-filename">main.dart</div>

</div><div class="col-md-5" markdown="1">

* The call to the constructor provides a value for one optional named parameter.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Change `generateBadge()` to generate a PirateName instead of using `Anne Bonney`.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
void generateBadge(Event e) {
  setBadgeName([[highlight]]new PirateName()[[/highlight]]);
}
{% endprettify %}
</div>

<div class="trydart-filename">main.dart</div>

</div><div class="col-md-5" markdown="1">

* In this case, the call to the constructor passes no parameters.

</div></div>

### <i class="fa fa-anchor"> </i> Test the app.

<div class="trydart-step-details" markdown="1">
  
Click the **Run** button.

Type in the input field.
Remove the text from the input field.
Click the button.

#### Problems?

Check your code against the files in `4-classbadge`.

xxx: These links go to the master, not the dartpad-darrrt  branch.
     (Fewer links to fix later.)

* [index.html](https://github.com/dart-lang/one-hour-codelab/blob/master/4-classbadge/web/index.html)

* [main.dart](https://github.com/dart-lang/one-hour-codelab/blob/master/4-classbadge/web/main.dart)

</div>

<hr>

##What next? {#whatnext}

Now that you've written your app, what do you do now? Here are some suggestions.

### <i class="fa fa-anchor"> </i> Deploy a server and your app

<div class="trydart-step-details" markdown="1">

The [server side code lab](/codelabs/server/) allows you
create a pirate crew by storing pirate names to a RESTful Dart server.

Also, see the [Write HTTP Clients & Servers](/docs/tutorials/httpserver/)
tutorial if you are interested in server-side programming.

</div>

### <i class="fa fa-anchor"> </i> Check out the samples.

<div class="trydart-step-details" markdown="1">

Run some Dart programs online and check out the source code
on our [Samples page](/samples/).
</div>

### <i class="fa fa-anchor"> </i> Read the tutorials.

<div class="trydart-step-details" markdown="1">
Learn more about Dart from
the [Dart tutorials](/docs/tutorials/).
</div>

<hr>

##Summary and resources {#resources}

### <i class="fa fa-anchor"> </i> Think about what you've done!

<div class="trydart-step-details" markdown="1">

This code lab provided a tour of most Dart language features
and many library features.
Here's where to go to learn more.

#### The Dart language

<a href="/docs/dart-up-and-running/ch02.html">
A Tour of the Dart Language</a>
shows you how to use each major Dart feature,
from variables and operators to classes and libraries.
This code lab introduced the following Dart language features,
all of which are covered in more detail in the language tour.

* string interpolation (`'$_firstName the $_appellation'`)
* the cascade operator (`..`)
* the fat arrow (`=>`) function syntax
* the ternary operator (`?:`)
* named constructors (`PirateName.fromJSON(...)`)
* optional parameters
* a class
* getters
* instance methods and fields
* class level methods and fields
* top-level variables and functions
* typecasting with `as` (`(e.target as InputElement)`)
* import, and import with `show` (`import 'dart:math' show Random;`)
* generics
* asynchrony support (`async` and `await`) - xxx: NO!
</div>

### <i class="fa fa-anchor"> </i> Online documentation

<div class="trydart-step-details" markdown="1">


#### The Dart libraries

* <a href="/docs/dart-up-and-running/ch03.html">
A Tour of the Dart Libraries</a>
shows you how to use the major features in Dart’s libraries.

#### API documentation for classes

* <a href="https://api.dartlang.org/dart_core/String.html" target="_blank">String</a>,
<a href="https://api.dartlang.org/dart_core/List.html" target="_blank">List</a>,
<a href="https://api.dartlang.org/dart_core/Map.html" target="_blank">Map</a>,
<a href="https://api.dartlang.org/dart_math/Random.html" target="_blank">Random</a>,
<a href="https://api.dartlang.org/dart_html/InputElement.html" target="_blank">InputElement</a>,
<a href="https://api.dartlang.org/dart_html/ButtonElement.html" target="_blank">ButtonElement</a>,
<a href="https://api.dartlang.org/dart_html/Event.html" target="_blank">Event</a>,
<a href="https://api.dartlang.org/dart_async/Future.html" target="_blank">Future</a>, and
<a href="https://api.dartlang.org/dart_async/Stream.html" target="_blank">Stream</a>

#### API documentation for libraries

* <a href="https://api.dartlang.org/dart_core.html" target="_blank">dart:core</a>,
<a href="https://api.dartlang.org/dart_math.html" target="_blank">dart:math</a>,
<a href="https://api.dartlang.org/dart_html.html" target="_blank">dart:html</a>,
<a href="https://api.dartlang.org/dart_async.html" target="_blank">dart:async</a>, and
<a href="https://api.dartlang.org/dart_convert.html" target="_blank">dart:convert</a>

#### API documentation for JSON

* <a href="https://api.dartlang.org/dart_convert.html#JSON" target="_blank">JSON</a>


</div>

### <i class="fa fa-anchor"> </i> Feedback

<div class="trydart-step-details" markdown="1">

Please provide feedback to the appropriate repo:

* [www.dartlang.org repo](https://github.com/dart-lang/www.dartlang.org/issues)
* [DartPad repo](https://github.com/dart-lang/dart-pad/issues)

</div>


