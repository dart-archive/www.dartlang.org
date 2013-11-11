---
layout: default
title: "Try Dart"
description: "Write some Dart code. Learn some stuff."
snippet_img: images/piratemap.jpg
has-permalinks: true
tutorial:
  id: trydart
js:
- url: /js/os-switcher.js
  defer: true
- url: /js/editor-downloads-analytics.js
  defer: true
- url: /js/editor-version.js
  defer: true
header:
  css: ["/codelabs/darrrt/darrrt.css"]
---

# {{ page.title }}

## Got an hour? Write a Dart app.

In this code lab,
you build a pirate badge generator from a skeleton app.
The sample app provides a brief look at some Dart language and library features.
This code lab assumes that you have some programming experience.

<strong>Build this app!</strong>

<iframe class="running-app-frame"
        style="height:220px;width:530px;"
        src="examples/6-piratebadge_json/piratebadge.html">
</iframe>

<hr>

<div class="piratemap" markdown="1" style="min-height:325px">

## Map

* [Step 0: Set up](#set-up)
* [Step 1: Run the skeleton app](#step-one)
* [Step 2: Add an input field](#step-two)
* [Step 3: Add a button](#step-three)
* [Step 4: Create a class](#step-four)
* [Step 5: Save to local storage](#step-five)
* [Step 6: Read names from JSON file using HttpRequest](#step-six)
* [Step 7: Go forth and learn more about Dart](#step-seven)

</div>


<hr>

## Step 0: Set up {#set-up}

In this step, you download Dart and get the sample code.


#### <i class="icon-anchor"> </i> Get Dart.

<div class="trydart-step-details" markdown="1">
If you haven't already done so,
get the Dart download.
Unzip the ZIP file, which creates a directory called `dart`.

{% include downloads/_dart-editor.html buttonclass="btn btn-primary btn-lg" %}

<p markdown="1">
  The Dart tools
  work in recent versions of
  {% include os-choices.html %}
</p>
</div>

#### <i class="icon-anchor"> </i> Start the editor.

<div class="trydart-step-details" markdown="1">
Go to the `dart` directory and double-click **DartEditor**.

**Got questions? Having trouble?** Go to the
[Troubleshooting Dart Editor](/tools/editor/troubleshoot.html) page.

</div>

#### <i class="icon-anchor"> </i> Get the sample code.

<div class="trydart-step-details" markdown="1">
<a href="https://github.com/dart-lang/one-hour-codelab/archive/master.zip">Download</a>
the sample code.
Unzip the ZIP file,
which creates a directory called `one-hour-codelab-master`.
</div>

#### <i class="icon-anchor"> </i> Open the one-hour-codelab-master sample.

<div class="trydart-step-details" markdown="1">
In Dart Editor,
use **File > Open Existing Folder...**
to open the `one-hour-codelab-master` directory.
</div>

<div class="row"> <div class="span7" markdown="1">

![The files and directories in the piratebadge directory.](images/filesanddirs.png)

</div> <div class="span5" markdown="1">

<i class="icon-key"> </i> <strong> Key Information </strong>

* The `packages` directory, as well as the `pubspec.yaml` and `pubspec.lock` files are
related to package dependencies.
This project has all the dependencies set up for you.
Dart Editor automatically installs the necessary packages.

* Several numbered directories contain the completed code for each step.
`1-blankbadge` contains the skeletal version of the app that you begin with.
`6-piratebadge_json` contains the final version of the app.

* The `piratebadge.css` file
provides the CSS styles for all steps of the app.
You don't change this file during this code lab.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

<hr>

##Step 1: Run the skeleton app {#step-one}

In this step, you open the source files,
familiarize yourself with the Dart and HTML code,
and run the app.

#### <i class="icon-anchor"> </i> Expand the 1-blankbadge directory.

<div class="trydart-step-details" markdown="1">
In Dart Editor, expand the `1-blankbadge` directory
by clicking the little arrow
![wee arrow](images/wee-arrow.png) to the left of its name.
The directory contains two files, `piratebadge.html` and `piratebadge.dart`.
</div>

#### <i class="icon-anchor"> </i> Open the files.

<div class="trydart-step-details" markdown="1">
Open both files, `piratebadge.html` and `piratebadge.dart`,
by double-clicking each filename in Dart Editor.
</div>

#### <i class="icon-anchor"> </i> Review the code.

<div class="trydart-step-details" markdown="1">
Get familiar with the HTML and the Dart code for the skeleton version of the app.
</div>

<div class="trydart-step-details" markdown="1">
##### piratebadge.html
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details" markdown="1">
{% prettify html%}
<html>
  <head>
    <meta charset="utf-8">
    <title>Pirate badge</title>
    <link rel="stylesheet" href="../piratebadge.css">
  </head>
  <body>
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

    [[highlight]]<script type="application/dart" src="piratebadge.dart"></script>[[/highlight]]
    [[highlight]]<script src="packages/browser/dart.js"></script>[[/highlight]]
  </body>
</html>
{% endprettify %}

</div>
<div class="trydart-filename">piratebadge.html</div>

</div> <div class="span5" markdown="1">

<i class="icon-key"> </i> <strong> Key Information </strong>

* During this code lab,
all the changes you make to `piratebadge.html` are within
the &lt;div&gt; element identified with the class `widgets`.

* In later steps,
the &lt;span&gt; element with the ID `badgeName`
is programmatically updated by the Dart code
based on user input.

* The `piratebadge.dart` script provides the main program for the app.

* The `packages/browser/dart.js` script is a bootstrap script
that takes care of turning on the Dart VM,
as well as compatibility with non-Dart browsers.

</div> </div>

<div class="trydart-step-details" markdown="1">
##### piratebadge.dart
</div>

<div class="row"> <div class="span7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
[[highlight]]void main() {
  // Your app starts here.
}
[[/highlight]]
{% endprettify %}
</div>
<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

* This file is the main script for the app.
It is referenced by a &lt;script&gt; tag in the `piratebadge.html` file.

* The `main()` function is a top-level function.
  Dart calls this function when your app starts.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}
</div> </div>

#### <i class="icon-anchor"> </i> Run the app.

<div class="trydart-step-details" markdown="1">
To run the app in Dart Editor, select `piratebadge.html`
and click the Run button
<img src="images/run.png" width="16" height="16"
     alt="Run button">.

![Click the run button](images/clickrun.png)

Dart Editor launches _Dartium_, a special build of Chromium
that has the Dart Virtual Machine built in, and loads the app.

You should see a TO DO comment on the left
and a red and white name badge on the right.
</div>

<div class="trydart-step-details" markdown="1">
<iframe class="running-app-frame"
        style="height:220px;width:530px;"
        src="examples/1-blankbadge/piratebadge.html">
</iframe>
</div>

<hr>

##Step 2: Add an input field {#step-two}

<div class="trydart-note" markdown="1">
<strong>Note:</strong> Throughout this code lab,
continue to edit the files in `1-blankbadge`.
You can use the files in the other directories to compare to your code
or to recover if you get off track.
</div>

In this step, you add an input field to the app.
As the user types into the text field,
the Dart code updates the badge from the value of the text field.

#### <i class="icon-anchor"> </i> Edit piratebadge.html.

<div class="row"> <div class="span7" markdown="1">

<div class="trydart-step-details" markdown="1">

Add the &lt;input&gt; tag to the HTML code
within the `widgets` &lt;div&gt;.

{% prettify html %}
...
<div class="widgets">
[[highlight]]  <div>
    <input type="text" id="inputName" maxlength="15">
  </div>[[/highlight]]
</div>
...
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.html</div>

</div> <div class="span5" markdown="1">

<i class="icon-key"> </i> <strong> Key Information </strong>

* The ID for the input element is `inputName`.
Dart uses CSS selectors, like this ID,
to get elements from the DOM.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

#### <i class="icon-anchor"> </i> Edit piratebadge.dart.

<div class="trydart-step-details" markdown="1">

Import the `dart:html`
library at the top of the file
(below the copyright).

</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details" markdown="1">

{% prettify dart %}
[[highlight]]import 'dart:html';[[/highlight]]
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

* This imports all classes and other resources from dart:html,
which provides HTML elements and access to the DOM.

* Dart Editor helpfully warns you that the import is unused.
Don't worry about it. You'll fix it in the next step.

</div> </div>

<div class="trydart-step-details" markdown="1">

<hr>

Register a function to handle input events on the input field.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details" markdown="1">

{% prettify dart %}
void main() {
  [[highlight]]querySelector('#inputName').onInput.listen(updateBadge);[[/highlight]]
}
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

* The `querySelector()` function, defined in
dart:html, gets an element from the DOM.
Here, the code uses the ID `#inputName`
to specify the input field.

* `onInput` registers an event handler for input events.

* An input event occurs when the user presses a key.

* You can use either single or double quotes to create a string.

* Dart Editor warns you that the function doesn't exist.
Let's fix that now.

</div> </div>

<div class="trydart-step-details" markdown="1">

<hr>

Implement the event handler as a top-level function.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details" markdown="1">

{% prettify dart %}
...

[[highlight]]void updateBadge(Event e) { 
  querySelector('#badgeName').text = (e.target as InputElement).value;
}[[/highlight]]
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

* This function sets the text of the `badgeName` element from the value of the input field.

* You can tell that `updateBadge()` is an event handler because it takes an
`Event` object.

* The element that generated the event, the input field, is `e.target`.

* The `as` keyword typecasts `e.target` to an
`InputElement` to silence warnings from Dart Editor.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

#### <i class="icon-anchor"> </i> Run the app.

<div class="trydart-step-details" markdown="1">

Save your files with **File > Save All**.

Use the Run button
<img src="images/run.png" width="16" height="16"
     alt="Run button">
in Dart Editor to run the app.

Compare your app to the one running below.

Type in the input field.

<iframe class="running-app-frame"
        style="height:220px;width:530px;"
        src="examples/2-inputnamebadge/piratebadge.html">
</iframe>

##### Problems?

Check your code against the files in `2-inputbadge`.

* [piratebadge.html](https://github.com/dart-lang/one-hour-codelab/blob/master/web/2-inputnamebadge/piratebadge.html)

* [piratebadge.dart](https://github.com/dart-lang/one-hour-codelab/blob/master/web/2-inputnamebadge/piratebadge.dart)
</div>


<hr> 

##Step 3: Add a button {#step-three}

In this step, you add a button to the app.
The button is enabled when the text field contains no text.
When the user clicks the button,
the app puts the name `Anne Bonney` on the badge.

#### <i class="icon-anchor"> </i> Edit piratebadge.html.

<div class="trydart-step-details" markdown="1">
Add the &lt;button&gt; tag below the input field.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify html %}
...
<div class="widgets">
  <div>
    <input type="text" id="inputName" maxlength="15">
  </div>
[[highlight]]  <div>
    <button id="generateButton">Aye! Gimme a name!</button>
  </div>[[/highlight]]
</div>
...
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.html</div>

</div> <div class="span5" markdown="1">

<i class="icon-key"> </i> <strong> Key Information </strong>

* The button has the ID `generateButton` so
the Dart code can get the element.

</div> </div>

#### <i class="icon-anchor"> </i> Edit piragebadge.dart.

<div class="trydart-step-details" markdown="1">
Below the import, declare a top-level variable to hold the `ButtonElement`.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
import 'dart:html';

[[highlight]]ButtonElement genButton;[[/highlight]]
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

* Top-level variables are names at the library level.

* ButtonElement is one of many different kinds of DOM elements
provided by the dart:html library.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

<div class="trydart-step-details" markdown="1">

<hr>

Wire up the button with an event handler.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
void main() {
  querySelector('#inputName').onInput.listen(updateBadge);
  [[highlight]]genButton = querySelector('#generateButton');
  genButton.onClick.listen(generateBadge);[[/highlight]]
}
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

* `onClick` registers a mouse click handler.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

<div class="trydart-step-details" markdown="1">

<hr>

Add a top-level function that changes the name on the badge.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
...

[[highlight]]void setBadgeName(String newName) {
  querySelector('#badgeName').text = newName;
} [[/highlight]]
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

* The function updates the HTML page with a new name.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

<div class="trydart-step-details" markdown="1">

<hr>

Implement the click handler for the button.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
...

[[highlight]]void generateBadge(Event e) {
  setBadgeName('Anne Bonney');
}[[/highlight]]
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

* This function sets the badge name to `Anne Bonney`.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

<div class="trydart-step-details" markdown="1">

<hr>
Modify `updateBadge()` to call `setBadgeName()`.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
void updateBadge(Event e) {
[[highlight]]  String inputName = [[/highlight]](e.target as InputElement).value;
[[highlight]]  setBadgeName(inputName);[[/highlight]]
}
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

* Assign the input field's value to a local string.

</div></div>


<div class="trydart-step-details" markdown="1">

<hr>

Add a skeleton if-else statement to `updateBadge()`.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
void updateBadge(Event e) {
  String inputName = (e.target as InputElement).value;
  setBadgeName(inputName);
[[highlight]]  if (inputName.trim().isEmpty) {
    // To do: add some code here.
  } else {
    // To do: add some code here.
  }[[/highlight]]
}
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

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

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
void updateBadge(Event e) {
  String inputName = (e.target as InputElement).value;
  setBadgeName(inputName);
  if (inputName.trim().isEmpty) {
    [[highlight]]genButton..disabled = false
             ..text = 'Aye! Gimme a name!';[[/highlight]]
  } else {
    [[highlight]]genButton..disabled = true
             ..text = 'Arrr! Write yer name!';[[/highlight]]
  }
}
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

* The cascade operator (`..`) allows you to perform multiple
operations on the members of a single object. 

* The `updateBadge()` code uses the cascade operator
to set two properties on the button element.
The result is the same as this more verbose code:

<pre>
genButton.disabled = false;
genButton.text = 'Aye! Gimme a name!';
</pre>

</div></div>


#### <i class="icon-anchor"> </i> Run the app.

<div class="trydart-step-details" markdown="1">

Save your files with **File > Save All**.

Use the Run button
<img src="images/run.png" width="16" height="16"
     alt="Run button">
in Dart Editor to run the app.

Compare your app to the one running below.

Type in the input field.
Remove the text from the input field.
Click the button.

<iframe class="running-app-frame"
        style="height:220px;width:530px;"
        src="examples/3-buttonbadge/piratebadge.html">
</iframe>


##### Problems?

Check your code against the files in `3-buttonbadge`.

* [piratebadge.html](https://github.com/dart-lang/one-hour-codelab/blob/master/web/3-buttonbadge/piratebadge.html)

* [piratebadge.dart](https://github.com/dart-lang/one-hour-codelab/blob/master/web/3-buttonbadge/piratebadge.dart)

</div>


<hr>

##Step 4: Create a PirateName class {#step-four}

In this step, you change only the Dart code.
You create a class to represent a pirate name.
When created, an instance of this class
randomly selects a name and appellation from a list,
or optionally you can provide a name
and an appellation to the constructor.

#### <i class="icon-anchor"> </i> Edit piratebadge.dart.

<div class="trydart-step-details" markdown="1">
Add an import to the top of the file.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
import 'dart:html';

[[highlight]]import 'dart:math' show Random;[[/highlight]]
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

<i class="icon-key"> </i> <strong> Key Information </strong>

* Using the `show` keyword,
you can import only the classes, functions, or properties you need.

* `Random` provides a random number generator.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Add a class declaration to the bottom of the file.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
...

[[highlight]]class PirateName {
}[[/highlight]]
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

* The class declaration provides the class name.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Create a class-level Random object.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
class PirateName {
  [[highlight]]static final Random indexGen = new Random();[[/highlight]]
}
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

* `static` defines a class-level field. That is,
the random number generator is shared with all
instances of this class.

* Dart Editor italicizes static names.

* Use `new` to call a constructor.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Add two instance variables to class,
one for the first name and one for the appellation.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
class PirateName {
  static final Random indexGen = new Random();
[[highlight]]  String _firstName;
  String _appellation;[[/highlight]]
}
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

* Private variables start with underscore (`_`).

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Create two static lists within the class
that provide a small collection of names and appellations to choose from.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
class PirateName {
  ...
[[highlight]]  static final List names = [
    'Anne', 'Mary', 'Jack', 'Morgan', 'Roger',
    'Bill', 'Ragnar', 'Ed', 'John', 'Jane' ];
  static final List appellations = [
    'Black','Damned', 'Jackal', 'Red', 'Stalwart', 'Axe',
    'Young', 'Old', 'Angry', 'Brave', 'Crazy', 'Noble'];[[/highlight]]
}
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

* `final` variables cannot change.

* Lists are built into the language.
These lists are created using list literals.

* The `List` class provides the API for lists.

</div></div>


<div class="trydart-step-details" markdown="1">

<hr>

Provide a constructor for the class.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
class PirateName {
  ...
[[highlight]]  PirateName({String firstName, String appellation}) {
    if (firstName == null) {
      _firstName = names[indexGen.nextInt(names.length)];
    } else {
      _firstName = firstName;
    }
    if (appellation == null) {
      _appellation = appellations[indexGen.nextInt(appellations.length)];
    } else {
      _appellation = appellation;
    }
  }[[/highlight]]
}
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

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

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
class PirateName {
  ...
[[highlight]]  String get pirateName =>
    _firstName.isEmpty ? '' : '$_firstName the $_appellation';[[/highlight]]
}
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div><div class="span5" markdown="1">

* Getters are special methods that provide read access to an object’s properties.

* The ternary operator `?:` is short-hand for an if-then-else statement.

* String interpolation
(`'$_firstName the $_appellation'`)
lets you easily build strings from other objects.

* The fat arrow (` => expr; `) syntax is a shorthand for `{ return expr; }`.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Modify the function `setBadgeName()` to use a PirateName instead of a String:
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
void setBadgeName([[highlight]]PirateName[[/highlight]] newName) {
  querySelector('#badgeName').text = newName[[highlight]].pirateName[[/highlight]];
}
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div><div class="span5" markdown="1">

* This code calls the getter to get the PirateName as a string.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Change `updateBadge()` to generate a PirateName based on the input field value.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
void updateBadge(Event e) {
  String inputName = (e.target as InputElement).value;
  
  [[highlight]]setBadgeName(new PirateName(firstName: inputName));[[/highlight]]
  ...
}
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div><div class="span5" markdown="1">

* The call to the constructor provides a value for one optional named parameter.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Change `generateBadge()` to generate a PirateName instead of using `Anne Bonney`.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
void generateBadge(Event e) {
  setBadgeName([[highlight]]new PirateName()[[/highlight]]);
}
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div><div class="span5" markdown="1">

* In this case, the call to the constructor passes no parameters.

</div></div>

#### <i class="icon-anchor"> </i> Run the app.

<div class="trydart-step-details" markdown="1">
  
Save your files with **File > Save All**.

Use the Run button
<img src="images/run.png" width="16" height="16"
     alt="Run button">
in Dart Editor to run the app.

Compare your app to the one running below.

Type in the input field.
Remove the text from the input field.
Click the button.

<iframe class="running-app-frame"
        style="height:220px;width:530px;"
        src="examples/4-classbadge/piratebadge.html">
</iframe>


##### Problems?

Check your code against the files in `4-classbadge`.

* [piratebadge.html](https://github.com/dart-lang/one-hour-codelab/blob/master/web/4-classbadge/piratebadge.html)

* [piratebadge.dart](https://github.com/dart-lang/one-hour-codelab/blob/master/web/4-classbadge/piratebadge.dart)

</div>


<hr>


##Step 5: Save to local storage {#step-five}

In this step, you give the app some persistence
by saving the badge name to local storage each time it changes.
When you restart the app,
it initializes the badge from the saved name.

#### <i class="icon-anchor"> </i> Edit piratebadge.dart.

<div class="trydart-step-details" markdown="1">
Import the JSON converter from the `dart:convert` library.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
import 'dart:html';
import 'dart:math' show Random;
[[highlight]]
import 'dart:convert' show JSON;[[/highlight]]
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

<i class="icon-key"> </i> <strong> Key Information </strong>

* `JSON` provides convenient access to the most common JSON use cases.

</div> </div>

<div class="trydart-step-details" markdown="1">

<hr>

Add a named constructor to the PirateName class.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
class PirateName {
  ...
[[highlight]]  PirateName.fromJSON(String jsonString) {
    Map storedName = JSON.decode(jsonString);
    _firstName = storedName['f'];
    _appellation = storedName['a'];
  }[[/highlight]]
}
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

* The constructor creates a new PirateName instance from a JSON-encoded string.

* `PirateName.fromJson` is a named constructor.

* `JSON.decode()` parses a JSON string and creates Dart objects from it.

* The pirate name is decoded into a `Map` object.

</div> </div>

<div class="trydart-step-details" markdown="1">

<hr>

Add a getter to the PirateName class
that encodes a pirate name in a JSON string.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
class PirateName {
  ...
  [[highlight]]String get jsonString => '{ "f": "$_firstName", "a": "$_appellation" } ';[[/highlight]]
}
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

* The getter formats the JSON string using the map format.

</div> </div>


<div class="trydart-step-details" markdown="1">

<hr>

Declare a top-level string.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
[[highlight]]final String TREASURE_KEY = 'pirateName';[[/highlight]]

void main() {
  ...
}
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

* You store key-value pairs in local storage. This string is the key.
The value is the pirate name.

</div> </div>

<div class="trydart-step-details" markdown="1">

<hr>

Save the pirate name when the badge name changes.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
void setBadgeName(PirateName newName) {
  [[highlight]]if (newName == null) {
    return;
  }[[/highlight]]
  querySelector('#badgeName').text = newName.pirateName;
  [[highlight]]window.localStorage[TREASURE_KEY] = newName.jsonString;[[/highlight]]
}
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

* Local storage is provided by the browser's `Window`.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

<div class="trydart-step-details" markdown="1">

<hr>

Add a top-level function called `getBadgeNameFromStorage()`.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
void setBadgeName(PirateName newName) {
  ...
}

[[highlight]]PirateName getBadgeNameFromStorage() {
  String storedName = window.localStorage[TREASURE_KEY];
  if (storedName != null) {
    return new PirateName.fromJSON(storedName);
  } else {
    return null;
  }
}[[/highlight]]
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

* The function retrieves the pirate name from local storage
and creates a PirateName object from it.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

<div class="trydart-step-details" markdown="1">
<hr>
Call the function from the `main()` function.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
void main() {
  ...
  [[highlight]]setBadgeName(getBadgeNameFromStorage());[[/highlight]]
}
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

* Initialize the badge name from local storage.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

#### <i class="icon-anchor"> </i> Run the app.

<div class="trydart-step-details" markdown="1">
  
Save your files with **File > Save All**.

Use the Run button
<img src="images/run.png" width="16" height="16"
     alt="Run button">
in Dart Editor to run the app.

Compare your app to the one running below.

Click the button to put a name on the badge.
Start the app again by duplicating this window.

<iframe class="running-app-frame"
        style="height:220px;width:530px;"
        src="examples/5-localbadge/piratebadge.html">
</iframe>


##### Problems?

Check your code against the files in `5-localbadge`.

* [piratebadge.html](https://github.com/dart-lang/one-hour-codelab/blob/master/web/5-localbadge/piratebadge.html)

* [piratebadge.dart](https://github.com/dart-lang/one-hour-codelab/blob/master/web/5-localbadge/piratebadge.dart)

</div>


<hr>


##Step 6: Read names from JSON-encoded file {#step-six}

In this step, you change the PirateName class to get
the list of names and appellations from a JSON file.
This gives you a chance to add more names and
appellations to the program.

#### <i class="icon-anchor"> </i> Create piratenames.json.

<div class="trydart-step-details" markdown="1">
Use **File > New File...** to create a JSON-encoded file
named `piratenames.json` with the following content.

Put the file in `1-blankbadge` alongside the Dart and HTML files you've been editing.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
{ "names": [ "Anne", "Bette", "Cate", "Dawn",
            "Elise", "Faye", "Ginger", "Harriot",
            "Izzy", "Jane", "Kaye", "Liz",
            "Maria", "Nell", "Olive", "Pat",
            "Queenie", "Rae", "Sal", "Tam",
            "Uma", "Violet", "Wilma", "Xana",
            "Yvonne", "Zelda",
            "Abe", "Billy", "Caleb", "Davie",
            "Eb", "Frank", "Gabe", "House",
            "Icarus", "Jack", "Kurt", "Larry",
            "Mike", "Nolan", "Oliver", "Pat",
            "Quib", "Roy", "Sal", "Tom",
            "Ube", "Val", "Walt", "Xavier",
            "Yvan", "Zeb"],
  "appellations": [ "Awesome", "Black", "Captain", "Damned",
            "Even", "Fighter", "Great", "Hearty",
            "Irate", "Jackal", "King", "Lord",
            "Mighty", "Noble", "Old", "Powerful",
            "Quick", "Red", "Stalwart", "Tank",
            "Ultimate", "Vicious", "Wily", "aXe",
            "Young", "Zealot",
            "Angry", "Brave", "Crazy", "Damned",
            "Eager", "Fool", "Greedy", "Hated",
            "Idiot", "Jinxed", "Kind", "Lame",
            "Maimed", "Naked", "Old", "Pale",
            "Queasy", "Rat", "Sandy", "Tired",
            "Ugly", "Vile", "Weak", "Xeric",
            "Yellow", "Zesty"]}
{% endprettify %}
</div>

<div class="trydart-filename">piratenames.json</div>

</div> <div class="span5" markdown="1">

<i class="icon-key"> </i> <strong> Key Information </strong>

* The file contains a JSON-encoded map,
which contains two lists of strings.

</div> </div>

#### <i class="icon-anchor"> </i> Edit piratebadge.html.

<div class="trydart-step-details" markdown="1">
Disable the input field and the button.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify html %}
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

<div class="trydart-filename">piratebadge.html</div>

</div> <div class="span5" markdown="1">


* The Dart code enables the text field and
the button after the pirate names are successfully read from
the JSON file.

</div> </div>

#### <i class="icon-anchor"> </i> Edit piratebadge.dart.

<div class="trydart-step-details" markdown="1">

Add an import to the top of the file.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
import 'dart:html';
import 'dart:math' show Random;
import 'dart:convert' show JSON;

[[highlight]]import 'dart:async' show Future;[[/highlight]]
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

* The `dart:async` library provides for asynchronous programming.

* A `Future` provides a way to get a value in the future.

</div> </div>

<div class="trydart-step-details" markdown="1">

<hr>
Replace the `names` and `appellations` lists with these static, empty lists:
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
class PirateName {
  ...
  [[highlight]]static List<String> names = [];
  static List<String> appellations = [];[[/highlight]]
  ...
}
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

* **Be sure to remove `final` from these declarations.**

* `[]` is equivalent to `new List()`.

* A List is a _generic_ type&mdash;a List can contain any kind of object.
If you intend for a list to contain only strings,
you can declare it as `List<String>`.

</div> </div>

<div class="trydart-step-details" markdown="1">

<hr>

Add two static functions to the PirateName class:
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
class PirateName {
  ...

  [[highlight]]static Future readyThePirates() {
    var path = 'piratenames.json';
    return HttpRequest.getString(path)
        .then(_parsePirateNamesFromJSON);
  }
  
  static _parsePirateNamesFromJSON(String jsonString) {
    Map pirateNames = JSON.decode(jsonString);
    names = pirateNames['names'];
    appellations = pirateNames['appellations'];
  }[[/highlight]]
}
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

* `HttpRequest` is a utility for retrieving data from a URL.

* `getString()` is a convenience method for doing a simple
GET request that returns a string.

* The code uses a `Future` to perform the GET asynchronously.

* The callback function for `.then()` is called when
the Future completes successfully.

* When the Future completes successfully,
the pirate names are read from the JSON file.

* `readyThePirates` returns the Future so the main program has the
opportunity to do something after the file is read.

</div> </div>

<div class="trydart-step-details" markdown="1">
<hr>
Add a top-level variable.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
[[highlight]]SpanElement badgeNameElement;[[/highlight]]

void main() {
  ...
}
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

* Stash the span element for repeated use instead of querying the DOM for it.

</div> </div>

<div class="trydart-step-details" markdown="1">
<hr>
Make these changes to the `main()` function.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
void main() {
  [[highlight]]InputElement inputField = querySelector('#inputName');
  inputField.onInput.listen(updateBadge);[[/highlight]]
  genButton = querySelector('#generateButton');
  genButton.onClick.listen(generateBadge);
  
  [[highlight]]badgeNameElement = querySelector('#badgeName');[[/highlight]]
  ...
}
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

* Stash the span element in the global variable.
Also, stash the input element in a local variable.


</div> </div>

<div class="trydart-step-details" markdown="1">
<hr>
Then, add the code to get the names from the JSON file,
handling both success and failure.
</div>

<div class="row"> <div class="span7">

<div class="trydart-step-details">
{% prettify dart %}
void main() {
  ...
  
[[highlight]]  PirateName.readyThePirates()
    .then((_) {
      //on success
      inputField.disabled = false; //enable
      genButton.disabled = false;  //enable[[/highlight]]
      setBadgeName(getBadgeNameFromStorage());
    [[highlight]]})
    .catchError((arrr) {
      print('Error initializing pirate names: $arrr');
      badgeNameElement.text = 'Arrr! No names.';
    });[[/highlight]]
}
{% endprettify %}
</div>

<div class="trydart-filename">piratebadge.dart</div>

</div> <div class="span5" markdown="1">

* Call the `readyThePirates()` function,
which returns a Future.

* When the Future successfully completes,
the `then()` callback function is called.

* Using underscore (`_`) as a parameter name
indicates that the parameter is ignored.

* The callback function enables the UI
and gets the stored name.

* If the Future encounters an error
the `catchError` callback function is called
and the program displays an error message,
leaving the UI disabled.

* The callback functions for `then()` and `catchError` are defined inline.

</div> </div>

#### <i class="icon-anchor"> </i> Run the app.

<div class="trydart-step-details" markdown="1">
  
Save your files with **File > Save All**.

Use the Run button
<img src="images/run.png" width="16" height="16"
     alt="Run button">
in Dart Editor to run the app.

If you want to see what happens when the app can't find the `.json` file,
change the file name in the code and run the program again.

Compare your app to the final version running below.


<iframe class="running-app-frame"
        style="height:220px;width:530px;"
        src="examples/6-piratebadge_json/piratebadge.html">
</iframe>


##### Problems?

Check your code against the files in `6-piratebadge_json`.

* [piratebadge.html](https://github.com/dart-lang/one-hour-codelab/blob/master/web/6-piratebadge_json/piratebadge.html)

* [piratebadge.dart](https://github.com/dart-lang/one-hour-codelab/blob/master/web/6-piratebadge_json/piratebadge.dart)

</div>

{% comment %}

#### <i class="icon-anchor"> </i> Share your pirate name.

<div class="trydart-step-details" markdown="1">

Congratulations! You finished the pirate badge code lab.


Share your pirate name with the world.

<p class="share-button twitter">
<a href="https://twitter.com/share"
   class="twitter-share-button external-link"
   data-count="none"
   data-text="Arrr! I've generated me pirate name and learnt Dart, to boot. http://dartlang.org/darrrt"
   data-hashtags="dartlang">Tweet</a>
 </p>

<script src="https://apis.google.com/js/plusone.js"></script>
<g:plus action="share"></g:plus>

</div>
{% endcomment %}


<hr>

##Step 7: Go forth and learn more about Dart {#step-seven}

#### <i class="icon-anchor"> </i> Think about what you've done!

<div class="trydart-step-details" markdown="1">

This code lab provided a tour of most Dart language features
and many library features.
Here's where to go to learn more.

##### The Dart language

<a href="https://www.dartlang.org/docs/dart-up-and-running/contents/ch02.html">
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

##### The Dart libraries

<a href="https://www.dartlang.org/docs/dart-up-and-running/contents/ch03.html">
A Tour of the Dart Libraries</a>
shows you how to use the major features in Dart’s libraries.

##### API documentation for classes

<a href="https://api.dartlang.org/dart_core/String.html" target="_blank">String</a>,
<a href="https://api.dartlang.org/dart_core/List.html" target="_blank">List</a>,
<a href="https://api.dartlang.org/dart_core/Map.html" target="_blank">Map</a>,
<a href="https://api.dartlang.org/dart_math/Random.html" target="_blank">Random</a>,
<a href="https://api.dartlang.org/dart_html/InputElement.html" target="_blank">InputElement</a>,
<a href="https://api.dartlang.org/dart_html/ButtonElement.html" target="_blank">ButtonElement</a>,
<a href="https://api.dartlang.org/dart_html/Event.html" target="_blank">Event</a>,
<a href="https://api.dartlang.org/dart_html/HttpRequest.html" target="_blank">HttpRequest</a>, and
<a href="https://api.dartlang.org/dart_async/Future.html" target="_blank">Future</a>

##### API documentation for libraries

<a href="https://api.dartlang.org/dart_core.html" target="_blank">dart:core</a>,
<a href="https://api.dartlang.org/dart_math.html" target="_blank">dart:math</a>,
<a href="https://api.dartlang.org/dart_html.html" target="_blank">dart:html</a>,
<a href="https://api.dartlang.org/dart_async.html" target="_blank">dart:async</a>, and
<a href="https://api.dartlang.org/dart_convert.html" target="_blank">dart:convert</a>

##### API documentation for JSON and local storage

<a href="https://api.dartlang.org/dart_html/Window.html#localStorage" target="_blank">LocalStorage</a>, and
<a href="https://api.dartlang.org/dart_convert.html#JSON" target="_blank">JSON</a>


</div>

#### <i class="icon-anchor"> </i> Check out the samples.

<div class="trydart-step-details" markdown="1">

Run some Dart programs online and check out the source code
on our [Samples page](/samples/).
</div>

#### <i class="icon-anchor"> </i> Read the tutorials.

<div class="trydart-step-details" markdown="1">
Learn more about Dart from
the [Dart tutorials](/docs/tutorials/).
</div>

