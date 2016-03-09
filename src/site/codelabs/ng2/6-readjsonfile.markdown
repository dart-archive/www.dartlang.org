---
layout: codelab
title: "Step 6: Read a  JSON File"
codelab-name: "Avast, Ye Pirates: Write a Web App"
description: "Take your first step to learning Dart fast."
snippet_img: images/piratemap.jpg
prev: 5-piratenameservice.html
prev-title: "Step 5: Create a Name Service"
next: what-next.html
next-title: "What Next?"
header:
  css: ["/codelabs/ng2/darrrt.css"]
---

{% include codelab-nav.html %}

# {{ page.title }}

In this final step, you change the pirate name service to fetch
the names and appellations from a JSON file on dartlang.
This step introduces you to Angular's support for dependency injection.

## <i class="fa fa-anchor"> </i> Edit pirate_name_service.dart.

<div class="trydart-step-details" markdown="1">
Add imports to the top.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
[[highlight]]import 'dart:html';[[/highlight]]
[[highlight]]import 'dart:async';[[/highlight]]
[[highlight]]import 'dart:convert';[[/highlight]]
import 'dart:math' show Random;

[[highlight]]import 'package:angular2/core.dart';[[/highlight]]
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* The `dart:html` library contains the classes for all DOM element
  types, in addition to functions for accessing the DOM.

* The `dart_async` library provides for asynchronous programming.

* The `dart:convert` library provides convenient access to the most
  commonly used JSON conversion utilities.

* The `angular2/core.dart` library defines the injectable annotation
  that you are adding in the next step.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Add a constant defining the location of the JSON file.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
import 'package:angular2/core.dart';

[[highlight]]const _namesPath =[[/highlight]]
    [[highlight]]'https://www.dartlang.org/codelabs/darrrt/files/piratenames.json';[[/highlight]]
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

