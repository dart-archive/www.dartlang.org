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
In this step, you learn about Angular's support for dependency
injection as you add a service that returns a pirate name.

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
Add imports to the file.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
[[highlight]]import 'dart:math' show Random;[[/highlight]]

[[highlight]]import 'package:angular2/core.dart';[[/highlight]]
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* Using the `show` keyword, you can import only the classes, functions,
  or properties that you need.

* `Random` provides a random number generator.

* The `angular2/core.dart` library defines the injectable annotation
  that you are adding in the next step.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Add a class declaration below the import and annotate it with
`@Injectable()`.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
[[highlight]]@Injectable()[[/highlight]]
[[highlight]]class PirateNameService[[/highlight]] {
[[highlight]]}[[/highlight]]
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* _Dependency injection_ is a design pattern that allows moving
  the definition of a dependency to the constructor of
  the class that uses the dependency.

* Dependency injection, also referred to as _DI_, allows you to write
  more robust code that is easier to test.

* When Angular detects the `@Injectable()` annotation,
  it generates necessary metadata so that the annotated object is injectable.

* Later, when you edit lib/pirate_name_service.dart,
  you'll add a constructor to PirateBadgeComponent
  that will inject an instance of PirateNameService.

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

Create two static lists within the class that provide a small
collection of names and appellations to choose from.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateNameService {
  static final Random _indexGen = new Random();

  [[highlight]]final List _names = [[[/highlight]]
    [[highlight]]'Anne', 'Mary', 'Jack', 'Morgan', 'Roger',[[/highlight]]
    [[highlight]]'Bill', 'Ragnar', 'Ed', 'John', 'Jane' ];[[/highlight]]
  [[highlight]]final List _appellations = [[[/highlight]]
    [[highlight]]'Jackal', 'King', 'Red', 'Stalwart', 'Axe',[[/highlight]]
    [[highlight]]'Young', 'Brave', 'Eager', 'Wily', 'Zesty'];[[/highlight]]
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* Private variables start with underscore (`_`);
  Dart has no `private` keyword.
  The language tools enforce a variable's privacy.

* `final` variables cannot change.

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
  final List _appellations = [
    'Jackal', 'King', 'Red', 'Stalwart', 'Axe',
    'Young', 'Brave', 'Eager', 'Wily', 'Zesty'];

  [[highlight]]String _randomFirstName() {[[/highlight]]
    [[highlight]]return _names[_indexGen.nextInt(_names.length)];[[/highlight]]
  [[highlight]]}[[/highlight]]

  [[highlight]]String _randomAppellation() {[[/highlight]]
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

Provide a method that gets a pirate name.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateNameService {
  ...
  String _randomAppellation() {
    return (_appellations[_indexGen.nextInt(_appellations.length)]);
  }

  [[highlight]]String getPirateName(String firstName) {[[/highlight]]
    [[highlight]]if (firstName == null || firstName.trim().isEmpty) {[[/highlight]]
      [[highlight]]firstName = _randomFirstName();[[/highlight]]
    [[highlight]]}[[/highlight]]
    [[highlight]]var appellation = _randomAppellation();[[/highlight]]

    [[highlight]]return '$firstName the $appellation';[[/highlight]]
  }
}
{% endprettify %}
</div>

</div><div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* String interpolation
  (`'$_firstName the $_appellation'`)
  lets you easily build strings from other objects.

* String interpolation is different than Angular's expression interpolation.

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

Add `PirateNameService` as a provider by adding the text
 `, providers: const [PirateNameService]`
to the `@Component` annotation. After formatting,
it should look as follows:
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
@Component(
    selector: 'pirate-badge',
    templateUrl: 'pirate_badge_component.html'[[highlight]],[[/highlight]]
    [[highlight]]providers: const [PirateNameService][[/highlight]])
class PirateBadgeComponent {
  ...
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* The `providers` part of `@Component` tells Angular what objects are
  available for injection in this component.

* You can reformat your code by right-clicking in the editor view
  and selecting **Reformat with Dart Style**. For more information,
  see [step 2](2-blankbadge.html).

</div></div>


<div class="trydart-step-details" markdown="1">

<hr>

Add a `_nameService` instance variable.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
@Component(
    selector: 'pirate-badge',
    templateUrl: 'pirate_badge_component.html',
    providers: const [PirateNameService])
class PirateBadgeComponent {
  [[highlight]]final PirateNameService _nameService;[[/highlight]]
  String badgeName = '';
  ...
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

Add a constructor that references `_nameService`.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateBadgeComponent {
  final PirateNameService _nameService;
  String badgeName = '';
  String buttonText = 'Aye! Gimme a name!';
  bool enableButton = true;

  [[highlight]]PirateBadgeComponent(this._nameService);[[/highlight]]
  ...
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* When Angular creates a component, it looks at its constructors
  and then goes looking for the types of arguments with the
  `@Injectable` annotation.

* When Angular locates the class, it creates an instance and
  injects it into the component via the constructor.

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

  [[highlight]]void setBadgeName([String newName = '']) {[[/highlight]]
    [[highlight]]if (newName == null) return;[[/highlight]]
    [[highlight]]badgeName = _nameService.getPirateName(newName);[[/highlight]]
  [[highlight]]}[[/highlight]]
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* `[String newName = '']` is an optional positional parameter with a default
  value of the empty string.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Modify the `generateBadge()` and `updateBadge()`  methods.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateBadgeComponent implements OnInit {
  ...
  void generateBadge() {
    [[highlight]]setBadgeName();[[/highlight]]
  }

  void updateBadge(String inputName) {
    [[highlight]]setBadgeName(inputName);[[/highlight]]
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

</div> <div class="col-md-5" markdown="1">

{% comment %}
<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

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
