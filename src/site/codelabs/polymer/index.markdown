---
layout: tutorial
title: "Polymer.dart Code Lab"
description: "Learn how to write a Dart app using Polymer GUI elements."
has-permalinks: true
tutorial:
  id: polymer
header:
  css: ["/codelabs/darrrt/darrrt.css"]
---

# {{ page.title }}

This code lab introduces you to [polymer.dart](/polymer/),
which helps you to use custom elements to build a web app.
To complete this lab you should have programming experience,
but you don't need experience
with web programming or the Dart langauge.

<aside class="alert alert-warning" markdown="1">
  **Note:**
  This code lab should be updated or deleted.
  It relies on a version of Polymer.dart that will soon be obsolete.
  A new version of Polymer.dart, based on the recently released
  [Polymer 1.0](https://blog.polymer-project.org/announcements/2015/05/29/one-dot-oh/),
  is in the works. This lab also depends on Dart Editor,
  which is [retired as of 1.11](http://news.dartlang.org/2015/04/the-present-and-future-of-editors-and.html).
  Pull requests [welcome!](https://github.com/dart-lang/www.dartlang.org/issues/1396)
</aside>

In this code lab, you build a single-page admin console for code labs.
(Yes, this is a meta code lab.) The console lets you add, remove,
and edit the code labs, as well as filter them by their difficulty level.

You want to build something fast, and you want to write clean,
maintainable, and elegant code. You decide that Polymer and Dart are
the right tools for the job.

Here's a picture of the app you build in this code lab:

<img style="border:1px solid #021a40;" src="images/final-app.png" alt="screenshot of final app"/>

Now that you know what you will be building, let's get started.

{% include default_toc.html %}

---

## Step 0: Setting up {#set-up}

In this step, you download Dart and get the sample code.

### Get Dart.
{:.no_toc}

<div class="trydart-step-details" markdown="1">

&rarr; If you haven't already done so, get the Dart download.
Unzip the ZIP file, which creates a directory called `dart`.
(For more options, go to the [download page](/downloads/).)

<!-- style here is a hack to remove the arrow, which was only partially
     showing-->

<div style="padding-left: 10px">
{% include/downloads/_dart-editor.html buttonclass="btn-primary" %}
</div>

<p class="os-choices" markdown="1">
  The Dart tools work in recent versions of
  {% include os-choices.html %}
</p>
</div>

<aside class="alert alert-info" markdown="1">
**Note:** Dart Editor requires Java version 6 or higher.
Problems? See [Troubleshooting Dart Editor](/tools/editor/troubleshoot.html).
</aside>

### Start the editor.
{:.no_toc}

<div class="trydart-step-details" markdown="1">
&rarr; Go to the `dart` directory and double-click **DartEditor**.

**Got questions? Having trouble?** Go to the 
[Troubleshooting Dart Editor](/tools/editor/troubleshoot.html) page.
</div>

### Get the sample code.
{:.no_toc}

<div class="trydart-step-details" markdown="1">
Download the sample code from the
[polymer-and-dart-codelab GitHub repo](https://github.com/dart-lang/polymer-and-dart-codelab)
using one of the following options:

<ul markdown="1">
<li markdown="1">
  Download the zip file,
  [polymer-and-dart-codelab-master.zip](https://github.com/dart-lang/polymer-and-dart-codelab/archive/master.zip).
  Unzip the ZIP file, which creates a directory called
  `polymer-and-dart-codelab-master`.
</li>

<li markdown="1">
  Clone the repo. For example, from the command line:

{% prettify sh %}
% git clone https://github.com/dart-lang/polymer-and-dart-codelab.git
{% endprettify %}

This creates a directory named `polymer-and-dart-codelab`.
</li>
</ul>

</div>

### Open the polymer-and-dart-codelab sample.
{:.no_toc}

<div class="trydart-step-details" markdown="1">
&rarr; In Dart Editor, use **File > Open Existing Folder...** to open
the `polymer-and-dart-codelab` directory.

&rarr; Click to expand the `web` directory.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<img src="images/filesanddirs.png" alt="The files and directories in the polymer-and-dart-codelab directory." />

<div class="trydart-note" markdown="1">
**Note:** If you see <span style="color:red">red X's</span> at the
left of the filenames or if the `packages` directory is missing,
the packages are not properly installed. Right-click **pubspec.yaml**
and choose **Pub Get**.
</div>

</div><div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* The `packages` directory, as well as the `pubspec.yaml` and `pubspec.lock`
files are related to package dependencies.
This project has all the dependencies set up for you.
Dart Editor automatically installs the necessary packages.

* Several directories contain the app code:
  - The **begin** directory contains the skeletal version of the app that you
    begin with. This code lab assumes you'll work in the **begin** directory.
  - The **end** directory contains the commented finished version.

* **Dart SDK** contains the source code for all of the functions,
  variables, and classes provided by the Dart Software Development Kit.

* **Installed Packages** contains the source code for all of the functions,
  variables, and classes for the additional libraries that this application
  depends on.

</div></div>

<hr>

## Step 1: Getting started with Polymer {#get-started}

Understand the layout of the Polymer code. Learn about custom elements and
HTML imports.

### Understand the project layout.
{:.no_toc}

<div class="trydart-step-details" markdown="1">

&rarr; In Dart Editor, double-click to expand the **begin** directory
(under **web**).  Here is a short description of what each file does:

* `index.html` file is the entry point for this application.

* `model.dart` contains the `Codelab` class.

* `codelab_element.html` and `codelab_element.dart` contain
HTML and Dart code for `<codelab-element>`, a
Polymer element representing a `Codelab` object.

* `codelab_form.html` and `codelab_form.dart` contain
HTML and Dart code for `<codelab-form>`, a
Polymer element representing a form for creating or updating a `Codelab`.

* `codelab_list.html` and `codelab_list.dart` contain
HTML and Dart code for `<codelab-list>`, a
Polymer element representing a collection of `Codelab` objects.

</div>

### Learn about the structure of a Polymer element.
{:.no_toc}

<div class="trydart-step-details" markdown="1">

A Polymer element is a custom, reusable, complex HTML element.
In polymer.dart, the visual aspect of the element is implemented in HTML
and CSS, and the element's behavior is implemented in Dart.
You can use Polymer elements that others have created (such as
[core elements](https://pub.dartlang.org/packages/core_elements) or
[paper elements](https://pub.dartlang.org/packages/paper_elements)),
or you can build your own.

A Polymer element is defined in an HTML file
(for example, `codelab_list.html`).
A Polymer element typically has the following three-part structure:

* The markup for the element goes inside `<template>` tags.
* The CSS for the element goes inside `<style>` tags.
* The Dart code for the element is in a companion file that is linked to from
within the element.


<aside class="alert alert-info" markdown="1">
**Note:** The Polymer elements in this code lab do not contain any markup
with the `<template>` tag at this stage.
You'll be adding that as you proceed through the code lab.
The CSS is already added, and you won't need to change it.
</aside>

</div>

### Bootstrap a Polymer application.
{:.no_toc}

<div class="trydart-step-details" markdown="1">

The `index.html` file is this application's entry point:

{% prettify html %}
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Polymer: Build an Admin Console Using Dart</title>
    <link rel="import" href="codelab_list.html">
    <link rel="stylesheet" href="app.css">
  </head>
  <body>
    <h1>Polymer: Build an Admin Console Using Dart</h1>
    <codelab-list></codelab-list>
    <script type="application/dart">export 'package:polymer/init.dart';</script>
  </body>
</html>
{% endprettify %}

The following line is an example of an **HTML import**,
an important part of the Web Component stack:

{% prettify html %}
<link rel="import" href="codelab_list.html">
{% endprettify %}

HTML imports are a way to include and reuse HTML documents in other HTML
documents. We use the `<codelab-list>` component imported from
`codelab_list.html` like any other HTML element:

{% prettify html %}
<body>
  ...
  <codelab-list></codelab-list>
  ...
</body>
{% endprettify %}

The following line initializes Polymer:

{% prettify html %}
<script type="application/dart">export 'package:polymer/init.dart';</script>
{% endprettify %}


</div>

### Run your app.
{:.no_toc}

<div class="trydart-step-details" markdown="1">

&rarr; Right-click **index.html** (under **begin**) and choose
**Run in Dartium**. This launches the app in a custom build of Chromium
which includes the Dart VM. In later steps, you'll run the app in JavaScript
as well.

&rarr; A dialog may ask for remote device access in order to run your Dart
application.  Click OK to accept this application.

For now, all you see is a headline. You'll now write the rest of this app!
</div>

## Step 2: Creating a code lab model {#create-model}

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

&rarr; Open `model.dart` and replace the contents of the barebones `Codelab` class
with the following:

{% prettify dart %}
class Codelab extends Observable {
  static const List<String> LEVELS
      = const ['easy', 'intermediate', 'advanced'];
  static const MIN_TITLE_LENGTH = 10;
  static const MAX_TITLE_LENGTH = 30;
  static const MAX_DESCRIPTION_LENGTH = 140;

  @observable String title;
  @observable String description;
  @observable String level;

  // Constructor.
  Codelab([this.title = "", this.description = ""]);
}
{% endprettify %}

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i><strong> Key information</strong>

* You've defined some constants containing validation rules for a
`Codelab` object.

* You've defined three fields,  `title`, `description`, and `level`.
And you've restricted each code lab to one of three preset levels.

* Notice the `@observable` annotation before `title`, `description`, and
`level`? This tells Polymer that you want to trigger *two-way data binding*
between these fields and the UI. This provides the following functionality:

  * When an @observable field's value changes, the UI for that field updates
automatically.
  * When a UI element (such as a `<form>` element) is bound to an @observable
field, it can modify its value.

<div class="trydart-step-details" markdown="1">
Two-way data binding is very powerful, and you'll be using it when you
create the HTML for the `<codelab-form>` element.
</div>

</div></div>


### Run your app.
{:.no_toc}

<div class="trydart-step-details" markdown="1">

&rarr; Right-click **index.html** (under **begin**) and choose
**Run in Dartium**.

Since we haven't updated the UI, you still see just the bare headline. We'll
be changing the UI soon.

Check that your project builds without errors.

</div>

## Step 3: Creating a code lab form {#create-form}

### Update the form template.
{:.no_toc}

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

&rarr; Open **`codelab_form.html`**. Add the following snippet of markup between
`</style>` and the `</template>` (there's nothing there now):

{% prettify html %}{% raw %}
<form>
  <div class="field">
    <textarea placeholder="Add title" value="{{codelab.title}}">
    </textarea>
    <div>
      <span class="chars-left">{{maxTitleLength - codelab.title.length}}</span>
    </div>
  </div>
  <div class="field">
    <textarea placeholder="Add description" value="{{codelab.description}}">
    </textarea>
    <div>
      <span class="chars-left">
        {{maxDescriptionLength - codelab.description.length}}
      </span>
    </div>
  </div>
  <div class="field">
    <label>Level: </label>
    <select value="{{codelab.level}}">
      <option template repeat="{{level in allLevels}}">
        {{level}}
      </option>
    </select>
  </div>
  <div>
    <button type="submit">Submit</button>
  </div>
</form>
{% endraw %}{% endprettify %}

</div>

</div><div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"></i> <strong>Key information</strong>

<ul markdown="1">
<li markdown="1">
  You've added a couple of `<textarea>` tags for the `title` and
  `description` fields, a `<select>` for the `level` field, and a `Submit`
  button.
</li>

<li markdown="1">
  You bind `<form>` widgets to fields of the `codelab` object:

{% prettify html %}{% raw %}
<textarea placeholder="Add title"
          value="{{codelab.title}}">
</textarea>
...
<textarea placeholder="Add description"
          value="{{codelab.description}}">
</textarea>
...
<select value="{{codelab.level}}">
  ...
</select>
{% endraw %}{% endprettify %}
</li>
</ul>

Since the `title`, `description`, and `level` fields in the
`Codelab` model are observable, this creates a **two-way data
binding** between the fields and the UI. This provides the following
functionality:

<ul markdown="1">
<li markdown="1">
  If a field has an initial value, it is displayed
  (useful when editing an object).
</li>

<li markdown="1">
  If the user changes the value of a bound form element,
  the value of the `@observable` field updates automatically.
</li>

<li markdown="1">
  Data binding makes it easy to keep track of the characters remaining for
  each `<textarea>` field.

{% prettify html %}{% raw %}
<span class="chars-left">{{maxTitleLength - codelab.title.length}}</span>
...
<span class="chars-left">{{maxDescriptionLength - codelab.description.length}}</span>
{% endraw %}{% endprettify %}

Since changes to observable fields is live, the counters update as the user
types into a `<textarea>`.
</li>

<li markdown="1">
  You use `template repeat` to iterate over the three `level` values:

{% prettify html %}{% raw %}
<select value="{{codelab.level}}">
  <option template
      repeat="{{level in allLevels}}">
    {{level}}
  </option>
</select>
{% endraw %}{% endprettify %}
</li>
</ul>

</div></div>

### Update the Dart code.
{:.no_toc}

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

&rarr; Open `codelab_form.dart` and add this line to the beginning of the
`CodelabFormElement` class:

{% prettify dart %}
@published Codelab codelab;
{% endprettify %}

</div>

</div><div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"></i> <strong>Key information</strong>

<ul markdown="1">
<li markdown="1">
  This declares a `Codelab` object as a `CodelabFormElement` field.
  The `@published` annotation lets you pass the
  `codelab` object as an attribute to `<codelab-form>` as is done here,
  for example:

{% prettify html %}{% raw %}
<codelab-form
    codelab="{{codelab}}"></codelab-form>
{% endraw %}{% endprettify %}
</li>
</ul>

</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

&rarr; Next, add the following lines to the `CodelabFormElement` class:

{% prettify dart %}
List<String> get allLevels => Codelab.LEVELS;
int get minTitleLength =>  Codelab.MIN_TITLE_LENGTH;
int get maxTitleLength => Codelab.MAX_TITLE_LENGTH;
int get maxDescriptionLength => Codelab.MAX_DESCRIPTION_LENGTH;
{% endprettify %}

</div>

</div><div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"></i> <strong>Key information</strong>

* Defining these getters lets you use `Codelab` model's static
  variables inside Polymer templates.

</div></div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

  The new version of `CodelabFormElement` should now look like this:

{% prettify dart %}
@CustomTag('codelab-form')
class CodelabFormElement extends PolymerElement {
  @published Codelab codelab;

  List<String> get allLevels => Codelab.LEVELS;
  int get minTitleLength =>  Codelab.MIN_TITLE_LENGTH;
  int get maxTitleLength => Codelab.MAX_TITLE_LENGTH;
  int get maxDescriptionLength => Codelab.MAX_DESCRIPTION_LENGTH;

  CodelabFormElement.created() : super.created() {}
}
{% endprettify %}

</div>

</div><div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"></i> <strong>Key information</strong>

<ul markdown="1">
<li markdown="1">
  In **`codelab_form.dart`**, the `@CustomTag` annotation before the
  `CodelabFormElement` class declares the tag for the element. The tag for
  CodelabFormElement is `<codelab-form>`.
</li>

<li markdown="1">
  The `CodelabFormElement` inherits from
  `PolymerElement`.  The following constructor definition is required:

{% prettify dart %}
CodelabFormElement.created() : super.created() {}
{% endprettify %}
</li>

<li markdown="1">
  In **`codelab_form.html`**, you use 'double curlies'
  (`{% raw %}{{}}{% endraw %}`) for variable and expression
  interpolation.
</li>

</ul>

</div></div></div>

### Run your app.
{:.no_toc}

<div class="trydart-step-details" markdown="1">

&rarr; Right-click **index.html** (under **begin**) and choose
**Run in Dartium**.

You still only see the bare headline (this is about to change).
But make sure that your app runs without any errors.
</div>

## Step 4: Displaying the form {#display-form}

### Update the `codelab` list.
{:.no_toc}

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

You've created the form, and now you add it to the `<codelab-list>`
element to display it in the UI.

&rarr; Open `codelab_list.html`, and add the following between the
`</style>` and the `</template>` tags (there is nothing there now):

{% prettify html %}{% raw %}
<div>
  <codelab-form codelab="{{newCodelab}}"></codelab-form>
</div>
{% endraw %}{% endprettify %}

&rarr; In `codelab_list.dart`, modify the `CodelabList` class so it looks like
this:

{% prettify dart %}
@CustomTag('codelab-list')
class CodelabList extends PolymerElement {
   @observable Codelab newCodelab = new Codelab();
   String get defaultLevel => Codelab.LEVELS[1];

   CodelabList.created() : super.created() {
     newCodelab.level = defaultLevel;
   }
}
{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i><strong> Key information</strong>

* In `codelab_list.dart`, you've added a `newCodelab` field that
binds to the template.

* You've assigned a default value to `newCodelab`'s `level`. When the
`<form>` loads, the default level is automatically selected.

</div></div>

### Run your app.
{:.no_toc}

<div class="trydart-step-details" markdown="1">

&rarr; Right-click **index.html** (under **begin**) and choose
**Run in Dartium**.

You should see the following:

* The form is now displayed.
* The 'intermediate' level is selected.
* As you type in the `<textarea>`s, the counters change.

You haven't implemented `Submit` functionality for the form yet, so
hitting 'Submit' just reloads the page (and wipes your content). Also,
while it is nice that counters tell the user about the remaining
characters for the `title` and `description` fields, you want to
implement better field validation and error handling.

</div>

## Step 5: Validating form data {#validate-form}

### Add validators.
{:.no_toc}

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

&rarr; In **`codelab_form.dart`**, add the following fields to the
`CodelabFormElement` class directly above the `CodelabFormElement.created()`
constructor:

{% prettify dart %}
@observable String titleErrorMessage = '';
@observable String descriptionErrorMessage = '';
{% endprettify %}

&rarr; After the constructor, add the following validator methods:

{% prettify dart %}
bool validateTitle() {
  if (codelab.title.length < minTitleLength ||
      codelab.title.length > maxTitleLength) {
    titleErrorMessage = "Title must be between $minTitleLength and "
        "$maxTitleLength characters.";
    return false;
  }
  titleErrorMessage = '';
  return true;
}

bool validateDescription() {
  if (codelab.description.length > maxDescriptionLength) {
    descriptionErrorMessage = "Description cannot be more than "
        "$maxDescriptionLength characters.";
    return false;
  }
  descriptionErrorMessage = '';
  return true;
}
{% endprettify %}

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i><strong> Key information</strong>

* The validation code is pretty straightforward: each method checks a
  code lab field against the validation rules defined in the
  model.  If validation fails, the validator sets an error message and
  returns false. Otherwise it removes the error message and returns true.

</div></div>

### Plug the validators into your template.
{:.no_toc}

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

&rarr; In **`codelab_form.html`**, replace the `<form>` with the
following:

{% prettify html %}{% raw %}
<form>
  <div class="field">
    <textarea placeholder="Add title" value="{{codelab.title}}"
              on-keyup="{{validateTitle}}">
    </textarea>
    <div>
      <span class="chars-left">
          {{maxTitleLength - codelab.title.length}}</span>
      <span class="error" hidden?="{{titleErrorMessage.isEmpty}}">
          {{titleErrorMessage}}
      </span>
    </div>

  </div>
  <div class="field">
    <textarea placeholder="Add description" value="{{codelab.description}}"
              on-keyup="{{validateDescription}}">
    </textarea>
    <div>
      <span class="chars-left">
        {{maxDescriptionLength - codelab.description.length}}
      </span>
      <span class="error" hidden?="{{descriptionErrorMessage.isEmpty}}">
        {{descriptionErrorMessage}}
      </span>
    </div>
  </div>
  <div class="field">
    <label>Level: </label>
    <select value="{{codelab.level}}">
      <option template repeat="{{level in allLevels}}">
        {{level}}
      </option>
    </select>
  </div>
  <div>
    <button type="submit">Submit</button>
  </div>
</form>
{% endraw %}{% endprettify %}

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i><strong> Key information</strong>

<ul markdown="1">
<li markdown="1">
  You now invoke `validateTitle()` and `validateDescription()`
  every time the user releases a key:

{% prettify html %}{% raw %}
<textarea ...
   on-keyup="{{validateTitle}}"></textarea>
...
<textarea ...
   on-keyup="{{validateDescription}}"></textarea>
{% endraw %}{% endprettify %}

Polymer uses the `on-<event>` syntax for events.
</li>

<li markdown="1">
  You now display error messages when validation fails:

{% prettify html %}{% raw %}
<span class="error"
   hidden?="{{titleErrorMessage.isEmpty}}">
  {{titleErrorMessage}}
</span>
...
<span class="error"
   hidden?="{{descriptionErrorMessage.isEmpty}}">
  {{descriptionErrorMessage}}
</span>
{% endraw %}{% endprettify %}

When there is no error message, you set the `hidden` attribute on the
`<span>`. Using `?=` syntax to set boolean attributes is common in
Polymer.
</li>
</ul>

</div></div>

### Run your app.
{:.no_toc}

<div class="trydart-step-details" markdown="1">

&rarr; Right-click **index.html** (under **begin**) and choose
**Run in Dartium**.

You should see the following:

* The form displays error messages as the user interacts with it.
* The error message clears when a field validates.

While validation works now, there is still no way to submit the form and
display the new code lab object.

</div>

## Step 6: Displaying code labs {#display-codelabs}

### Make the Submit button work.
{:.no_toc}

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

&rarr; In **`codelab_form.dart`** add the following code to the bottom of
the `CodelabFormElement` class:

{% prettify dart %}
validateCodelab(Event event, Object detail, Node sender) {
  event.preventDefault();
  if (validateTitle() && validateDescription()) {
    dispatchEvent(new CustomEvent('codelabvalidated',
        detail: {'codelab': codelab}));
  }
}
{% endprettify %}

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i><strong> Key information</strong>

* The `validateCodelab()` method calls the code lab validators.

* If the code lab object validates,
`validateCodelab()` fires a **custom event**,
passing the validated code lab object as data.

* It is the responsibility of
`<codelab-form>`'s parent element to register a
listener that adds the new code lab to `<codelab-list>`.
You implement that code in the next step.

</div></div>

<div class="trydart-step-details" markdown="1">

<aside class="callout">
<b>Note:</b>
Using custom events for communication between child and parent elements
is a common pattern in Polymer.
</aside>
</div>

<div class="trydart-step-details" markdown="1">

Next, you plug `validateCodelab()` into the template.

<div class="row"> <div class="col-md-7" markdown="1">

&rarr; In **`codelab_form.html`**,
add an `on-submit` event to the `<form>` element:

{% prettify html %}{% raw %}
<form on-submit="{{validateCodelab}}">
{% endraw %}{% endprettify %}

Now write code to handle the `codelabvalidated` event.

&rarr; In **`codelab_list.html`**, replace the HTML between the `</style>`
and the `</template>` tags with the following:

{% prettify html %}{% raw %}
<div on-codelabvalidated="{{addCodelab}}">
  <codelab-form codelab="{{newCodelab}}"></codelab-form>
</div>
<div>
  <template repeat="{{codelab in codelabs}}">
    <codelab-element codelab="{{codelab}}"></codelab-element>
  </template>
</div>
{% endraw %}{% endprettify %}

&rarr; In **`codelab_list.dart`**, add the following at the top of the
`CodelabList` class body:

{% prettify dart %}
@observable List<Codelab> codelabs = toObservable([]);
{% endprettify %}

&rarr;Then add these methods to the bottom of `CodelabList`:

{% prettify dart %}
resetForm() {
  newCodelab = new Codelab();
  newCodelab.level = defaultLevel;
}

addCodelab(Event e, var detail, Node sender) {
  e.preventDefault();
  codelabs.add(detail['codelab']);
  resetForm();
}
{% endprettify %}

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i><strong> Key information</strong>

<ul markdown="1">
<li markdown="1">
  You added a `codelabs` field to `CodelabList` and made it
  observable. This is the definitive collection of code labs in this app.
</li>

<li markdown="1">
  You added an `on-codelabvalidated` handler to `<codelab-form>`s
parent element:

{% prettify html %}{% raw %}
<div on-codelabvalidated="{{addCodelab}}">
  <codelab-form
   codelab="{{newCodelab}}"></codelab-form>
</div>
{% endraw %}{% endprettify %}

When `<codelab-form>` fires a `codelabvalidated` event,
it transmits the newly created code lab in the `detail` parameter.
When the parent
`<div>` triggers `addCodelab()`, it appends the code lab to the `codelabs`
list and resets the form.
</li>

<li markdown="1">
  You added code to display all code labs:

{% prettify html %}{% raw %}
<template repeat="{{codelab in codelabs}}">
  <codelab-element
   codelab="{{codelab}}"></codelab-element>
</template>
{% endraw %}{% endprettify %}
</li>
</ul>

</div></div>

### Display the code lab object.
{:.no_toc}

&rarr; In **`codelab_element.html`**, add the following between the
`</style>` and the `</template>` tags (there's nothing there now):

{% prettify html %}{% raw %}
<div>
  <div class="codelab">
    <div class="field">
      <h2>{{codelab.title}}</h2>
    </div>

    <div class="field">
      <p>{{codelab.description}}</p>
    </div>

    <div class="field">
      <p><span>Level: </span>{{codelab.level}}</p>
    </div>
  </div>
</div>
{% endraw %}{% endprettify %}

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

&rarr; In **`codelab_element.dart`**, add the following as the first
line in the body of the `CodelabElement` class:

{% prettify dart %}
@published Codelab codelab;
{% endprettify %}

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i><strong> Key information</strong>

* Adding the `@published` annotation lets you pass a code lab as an attribute
  to `<codelab-element>`.

</div></div>

### Run your app.
{:.no_toc}

<div class="trydart-step-details" markdown="1">

&rarr; Right-click **index.html** file (under **begin**) and choose
**Run in Dartium**.

You should see the following:

* Your code lab shows up on the page when you hit "Submit".
* You cannot submit a form with validation errors.
* The form clears after a code lab is successfully created.

</div>

## Step 7: Editing a code lab {#edit-codelab}

### Update the `codelab-element` element.
{:.no_toc}

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

&rarr; In **`codelab_element.html`**, replace all content between
the `</style>` and `</template>` tags with the following:

{% prettify html %}{% raw %}
<div on-formNotNeeded="{{cancelEditing}}"
     on-codelabvalidated="{{updateCodelab}}">
  <template if="{{!editing}}">
    <div class="codelab">
      <div class="field">
        <h2>{{codelab.title}}</h2>
      </div>

      <div class="field">
        <p>{{codelab.description}}</p>
      </div>

      <div class="field">
        <p><span>Level: </span>{{codelab.level}}</p>
      </div>

      <div class="field">
        <span on-click="{{startEditing}}" class="small">Edit</span>
      </div>
    </div>
  </template>
  <template if="{{editing}}">
    <codelab-form codelab="{{codelab}}"></codelab-form>
  </template>
</div>
{% endraw %}{% endprettify %}

</div>


<div class="trydart-step-details" markdown="1">

&rarr; In **`codelab_element.dart`**, add the following at the top
of the `CodelabElement` class body:

{% prettify dart %}
@observable bool editing = false;
Codelab _cachedCodelab;
{% endprettify %}

&rarr; After the `CodelabElement.created()` constructor, add the
following methods:

{% prettify dart %}
updateCodelab(Event e, var detail, Node sender) {
  e.preventDefault();
  editing = false;
}

startEditing(Event e, var detail, Node sender) {
  e.preventDefault();
  _cachedCodelab = new Codelab();
  copyCodelab(codelab, _cachedCodelab);
  editing = true;
}

cancelEditing(Event e, var detail, Node sender) {
  e.preventDefault();
  copyCodelab(_cachedCodelab, codelab);
  editing = false;
}

copyCodelab(source, destination) {
  destination.title = source.title;
  destination.description = source.description;
  destination.level = source.level;
}
{% endprettify %}

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i><strong> Key information</strong>

<ul markdown="1">
<li markdown="1">
  You created a boolean `editing` field to keep track of the
  editing status of a `CodelabElement` object.
</li>

<li markdown="1">
  You use `editing` to conditionally render templates:

{% prettify html %}{% raw %}
<template if="{{!editing}}">
  ...
</template>
<template if="{{editing}}">
  ...
</template>
{% endraw %}{% endprettify %}
</li>

<li markdown="1">
  You created a `_cachedCodelab` field to store the edited
  code lab's contents.
  If you cancel editing, you restore the original code lab values from
  `_cachedCodelab`. See the `startEditing()` and `cancelEditing()` methods
  in `CodelabElement` for the caching workflow.
</li>
</ul>

</div></div>

### Add a cancel button.
{:.no_toc}

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

&rarr; In **`codelab_form.dart`**, add the following method to the
bottom of the `CodelabFormElement` class body:

{% prettify dart %}
cancelForm(Event event, Object detail, Node sender) {
  event.preventDefault();
  titleErrorMessage = '';
  descriptionErrorMessage = '';
  dispatchEvent(new CustomEvent('formnotneeded'));
}
{% endprettify %}

&rarr; In **`codelab_form.html`**, locate the `<div>` containing the
`Submit` button:

{% prettify btml %}
<div>
  <button type="submit">Submit</button>
</div>
{% endprettify %}

&rarr; Add a **Cancel** button next to it. The `<div>` should look like
this:

{% prettify html %}{% raw %}
<div>
  <button type="submit">Submit</button>
  <button type="button" on-click="{{cancelForm}}">Cancel</button>
</div>
{% endraw %}{% endprettify %}

&rarr; In **`codelab_list.html`**, find the first `<div>` (located
immediately after the `</style>` tag):

{% prettify html %}{% raw %}
<div on-codelabvalidated="{{addCodelab}}">
{% endraw %}{% endprettify %}

&rarr; Add an `on-formnotneeded` event handler so that the `<div>`
looks like this:

{% prettify html %}{% raw %}
<div on-codelabvalidated="{{addCodelab}}"
     on-formnotneeded="{{resetForm}}">
{% endraw %}{% endprettify %}
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i><strong> Key information</strong>

* In `CodelabFormElement`, the  `cancelForm()` method dispatches
  a `formnotneeded` custom event when `<codelab-form>` is no longer being
  used. It is up to `<codelab-form>`'s parent element to decide how to
  handle the custom event.

* In `<codelab-list>`, the parent of `<codelab-form>`
  handles the `formnotneeded` event by calling `CodelabList`'s `resetForm()`
  method, which clears the form.

* In `<codelab-element>`, the parent of `<codelab-form>`
  handles the `formnotneeded` event by calling `CodelabElement`'s
  `cancelEditing()` method, which clears the form, and _also closes it_.

</div></div>

### Run your app.
{:.no_toc}

<div class="trydart-step-details" markdown="1">

&rarr; Right-click **index.html** (under **begin**) and choose
**Run in Dartium**.

You should see the following:

* You can now edit a code lab.
* While editing, you can press **Cancel** to cancel the edit.
* You cannot render the code lab in an invalid state, and still
be able to save it.

</div>

## Step 8: Deleting a code lab {#delete-codelab}

### Add the delete link.
{:.no_toc}

<div class="trydart-step-details" markdown="1">

&rarr; In **`codelab_element.html`**,
located the `<div>` with the **Edit** link:

{% prettify html %}{% raw %}
<div class="field">
  <span on-click="{{startEditing}}" class="small">Edit</span>
</div>
{% endraw %}{% endprettify %}

&rarr; Add a **Delete** link to the `<div>`, which should now look like
this:

{% prettify html %}{% raw %}
<div class="field">
  <span on-click="{{startEditing}}" class="small">Edit</span> |
  <span on-click="{{deleteCodelab}}" class="small">Delete</span>
</div>
{% endraw %}{% endprettify %}

</div>

### Dispatch a custom event.
{:.no_toc}

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

&rarr; In **`codelab_element.dart`**,
add the following method to the bottom of the `CodelabElement` class body:

{% prettify dart %}{% raw %}
deleteCodelab(Event e, var detail, Node sender) {
  e.preventDefault();
  dispatchEvent(new CustomEvent('deletecodelab',
      detail: {'codelab': codelab}));
}
{% endraw %}{% endprettify %}

</div>

### Handle the custom event.
{:.no_toc}

<div class="trydart-step-details" markdown="1">

&rarr; In **`codelab_list.html`**, locate the `<div>` containing the
`template repeat`:

{% prettify html %}{% raw %}
<div>
  <template repeat="{{codelab in codelabs}}">
    ...
  </template>
</div>
{% endraw %}{% endprettify %}

&rarr; Add a `deletecodelab` handler to the `<div>`. It should now look
like this:

{% prettify html %}{% raw %}
<div on-deletecodelab="{{deleteCodelab}}">
  <template repeat="{{codelab in codelabs}}">
    ...
  </template>
</div>
{% endraw %}{% endprettify %}

&rarr; In **`codelab_list.dart`**, add the following method to the
bottom of the `CodelabList` class body:

{% prettify dart %}
deleteCodelab(Event e, var detail, Node sender) {
  var codelab = detail['codelab'];
  codelabs.remove(codelab);
}
{% endprettify %}

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i><strong> Key information</strong>

* The `deleteCodelab()` method in `CodelabElement`
  dispatches a `deleteCodelab` custom event, and forwards the code lab to be
  deleted with that event.

* `<codelab-element>`'s parent `<div>` inside
  `<codelab-list>` handles the `deletecodelab` custom event by
  invoking `CodelabList`'s
  `deleteCodelab()` method. This method removes the code lab from the `codelabs`
  list. Since `codelabs` is an observed variable (see the `@observable`
  annotation that precedes it in `CodelabList`), the UI updates automatically
  and removes the code lab.

</div></div>

### Run your app.
{:.no_toc}

<div class="trydart-step-details" markdown="1">

&rarr; Right-click **index.html** (under **begin**) and choose
**Run in Dartium**.

You should see the following:

* You can now delete a code lab.
* The UI refreshes automatically with the deleted code lab removed from the
  list of displayed code labs.

You have now implemented full CRUD (Create, Read, Update, Delete)
functionality for code lab objects. The admin you've created works well, but as
the number of code labs increases, you'd like to be able to filter them by
code lab level.

</div>

## Step 9: Filtering the code labs list {#filter-codelabs}

### Know what you're building.
{:.no_toc}

<div class="trydart-step-details" markdown="1">

The `codelabs` list is the canonical source of truth for this app.
In this step, you implement functionality to show a filtered subset
of all code labs.

This step breaks down into the following sections:

- You create a `filteredCodelabs` list to store filtered code lab objects.

- You update the contents of `filteredCodelabs` every time a code lab is
added or removed, or when a code lab's `level` is changed.

- You add a `<select>` to the `<codelab-list>` that lets a user
filter code labs by level.

You begin by creating a `filteredCodelabs` field and a `filter()` method
in `CodelabList`.

</div>

### Implement the filter code.
{:.no_toc}

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

&rarr; In **`codelab_list.dart`**,
begin by adding the following lines at the beginning of the
`CodelabList` class body:

{% prettify dart %}
static const ALL = "all";
final List<String> filters = [ALL]..addAll(Codelab.LEVELS);
@observable String filterValue = ALL;
@observable List<Codelab> filteredCodelabs = toObservable([]);
{% endprettify %}

&rarr; Inside the `CodelabList.created()` constructor, add the following
line:

{% prettify dart %}
filteredCodelabs = codelabs;
{% endprettify %}

The constructor should now look like this:

{% prettify dart %}
CodelabList.created() : super.created() {
  filteredCodelabs = codelabs;
  newCodelab.level = defaultLevel;
}
{% endprettify %}

&rarr; In the `CodelabList` class body, add these methods:

{% prettify dart %}
filter() {
  if (filterValue == ALL) {
    filteredCodelabs = codelabs;
    return;
  }
  filteredCodelabs = codelabs.where((codelab) {
    return codelab.level == filterValue;
  }).toList();
}

codelabsChanged() {
  filter();
}
{% endprettify %}

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i><strong> Key information</strong>

<ul markdown="1">
<li markdown="1">
  Inside `CodelabList`, you created a `filters` field for the
  filter options you plan to expose through the UI. This includes the
  three preset code lab levels, as well as 'all'.

{% prettify dart %}
final List<String> filters = [ALL]..addAll(Codelab.LEVELS);
{% endprettify %}
</li>

<li markdown="1">
  You created a list, `filteredCodelabs`, to store the
  filtered code labs. Since `filteredCodelabs` is observable(note the
  @observable annotation), the UI updates
  automatically when it changes.
</li>

<li markdown="1">
  You added a `filter()` method to `CodelabList` that filters the
  contents of `codelabs` and saves the results in `filteredCodelabs`.
</li>

<li markdown="1">
  The `codelabsChanged()` method in `CodelabList` is an example of a
  Polymer _changed watcher_.
  All properties on Polymer elements can be watched for changes
  by implementing a <code><em>propertyName</em>Changed</code> handler.
  When the value of a watched property changes,
  the watcher runs automatically.
  Since `codelabs` is a field in `CodelabList`, you
  can watch it for changes by implementing a `codelabsChanged()` method.
</li>
</ul>

</div></div>

### Iterate over filteredCodelabs.
{:.no_toc}

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

&rarr; In **`codelab_list.html`**,
remove everything between the `</template>` and `</style>` tags,
and insert the following HTML in its place:

{% prettify html %}{% raw %}
<div>
  <label>Filter: </label>
  <select value="{{filterValue}}" on-change="{{filter}}">
    <option template repeat="{{filter in filters}}">
      {{filter}}
    </option>
  </select>
</div>
<div on-codelabvalidated="{{addCodelab}}"
     on-formnotneeded="{{resetForm}}">
  <codelab-form codelab="{{newCodelab}}"></codelab-form>
</div>
<div on-deletecodelab="{{deleteCodelab}}"
     on-levelchanged="{{filter}}">
  <template repeat="{{codelab in filteredCodelabs}}">
    <codelab-element codelab="{{codelab}}"></codelab-element>
  </template>
</div>
{% endraw %}{% endprettify %}

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i><strong> Key information</strong>

<ul markdown="1">
<li markdown="1">
  You use a `template repeat` to iterate over the list of filters.

{% prettify html %}{% raw %}
<option template repeat="{{filter in filters}}">
  {{filter}}
</option>
{% endraw %}{% endprettify %}
</li>

<li markdown="1">
  When displaying code labs in `<codelab-list>`, you now iterate
  over `filteredCodelabs`, not `codelabs`:

{% prettify html %}{% raw %}
<template
 repeat="{{codelab in filteredCodelabs}}">
  <codelab-element
   codelab="{{codelab}}"></codelab-element>
</template>
{% endraw %}{% endprettify %}
</li>
</ul>

</div></div>

### Handle changes to a code lab's level.
{:.no_toc}

You've implemented _most_ of the filter functionality. But what happens
when you're in a filtered view, decide to edit a code lab, and then
change its level? You want the filtering to feel live, and you want
the change in a code lab's level to automatically trigger the filter
process. This is easy to implement.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

&rarr; In **`codelab_element.dart`**,
replace the `updateCodelab()` method with this new version:

{% prettify dart %}
updateCodelab(Event e, var detail, Node sender) {
  e.preventDefault();
  if (_cachedCodelab.level != codelab.level) {
    dispatchEvent(new CustomEvent('levelchanged'));
  }
  editing = false;
}
{% endprettify %}

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i><strong> Key information</strong>

<ul markdown="1">
<li markdown="1">
  You updated `CodelabElement`'s `updateCodelab()` method so that
  if a code lab's level changes, it fires a `levelchanged` custom event.
</li>

<li markdown="1">
  Earlier in this step, you changed the template in
  `codelab_list.html` to handle the `levelchanged` custom event:

{% prettify html %}{% raw %}
<div on-deletecodelab="{{deleteCodelab}}"
     on-levelchanged="{{filter}}">
  ...
</div>
{% endraw %}{% endprettify %}

Now when a code lab's level changes, the `CodelabList`'s `filter()` method
runs and updates `filteredCodelabs`.
</li>
</ul>

</div></div>

That's it!

### Run your app.
{:.no_toc}

<div class="trydart-step-details" markdown="1">

&rarr; Right-click **index.html** (under **begin**) and choose
**Run in Dartium**.

You should see the following:

* You can filter code labs by level.
* When you've selected a filtered view, and you modify a code lab's
level, the filtered view updates automatically.

</div>

## Step 10: Wrapping up {#wrap-up}

<div class="trydart-step-details" markdown="1">

This code lab packs a lot of information in a short time. Here are some
takeaways:

* Polymer lets you implement a lot of functionality while writing very little
code.

* Create **custom elements** to organize your code.

* Use **HTML imports** to get access to any custom elements.

* Use **observable** fields and **data binding** to keep your data and the
UI in sync.

* Optionally, use **custom events** to communicate between child and parent
elements.

</div>

### Polymer resources.
{:.no_toc}

<div class="trydart-step-details" markdown="1">

* Read more about Polymer at [polymer-project.org](http://www.polymer-project.org/).

* Polymer implements the [Web Components][] stack.

[Web Components]: http://www.w3.org/wiki/WebComponents/

* Polymer.dart is a port of polymer.js to Dart. You can look at
[polymer.dart code on GitHub](https://github.com/dart-lang/bleeding_edge/tree/master/dart/pkg/polymer).

</div>

### Dart resources.
{:.no_toc}

<div class="trydart-step-details" markdown="1">

* Run some Dart programs online and check out the source code
on our [Samples page](/samples/).

* Learn more about Dart from
the [Dart tutorials](/docs/tutorials/).

* [A Tour of the Dart Language](/docs/dart-up-and-running/ch02.html)
shows you how to use each major Dart feature,
from variables and operators to classes and libraries.

* [A Tour of the Dart Libraries](/docs/dart-up-and-running/ch03.html)
shows you how to use the major features in Dart’s libraries.

</div>

### Give us feedback.
{:.no_toc}

<div class="trydart-step-details" markdown="1">

Please provide feedback about Dart and this code lab at
[dartbug.com](http://dartbug.com/new).

</div>
