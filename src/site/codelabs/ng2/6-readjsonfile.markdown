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
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* The `dart:html` library contains the classes for all DOM element
  types, in addition to functions for accessing the DOM.

* The `dart_async` library provides for asynchronous programming.

* The `dart:convert` library provides convenient access to the most
  commonly used JSON conversion utilities.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Replace the `_names` and `_appellations` lists with static, empty lists.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateNameService {
  static final Random _indexGen = new Random();

  final String _firstName;
  final String _appellation;

  [[highlight]]static final List<String> _names = [];[[/highlight]]
  [[highlight]]static final List<String> _appellations = [];[[/highlight]]
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* `[]` is equivalent to `new List()`.

* A list is a _generic_ type&mdash;a List can contain any kind of object.
  If you intend for a list to contain only strings,
  you can declare it as `List<String>`.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Add a static function, `readyThePirates()`,
to read the names and appellations from the JSON file.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateNameService {
  ...

  static String randomAppellation() {
    return _appellations[_indexGen.nextInt(_appellations.length)];
  }

  [[highlight]]static Future readyThePirates() async {[[/highlight]]
    [[highlight]]if (_names.isNotEmpty && _appellations.isNotEmpty)[[/highlight]]
      [[highlight]]return;[[/highlight]]

    [[highlight]]final path =[[/highlight]]
        [[highlight]]'https://www.dartlang.org/codelabs/darrrt/files/piratenames.json';[[/highlight]]

    [[highlight]]final jsonString = await HttpRequest.getString(path);[[/highlight]]
    [[highlight]]final pirateNames = JSON.decode(jsonString);[[/highlight]]
    [[highlight]]PirateNameService._names.addAll(pirateNames['names']);[[/highlight]]
    [[highlight]]PirateNameService._appellations[[/highlight]]
        [[highlight]].addAll(pirateNames['appellations']);[[/highlight]]
  [[highlight]]}[[/highlight]]
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* `readyThePirates` is marked with the `async` keyword.
  An async function returns a Future immediately, so the caller
  has the opportunity to do something else while waiting for
  the function to complete its work.

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

## <i class="fa fa-anchor"> </i> Edit pirate_badge_component.dart.

Instruct the name service to load the pirate names
from the JSON file on startup.

<div class="trydart-step-details" markdown="1">

At startup, disable the button and input field.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateBadgeComponent {
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

  [[highlight]]ngOnInit() async {[[/highlight]]
    [[highlight]]try {[[/highlight]]
      [[highlight]]await PirateNameService.readyThePirates();[[/highlight]]
      [[highlight]]//on success[[/highlight]]
      [[highlight]]enableButton = true;[[/highlight]]
      [[highlight]]enableInput = true;[[/highlight]]
    [[highlight]]} catch (arrr) {[[/highlight]]
      [[highlight]]badgeName = 'Arrr! No names.';[[/highlight]]
      [[highlight]]print('Error initializing pirate names: $arrr');[[/highlight]]
    [[highlight]]}[[/highlight]]
  [[highlight]]}[[/highlight]]

  void generateBadge() {
    setBadgeName(new PirateNameService());
  }
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
