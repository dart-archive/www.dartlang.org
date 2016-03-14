---
layout: codelab
title: "Step 4: Add a Button"
codelab-name: "Avast, Ye Pirates: Write a Web App"
description: "Take your first step to learning Dart fast."
snippet_img: images/piratemap.jpg
prev: 3-inputnamebadge.html
prev-title: "Step 3: Add an Input Field"
next: 5-piratenameservice.html
next-title: "Step 5: Create a Name Service"
header:
  css: ["/codelabs/ng2/darrrt.css"]
---

{% include codelab-nav.html %}

# {{ page.title }}

In this step, you add a button.
The button is enabled when the input field is empty.
When the user clicks the button,
the app displays "Anne Bonney" on the badge.

## <i class="fa fa-anchor"> </i> Edit pirate_badge_component.html.

<div class="trydart-step-details" markdown="1">
Add a button to the `widgets` div.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify html %}{% raw %}
<div class="widgets">
  <input (input)="updateBadge($event.target.value)"
         type="text" maxlength="15">
  [[highlight]]<button [disabled]="!enableButton" (click)="generateBadge()">[[/highlight]]
    [[highlight]]{{buttonText}}[[/highlight]]
  [[highlight]]</button>[[/highlight]]
</div>
<div class="badge">
  <div class="greeting">Arrr! Me name is</div>
  <div class="name">{{badgeName}}</div>
</div>
{% endraw %}{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* Square brackets `[]` specify a _property_ on the element.
  This example references the `disabled` property.

* The `[disabled] != "!enableButton"` text enables or disables
  the button element, based on the value of the corresponding Dart variable.

* You will add `enableButton` to the Dart code in the next section.

* The `(click)="generateBadge()"` text sets up an event handler for button
  clicks.  You'll add the `generateBadge()` event handler to the Dart
  code in the next section.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div></div>

## <i class="fa fa-anchor"> </i> Edit pirate_badge_component.dart.

<div class="trydart-step-details" markdown="1">
Add two variables to the PirateBadgeComponent class.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

{% prettify dart %}
class PirateBadgeComponent {
  String badgeName = '';
  [[highlight]]String buttonText = 'Aye! Gimme a name!';[[/highlight]]
  [[highlight]]bool enableButton = true;[[/highlight]]
  ...
}
{% endprettify %}

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* All instance variables defined in an Angular component are visible
  to the template for that component.

* As you've seen, the HTML template uses `enableButton`
  when displaying the button.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

<div class="trydart-step-details" markdown="1">

<hr>

Add a `generateBadge()` function.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details">
{% prettify dart %}
@Component(selector: 'pirate-badge', templateUrl: 'pirate_badge_component.html')
class PirateBadgeComponent {
  String badgeName = '';
  String buttonText = 'Aye! Gimme a name!';
  bool enableButton = true;
  bool enableInput = true;

  [[highlight]]void generateBadge() {[[/highlight]]
    [[highlight]]badgeName = 'Anne Bonney';[[/highlight]]
  [[highlight]]}[[/highlight]]

  void updateBadge(String inputName) {
    badgeName = inputName;
  }
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* Clicking the button displays "Anne Bonney" on the pirate badge.
  In Step 5, you replace this with more interesting logic.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Modify the `updateBadge()` function to toggle the button's
state based on whether there is text in the input field.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details">
{% prettify dart %}
class PirateBadgeComponent {
  ...
  void updateBadge(String inputName) {
    badgeName = inputName;
    [[highlight]]if (inputName.trim().isEmpty) {[[/highlight]]
      [[highlight]]buttonText = 'Aye! Gimme a name!';[[/highlight]]
      [[highlight]]enableButton = true;[[/highlight]]
    [[highlight]]} else {[[/highlight]]
      [[highlight]]buttonText = 'Arrr! Write yer name!';[[/highlight]]
      [[highlight]]enableButton = false;[[/highlight]]
    [[highlight]]}[[/highlight]]
  }
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* Enable the button if the input field is empty,
  otherwise disable it.

* The text on the button also changes depending on whether it's
  enabled.

</div></div>

## <i class="fa fa-anchor"> </i> Test it!

<div class="trydart-step-details" markdown="1">

Click <img src="images/run.png" alt="the green arrow"> to run the app.

Type in the input field. The name badge updates to display what you've typed,
and the button is disabled.  Remove the text from the input field and the
button is enabled. Click the button. The name badge displays "Anne Bonney".

## Problems?

Look in WebStorm's window for possible errors, then look
in Dartium's JavaScript console. You can find the console under
**View > Developer > JavaScript Console**.

Finally, check your code against the files in
[4-buttonbadge](https://github.com/dart-lang/one-hour-codelab/tree/ng2/ng2/4-buttonbadge).

* [lib/pirate_badge_component.dart](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/4-buttonbadge/lib/pirate_badge_component.dart)
* [lib/pirate_badge_component.html](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/4-buttonbadge/lib/pirate_badge_component.html)

<hr>

{% include codelab-nav.html %}
