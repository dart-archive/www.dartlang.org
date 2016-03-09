---
layout: codelab
title: "Step 2: Add a Pirate Badge Component"
codelab-name: "Avast, Ye Pirates: Write a Web App"
description: "Take your first step to learning Dart fast."
snippet_img: images/piratemap.jpg
prev: 1-skeleton.html
prev-title: "Step 1: Create a Basic Web App"
next: 3-inputnamebadge.html
next-title: "Step 3: Add an Input Field"
header:
  css: ["/codelabs/ng2/darrrt.css"]
---

{% include codelab-nav.html %}

# {{ page.title }}

In this step, you extend the basic Angular app
with a pirate badge component, which encapulates
the behavior and appearance of the pirate badge.

This is the hardest step in this code lab.
By the end of this step, your app will display
a snazzy name badge. The next steps,
where you add interactivity, are easy and fun.

## <i class="fa fa-anchor"> </i> Add pirate_badge_component.html.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

<ol markdown="1">
<li markdown="1">In WebStorm's Project view,
   right-click the `lib` directory and
   select **New > File** from the menu that pops up.
</li>
<li markdown="1">Enter `pirate_badge_component.html` as the filename
   and click **OK**.
</li>
</ol>
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* WebStorm creates an empty `pirate_badge_component.html` file under `lib`.

* You can also create the file by selecting **New > HTML File** from
  the menu, and entering `pirate_badge_component` as the name, but the
  resulting file contains HTML required for a standalone page.
  You'll need to delete the code before proceeding.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}
</div> </div>

## <i class="fa fa-anchor"> </i> Edit pirate_badge_component.html.

<div class="trydart-step-details" markdown="1">
Enter the HTML for the name badge.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}{% raw %}
[[highlight]]<div class="badge">[[/highlight]]
  [[highlight]]<div class="greeting">Arrr! Me name is</div>[[/highlight]]
  [[highlight]]<div class="name">{{badgeName}}</div>[[/highlight]]
[[highlight]]</div>[[/highlight]]
{% endraw %}{% endprettify %}
</div>

<div class="trydart-step-details" markdown="1">
<aside class="alert alert-success" markdown="1">
<i class="fa fa-lightbulb-o"> </i> **Tip** <br>
WebStorm defaults to 4 characters when indenting HTML code.
You can change it to the 2-character indentation used in Dart code files:

<ol markdown="1">
<li markdown="1">Bring up the **Preferences** dialog.
</li>
<li markdown="1">Select **Editor > Code Style > HTML**.
</li>
<li markdown="1">Enter `2` for **Tab size** and **Indent**, and `4` for
  **Continuation indent**.
</li>
</ol>
</aside>
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* An Angular component defines an HTML template&mdash;it is not a complete
  HTML file with `<head>` and `<body>` tags, or a `DOCTYPE` definition.

* The `<div class =...>` code specifies the styling of the component.
  Later in this step, you add a style sheet that defines how the
  badge should be displayed. This lab doesn't cover how to write CSS.
  The [resources](resources.html) page has information on where you
  can learn more about CSS styling.

* You will add `badgeName` to the Dart code as an instance variable
  in the next section.

* All instance variables defined in an Angular component are
  available to the template for that component.

* The curly bracket notation, {% raw %}`{{expression}}`{% endraw %},
  is referred to as a "double mustache". This notation creates a
  one-way binding between the HTML template and the Dart code.

* The expression inside the curly brackets
  is evaluated using _interpolation_, a process where
  Angular evaluates the expression and converts it to a string.

* Angular's expression interpolation is different than Dart's string
  interpolation.

* In a double-mustache binding, data is copied from an expression into the UI.
  So, when the value of `badgeName` changes in the Dart code, it
  automatically updates in the UI.

</div></div>

## <i class="fa fa-anchor"> </i> Add pirate_badge_component.dart.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

<ol markdown="1">
<li markdown="1">In WebStorm's Project view,
   right-click the `lib` directory, and
   select **New > Dart File** from the menu that pops up.
</li>
<li markdown="1">Enter `pirate_badge_component` as the filename
   and click **OK**.
</li>
</ol>
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* WebStorm creates an empty `pirate_badge_component.dart` file under `lib`.
  Note that the Dart extension is provided for you.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}
</div> </div>

## <i class="fa fa-anchor"> </i> Edit pirate_badge_component.dart.

<div class="trydart-step-details" markdown="1">
Import the Angular 2 library.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
[[highlight]]import 'package:angular2/angular2.dart';[[/highlight]]
{% endprettify %}
</div>

<hr>

<div class="trydart-step-details" markdown="1">
Create a PirateBadgeComponent class annotated with
`@Component`. The class contains a name badge
instance variable&mdash;replace "Shams" with your name.
</div>

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
import 'package:angular2/angular2.dart';

[[highlight]]@Component(selector: 'pirate-badge', templateUrl: 'pirate_badge_component.html')[[/highlight]]
[[highlight]]class PirateBadgeComponent {[[/highlight]]
  [[highlight]]String badgeName = 'Shams';[[/highlight]]
[[highlight]]}[[/highlight]]
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* The pirate badge component manages the portion of the UI
  that displays the pirate badge. By the end of this code lab,
  the pirate badge component will also provide an input field for
  entering a name, and a button for generating a pirate name.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}
</div> </div>

