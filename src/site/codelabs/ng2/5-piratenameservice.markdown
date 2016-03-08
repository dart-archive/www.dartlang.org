---
layout: codelab
title: "Step 5: Create a Name Service"
codelab-name: "Avast, Ye Pirates: Write a Web App"
description: "Take your first step to learning Dart fast."
snippet_img: images/piratemap.jpg
prev: 4-buttonbadge.html
prev-title: "Step 4: Add a Button"
next: 6-readjsonfile.html
next-title: "Step 6: Read a JSON File"
header:
  css: ["/codelabs/ng2/darrrt.css"]
---

{% include codelab-nav.html %}

# {{ page.title }}

A proper pirate name consists of a name and an appellation,
such as "Margy the Fierce" or "Renée the Fighter".
In this step, you add a service that returns a pirate name.

## <i class="fa fa-anchor"> </i> Create a class for the pirate name service.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

<ol markdown="1">
<li markdown="1">In WebStorm's Project view,
   right-click the `lib` directory and
   select **New > Dart File** from the menu that pops up.
</li>
<li markdown="1">Enter "pirate_name_service" into the dialog
   and click **OK**.
</li>
</ol>
</div>

</div> <div class="col-md-5" markdown="1">

{% comment %}
<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* x
{% endcomment %}

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}
</div> </div>

## <i class="fa fa-anchor"> </i> Edit pirate_name_service.dart.

<div class="trydart-step-details" markdown="1">
Add an import to the file.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
[[highlight]]import 'dart:math' show Random;[[/highlight]]
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* Using the `show` keyword, you can import only the classes, functions,
  or properties that you need.

* `Random` provides a random number generator.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Add a class declaration below the import.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
[[highlight]]class PirateNameService[[/highlight]] {
[[highlight]]}[[/highlight]]
{% endprettify %}
</div>

