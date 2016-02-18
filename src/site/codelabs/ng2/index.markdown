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

xxx: Add a note about the warning you get when you add imports
  but haven't used them yet.

# {{ page.title }}

This code lab walks you through the process of building a simple
web app with Dart and Angular2 2.

You don't need to know Dart, Angular, or web programming to complete
this code lab, but we do assume you have some programming experience.
You also need:

* A Windows, Mac, or Linux computer
* A web connection, so you can download software, libraries, and sample code

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

### <i class="fa fa-anchor"> </i> Get Dart and Dartium.

<div class="trydart-step-details" markdown="1">

If you haven't already done so, get the [Dart SDK](/downloads/)
and [Dartium](/tools/dartium).

The Dart SDK download includes several Dart tools that you'll need.
If you wish to run the Dart tools from the command line, add
`<path-to-the-SDK>/dart-sdk/bin` to your path.

You will need [Dartium](/downloads/) to test your app during development.
If you use Homebrew on the Mac, you can include Dartium as part of
the SDK download. Otherwise you can download Dartium directly:

* [Dartium for Windows](https://storage.googleapis.com/dart-archive/channels/stable/release/latest/dartium/dartium-windows-ia32-release.zip)
* [Dartium for Linux](https://storage.googleapis.com/dart-archive/channels/stable/release/latest/dartium/dartium-linux-x64-release.zip)
* [Dartium for Mac](https://storage.googleapis.com/dart-archive/channels/stable/release/latest/dartium/dartium-macos-ia32-release.zip)
</div>

### <i class="fa fa-anchor"> </i> Get WebStorm or a plugin.

<div class="trydart-step-details" markdown="1">

If you don't have a favorite editor already, try
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
While you can use any IDE or editor for Dart development,
these instructions assume that you're using WebStorm.
Alternate instructions are provided for some of the steps.
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

This creates a directory named `one-hour-codelab`.
From the `one-hour-codelab` directory, or a directory underneath
`one-hour-codelab`, check out the `ng2` branch:

{% prettify sh %}
cd one-hour-codelab
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
: Displays some text&mdash;a basic Angular 2 app

`2-blankbadge`
: Displays a pirate name badge

`3-inputnamebadge`
: As you type into the input field,
  the text displays on the name badge

`4-buttonbadge`
: An empty input field enables the button;
  clicking the button displays "Anne Bonney" on the name badge.

`5-piratenameservice`
: Clicking the button displays a pirate name chosen at random from a list

`6-readjsonfile`
: Loads the pirate names from a JSON file on the web

<aside class="alert alert-info" markdown="1">
<i class="fa fa-lightbulb-o"> </i> **Tip:** <br>
As you work through this code lab,
you can use the files in the numbered directories to compare to your code
or to recover if you get off track.
</aside>

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

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details" markdown="1">

<ol>
<li markdown="1">Launch WebStorm.
  If this is the first time you are running WebStorm, or if
  you have no open projects from a previous session,
  a "Welcome to WebStorm" dialog appears.
</li>

<li markdown="1">If you have not already done so, set the paths to Dartium and
the SDK. You can find the instructions at
[Configuring Dart Support](/tools/webstorm/#configuring-dart-support).
</li>

<li markdown="1">Choose **Create New Project** from the welcome panel,
or **File > New > Project...** from the menu.
A dialog appears asking you to fill out a simple form.
</li>

<li markdown="1">Select **Dart** from the list on the left.
This loads the available project templates from Stagehand.
</li>

<li markdown="1">In the **Location** input field, check that
the project folder is where you want it.
</li>

<li markdown="1">Also in the **Location** field,
change the name of the project from "untitled" to "pirate_badge".
</li>

<li markdown="1">Make sure that **Start Dartium in checked mode** is checked.
</li>

<li markdown="1">Make sure that **Generate sample content** is checked.
</li>

<li markdown="1">Select **Angular 2 Web Application** from the list.

The form should look similar to the following:

<img style="border:1px solid black" src="images/create-ng2-project.png" alt="A screenshot of the Welcome to WebStorm window, with the specified selections">
</li>

<li markdown="1">Click **Create**.
</li>
</ol>

WebStorm creates a `pirate_badge` directory and boilerplate files for
a basic Angular 2 app. It then runs `pub get` to download the packages
that the app depends on.

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-lightbulb-o"> </i> <strong> Not using WebStorm? </strong>

<ol markdown="1">
<li markdown="1">Create a directory on your computer for the project.
</li>
<li markdown="1">Copy the contents of the `one-hour-code-lab/ng2/1-skeleton`
    directory into your new project's directory.
</li>
<li markdown="1">Run `pub get` within your project's directory.
</li>
</ol>

</div></div>

### <i class="fa fa-anchor"> </i> What did you get?

Get familiar with the structure of a basic Angular app.

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details" markdown="1">
Expand the `pirate_badge` folder.
Then expand the `lib` and `web` folders to see the following:

<img style="border:1px solid black" src="images/project-files.jpg" alt="The list of autocreated files.">
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* Angular 2 is an application framework for web apps.

* In Angular, you display data by defining _components_, a type of class.

* A component manages a _view_, an HTML template that defines
  the component's UI.

* A component encapsulates the appearance and behavior of the view.

</div></div>

<div class="row"> <div class="col-md-7" markdown="1">
<div class="trydart-step-details" markdown="1">
For now, you can ignore some of these auto-created files.
The following shows the files and directories referenced in
this code lab:
</div>

<div class="trydart-step-details" markdown="1">

{% prettify none %}
pirate_badge/
  lib/
    app_component.dart
    app_component.html
  pubspec.yaml
  web/
    index.html
    main.dart
{% endprettify %}

As you might expect,
the `lib` directory contains library files. In an Angular app,
component classes are generally created as library files.
The `web` directory contains the "main" files for a web app.
</div>

</div> <div class="col-md-5" markdown="1">

</div></div>

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

{% prettify dart %}
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

* The top lines import two libraries.

* The `package:` syntax specifies the location of the library.

* This app depends on the `angular2` package, which is loaded from
  [pub.dartlang.org](https://pub.dartlang.org/).
  Files that call `bootstrap()` import `bootstrap.dart` from the
  angular package.

* The second import, `app_component.dart`,
  loads the app component, `AppComponent`.
  The text, `package:pirate_badge/app_component.dart`, tells
  the pub tool to look for this file under the `lib`
  directory of this app.

* By convention,
  Dart filenames use lower case, separating words with underscores,
  while Dart classes use camel case.
  So, the `app_component.dart` file defines the `AppComponent` class.

* Calling `bootstrap()` with the app component launches Angular.


</div> </div>

<hr>

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

* When Angular detects the `<my-app>` selector, it loads an
  instance of the component associated with that selector.
  In this example, that's the `AppComponent` class.

</div></div>

<hr>

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

* All Dart files that use Angular APIs import `angular2.dart`.

* The `@Component` annotation defines `AppComponent` as an Angular 2
  component.

* The `@Component` constructor has two named parameters: `selector`
  and `templateUrl`.

* The `selector` parameter specifies a CSS selector for this component.
  Angular creates and displays an instance of `AppComponent` when it
  encounters a `<my-app>` element in the HTML.

* The `templateUrl` parameter specifies the file that contains the view.
  To define the HTML _within_ the Dart file as a Dart string,
  use the `template` parameter instead.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}
</div> </div>

<hr>

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

* This file is the template for the AppComponent class.
  This HTML is inserted whenever the `<my-app>` element
  appears in the app.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}
</div> </div>

<hr>

<div class="trydart-step-details" markdown="1">
#### **pubspec.yaml**
</div>

<div class="row"> <div class="col-md-7" markdown="1">
<div class="trydart-step-details" markdown="1">

{% prettify yaml %}
name: pirate_badge
description: Write a Dart web app code lab
version: 0.0.1
environment:
  sdk: '>=1.13.0 <2.0.0'
dependencies:
  angular2: 2.0.0-beta.2
  browser: ^0.10.0
transformers:
- angular2:
    platform_directives:
    - 'package:angular2/common.dart#COMMON_DIRECTIVES'
    platform_pipes:
    - 'package:angular2/common.dart#COMMON_PIPES'
    entry_points: web/main.dart
{% endprettify %}

</div>

</div> <div class="col-md-5" markdown="1">

* The `pubspec.yaml` file (often referred to as the _pubspec_)
  contains metadata about that package, such as its name.

* The pubspec also lists the packages on which the
  app depends. The `browser` and `angular2` packages needed by
  this app are hosted on [pub.dartlang.org](https://pub.dartlang.org/)
  along with many others.

* When pub serves, builds, or runs an app, it can run one or
  more transformers to prepare the app.
  Transformers are listed and configured in
  the pubspec under the `transformers:` field.

* The Angular 2 transformer generates static structures that
  remove the need for reflection at runtime, making your app
  run more efficiently.

* The `platform_directives` definition makes some common
  Angular directives available to every component.
  An example of a common Angular direcdtive is NgIf,
  which lets a component change its UI based on a true-false value
  in your Dart code.

* The `platform_pipes` definition makes some common
  Angular pipes available to every component.
  For example, you can use the built-in PercentPipe to format
  a number as a percentage.

* The `entry_points` section tells the Angular transformer which file contains
  the starting point for the app. Some apps have multiple entrypoints.

* Running `pub get` installs the packages that your app depends on,
  as defined by your app's pubspec.
  WebStorm typically detects these changes and automatically installs
  the necessary packages, but you can also get the
  packages manually using buttons that appear in WebStorm when you open
  the pubspec file.

* The `pubspec.lock` file lists every package that your app directly
  or indirectly depends on, along with the version number for each package.

</div> </div>

### <i class="fa fa-anchor"> </i> Run the app.

Run the app using Dartium.

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details" markdown="1">
In WebStorm's Project view,
right-click `index.html` and select **Run 'index.html'** from the menu
that pops up.

WebStorm uses a built-in web server to launch Dartium and load the app.
You should see something like the following:

<img style="border:1px solid black" src="images/first-ng2-app.png" alt="The skeleton app.">

After you've run the app using the menu, WebStorm remembers.
In future, you can launch the app using the enabled **Run** button
<img src="images/run.png"> in the upper right.

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-lightbulb-o"> </i> <strong> Not using WebStorm? </strong>

You can manually launch a local HTTP server and
then view the app in Dartium.
The following instructions use the simple Python server:

<ol markdown="1">

<li markdown="1">
From the project's `web` directory,
launch the Python server as follows:

{% prettify none %}
cd pirate_badge/web
python -m SimpleHTTPServer
{% endprettify %}

You should see the following:

{% prettify none %}
Serving HTTP on 0.0.0.0 port 8000 ...
{% endprettify %}

You can specify an alternate port if 8000 is not available.

{% prettify none %}
python -m SimpleHTTPServer <port-number>
{% endprettify %}
</li>

<li markdown="1">
A dialog appears asking if you want to allow "Python.app"
to accept incoming network connections.
For this example, it doesn't matter, so you can select **Deny**.
</li>

<li markdown="1">
Launch Dartium. If Dartium is not in your path, specify the full path
to the executable. On a Mac, it would look something like the following:

{% prettify none %}
<path-to-dartium>/Chromium.app/Contents/MacOS/Chromium
{% endprettify %}

Dartium opens and displays two warnings highlighted in yellow:
"You are using an unsupported command-line flag..."
and "Google API keys are missing..."
You can ignore these.
</li>

<li markdown="1">
In the address bar, navigate to index.html as follows:

{% prettify none %}
localhost:8000/index.html
{% endprettify %}

If you specified a different port when you started the server,
use that instead of 8000:
</li>

</ol>

Your app's UI should load. If the app fails to load,
the JavaScript console (**View > Developer > JavaScript Console**)
might tell you why.

</div></div>

#### Problems?

Check your code against the files in
[1-skeleton](https://github.com/dart-lang/one-hour-codelab/tree/ng2/ng2/1-skeleton).

* [main.dart](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/1-skeleton/web/main.dart)
* [index.html](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/1-skeleton/web/index.html)
* [app_component.dart](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/1-skeleton/lib/app_component.dart)
* [app_component.html](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/1-skeleton/lib/app_component.html)

<hr>

##Step 2: Add a pirate badge component {#step-two}

In this step, you extend the basic Angular 2 app
with a pirate badge component, which encapulates
the behavior and appearance of the pirate badge.

This is the hardest step in this code lab.
By the end of this step, your Angular app will display
a snazzy name badge. The next steps,
where you add interactivity, are easy and fun.

### <i class="fa fa-anchor"> </i> Add pirate_badge_component.html.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

<ol markdown="1">
<li markdown="1">In WebStorm's Project view,
   right-click the `lib` directory and
   select **New > File** from the menu that pops up.
</li>
<li markdown="1">Enter "pirate_badge_component.html" into the dialog
   and click **OK**.
</li>
</ol>
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* WebStorm creates an empty `pirate_badge_component.html` file under `lib`.

* You can also create the file by selecting **New > HTML File** from
  the menu, and entering "pirate_badge_component" as the name, but the
  resulting file contains HTML required for a standalone page.
  You'll need to delete the code before proceeding.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}
</div> </div>

### <i class="fa fa-anchor"> </i> Edit pirate_badge_component.html.

<div class="trydart-step-details" markdown="1">
Define the HTML for the name badge.
</div>

<div class="trydart-step-details" markdown="1">
<aside class="alert alert-info" markdown="1">
<i class="fa fa-lightbulb-o"> </i> **Tip:** <br>
WebStorm defaults to 4 characters when indenting HTML code.
You can change it to the 2-character indentation used in Dart:

<ol markdown="1">
<li markdown="1">Bring up the **Preferences** dialog.
</li>
<li markdown="1">Select **Editor > Code Style > HTML**.
</li>
<li markdown="1">Enter "2" for **Tab size** and **Indent**, and "4" for
  **Continuation indent**.
</li>
</ol>
</aside>
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}{% raw %}
[[highlight]]<div class="badge">[[/highlight]]
  [[highlight]]<div class="greeting">Arrr! Me name is</div>[[/highlight]]
  [[highlight]]<div class="name">{{ badgeName }}</div>[[/highlight]]
[[highlight]]</div>[[/highlight]]
{% endraw %}{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* An Angular 2 component defines an HTML template&mdash;it is not a complete
  HTML file with `<head>` and `<body>` tags, and a `DOCTYPE` definition.

* The `<div class =...>` code specifies the styling of the component.
  Later in this step, you add a style sheet that defines how the
  badge should be displayed. This lab won't cover how to write CSS.
  The [resources](#resources) section has information on where you
  can learn more about CSS styling.

* You will add `badgeName` to the Dart code as an instance variable
  in the next section.

* All instance variables defined in an Angular 2 component are
  available to the template for that component.

* The curly bracket notation, {% raw %}`{{ expression }}`{% endraw %},
  referred to as "double mustache",
  creates a one-way binding between the HTML template and the Dart code.

* In a one-way binding, data is copied from an expression into the UI.
  So, when the value of `badgeName` changes in the Dart code, it
  automatically updates in the UI.

</div></div>

### <i class="fa fa-anchor"> </i> Add pirate_badge_component.dart.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

<ol markdown="1">
<li markdown="1">In WebStorm's Project view,
   right-click the `lib` directory, and
   select **New > Dart File** from the menu that pops up.
</li>
<li markdown="1">Enter "pirate_badge_component" into the dialog
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

### <i class="fa fa-anchor"> </i> Edit pirate_badge_component.dart.

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
Create a PirateBadgeComponent class containing a name badge
instance variable&mdash;replace "Shams" with your name.
</div>

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
import 'package:angular2/angular2.dart';

[[highlight]]class PirateBadgeComponent {[[/highlight]]
  [[highlight]]String badgeName = 'Shams';[[/highlight]]
[[highlight]]}[[/highlight]]
{% endprettify %}
</div>

<hr>

<div class="trydart-step-details" markdown="1">
Annotate the class with `@Component`.
</div>

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
[[highlight]]@Component(selector: 'pirate-badge', templateUrl: 'pirate_badge_component.html')[[/highlight]]
class PirateBadgeComponent {
  String badgeName = 'Shams';
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* The pirate badge component manages the portion of the UI
  that displays the pirate badge. By the end of this code lab,
  the pirate badge component will also provide an input field for
  entering a name, and a button for generating a pirate name.

<i class="fa fa-lightbulb-o key-header"> </i> <strong> Not using WebStorm? </strong>

* You can run the analyzer on your code at the command line using the
  [dartanalyzer](https://github.com/dart-lang/analyzer_cli#dartanalyzer) command.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}
</div> </div>

### <i class="fa fa-anchor"> </i> Edit app_component.dart.

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

* The root-level app component manages the other components in
  the app, so it imports the pirate badge component.

* When importing a library within `lib`, you can use a relative path.
  When importing a library that crosses the `lib` boundary,
  use an absolute location, specified using `package:`.

</div> </div>

<div class="trydart-step-details" markdown="1">

<hr>

Update the `@Component` annotation.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
@Component(
    selector: 'my-app',
    [[highlight]]template: '''[[/highlight]]
    [[highlight]]<h1>Pirate badge</h1>[[/highlight]]
    [[highlight]]<pirate-badge></pirate-badge>[[/highlight]]
    [[highlight]]''',[[/highlight]]
    [[highlight]]directives: const [PirateBadgeComponent])[[/highlight]]
class AppComponent {}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* The HTML template for the app component is simple,
  so the code uses the `template` parameter,
  and the HTML is defined inline.

* The template view consists of a level-one header and a
  `<pirate-badge>` instance.

* All components that this component interacts with are listed in
  the `directives:` field.

* The `selector` for the root-level app component is `my-app`.
  Angular creates and displays an instance of AppComponent when it
  encounters a `my-app` element in the HTML.

* When the app component is loaded, Angular detects the
  `<pirate-badge>` selector and loads the PirateBadgeComponent class.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

### <i class="fa fa-anchor"> </i> Delete app_component.html.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
<ol markdown="1">
<li markdown="1">Under `lib`, select app_component.html and type the delete key.
</li>

<li markdown="1">A dialog appears with the **Safe delete** and
**Search in comments and strings** checked. Leave them checked
and click **OK**.
</li>

<li markdown="1">At the bottom of the window,
WebStorm asks if you are sure you want to proceed.
Click **Do Refactor**.
</li>
</ol>
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* The template code for app_component is defined within the Dart file,
  so this file is no longer needed.

</div></div>

<hr>

### <i class="fa fa-anchor"> </i> Create a style sheet.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
<ol markdown="1">
<li markdown="1">In WebStorm's Project view,
  right-click the `web` directory and
  select **New > Stylesheet** from the menu that pops up.
</li>
<li markdown="1">Enter "styles" in the dialog that opens and click **OK**.
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

* We've provided a style sheet for you. The [resources](#resources)
  section has information on where you can learn more about CSS
  styling.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}
</div> </div>

### <i class="fa fa-anchor"> </i> Edit index.html.

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

### <i class="fa fa-anchor"> </i> Test it!

<div class="trydart-step-details" markdown="1">
Run the app. You should see a name badge with your name,
or "Shams" if you did not change the name:

<img style="border:1px solid black" src="images/basic-pirate-name-badge.png" alt="A screenshot of the basic pirate name badge">
</div>

Next you will add some interactivity.

#### Problems?

Check your code against the files in
[2-blankbadge](https://github.com/dart-lang/one-hour-codelab/tree/ng2/ng2/2-blankbadge).

* [index.html](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/2-blankbadge/web/index.html)
* [app_component.dart](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/2-blankbadge/lib/app_component.dart)
* [pirate_badge_component.dart](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/2-blankbadge/lib/pirate_badge_component.dart)
* [pirate_badge_component.html](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/2-blankbadge/lib/pirate_badge_component.html)
* [styles.css](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/2-blankbadge/web/styles.css)


##Step 3: Add an input field {#step-three}

In this step, you add an input field.
As the user types into the input field,
the badge updates.

### <i class="fa fa-anchor"> </i> Edit pirate_badge_component.html.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

Add a div containing an input field to the top of the file:

{% prettify html %}
[[highlight]]<div class="widgets">[[/highlight]]
  [[highlight]]<input (input)="updateBadge($event.target.value)"[[/highlight]]
         [[highlight]]type="text" maxlength="15">[[/highlight]]
[[highlight]]</div>[[/highlight]]
{% endprettify %}

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* `<input...>` defines an HTML5 input element.

* The `(input)="updateBadge(...)"` text is referred to as
  _event binding_ syntax.
  The expression to the right of the equals sign is a _template statement_.

* The template statement may reference functions or variables
  from the Dart component code.

* By convention, a template statement is short&mdash;more
  complex logic should be placed in a function and called
  from the template statement.

* User input in this field is limited to 15 characters.

</div> </div>

### <i class="fa fa-anchor"> </i> Edit pirate_badge_component.dart.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

Add an event handler, `updateBadge()`, to the PirateBadgeComponent class.

{% prettify dart %}
class PirateBadgeComponent {
  String badgeName = '';
  [[highlight]]void updateBadge(String inputName) {[[/highlight]]
    [[highlight]]badgeName = inputName;[[/highlight]]
  [[highlight]]}[[/highlight]]
}
{% endprettify %}

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* The `(input)="updateBadge(...)"` attribute binds input events
  to the `updateBadge()` method in the component class.
  When an input event occurs on this element,
  Angular calls `updateBadge()` with the value entered by the user.

</div> </div>

### <i class="fa fa-anchor"> </i> Test it!

<div class="trydart-step-details" markdown="1">

Run the app. Type into the input field.
The name badge updates to display what you've typed.
The UI should look similar to the following screenshot.

<img style="border:1px solid black" src="images/pirate-badge-input-field.png" alt="A screenshot of the app with input field filled in">

</div>

#### Problems?

Check your code against the files in
[3-inputnamebadge](https://github.com/dart-lang/one-hour-codelab/tree/ng2/ng2/3-inputnamebadge).

* [pirate_badge_component.dart](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/3-inputnamebadge/lib/pirate_badge_component.dart)
* [pirate_badge_component.html](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/3-inputnamebadge/lib/pirate_badge_component.html)

<hr>

##Step 4: Add a button {#step-four}

In this step, you add a button.
The button is enabled when the input field is empty.
When the user clicks the button,
the app displays "Anne Bonney" on the badge.

### <i class="fa fa-anchor"> </i> Edit pirate_badge_component.html.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
Modify the input field to enable or disable input based on the
value of the `enableInput` boolean.
</div>

<div class="trydart-step-details" markdown="1">
{% prettify html %}{% raw %}
<div class="widgets">
  <input [[highlight]][disabled]="!enableInput"[[/highlight]] (input)="updateBadge($event.target.value)"
         type="text" maxlength="15">
</div>
<div class="badge">
  <div class="greeting">Arrr! Me name is</div>
  <div class="name">{{ badgeName }}</div>
</div>
{% endraw %}{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* You will add `enableInput` to the Dart code in the next section.

* Square brackets `[]` specify a _property_ on the element.
  This example references the `disabled` property.

* The `[disabled] != "!enableInput"` text enables or disables
  the input element, based on the value of the corresponding Dart variable.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}
</div> </div>

<div class="trydart-step-details" markdown="1">

<hr>

Add a button to the `widgets` div.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify html %}{% raw %}
<div class="widgets">
  <input [disabled]="!enableInput" (input)="updateBadge($event.target.value)"
         type="text" maxlength="15">
  [[highlight]]<button [disabled]="!enableButton" (click)="generateBadge()">[[/highlight]]
    [[highlight]]{{ buttonText }}[[/highlight]]
  [[highlight]]</button>[[/highlight]]
</div>
<div class="badge">
  <div class="greeting">Arrr! Me name is</div>
  <div class="name">{{ badgeName }}</div>
</div>
{% endraw %}{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

* Enable the  button depending on the value of `enableButton`.
  You will add this to the Dart code in the next section.

* The `(click)="generateBadge()"` text sets up an event handler&mdash;Angular
  calls `generateBadge()` when receiving a click event.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div></div>

### <i class="fa fa-anchor"> </i> Edit pirate_badge_component.dart.

<div class="trydart-step-details" markdown="1">
Add several variables to the PirateBadgeComponent class.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

{% prettify dart %}
class PirateBadgeComponent {
  String badgeName = '';
  [[highlight]]String buttonText = 'Aye! Gimme a name!';[[/highlight]]
  [[highlight]]bool enableButton = true;[[/highlight]]
  [[highlight]]bool enableInput = true;[[/highlight]]
{% endprettify %}

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* All instance variables defined in an Angular 2 component are visible
  to the template for that component.

* As you've seen, the HTML template uses `enableButton` and
  `enableInput` when displaying the button and input field, respectively.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

<div class="trydart-step-details" markdown="1">

<hr>

Add a `generateBadge()` function.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
  [[highlight]]void generateBadge() {[[/highlight]]
    [[highlight]]badgeName = 'Anne Bonney';[[/highlight]]
  [[highlight]]}[[/highlight]]
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

* Clicking the button displays "Anne Bonney" on the pirate badge.
  In Step 5, you replace this with more interesting logic.

</div></div>

<div class="trydart-step-details" markdown="1">

<hr>

Modify the `updateBadge()` function to toggle the button's
state based on whether there is text in the input field.
</div>

<div class="row"> <div class="col-md-7">

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

* Enable the button if the input field is empty,
  otherwise disable it.

* The text on the button also changes depending on whether it's
  enabled.

</div></div>

### <i class="fa fa-anchor"> </i> Test it!

<div class="trydart-step-details" markdown="1">

Run the app.

Type in the input field. The name badge updates to display what you've typed,
and the button is disabled.  Remove the text from the input field and the
button is enabled. Click the button. The name badge displays "Anne Bonney".

#### Problems?

Check your code against the files in
[4-buttonbadge](https://github.com/dart-lang/one-hour-codelab/tree/ng2/ng2/4-buttonbadge).

* [pirate_badge_component.dart](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/4-buttonbadge/lib/pirate_badge_component.dart)
* [pirate_badge_component.html](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/4-buttonbadge/lib/pirate_badge_component.html)

</div>

<hr>

##Step 5: Create a name service {#step-five}

A proper pirate name consists of a name and an appellation,
such as "Margy the Fierce" or "Renée the Fighter".
In this step, you add a service that returns a pirate name.

### <i class="fa fa-anchor"> </i> Create a class for the pirate name service.

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

### <i class="fa fa-anchor"> </i> Edit the pirate name service.

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

  [[highlight]]static final List _names = [[[/highlight]]
    [[highlight]]'Anne', 'Mary', 'Jack', 'Morgan', 'Roger',[[/highlight]]
    [[highlight]]'Bill', 'Ragnar', 'Ed', 'John', 'Jane' ];[[/highlight]]
  [[highlight]]static final List _appellations = [[[/highlight]]
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

Provide helper methods that retrieve a randomly chosen first name
and appellation.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
class PirateNameService {
  ...
  [[highlight]]static String randomFirstName() {[[/highlight]]
    [[highlight]]return _names[_indexGen.nextInt(_names.length)];[[/highlight]]
  [[highlight]]}[[/highlight]]

  [[highlight]]static String randomAppellation() {[[/highlight]]
    [[highlight]]return _appellations[_indexGen.nextInt(_appellations.length)];[[/highlight]]
  [[highlight]]}[[/highlight]]
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

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
  [[highlight]]PirateNameService({String firstName, String appellation})[[/highlight]]
      [[highlight]]: _firstName = firstName ?? randomFirstName(),[[/highlight]]
        [[highlight]]_appellation = appellation ?? randomAppellation();[[/highlight]]
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

* Constructor names can be either <em><code>ClassName</code></em> or
  <em><code>ClassName</code></em>.<em><code>identifier</code></em>.

* The parameters enclosed in curly brackets (`{` and `}`)
  are optional, named parameters.

* These parameters are initialized using an initializer list
  which appears after the colon (`:`).

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
class PirateNameService {
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

### <i class="fa fa-anchor"> </i> Edit pirate_badge_component.dart.

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

{% comment %}
</div> <div class="col-md-5" markdown="1">

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

### <i class="fa fa-anchor"> </i> Test it!

<div class="trydart-step-details" markdown="1">

Run the app.

Click the button&mdash;each click displays a new pirate name composed
of a name and an appellation.

#### Problems?

Check your code against the files in
[5-piratenameservice](https://github.com/dart-lang/one-hour-codelab/tree/ng2/ng2/5-piratenameservice).

* [pirate_badge_component.dart](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/5-piratenameservice/lib/pirate_badge_component.dart)
* [pirate_name_service.dart](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/5-piratenameservice/lib/pirate_badge_component.html)

</div>

<hr>

##Step 6: Read a JSON file {#step-six}

In this final step, you change the pirate name service to fetch
the names and appellations from a JSON file on dartlang.

### <i class="fa fa-anchor"> </i> Edit pirate_name_service.dart.

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
|
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

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

### <i class="fa fa-anchor"> </i> Edit pirate_badge_component.dart.

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
  [[highlight]]bool enableButton = false;[[/highlight]]
  [[highlight]]bool enableInput = false;[[/highlight]]
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* These inputs will be enabled once the file is loaded.

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
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

* `ngOnInit()` is one of the
  [lifecycle hooks](https://angular.io/docs/ts/latest/guide/lifecycle-hooks.html)
  available in Angular 2. Angular calls ngOnInit after the component
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
<aside class="alert alert-info" markdown="1">
<i class="fa fa-lightbulb-o"> </i> **Tip:** <br>
Well formatted code is (usually) more readable code.
Format your code by right-clicking within the open file
in WebStorm and select **Reformat with Dart Style**
from the menu that pops up.
From the command line, format your code using the
[dartfmt](https://github.com/dart-lang/dart_style#readme) command.

Only white space is affected.
</aside>

</div>

### <i class="fa fa-anchor"> </i> Test it!

<div class="trydart-step-details" markdown="1">

Run the app.

The app should work as before, but this time the pirate name is
constructed from the JSON file.

#### Problems?

Check your code against the files in
[6-readjsonfile](https://github.com/dart-lang/one-hour-codelab/tree/ng2/ng2/6-readjsonfile).

* [pirate_badge_component.dart](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/6-readjsonfile/lib/pirate_badge_component.dart)
* [pirate_name_service.dart](https://raw.githubusercontent.com/dart-lang/one-hour-codelab/ng2/ng2/6-readjsonfile/lib/pirate_name_service.dart)

</div>

<hr>

##What next? {#whatnext}

Now that you've written your app, what do you do next?
Here are some suggestions.

### <i class="fa fa-anchor"> </i> Work through the guides on angular.io

<div class="trydart-step-details" markdown="1">
Work through the [QuickStart](https://angular.io/docs/dart/latest/quickstart.html)
and [Developer](https://angular.io/docs/dart/latest/guide/) Guides
on [angular.io](https://angular.io/docs/dart/latest/).
</div>

### <i class="fa fa-anchor"> </i> Build your app to run in any browser

<div class="trydart-step-details" markdown="1">
You can _test_ your app in other browsers by right-clicking
index.html and choosing **Open in browser &gt;*** from the pop up menu.

To _compile_ the app into JavaScript that runs in any modern browser,
use **pub build**.  Build the app in WebStorm, as follows:
</div>

<ol markdown="1">
<li markdown="1">Open the pubspec and click **Build...**.
</li>

<li markdown="1">From the dialog,
choose **Release** or **Debug**, as desired.
The third option allows you to
[specify a mode](/tools/pub/cmd/pub-build.html#options)
to `pub build`.
</li>
</ol>

<div class="trydart-step-details" markdown="1">
When deploying your application, use the
[dart_to_js_script_rewriter](https://pub.dartlang.org/packages/dart_to_js_script_rewriter)
transformer to create a more performant version.
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

### <i class="fa fa-anchor"> </i> Online documentation

<div class="trydart-step-details" markdown="1">

#### The Dart language

* <a href="/docs/dart-up-and-running/ch02.html">
  A Tour of the Dart Language</a> shows you how to use
  each major Dart feature, from variables and operators to
  classes and libraries.

#### The Dart libraries

* <a href="/docs/dart-up-and-running/ch03.html">
A Tour of the Dart Libraries</a>
shows you how to use the major features in Dart’s libraries.

#### Angular 2 documentation

* The <a href="https://angular.io/docs/dart/latest/"
  target="_blank">Angular 2 for Dart</a> site has a quick start guide,
  a developer guide, and API documentation.
  You might want to bookmark the
  <a href="https://angular.io/docs/dart/latest/guide/cheatsheet.html">Angular
  Cheat Sheet</a>.
{% comment %}
  Until the Angular 2 for Dart docs are complete,
  also refer to the JavaScript
  <a href="https://angular.io/docs/js/latest/api/" target="_blank">API 2.0</a>
  documentation.
{% endcomment %}

#### API documentation for classes

* <a href="https://api.dartlang.org/dart_core/String.html" target="_blank">String</a>,
<a href="https://api.dartlang.org/dart_core/List.html" target="_blank">List</a>,
<a href="https://api.dartlang.org/dart_core/Map.html" target="_blank">Map</a>,
<a href="https://api.dartlang.org/dart_math/Random.html" target="_blank">Random</a>,
<a href="https://api.dartlang.org/dart_html/Event.html" target="_blank">Event</a>,
<a href="https://api.dartlang.org/dart_async/Future.html" target="_blank">Future</a>, and
<a href="https://api.dartlang.org/dart_async/Stream.html" target="_blank">Stream</a>.

#### API documentation for libraries

* <a href="https://api.dartlang.org/dart_core.html" target="_blank">dart:core</a>,
<a href="https://api.dartlang.org/dart_math.html" target="_blank">dart:math</a>,
<a href="https://api.dartlang.org/dart_html.html" target="_blank">dart:html</a>,
<a href="https://api.dartlang.org/dart_async.html" target="_blank">dart:async</a>, and
<a href="https://api.dartlang.org/dart_convert.html" target="_blank">dart:convert</a>

#### API documentation for the JSON constant

* <a href="https://api.dartlang.org/dart:convert#id_JSON" target="_blank">JSON</a>

#### Cascading Style Sheets (CSS)

There are many resources on CSS, but you might want to look at

* <a href="http://www.w3schools.com/css/css_intro.asp" target="_blank">CSS</a> on w3schools.com.

</div>

### <i class="fa fa-anchor"> </i> Feedback

<div class="trydart-step-details" markdown="1">

Please provide feedback on this code lab to the
[www.dartlang.org repo](https://github.com/dart-lang/www.dartlang.org/issues).

</div>

{% comment %}
Original pirate code lab on the wayback machine:
https://web.archive.org/web/20150102192113/https://www.dartlang.org/codelabs/darrrt/

Server-side code lab:
https://dart-lang.github.io/server/codelab/
{% endcomment %}