Annotate the PirateNameService class with `@Injectable()`.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
[[highlight]]@Injectable()[[/highlight]]
class PirateNameService {
  final Random _indexGen = new Random();
  ...
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* _Dependency injection_ is a design pattern that allows moving
  the definition of a dependency to the constructor of
  the class that uses the dependency.

* Dependency injection, also referred to as _DI_, allows you to write
  more robust code that is easier to test.

* When Angular detects the `@Injectable` annotation,
  it generates necessary metadata so that the annotated object is injectable.

* Later, when you edit lib/pirate_name_service.dart,
  you'll add a constructor to PirateBadgeComponent
  that will inject an instance of PirateNameService.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Delete the `_firstName` and `_appellation` variables,
and replace `_names` and `_appellations` with empty lists.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateNameService {
  static final Random _indexGen = new Random();

  [[highlight]]final _names = <String>[];[[/highlight]]
  [[highlight]]final _appellations = <String>[];[[/highlight]]

  static String randomFirstName() {
    return (_names[_indexGen.nextInt(_names.length)]);
  }
  ...
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* `<String>[]` is equivalent to `new List<String>()`.

* A generic list can contain any kind of object, but this list is
  typed so that it can only contain strings.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Remove `static` from the `_randomFirstName` and `_randomAppellation`
helper methods.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateNameService {
  final Random _indexGen = new Random();

  final _names = <String>[];
  final _appellations = <String>[];

   [[highlight]]String randomFirstName()[[/highlight]] {
    return (_names[_indexGen.nextInt(_names.length)]);
  }

   [[highlight]]String randomAppellation()[[/highlight]] {
    return (_appellations[_indexGen.nextInt(_appellations.length)]);
  }
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

Add a function, `readyThePirates()`,
to read the names and appellations from the JSON file.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateNameService {
  ...
  String randomAppellation() {
    return (_appellations[_indexGen.nextInt(_appellations.length)]);
  }

  [[highlight]]Future readyThePirates() async {[[/highlight]]
    [[highlight]]if (_names.isNotEmpty && _appellations.isNotEmpty) return;[[/highlight]]
[[/highlight]]
    [[highlight]]var jsonString = await HttpRequest.getString(_namesPath);[[/highlight]]
    [[highlight]]var pirateNames = JSON.decode(jsonString);[[/highlight]]
    [[highlight]]_names.addAll(pirateNames['names']);[[/highlight]]
    [[highlight]]_appellations.addAll(pirateNames['appellations']);[[/highlight]]
  [[highlight]]}[[/highlight]]
  ...
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* `readyThePirates` is marked with the `async` keyword.
  An asynchronous function returns a Future immediately,
  so the caller has the opportunity to do something else while
  waiting for the function to complete its work.

* A `Future` provides a way to get a value in the future.
  (For JavaScript developers: Futures are similar to Promises.)

* `HttpRequest` is a utility for retrieving data from a URL.

* `getString()` is a convenience method for doing a simple GET
  request that returns a string.

* `getString()` is asynchronous. It setups up the GET request
  and returns a Future that _completes_ when the GET request
  is finished.

* The `await` expression, which can only be used in an async function,
  causes execution to pause until the GET request is finished
  (when the Future returned by `getString()` completes).

* After the GET request returns a JSON string, the code extracts
  pirate names and appellations from the string.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Add a `getPirateName` method.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateNameService {
  ...
  Future readyThePirates() async {
    if (_names.isNotEmpty && _appellations.isNotEmpty) return;

    var jsonString = await HttpRequest.getString(_namesPath);
    var pirateNames = JSON.decode(jsonString);
    _names.addAll(pirateNames['names']);
    _appellations.addAll(pirateNames['appellations']);
  }

  [[highlight]]String getPirateName(String firstName) {[[/highlight]]
    [[highlight]]if (firstName == null || firstName.trim().isEmpty) {[[/highlight]]
      [[highlight]]firstName = randomFirstName();[[/highlight]]
    [[highlight]]}[[/highlight]]

    [[highlight]]var appellation = randomAppellation();[[/highlight]]

    [[highlight]]return '$firstName the $appellation';[[/highlight]]
  [[highlight]]}[[/highlight]]
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* If the first name is passed to the method,
  append a randomly chosen appellation.
  Otherwise, generate a randomly chosen pirate name from the list
  of possible names and appellations.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Delete the constructor, the setter, and the implementation of `toString()`.
The body of the class should now look like the following.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
@Injectable()
class PirateNameService {
  final Random _indexGen = new Random();

  final _names = <String>[];
  final _appellations = <String>[];

  String randomFirstName() {
    return (_names[_indexGen.nextInt(_names.length)]);
  }

  String randomAppellation() {
    return (_appellations[_indexGen.nextInt(_appellations.length)]);
  }

  Future readyThePirates() async {
    if (_names.isNotEmpty && _appellations.isNotEmpty) return;

    var jsonString = await HttpRequest.getString(_namesPath);
    var pirateNames = JSON.decode(jsonString);
    _names.addAll(pirateNames['names']);
    _appellations.addAll(pirateNames['appellations']);
  }

  String getPirateName(String firstName) {
    if (firstName == null || firstName.trim().isEmpty) {
      firstName = randomFirstName();
    }
    var appellation = randomAppellation();

    return '$firstName the $appellation';
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

## <i class="fa fa-anchor"> </i> Edit pirate_badge_component.dart.

Modify PirateBadgeComponent to get a pirate name via dependency injection.

<div class="trydart-step-details" markdown="1">
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

At startup, disable the button and input field.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateBadgeComponent {
  final PirateNameService _nameService;
  String badgeName = '';
  String buttonText = 'Aye! Gimme a name!';
  bool enableButton = [[highlight]]false[[/highlight]];
  bool enableInput = [[highlight]]false[[/highlight]];
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* These inputs will be enabled once the file is successfully loaded.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}
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
  bool enableButton = false;
  bool enableInput = false;

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

Add a function to get the names from the JSON file,
handling both success and failure.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateBadgeComponent [[highlight]]implements OnInit[[/highlight]] {
  ...
  bool enableButton = false;
  bool enableInput = false;

  PirateBadgeComponent(this._nameService);

  [[highlight]]ngOnInit() async {[[/highlight]]
    [[highlight]]try {[[/highlight]]
      [[highlight]]await _nameService.readyThePirates();[[/highlight]]
      [[highlight]]//on success[[/highlight]]
      [[highlight]]enableButton = true;[[/highlight]]
      [[highlight]]enableInput = true;[[/highlight]]
    [[highlight]]} catch (arrr) {[[/highlight]]
      [[highlight]]badgeName = 'Arrr! No names.';[[/highlight]]
      [[highlight]]print('Error initializing pirate names: $arrr');[[/highlight]]
    [[highlight]]}[[/highlight]]
  [[highlight]]}[[/highlight]]
  ...
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* `ngOnInit()` is one of the
  [lifecycle hooks](https://angular.io/docs/ts/latest/guide/lifecycle-hooks.html)
  available in Angular. Angular calls ngOnInit after the component
  is initialized.

* Mark the function body with `async`, so this function can use
  the `await` keyword.

* Asynchronous functions must return a Future, so you can either
  specify a Future return type or leave it blank.

* Call the `readyThePirates()` function, which immediately returns
  a Future.

* When the Future returned by `readyThePirates()` successfully completes,
  set up the UI.

* Use `try` and `catch` to detect and handle errors.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Modify the `generateBadge()`, `setBadgeName()`,
and `updateBadge()`  methods.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateBadgeComponent implements OnInit {
  ...
  void generateBadge() {
    [[highlight]]setBadgeName();[[/highlight]]
  }

  void setBadgeName([[highlight]][String newName = ''][[/highlight]]) {
    if (newName == null) return;
    [[highlight]]badgeName = _nameService.getPirateName(newName);[[/highlight]]
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

The app should work as before, but this time the pirate name is
constructed from the JSON file.
</div>

## Problems?

Look in WebStorm's window for possible errors, then look
in Dartium's JavaScript console. You can find the console under
**View > Developer > JavaScript Console**.

Finally, check your code against the files in
[6-readjsonfile](https://github.com/dart-lang/one-hour-codelab/tree/ng2/ng2/6-readjsonfile).

* [lib/pirate_badge_component.dart](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/6-readjsonfile/lib/pirate_badge_component.dart)
* [lib/pirate_name_service.dart](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/6-readjsonfile/lib/pirate_name_service.dart)

<hr>

{% include codelab-nav.html %}