{% comment %}
</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* x
{% endcomment %}

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Create a class-level Random object.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateNameService {
  [[highlight]]static final Random _indexGen = new Random();[[/highlight]]
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

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

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateNameService {
  static final Random _indexGen = new Random();

  [[highlight]]final String _firstName;[[/highlight]]
  [[highlight]]final String _appellation;[[/highlight]]
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* Private variables start with underscore (`_`);
  Dart has no `private` keyword.
  The language tools enforce a variable's privacy.

* `final` variables cannot change.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Create two static lists within the class that provide a small
collection of names and appellations to choose from.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateNameService {
  static final Random _indexGen = new Random();

  final String _firstName;
  final String _appellation;

  [[highlight]]static final List _names = [[[/highlight]]
    [[highlight]]'Anne', 'Mary', 'Jack', 'Morgan', 'Roger',[[/highlight]]
    [[highlight]]'Bill', 'Ragnar', 'Ed', 'John', 'Jane' ];[[/highlight]]
  [[highlight]]static final List _appellations = [[[/highlight]]
    [[highlight]]'Jackal', 'King', 'Red', 'Stalwart', 'Axe',[[/highlight]]
    [[highlight]]'Young', 'Brave', 'Eager', 'Wily', 'Zesty'];[[/highlight]]
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* Lists are built into the language. These lists are created
  using list literals.

* The `List` class provides the API for lists.

</div></div>

<div class="trydart-step-details" markdown="1">
<hr>

Provide helper methods that retrieve a randomly chosen first name
and appellation.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateNameService {
  ...
  static final List _names = [
    'Anne', 'Mary', 'Jack', 'Morgan', 'Roger',
    'Bill', 'Ragnar', 'Ed', 'John', 'Jane' ];
  static final List _appellations = [
    'Jackal', 'King', 'Red', 'Stalwart', 'Axe',
    'Young', 'Brave', 'Eager', 'Wily', 'Zesty'];

  [[highlight]]static String randomFirstName() {[[/highlight]]
    [[highlight]]return _names[_indexGen.nextInt(_names.length)];[[/highlight]]
  [[highlight]]}[[/highlight]]

  [[highlight]]static String randomAppellation() {[[/highlight]]
    [[highlight]]return _appellations[_indexGen.nextInt(_appellations.length)];[[/highlight]]
  [[highlight]]}[[/highlight]]
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* The code uses a random number as an index into the list.

* The `nextInt()` function gets a new random integer
from the random number generator.

* Use square brackets (`[` and `]`) to index into a list.

* The `length` property returns the number of items in a list.

</div> </div>

<div class="trydart-step-details" markdown="1">
<hr>

Provide a constructor for the class.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateNameService {
  ...

  static String randomAppellation() {
    return (_appellations[_indexGen.nextInt(_appellations.length)]);
  }

  [[highlight]]PirateNameService({String firstName, String appellation})[[/highlight]]
      [[highlight]]: _firstName = firstName ?? randomFirstName(),[[/highlight]]
        [[highlight]]_appellation = appellation ?? randomAppellation();[[/highlight]]
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* Constructor names can be either <em><code>ClassName</code></em> or
  <em><code>ClassName</code></em>.<em><code>identifier</code></em>.

* The parameters enclosed in curly brackets (`{` and `}`)
  are optional, named parameters.

* These parameters are initialized using an initializer list
  which appears after the colon (`:`).

* The double questionmark syntax `??` specifies a _null-aware_ operation.
  If `firstName` is non-null, assign that value to `_firstName`.
  Otherwise, if `firstName` is null, assign the value returned
  by `randomFirstName()` to `_firstName`.

* Note that this constructor has no body because it sets the values in
  an initalizer list.

</div> </div>

<div class="trydart-step-details" markdown="1">

<hr>

Provide a getter for the pirate name.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateNameService {
  ...

  PirateNameService({String firstName, String appellation})
      : _firstName = firstName ?? randomFirstName(),
        _appellation = appellation ?? randomAppellation();

  [[highlight]]String get pirateName =>[[/highlight]]
      [[highlight]]_firstName.isEmpty ? '' : '$_firstName the $_appellation';[[/highlight]]
}
{% endprettify %}
</div>

</div><div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* Getters are special methods that provide read access to an object’s
  properties.

* All instance variables have an implicit getter, but you can
  create additional properties by implementing getters
  using the `get` keyword.

* `pirateName` is a property, the same as any explicitly declared
  instance variable.

* This example doesn't include an explicit setter for `pirateName`,
  so it's a read-only property,
  but you can create one using the `set` keyword.

* The conditional operator `?:` is equivalent to an if-then-else
  statement, but for expressions.

* String interpolation
  (`'$_firstName the $_appellation'`)
  lets you easily build strings from other objects.

* String interpolation is different than Angular's expression interpolation.

* The fat arrow (` => expr; `) syntax is a shorthand for `{ return expr; }`.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Override the toString() method.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateNameService {
  ...

  String get pirateName =>
      _firstName.isEmpty ? '' : '$_firstName the $_appellation';

  [[highlight]]String toString() => pirateName;[[/highlight]]
}
{% endprettify %}
</div>

</div><div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* Because the Object implementation of `toString()` doesn't give much
  information, many classes override `toString()`.

* When you call `print(anObject)` for any non-String, it prints the value
  returned by `anObject.toString()`.

* Overriding `toString()` can be especially helpful for debugging or logging.

</div></div>

## <i class="fa fa-anchor"> </i> Edit pirate_badge_component.dart.

Hook up the pirate name service to the pirate badge component.

<div class="trydart-step-details" markdown="1">
Import the pirate name service.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
import 'package:angular2/angular2.dart';
[[highlight]]import 'pirate_name_service.dart';[[/highlight]]
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

{% comment %}

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* x
{% endcomment %}

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Add a `setBadgeName()` method.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateBadgeComponent {
  ...
  void generateBadge() {
    setBadgeName(new PirateNameService());
  }

  [[highlight]]void setBadgeName(PirateNameService newName) {[[/highlight]]
    [[highlight]]if (newName == null) return;[[/highlight]]
    [[highlight]]badgeName = newName.pirateName;[[/highlight]]
  [[highlight]]}[[/highlight]]
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">
{% comment %}

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* x

{% endcomment %}
</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Update `generateBadge()` to call `setBadgeName()` for a new pirate name.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateBadgeComponent {
  ...
  void generateBadge() {
    [[highlight]]setBadgeName(new PirateNameService());[[/highlight]]
  }
  ...
}
{% endprettify %}
</div>

{% comment %}
</div> <div class="col-md-5" markdown="1">

* x
{% endcomment %}

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Modify the `updateBadge()` function to use the name service.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateBadgeComponent() {
  ...

  void updateBadge(String inputName) {
    [[highlight]]setBadgeName(new PirateNameService(firstName: inputName));[[/highlight]]
    if (inputName.trim().isEmpty) {
      buttonText = 'Aye! Gimme a name!';
      enableButton = true;
    } else {
      buttonText = 'Arrr! Write yer name!';
      enableButton = false;
    }
  }
}
{% endprettify %}
</div>

{% comment %}
</div> <div class="col-md-5" markdown="1">

* x
{% endcomment %}

</div></div>

## <i class="fa fa-anchor"> </i> Test it!

<div class="trydart-step-details" markdown="1">

Click <img src="images/run.png" alt="the green arrow"> to run the app.

Click the button&mdash;each click displays a new pirate name composed
of a name and an appellation.

## Problems?

Look in WebStorm's window for possible errors, then look
in Dartium's JavaScript console. You can find the console under
**View > Developer > JavaScript Console**.

Finally, check your code against the files in
[5-piratenameservice](https://github.com/dart-lang/one-hour-codelab/tree/ng2/ng2/5-piratenameservice).

* [lib/pirate_badge_component.dart](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/5-piratenameservice/lib/pirate_badge_component.dart)
* [lib/pirate_name_service.dart](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/5-piratenameservice/lib/pirate_name_service.dart)

<hr>

{% include codelab-nav.html %}