## <i class="fa fa-anchor"> </i> Edit app_component.dart.

<div class="trydart-step-details" markdown="1">
Import the pirate badge component.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
import 'package:angular2/angular2.dart';
[[highlight]]import 'pirate_badge_component.dart';[[/highlight]]
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* A component imports the other components that it uses.

* By default, every Dart file is a separate library.

* When you have multiple Dart files under `lib`, they can import
  each other using a relative path, such as
  `import 'pirate_badge_component.dart'`.
  However, any file that's not under `lib` (`web/main.dart`, for example)
  must use a `package:` URL to import libraries defined under `lib`.

* After you import the library, the analyzer warns that you
  have an unused import. This error goes away when you add
  the `PirateBadgeComponent` directive in the next step.

</div> </div>

<hr>

<div class="trydart-step-details" markdown="1">

Add a directive to the `@Component` annotation.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
@Component(selector: 'my-app', templateUrl: 'app_component.html'[[highlight]],
    directives: const [PirateBadgeComponent][[/highlight]])
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* Any components that this component directly uses
  are listed in the `directives:` field.

* When the app component is loaded, Angular detects the
  `<pirate-badge>` selector and loads the PirateBadgeComponent class.


&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div></div>

<hr>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

Format the file.

To format the file that is currently open,
right-click in the editor view and select
**Reformat with Dart Style** from the menu that pops up.
After formatting, the file should look like the following:
</div>

<div class="trydart-step-details">
{% prettify dart %}
@Component(
    selector: 'my-app',
    templateUrl: 'app_component.html',
    directives: const [PirateBadgeComponent])
class AppComponent {}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* Well formatted code is (usually) more readable code.

* Only white space is affected.

<i class="fa fa-lightbulb-o key-header"> </i> <strong> Not using WebStorm? </strong>

* From the command line, format your code using the
  [dartfmt](https://github.com/dart-lang/dart_style#readme) command.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

## <i class="fa fa-anchor"> </i> Edit app_component.html.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
Replace the contents of the HTML template:
</div>

<div class="trydart-step-details" markdown="1">
{% prettify html %}
[[highlight]]<h1>Avast, Ye Pirates</h1>[[/highlight]]
[[highlight]]<pirate-badge></pirate-badge>[[/highlight]]
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* When Angular detects the `<pirate-badge>` selector, it loads an
  instance of `PirateBadgeComponent`.

</div></div>

<hr>

## <i class="fa fa-anchor"> </i> Create a style sheet.

<div class="row"> <div class="col-md-7" markdown="1">

Shiver me timbers!

The style sheet is too long to include here,
but we've provided one for you to copy and paste into your project.

<div class="trydart-step-details" markdown="1">
<ol markdown="1">
<li markdown="1">In WebStorm's Project view,
  right-click the `web` directory and
  select **New > Stylesheet** from the menu that pops up.
</li>
<li markdown="1">Enter `styles` in the dialog that opens and click **OK**.
  An empty `styles.css` file is created under `web`.
</li>
<li markdown="1">Paste the contents from
[styles.css](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/2-blankbadge/web/styles.css)
into the newly created file.
</li>
</ol>
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* Cascading Style Sheets (CSS) is a language used for describing
  the appearance of a document written in HTML, XHTML, or other
  markup languages.

* In this example,
  the style sheet defines the appearance of the pirate badge.

* We've provided a style sheet for you. The [resources](resources.html)
  section has information on where you can learn more about CSS
  styling.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}
</div> </div>

## <i class="fa fa-anchor"> </i> Edit index.html.

<div class="trydart-step-details" markdown="1">
Change the title to "Avast, Ye Pirates".
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify html %}
<!DOCTYPE html>

<html>
  <head>
    <title>[[highlight]]Avast, Ye Pirates[[/highlight]]</title>
    ...
  </head>
  ...
</html>
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

{% comment %}
<i class="fa fa-key key-header"> </i> <strong> Key information </strong>
{% endcomment %}

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Add a reference to the style sheet.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
<html>
  <head>
    <title>Avast, Ye Pirates</title>

    [[highlight]]<link rel="stylesheet" href="styles.css">[[/highlight]]

    <script defer src="main.dart" type="application/dart"></script>
    <script defer src="packages/browser/dart.js"></script>
  </head>
  ...
</html>
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
You should see a name badge with your name,
or "Shams" if you did not change the name:

<img style="border:1px solid black" src="images/basic-pirate-name-badge.png" alt="A screenshot of the basic pirate name badge">
</div>

Next you will add some interactivity.

## Problems?

Look in WebStorm's window for possible errors, then look
in Dartium's JavaScript console. You can find the console under
**View > Developer > JavaScript Console**.

Finally, check your code against the files in
[2-blankbadge](https://github.com/dart-lang/one-hour-codelab/tree/ng2/ng2/2-blankbadge).

* [lib/app_component.dart](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/2-blankbadge/lib/app_component.dart)
* [lib/app_component.html](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/2-blankbadge/lib/app_component.html)
* [lib/pirate_badge_component.dart](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/2-blankbadge/lib/pirate_badge_component.dart)
* [lib/pirate_badge_component.html](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/2-blankbadge/lib/pirate_badge_component.html)
* [web/index.html](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/2-blankbadge/web/index.html)
* [web/styles.css](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/2-blankbadge/web/styles.css)

<hr>

{% include codelab-nav.html %}
