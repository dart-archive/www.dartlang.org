---
layout: codelab
title: "Step 3: Add an Input Field"
codelab-name: "Avast, Ye Pirates: Write a Web App"
description: "Take your first step to learning Dart fast."
snippet_img: images/piratemap.jpg
prev: 2-blankbadge.html
prev-title: "Step 2: Add a Pirate Badge Component"
next: 4-buttonbadge.html
next-title: "Step 4: Add a Button"
header:
  css: ["/codelabs/ng2/darrrt.css"]
---

{% include codelab-nav.html %}

# {{ page.title }}

In this step, you add an input field.
As the user types into the input field,
the badge updates.

## <i class="fa fa-anchor"> </i> Edit pirate_badge_component.html.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

Add a div containing an input field to the top of the file:

{% prettify html %}
[[highlight]]<div class="widgets">[[/highlight]]
  [[highlight]]<input (input)="updateBadge($event.target.value)"[[/highlight]]
         [[highlight]]type="text" maxlength="15">[[/highlight]]
[[highlight]]</div>[[/highlight]]

<div class="badge">
  <div class="greeting">Arrr! Me name is</div>
  <div class="name">{{badgeName}}</div>
</div>
{% endprettify %}

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* `<input...>` defines an HTML5 input element.

* The `(input)="updateBadge(...)"` text is referred to as
  _event binding_ syntax.
  The expression to the right of the equals sign is a _template statement_.

* This template statement executes whenever an input event occurs on this element.

* A template statement may reference functions or variables
  from the Dart component code.

* By convention, a template statement is short&mdash;more
  complex logic should be placed in a function and called
  from the template statement.

* User input in this field is limited to 15 characters.

</div> </div>

## <i class="fa fa-anchor"> </i> Edit pirate_badge_component.dart.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

Delete the hardcoded badge name and add an event handler,
`updateBadge()`, to the PirateBadgeComponent class.

{% prettify dart %}
class PirateBadgeComponent {
  String badgeName = [[highlight]]''[[/highlight]];
  [[highlight]]void updateBadge(String inputName) {[[/highlight]]
    [[highlight]]badgeName = inputName;[[/highlight]]
  [[highlight]]}[[/highlight]]
}
{% endprettify %}

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* When an input event occurs on pirate badge component,
  Angular calls `updateBadge()` with the value entered by the user.

</div> </div>

## <i class="fa fa-anchor"> </i> Test it!

<div class="trydart-step-details" markdown="1">

Click <img src="images/run.png" alt="the green arrow"> to run the app.
Type into the input field.
The name badge updates to display what you've typed.
</div>

## Problems?

Look in WebStorm's window for possible errors, then look
in Dartium's JavaScript console. You can find the console under
**View > Developer > JavaScript Console**.

Finally, check your code against the files in
[3-inputnamebadge](https://github.com/dart-lang/one-hour-codelab/tree/ng2/ng2/3-inputnamebadge).

* [lib/pirate_badge_component.dart](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/3-inputnamebadge/lib/pirate_badge_component.dart)
* [lib/pirate_badge_component.html](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/3-inputnamebadge/lib/pirate_badge_component.html)

<hr>

{% include codelab-nav.html %}
