---
layout: tutorial
title: "Avast, Ye Pirates: Write a Web App"
description: "Take your first step to learning Dart fast."
snippet_img: images/piratemap.jpg
has-permalinks: true
tutorial:
  id: trydart
header:
  css: ["/codelabs/ng2/darrrt.css"]
---

# {{ page.title }}

{% comment %}
TODO:
* change 6-* to use ngOnInit - it's a "lifecycle" method
* remove step 7 from the repo -- for now
* should I then work on a continuation that shows dependency injection
  and some of the testing concepts that Sanford talked about?
* Or... What is the next doc I should work on?
{% endcomment %}

This code lab introduces you to the Dart language and libraries
by walking you through the process of building a simple web app
using Angular 2.

<strong>Build this app!</strong>

<iframe class="running-app-frame"
        style="height:220px;width:550px;"
        src="examples/web/index.html">
</iframe>

<hr>

<div class="piratemap" markdown="1" style="min-height:325px">

## Map

* [Step 0: Set up](#set-up)
* [Step 1: Create a basic web app](#step-one)
* [Step 2: Add a pirate badge component](#step-two)
* [Step 3: Add an input field](#step-three)
* [Step 4: Add a button](#step-four)
* [Step 5: Create a name service](#step-five)
* [Step 6: Read a JSON file](#step-six)
* [What next?](#whatnext)
* [Summary and resources](#resources)
</div>

<div class="row"> <div class="col-md-7" markdown="1">

</div> <div class="col-md-5" markdown="1">

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

<hr>

##Step 0: Set up {#set-up}

In this step, you download any software that you need,
and get the sample code.

### <i class="fa fa-anchor"> </i> Get Dart.

<div class="trydart-step-details" markdown="1">

If you haven't already done so, get the [Dart SDK](/downloads/).

The Dart SDK download includes several Dart tools that you'll need,
including `dart`, `pub`, and `dartanalyzer`. If you wish to run these
tools from the command line, add
`<path-to-the-SDK>/dart-sdk/bin` to your path.
</div>

### <i class="fa fa-anchor"> </i> Get Dartium and other tools

<div class="trydart-step-details" markdown="1">

You will need [Dartium](/downloads/) to test your app during development, as
well as your preferred IDE.  If you don't have a favorite editor already, try
[WebStorm](https://confluence.jetbrains.com/display/WI/Getting+started+with+Dart),
which comes with a Dart plugin. You can also download
[Dart plugins for other IDEs and editors](/tools/).

If this is the first time you've used your IDE with Dart, you'll
need to configure the plugin with the location of the Dart SDK and
Dartium. See
[Configuring Dart support](/tools/webstorm/#configuring-dart-support)
for instructions on configuring WebStorm. The
[Dart Tools](/tools/) page has links where you can find more information
about other plugins.

<aside class="alert alert-info" markdown="1">
**Note:**
This code lab works with any IDE or editor, but the instructions
assume that you're using WebStorm.
</aside>

</div>

### <i class="fa fa-anchor"> </i> Get the sample code.

<div class="trydart-step-details" markdown="1">

Download the sample code from the `ng2` branch of the
[one-hour-codelab GitHub repo](https://github.com/dart-lang/one-hour-codelab/tree/ng2)
using one of the following options:

<ul markdown="1">
<li markdown="1">Download the ZIP file,
  [one-hour-codelab-master.zip](https://github.com/dart-lang/one-hour-codelab/archive/ng2.zip).
  Unzip the ZIP file, which creates a directory called
  `one-hour-codelab-ng2`.
</li>

<li markdown="1">Clone the repo. From the command line:

{% prettify sh %}
git clone https://github.com/dart-lang/one-hour-codelab.git
{% endprettify %}

This creates a directory named `one-hour-codelab`. From the
`one-hour-codelab` directory, change to the `ng2` branch:

{% prettify sh %}
git checkout ng2
{% endprettify %}
</li>
</ul>

xxx: This section needs updating after the ng2 code is pushed to from ng2 to
master.

</div>

### <i class="fa fa-anchor"> </i> Look at the one-hour-codelab sample.

<div class="trydart-step-details" markdown="1">
The `ng2` directory contains several examples. Each example
corresponds to a completed step in this code lab:

`1-skeleton`
: A basic angular2 app.

`2-blankbadge`
: Displays the name badge.

`3-inputnamebadge`
: Enter text into the input field. As you type, it is displayed
  on the name badge.

`4-buttonbadge`
: When the input field is empty, the button is enabled.
  Click the button to see "Anne Bonney" on the name badge.

`5-piratenameservice`
: Click the button to see a pirate name, chosen at random from
  a list, appear on the name badge.

`6-readjsonfile`
: The list of pirate names are loaded from a JSON file on dartlang.

`7-final`
: The pirate name is provided by _dependency injection_.

xxx: Make the previous list parallel.

<div class="trydart-note" markdown="1">
<strong>Note:</strong>
As you work through this code lab,
you can use the files in the numbered directories to compare to your code
or to recover if you get off track.
</div>

</div>

<hr>

##Step 1: Create a basic web app {#step-one}

In this step, you create a basic web app.

### <i class="fa fa-anchor"> </i> Create a basic web app.

[Stagehand](https://github.com/google/stagehand),
a Dart project generator, provides a set of templates
for creating a variety of Dart apps.
When you create a new app,
you can start with one of the application templates,
or you can start from scratch.

<ol>
<li markdown="1">Launch WebStorm. This brings up a "Welcome to WebStorm" dialog.
</li>

<li markdown="1">If you have not already done so, set the paths to Dartium and
the SDK. You can find the instructions at
[Configuring Dart Support](/tools/webstorm/#configuring-dart-support).
</li>

<li markdown="1">Choose **Create New Project**. A dialog appears asking you to
fill out a simple form.
</li>

<li markdown="1">Select **Dart** from the list on the left.
This loads the available project templates from Stagehand.
</li>

<li markdown="1">In the **Location** input field, replace "untitled"
with "pirate_badge".
</li>

<li markdown="1">Make sure that **Generate sample content** is checked.
</li>

<li markdown="1">Select **Angular 2 Web Application** from the list.

The form should look similar to the following:

<img style="border:1px solid black" src="images/create-ng2-project.jpg" alt="A screenshot of the Welcome to WebStorm window, with the specified selections">
</li>

<li markdown="1">Click **Create**.
</li>
</ol>

WebStorm creates a `pirate_badge` directory and boilerplate files for
a basic Angular 2 app. It then runs `pub get` to download the packages
that the app depends on.

### <i class="fa fa-anchor"> </i> What did you get?

Get familiar with the structure of a basic Angular app.

<div class="trydart-step-details" markdown="1">

Expand the `pirate_badge` folder.
Then expand the `lib` and `web` folders to see the following:

<img style="border:1px solid black" src="images/project-files.jpg" alt="The list of autocreated files.">

For now, you can ignore some of these auto-created files.
The following diagram shows the most relevant files and directories:

<img src="images/basic-web-app-directory-structure.png" alt="The important lib, web, and pubspec files created using the Stagehand templates.">

The `lib` directory contains library files. In an Angular app,
component classes are generally created as library files.
The `web` directory contains the "main" files for a web app.

</div>

### <i class="fa fa-anchor"> </i> Review the code. {#review-the-code}

<div class="trydart-step-details" markdown="1">
Get familiar with the HTML and the Dart code for the skeleton
version of the app.
</div>

<div class="trydart-step-details" markdown="1">
#### **main.dart**
</div>

<div class="row"> <div class="col-md-7" markdown="1">
<div class="trydart-step-details" markdown="1">

{% prettify html %}
import 'package:angular2/bootstrap.dart';
import 'package:pirate_badge/app_component.dart';

main() {
  bootstrap(AppComponent);
}
{% endprettify %}

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* The `main()` function is the single entry point for the app.

* `main()` is a top-level function.
  A top-level variable or function is one that is declared outside a
  class definition.

* The top lines import two libraries. All Dart files that use Angular
  APIs import `angular2.dart`. Only files that call `bootstrap()`
  import `bootstrap.dart`.

* The second import, `app_component.dart`,
  pulls in the root component, `AppComponent`.
  Dart filenames use lower case, separating words with underscores,
  while Dart classes use camel case.
  So, the `app_component.dart` file defines the `AppComponent` class.

* Calling `bootstrap()` with the root component launches Angular.

</div> </div>

<div class="trydart-step-details" markdown="1">
#### **index.html**
</div>

<div class="row"> <div class="col-md-7" markdown="1">
<div class="trydart-step-details" markdown="1">

{% prettify html %}
<!DOCTYPE html>
<html>
  <head>
    <title>pirate_badge</title>

    <script defer src="main.dart" type="application/dart"></script>
    <script defer src="packages/browser/dart.js"></script>
  </head>
  <body>
    <my-app>Loading...</my-app>
  </body>
</html>
{% endprettify %}

</div>

</div> <div class="col-md-5" markdown="1">

* The first `<script>` tag identifies the main file that implements
  the app. Here, it's the `main.dart` file. The Dart VM launches
  the app using this file.

* The `packages/browser/dart.js` script checks for native Dart
  support (for example, Dartium) and either bootstraps the Dart VM
  or loads compiled JavaScript instead.

* When Angular detects the `<my-app>` selector, it loads the
  component associated with that selector. In this example,
  that's the `AppComponent` class.

* This file isn't touched throughout this code lab. Most of the work
  happens in the Angular components and in a service class.

</div></div>

<div class="trydart-step-details" markdown="1">
#### **app_component.dart**
</div>

<div class="row"> <div class="col-md-7" markdown="1">
<div class="trydart-step-details" markdown="1">

{% prettify dart %}
import 'package:angular2/angular2.dart';

@Component(selector: 'my-app', templateUrl: 'app_component.html')
class AppComponent {}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

* Angular is an application framework for web apps.

* In Angular, you display data by defining components, a type of class.

* A component manages a _view_, an HTML template that defines
  the component's UI.

* A component encapsulates the appearance and behavior of the view.

* The `@Component` annotation defines `AppComponent` as an Angular 2
  component.

* The `@Component` constructor has two named parameters: `selector`
  and `templateUrl`.

* The `selector` parameter specifies a CSS selector for this component.
  Angular creates and displays an instance of `AppComponent` when it
  encounters a `my-app` element in the HTML.

* The `templateUrl` parameter specifies the file that contains the view.
  To define the HTML _within_ the Dart file,
  use the `template` parameter instead.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}
</div> </div>

<div class="trydart-step-details" markdown="1">
#### **app_component.html**
</div>

<div class="row"> <div class="col-md-7" markdown="1">
<div class="trydart-step-details" markdown="1">

{% prettify html %}
<h1>My First Angular 2 App</h1>
{% endprettify %}

</div>

</div> <div class="col-md-5" markdown="1">

* This simple component displays a title.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}
</div> </div>

<div class="trydart-step-details" markdown="1">
#### **pubspec.yaml**
</div>

<div class="row"> <div class="col-md-7" markdown="1">
<div class="trydart-step-details" markdown="1">

{% prettify yaml %}
name: pirate_badge
description: Write a Dart web app code lab
version: 0.0.1
dependencies:
  angular2: 2.0.0-beta.0
  browser: ^0.10.0
transformers:
- angular2:
    entry_points: web/main.dart
{% endprettify %}

</div>

</div> <div class="col-md-5" markdown="1">

* Every Dart application is a package.

* The `pubspec.yaml` file (often referred to as the _pubspec_)
  contains metadata about that package, such as its name.

* The pubspec also lists the libraries on which the
  app depends. The `browser` and `angular` libraries needed by
  this app are hosted on [pub.dartlang.org](https://pub.dartlang.org/)
  along with many others.

* You specify one or more entry points to the `angular2` transformer
  in the pubspec.

* When creating or modifying the pubspec, running `pub get` installs
  the packages that your app depends on.
  WebStorm typically detects these changes and automatically installs
  the necessary packages, but you can also install or update the
  packages manually using buttons that are available when you open
  the pubspec file.

* Fetching the dependencies creates the `pubspec.lock` file,
  which contains the specific versions of the dependencies used by your app.

</div> </div>

### <i class="fa fa-anchor"> </i> Run the app.

<div class="trydart-step-details" markdown="1">

Run the app using Dartium.

From the list of files,
right-click `index.html` and select **Run index.html** from the menu
that pops up.

Dartium launches and loads the app. You should see the following:

<img style="border:1px solid black" src="images/first-ng2-app.png" alt="The skeleton app.">

After you've run the app using the menu, WebStorm remembers.
In future, you can launch the app using the enabled "run" button
(<img src="images/run.png">) in the upper right.

</div>

<hr>

##Step 2: Add a pirate badge component {#step-two}

In this step, you extend the basic Angular 2 app
with a pirate badge component, which encapulates
the behavior and appearance of the pirate badge.

As part of this work,
the lib directory is slightly restructured: some
files are moved and renamed, and a new file is added.
Finally, styling is added for the name badge.

### <i class="fa fa-anchor"> </i> Move the app_component.* files.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

<ol markdown="1">
<li markdown="1">Select `app_component.dart` and choose
  **Refactor > Move...** from the menu.
</li>
<li markdown="1">In the dialog that pops up,
  add "components" to the end of the string.
  This creates a new `lib/components` directory and moves the
  file there.
</li>
<li markdown="1">Repeat this step for `app_component.html`.
</li>
<li markdown="1">Open `main.dart` and change the
  `app_component.dart` import to
  reflect the change in directory structure:

{% prettify dart %}
import 'components/app_component.dart';
{% endprettify %}
</li>
<li markdown="1">Test it!
   Click the **Run** button to ensure that the app still works.
</li>
</ol>

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* Library files live under the `lib` directory and are public to
  other packages.

* You can create any hierarchy under `lib`.

* A common convention in Angular Dart is to place components under
  `lib/components` and services under `lib/services`.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}
</div> </div>

### <i class="fa fa-anchor"> </i> Rename app_component.* to pirate_badge_component.*.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

<ol>
<li markdown="1">Select `app_component.dart` and choose
  **Refactor > Rename...** from the menu.
</li>
<li markdown="1">Change the name to `pirate_badge_component.dart`.
</li>
<li markdown="1">Repeat this step for `app_component.html`.
  In the message window,
  WebStorm asks if you are sure that you want to proceed.
  Click **Do Refactor**.
</li>
<li markdown="1">Open `main.dart`.
  Confirm that the import reflects the new name.
</li>
<li markdown="1">Test it!
  Click the **Run** button to ensure that the app still works.
</li>
</ol>
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* Angular apps are modular and typically consist of a high level root
  component, referred to as the _app component_,
  that lives directly under the `lib` directory.
  The app component controls the other components.

* The high level component is passed to `bootstrap()` in
  `main.dart`.

* This step renamed the `app_component` files to `pirate_badge_component`,
  so our next task is to add a new root component that
  uses the `pirate_badge_component`.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}
</div> </div>

### <i class="fa fa-anchor"> </i> Add a root-level app component, App.

<div class="trydart-step-details" markdown="1">
Create a new file under `lib`.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

<ol markdown="1">
<li markdown="1">Select the `lib` directory and choose
   **File > New...** from the menu.
</li>
<li markdown="1">Select **File** from the list.
</li>
<li markdown="1">A dialog appears.
   Enter "app.dart" as the file name and click **OK**.
</li>
</ol>
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* By convention, the root-level app component goes directly under `lib`.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

<div class="trydart-step-details" markdown="1">
Add imports to the file that you just created.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
import 'package:angular2/angular2.dart';
import 'components/pirate_badge_component.dart';
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

* The root component manages all of the components in the app,
  so it imports the pirate badge component.

* When importing a library within `lib`,
  you can use a relative path.
  When importing a library that crosses the `lib` boundary,
  use an absolute location, specified using `package:`.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

<div class="trydart-step-details" markdown="1">
Add an empty `App` class marked with an `@Component` annotation.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
@Component(
    selector: 'my-app',
    template: '''
    <h1>Pirate badge</h1>
    <pirate-badge></pirate-badge>
    ''',
    directives: const [PirateBadge])
class App {}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

* xxx - say something about the @Component annotation...

* xxx - say something about directives, selectors, inline CSS

* The HTML view is defined in app.dart, so you don't need an `app.html` file.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

### <i class="fa fa-anchor"> </i> Edit pirate_badge_component.dart.

<div class="trydart-step-details" markdown="1">
xxx ...
Ends up with the following:
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
import 'package:angular2/angular2.dart';

@Component(
    selector: 'pirate-badge',
    templateUrl: 'pirate_badge_component.html')
class PirateBadge {
  String badgeName = "";
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* xxx blah blah

</div></div>

### <i class="fa fa-anchor"> </i> Edit pirate_badge_component.html.

<div class="trydart-step-details" markdown="1">
Replace the title with HTML for the name badge:
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify html %}{% raw %}
[[highlight]]<div class="badge">[[/highlight]]
  [[highlight]]<div class="greeting">Arrr! Me name is</div>[[/highlight]]
  [[highlight]]<div class="name">{{ badgeName }}</div>[[/highlight]]
[[highlight]]</div>[[/highlight]]
{% endraw %}{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* xxx - blah

</div></div>

### <i class="fa fa-anchor"> </i> Edit web/index.html.

<div class="trydart-step-details" markdown="1">
Make the following changes:
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify html %}
<!DOCTYPE html>

<html>
  <head>
    [[highlight]]<meta charset="utf-8">[[/highlight]]
    [[highlight]]<meta http-equiv="X-UA-Compatible" content="IE=edge">[[/highlight]]
    [[highlight]]<meta name="description" content="">[[/highlight]]
    [[highlight]]<meta name="viewport" content="width=device-width, initial-scale=1">[[/highlight]]

    [[highlight]]<title>Avast, Ye Pirates</title>[[/highlight]]

    [[highlight]]<link rel="stylesheet" href="styles.css">[[/highlight]]

    <script defer type="application/dart" src="main.dart"></script>
    <script defer src="packages/browser/dart.js"></script>
  </head>
  <body>
    <my-app>Loading...</my-app>
  </body>
</html>
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* xxx - blah

</div></div>

### <i class="fa fa-anchor"> </i> Edit main.dart.

<div class="trydart-step-details" markdown="1">
Make the following changes:
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
import 'package:angular2/bootstrap.dart';
[[highlight]]import 'package:pirate_badge/app.dart';[[/highlight]]

main() {
  [[highlight]]bootstrap(App);[[/highlight]]
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* xxx

</div></div>

### <i class="fa fa-anchor"> </i> Create a styles.css file.

<div class="trydart-step-details" markdown="1">
Select `web` and choose **File > New...**. Enter "styles.css"
as the name and click **OK**.
</div>

<div class="trydart-step-details" markdown="1">
Paste the contents from [styles.css](xxx) into the newly created file.
</div>

### <i class="fa fa-anchor"> </i> Test it!

<div class="trydart-step-details" markdown="1">
Run the app. You should see a blank name badge:

<img style="border:1px solid black" src="images/basic-pirate-name-badge.png" alt="A screenshot of the basic pirate name badge">
</div>

Next we will add some interactivity.

xxx: GLOBALLY-Add a note:
"Problems?<br>
If you are off track, here are the files you can start up with..."<br>
Link to the 2-blankbadge files on GitHub.

##Step 3: Add an input field {#step-three}

In this step, you add an input field.
As the user types into the input field,
the badge updates.

### <i class="fa fa-anchor"> </i> Edit pirate_badge_component.html.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

Add an input field to the top of the file:

{% prettify html %}
<div class="widgets">
  <input (input)="updateBadge($event.target.value)"
         type="text" maxlength="15">
</div>
{% endprettify %}

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* PENDING: xxx: Explain how this works, once I understand it.
  For example, where is "(input)" described? Does it come from
  ng2 or from HTML5? What's really going on here?

</div> </div>

### <i class="fa fa-anchor"> </i> Edit pirate_badge_component.dart.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

Add an event hander called `updateBadge()` to the PirateBadge class.

{% prettify dart %}
  void updateBadge(String inputName) {
    badgeName = inputName.toString();
  }
{% endprettify %}

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* Angular calls the `updateBadge()` event handler when
  when the input field receives a change event.

</div> </div>

### <i class="fa fa-anchor"> </i> Test it!

<div class="trydart-step-details" markdown="1">

Run the app. Type into the text field and see the badge update.
The UI should look similar to the following screenshot.

<img style="border:1px solid black" src="images/pirate-badge-input-field.png" alt="A screenshot of the app with input field filled in">

</div>

<hr>

##Step 4: Add a button {#step-four}

In this step, you add a button.
The button is enabled when the text field contains no text.
When the user clicks the button,
the app displays "Anne Bonney" on the badge.

### <i class="fa fa-anchor"> </i> Edit pirate_badge_component.html.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

Replace the `widgets` div at the top of the file with the following:

{% prettify html %}{% raw %}
<div class="widgets">
  <input [disabled]="!enableInput" (input)="updateBadge($event.target.value)"
         type="text" maxlength="15">
  <button [disabled]="!enableButton" (click)="generateBadge()">
    {{ buttonText }}
  </button>
</div>
{% endraw %}{% endprettify %}

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* blah blah blah - xxx

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

### <i class="fa fa-anchor"> </i> Edit pirate_badge_component.dart.

xxx: TODO: Break this up into smaller steps - BUILD it.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

Replace the PirateBadge class with the following

{% prettify dart %}
class PirateBadge {
  String badgeName = "";
  String buttonText = "Aye! Gimme a name!";
  bool enableButton = true;
  bool enableInput = true;

  void generateBadge() {
    badgeName = 'Anne Bonney';
  }

  void updateBadge(String inputName) {
    badgeName = inputName.toString();
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

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* blah blah blah - xxx

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

### <i class="fa fa-anchor"> </i> Test it!

<div class="trydart-step-details" markdown="1">

Click the **Run** button.

Type in the input field.
Remove the text from the input field.
Click the button.

The UI should look like the following:

<img style="border:1px solid black" src="images/button-badge.png" alt="The app now has an input field, a button, and a name badge.">

#### Problems?

Check your code against the solution.

* <a href="https://github.com/dart-lang/one-hour-codelab/tree/master/darrrt/3-buttonbadge/web/main.dart" target="_blank">main.dart</a>
* <a href="https://github.com/dart-lang/one-hour-codelab/tree/master/darrrt/3-buttonbadge/web/index.html" target="_blank">index.html</a>

</div>

<hr>

##Step 5: Create a name service {#step-five}

A proper pirate name consists of a name and an appellation,
such as "Margy the Fierce" or "Renée the Fighter".
In this step, you add a service that returns a pirate name.

### <i class="fa fa-anchor"> </i> Create the class for the pirate name service.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

<ol markdown="1">
<li markdown="1">Highlight the `lib` directory and select
  **File > New...** from the menu.
</li>
<li markdown="1">Select **File** from the list.
</li>
<li markdown="1">Enter "services/pirate_name.dart"
  as the filename and click **OK**.
</li>
</ol>

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* By convention, services are placed under lib/services.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}
</div> </div>

### <i class="fa fa-anchor"> </i> Edit the pirate name service.

Edit the file that you just created.

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

</div> <div class="col-md-5" markdown="1">

* The class declaration provides the class name.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Create a class-level Random object.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateNameService {
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

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateName {
  static final Random indexGen = new Random();

  [[highlight]]final String _firstName;[[/highlight]]
  [[highlight]]final String _appellation;[[/highlight]]
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

* Private variables start with underscore (`_`).
  Dart has no `private` keyword.

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

* Lists are built into the language. These lists are created
  using list literals.

* The `List` class provides the API for lists.

</div></div>

<div class="trydart-step-details" markdown="1">
<hr>

Provide a constructor for the class.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateName {
  ...
  [[highlight]]PirateNameService({String firstName, String appellation})[[/highlight]]
      [[highlight]]: _firstName =[[/highlight]]
            [[highlight]]firstName ?? _names[indexGen.nextInt(_names.length)],[[/highlight]]
        [[highlight]]_appellation = appellation ??[[/highlight]]
            [[highlight]]_appellations[indexGen.nextInt(_appellations.length)];[[/highlight]]
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

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
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

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
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

### <i class="fa fa-anchor"> </i> Edit the pirate badge component.

In this step, you hook up the pirate name service to the pirate badge
component.

<div class="trydart-step-details" markdown="1">
Open `lib/components/pirate_badge_component.dart`.
</div>

<div class="trydart-step-details" markdown="1">
Import the pirate name service.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
import 'package:angular2/angular2.dart';
[[highlight]]import '../services/pirate_name.dart' show PirateNameService;[[/highlight]]
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* xxx

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Add a `setBadgeName()` method.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateBadge {
  ...
  [[highlight]]void setBadgeName(PirateNameService newName) {[[/highlight]]
    [[highlight]]if (newName == null) return;[[/highlight]]
    [[highlight]]badgeName = newName.pirateName;[[/highlight]]
  [[highlight]]}[[/highlight]]
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* Get a new pirate name from the name service.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Update `generateBadge()` to call `setBadgeName()` for a new pirate name.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
  [[highlight]]void generateBadge() => setBadgeName(new PirateNameService());[[/highlight]]
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

* xxx

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Modify the `updateBadge()` function to use the name service.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateBadge() {
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

</div> <div class="col-md-5" markdown="1">

* xxx

</div></div>

### <i class="fa fa-anchor"> </i> Test it!

<div class="trydart-step-details" markdown="1">

Click the **Run** button.

Click the button.
Each click should display a new pirate name.

#### Problems?

Check your code against the solution.

* <a href="https://github.com/dart-lang/one-hour-codelab/tree/master/darrrt/5-final/web/main.dart" target="_blank">main.dart</a>
* <a href="https://github.com/dart-lang/one-hour-codelab/tree/master/darrrt/5-final/web/index.html" target="_blank">index.html</a>

</div>

<hr>

##Step 6: Read a JSON file {#step-six}

In this step, you change the PirateName service to fetch
the names and appellations from a JSON file on dartlang.

### <i class="fa fa-anchor"> </i> Edit the pirate name service.

Open `lib/services/pirate_name.dart`.

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

* `JSON` provides convenient access to the most commonly used JSON
  conversion utilities.

* The `dart_async` library provides for asynchronous programming.

* A `Future` provides a way to get a value in the future.
  (For JavaScript developers: Futures are similar to Promises.)

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Replace the `names` and `appellations` lists with these static,
empty lists.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateName {
  static final Random indexGen = new Random();

  [[highlight]]static final List<String> _names = [];[[/highlight]]
  [[highlight]]static final List<String> _appellations = [];[[/highlight]]
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

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

  [[highlight]]static Future readyThePirates() async {[[/highlight]]
    [[highlight]]if (_names.isNotEmpty && _appellations.isNotEmpty) {[[/highlight]]
      [[highlight]]return;[[/highlight]]
    [[highlight]]}[[/highlight]]
    [[highlight]]final path = 'https://www.dartlang.org/codelabs/darrrt/files/'[[/highlight]]
        [[highlight]]'piratenames.json';[[/highlight]]
    [[highlight]]final jsonString = await HttpRequest.getString(path);[[/highlight]]
    [[highlight]]final pirateNames = JSON.decode(jsonString);[[/highlight]]
    [[highlight]]PirateNameService._names.addAll(pirateNames['names']);[[/highlight]]
    [[highlight]]PirateNameService._appellations[[/highlight]]
        [[highlight]].addAll(pirateNames['appellations']);[[/highlight]]
  [[highlight]]}[[/highlight]]
|
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

* `readyThePirates` is marked with the `async` keyword.
  An async function returns a Future immediately, so the caller
  has the opportunity to do something else while waiting for
  the function to complete its work.

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

### <i class="fa fa-anchor"> </i> Edit the pirate badge component.

xxxx - loads the JSON file...

<div class="trydart-step-details" markdown="1">

At startup, disable the button and input field.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateBadge {
  String badgeName = "";
  String buttonText = "Aye! Gimme a name!";
  [[highlight]]bool enableButton = false;[[/highlight]]
  [[highlight]]bool enableInput = false;[[/highlight]]
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* These inputs are enabled when the file is loaded.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Add a function to get the names from the JSON file,
handling both success and failure.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateBadge {
  ...

  [[highlight]]loadFile() async {[[/highlight]]
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
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

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

Add a PirateBadge constructor.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateBadge {
  [[highlight]]PirateBadge() {[[/highlight]]
    [[highlight]]loadFile();[[/highlight]]
  [[highlight]]}[[/highlight]]
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

* Constructors cannot be asynchronous. The
  asynchronous code is placed in a separate function
  that is called by the constructor.

</div></div>

----------

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

</div>

<hr>

##What next? {#whatnext}

Now that you've written your app, what do you do next?
Here are some suggestions.

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

</div>


{% comment %}
Original pirate code lab on the wayback machine:
https://web.archive.org/web/20150102192113/https://www.dartlang.org/codelabs/darrrt/
{% endcomment %}
