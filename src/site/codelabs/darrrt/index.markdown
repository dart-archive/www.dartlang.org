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

This code lab introduces you to the Dart language and libraries
by walking you through the process of building a simple web app.

All you need is a browser and some familiarity with programming.
You'll use the browser to run **DartPad**,
a tool for writing and running simple Dart apps.
(By the way, both the client and the server side of DartPad
are themselves Dart apps.)

<strong>Build this app!</strong>

<iframe class="running-app-frame"
        style="height:220px;width:550px;"
        src="examples/index.html">
</iframe>

<hr>

<div class="piratemap" markdown="1" style="min-height:325px">

## Map

* [Step 1: Run the skeleton app](#step-one)
* [Step 2: Add an input field](#step-two)
* [Step 3: Add a button](#step-three)
* [Step 4: Create a class](#step-four)
* [Step 5: Read a JSON file](#step-five)
* [What next?](#whatnext)
* [Summary and resources](#resources)
</div>

<div class="row"> <div class="col-md-7" markdown="1">

</div> <div class="col-md-5" markdown="1">

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

<hr>

##Step 1: Run the skeleton app {#step-one}

In this step, you run the skeleton version of the app in DartPad.

### <i class="fa fa-anchor"> </i> Run the app in DartPad.

<a href="{{site.custom.dartpad.direct-link}}/9642dce02da158457f12" target="_blank">Open the skeleton app in DartPad.</a>

Click the **Run** button and make sure that the **HTML OUTPUT** tab
is selected. You should see a red-and-white name badge, plus some text,
as shown in the following screenshot:

<img src="images/InitialDartPad.png" alt="A screenshot of the output created in the skeleton app">

DartPad is an interactive web app that lets you immediately play with
Dart in your browser without having to download or install any software,
or do any special setup. It just works!

The following screenshot shows DartPad's UI. This example
contains an intentional error to show you how DartPad handles problems
that it detects.

<img src="images/AnnotatedDartPad.png" alt="A screenshot of DartPad running the skeleton version of the client code">

The code appears on the left under the **DART**, 
**HTML**, or **CSS** tab.
Output appears on the right under the
**HTML OUTPUT** or **CONSOLE** tab.
You can always restart the app using the **Run** button.
If the analyzer detects problems, errors and warnings appear
at the bottom of the screen.

<hr>

### <i class="fa fa-anchor"> </i> Review the code.

<div class="trydart-step-details" markdown="1">
Get familiar with the Dart and HTML code (in `main.dart`
and `index.html`, respectively) for the skeleton version of
the app. 
</div>

<div class="trydart-step-details" markdown="1">
#### **main.dart**
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

{% prettify dart %}
[[highlight]]void main() {[[/highlight]]
  [[highlight]]// Your app starts here.[[/highlight]]
  [[highlight]]// In Step 2, you'll add code to listen for updates for the pirate badge.[[/highlight]]
[[highlight]]}[[/highlight]]
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* The `main()` function is the single entry point for the app.

* `main()` is a top-level function.

* A top-level variable or function is one that is declared outside
  a class definition.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}
</div> </div>

<div class="trydart-step-details" markdown="1">
#### **index.html**
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

</div> <div class="col-md-5" markdown="1">

* All of the changes you make to the HTML in this code lab
  are within the &lt;div&gt; element identified with the class `widgets`.

* In later steps,
  the &lt;span&gt; element with the ID `badgeName`
  is programmatically updated by the Dart code
  based on user input.

</div> </div>

##Step 2: Add an input field {#step-two}

In this step, you add an input field to the app.
As the user types into the text field,
the Dart code updates the badge from the value of the text field.

### <i class="fa fa-anchor"> </i> Edit the Dart code.

<div class="trydart-step-details" markdown="1">

Import the `dart:html` library at the top of the code, below the copyright.

</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details" markdown="1">

{% prettify dart %}
[[highlight]]import 'dart:html';[[/highlight]]
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

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

* DartPad warns you that `updateBadge` doesn't exist.
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

</div> <div class="col-md-5" markdown="1">

* In this example, `e.target` is the input element
  that generated the event.

* InputElement is one of many different kinds of DOM elements
  provided by the dart:html library.

* The `as` keyword typecasts `e.target` to an
  `InputElement` to silence warnings from DartPad.


&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

### <i class="fa fa-anchor"> </i> Edit the HTML code.

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

</div> <div class="col-md-5" markdown="1">

* The ID for the input element is `inputName`.
Dart uses CSS selectors, such as `#inputName`,
to get elements from the DOM.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>


### <i class="fa fa-anchor"> </i> Test it!

<div class="trydart-step-details" markdown="1">

Click the **Run** button.

Type in the input field.
The name badge updates to display what you've typed.

#### Problems?

Check your code against the solution.

* <a href="https://github.com/dart-lang/one-hour-codelab/tree/master/darrrt/2-inputnamebadge/web/main.dart" target="_blank">main.dart</a>
* <a href="https://github.com/dart-lang/one-hour-codelab/tree/master/darrrt/2-inputnamebadge/web/index.html" target="_blank">index.html</a>

Or
<a href="{{site.custom.dartpad.direct-link}}/e78a858a1b8cfce15bbf" target="_blank">open the solution in DartPad</a>.

You may notice that the HTML displayed in DartPad is a bit different
than what is shown on GitHub.
DartPad requires only the portion of
the HTML specific to the example&mdash;
what appears between the `<body>` tags in the full HTML file.

</div>

<hr> 

##Step 3: Add a button {#step-three}

In this step, you add a button to the app.
The button is enabled when the text field contains no text.
When the user clicks the button,
the app puts the name `Anne Bonney` on the badge.

### <i class="fa fa-anchor"> </i> Edit the Dart code.

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

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

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

### <i class="fa fa-anchor"> </i> Edit the HTML code.

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

</div> <div class="col-md-5" markdown="1">

* The button has the ID `generateButton` so
the Dart code can get the element.

</div> </div>

### <i class="fa fa-anchor"> </i> Test it!

<div class="trydart-step-details" markdown="1">

Click the **Run** button.

Type in the input field.
Remove the text from the input field.
Click the button.

#### Problems?

Check your code against the solution.

* <a href="https://github.com/dart-lang/one-hour-codelab/tree/master/darrrt/3-buttonbadge/web/main.dart" target="_blank">main.dart</a>
* <a href="https://github.com/dart-lang/one-hour-codelab/tree/master/darrrt/3-buttonbadge/web/index.html" target="_blank">index.html</a>

Or
<a href="{{site.custom.dartpad.direct-link}}/feac8311871e29bc50a7" target="_blank">open the solution in DartPad</a>.

</div>

<hr>

##Step 4: Create a class {#step-four}

In this step, you create a class to represent a pirate name.
When created, an instance of this class
randomly selects a name and appellation from a list,
or optionally you can provide a name
and an appellation to the constructor.

### <i class="fa fa-anchor"> </i> Edit the Dart code.

<div class="trydart-step-details" markdown="1">
Add an import at the top of the code.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
import 'dart:html';
[[highlight]]import 'dart:math' show Random;[[/highlight]]
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* Using the `show` keyword,
you can import only the classes, functions, or properties you need.

* `Random` provides a random number generator.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Add a class declaration to the bottom of the code.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
...

[[highlight]]class PirateName {
}[[/highlight]]
{% endprettify %}
</div>

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

</div> <div class="col-md-5" markdown="1">

* Private variables start with underscore (`_`).
  Dart has no `private` keyword.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Create two static lists within the class that provide a small
collection of names and appellations to choose from.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
class PirateName {
  ...

  [[highlight]]static final List names = [[[/highlight]]
    [[highlight]]'Anne', 'Mary', 'Jack', 'Morgan', 'Roger',[[/highlight]]
    [[highlight]]'Bill', 'Ragnar', 'Ed', 'John', 'Jane' ];[[/highlight]]
  [[highlight]]static final List appellations = [[[/highlight]]
    [[highlight]]'Jackal', 'King', 'Red', 'Stalwart', 'Axe',[[/highlight]]
    [[highlight]]'Young', 'Brave', 'Eager', 'Wily', 'Zesty'];[[/highlight]]
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

* `final` variables cannot change.

* Lists are built into the language. These lists are created
  using list literals.

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

</div> <div class="col-md-5" markdown="1">

* Constructor names can be either <em><code>ClassName</code></em> or
  <em><code>ClassName</code></em>.<em><code>identifier</code></em>.

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

</div><div class="col-md-5" markdown="1">

* Getters are special methods that provide read access to an object’s properties.

* The conditional operator `?:` is equivalent to an if-then-else
  statement, but for expressions.

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

</div><div class="col-md-5" markdown="1">

* In this case, the call to the constructor passes no parameters.

</div></div>

### <i class="fa fa-anchor"> </i> Test it!

<div class="trydart-step-details" markdown="1">
  
Click the **Run** button.

Type in the input field.
Remove the text from the input field.
Click the button.

#### Problems?

Check your code against the solution.

* <a href="https://github.com/dart-lang/one-hour-codelab/tree/master/darrrt/4-classbadge/web/main.dart" target="_blank">main.dart</a>
* <a href="https://github.com/dart-lang/one-hour-codelab/tree/master/darrrt/4-classbadge/web/index.html" target="_blank">index.html</a>

Or
<a href="{{site.custom.dartpad.direct-link}}/445dcc541fd4dedf1b4c" target="_blank">open the solution in DartPad</a>.

</div>

<hr>

##Step 5: Read a JSON file {#step-five}

In this step, you change the PirateName class to get the list
of names and appellations from a JSON file on dartlang.

### <i class="fa fa-anchor"> </i> Edit the Dart code.

<div class="trydart-step-details" markdown="1">

Add imports to the top.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
import 'dart:html';
import 'dart:math' show Random;
[[highlight]]import 'dart:convert' show JSON;[[/highlight]]
[[highlight]]import 'dart:async' show Future;[[/highlight]]
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* `JSON` provides convenient access to the most commonly used
  JSON conversion utilities.

* The `dart:async` library provides for asynchronous programming.

* A `Future` provides a way to get a value in the future.
  (For JavaScript developers: Futures are similar to Promises.)

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Add a getter to the PirateName class that encodes a pirate
name in a JSON string.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
class PirateName {
  ...
  [[highlight]]String get jsonString =>[[/highlight]]
      [[highlight]]JSON.encode({"f": _firstName, "a": _appellation});[[/highlight]]
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

* The getter formats the JSON string using the map format.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Replace the `names` and `appellations` lists with these static,
empty lists.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
class PirateName {
  static final Random indexGen = new Random();

  [[highlight]]static List<String> names = [];[[/highlight]]
  [[highlight]]static List<String> appellations = [];[[/highlight]]
  ...
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

* **Be sure to remove `final` from these declarations.**

* `[]` is equivalent to `new List()`.

* A List is a _generic_ type&mdash;a List can contain any
  kind of object.
  If you intend for a list to contain only strings,
  you can declare it as `List<String>`.

</div></div>

<div class="trydart-step-details" markdown="1">
<hr>

Add two static functions to the PirateName class.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
class PirateName {
  ...

  [[highlight]]static Future readyThePirates() async {[[/highlight]]
    [[highlight]]String path =[[/highlight]]
        [[highlight]]'https://www.dartlang.org/codelabs/darrrt/files/piratenames.json';[[/highlight]]
    [[highlight]]String jsonString = await HttpRequest.getString(path);[[/highlight]]
    [[highlight]]_parsePirateNamesFromJSON(jsonString);[[/highlight]]
  [[highlight]]}[[/highlight]]

  [[highlight]]static _parsePirateNamesFromJSON(String jsonString) {[[/highlight]]
    [[highlight]]Map pirateNames = JSON.decode(jsonString);[[/highlight]]
    [[highlight]]names = pirateNames['names'];[[/highlight]]
    [[highlight]]appellations = pirateNames['appellations'];[[/highlight]]
  [[highlight]]}[[/highlight]]
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

* `readyThePirates` is marked with the `async` keyword.
   An async function returns a Future immediately, so the
   caller has the opportunity to do something else while
   waiting for the function to complete its work.

* `HttpRequest` is a utility for retriving data from a  URL.

* `getString()` is a convenience method for doing a simple GET
   request that returns a string.

* `getString()` is reading the
   [piratenames.json](https://www.dartlang.org/codelabs/darrrt/files/piratenames.json)
   file stored on dartlang.

* `getString()` is asynchronous. It sets up the GET request
  and returns a Future that _completes_ when the GET request is
  finished.

* The `await` expression, which can only be used in an async
  function, causes execution to pause until the GET request is
  finished (when the Future returned by `getString()` completes).

* After the GET request returns a JSON string, the code extracts
  pirate names and appellations from the string.

</div> </div>

<div class="trydart-step-details" markdown="1">

<hr>

Add a top-level variable.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
[[highlight]]SpanElement badgeNameElement;[[/highlight]]

void main() {
  ...
}
{% endprettify %}
</div>

</div><div class="col-md-5" markdown="1">

* Stash the span element for repeated use instead of querying
  the DOM for it.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Make these changes to the `main()` function.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
void main() {
  [[highlight]]InputElement inputField = querySelector('#inputName');[[/highlight]]
  [[highlight]]inputField.onInput.listen(updateBadge);[[/highlight]]
  genButton = querySelector('#generateButton');
  genButton.onClick.listen(generateBadge);
  
  [[highlight]]badgeNameElement = querySelector('#badgeName');[[/highlight]]
}
{% endprettify %}
</div>

</div><div class="col-md-5" markdown="1">

* Stash the span element in the global variable. Also, stash
  the input element in a local variable.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Then, add the code to get the names from the JSON file,
handling both success and failure.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
main() [[highlight]]async[[/highlight]] {
  ...
  
  [[highlight]]try {[[/highlight]]
    [[highlight]]await PirateName.readyThePirates();[[/highlight]]
    [[highlight]]//on success[[/highlight]]
    [[highlight]]inputField.disabled = false; //enable[[/highlight]]
    [[highlight]]genButton.disabled = false; //enable[[/highlight]]
  [[highlight]]} catch (arrr) {[[/highlight]]
    [[highlight]]print('Error initializing pirate names: $arrr');[[/highlight]]
    [[highlight]]badgeNameElement.text = 'Arrr! No names.';[[/highlight]]
  [[highlight]]}[[/highlight]]
}
{% endprettify %}
</div>

</div><div class="col-md-5" markdown="1">

* Mark the function body with `async`, so this function can use
  the `await` keyword.

* Remove `void` as the return type for `main()`.
  Asynchronous functions must return a Future, so you can either
  specify a Future return type or leave it blank.

* Call the `readyThePirates()` function, which immediately
  returns a Future.

* When the Future returned by `readyThePirates()` successfully
  completes, set up the UI.

* Use `try` and `catch` to detect and handle errors.

</div></div>

### <i class="fa fa-anchor"> </i> Edit the HTML code.

<div class="trydart-step-details" markdown="1">
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
Disable the input field and the button.

{% prettify dart %}
...
  <div>
    <input type="text" id="inputName" maxlength="15" [[highlight]]disabled[[/highlight]]>
  </div>
  <div>
    <button id="generateButton" [[highlight]]disabled[[/highlight]]>Aye! Gimme a name!</button>
  </div>
...
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

* The Dart code enables the text field and the button after the
  pirates names are successfully read from the JSON file.

</div></div>

### <i class="fa fa-anchor"> </i> Test it!

<div class="trydart-step-details" markdown="1">
  
Click the **Run** button.

Type in the input field.
Remove the text from the input field.
Click the button.

#### Problems?

Check your code against the solution.

* <a href="https://github.com/dart-lang/one-hour-codelab/tree/master/darrrt/5-final/web/main.dart" target="_blank">main.dart</a>
* <a href="https://github.com/dart-lang/one-hour-codelab/tree/master/darrrt/5-final/web/index.html" target="_blank">index.html</a>

Or
<a href="{{site.custom.dartpad.direct-link}}/eb2a7982598793c8d984" target="_blank">open the solution in DartPad</a>.

</div>

<hr>

{% comment %}
Once DartPad supports the "export" feature, we need to add a step
covering that and also explaining the difference between the DartPad
version and a "real" compileable version.
{% endcomment %}

##What next? {#whatnext}

Now that you've written your app, what do you do next?
Here are some suggestions.

### <i class="fa fa-anchor"> </i> Continue to play with DartPad
<div class="trydart-step-details" markdown="1">
DartPad includes a number of samples that you can play with,
or you can create your own.
Choose a sample using the **Samples** button in the upper
right corner.

<img src="images/DartPadSamples.png" alt="A screenshot of the samples menu in DartPad, including Clock, Fibonacci, and Sunflower">
</div>

### <i class="fa fa-anchor"> </i> Try programming with an editor or IDE

<div class="trydart-step-details" markdown="1">
Once you are ready to use a real editor or IDE,
like [WebStorm](/tools/webstorm/),
read the [Get Started](/docs/tutorials/get-started/) tutorial
for information on getting Dart, using the Dart tools,
and the directory structure used by Dart apps.

If you want to continue to play with the pirate app,
[download the source](https://github.com/dart-lang/one-hour-codelab/).
The code that corresponds to each step in this lab is
under the `darrrt` directory.
</div>

### <i class="fa fa-anchor"> </i> Build your app to run in any browser

<div class="trydart-step-details" markdown="1">
To compile the app into JavaScript that runs in any modern browser,
use **pub build**. For example, to build the final version of the app:

{% prettify sh %}
cd darrrt/5-final
pub build
{% endprettify %}

For more information, see
[Get Started](/docs/tutorials/get-started/) and
[pub build](/tools/pub/cmd/pub-build.html), one of the
[pub](/tools/pub/) commands.
</div>

### <i class="fa fa-anchor"> </i> Deploy a server and your app

<div class="trydart-step-details" markdown="1">

The [server side code lab](https://dart-lang.github.io/server/codelab/)
allows you create a pirate crew by storing pirate names to a RESTful
Dart server.

Also, see the [Write HTTP Clients & Servers](/docs/tutorials/httpserver/)
tutorial if you are interested in server-side programming.
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
* asynchrony support (`async` and `await`)
* DartPad
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

#### API documentation for the JSON constant

* <a href="https://api.dartlang.org/dart:convert#id_JSON" target="_blank">JSON</a>
</div>

### <i class="fa fa-anchor"> </i> Feedback

<div class="trydart-step-details" markdown="1">

Please provide feedback to the appropriate repo:

[www.dartlang.org repo](https://github.com/dart-lang/www.dartlang.org/issues)
: For feedback about this code lab.

[DartPad repo](https://github.com/dart-lang/dart-pad/issues)
: For feedback about DartPad.

</div>


