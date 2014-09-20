---
layout: default
title: "Polymer.dart"
description: "Standards-based web components:
custom elements, templates,
and data binding for Dart web apps. A Dart port of Polymer."
has-permalinks: true
---

{% include toc.html %}

<h1>
  {{page.title}}
  <img src="images/polymer-logo.svg" alt="Polymer logo"
       style="vertical-align:baseline" height="35">
</h1>

Use polymer.dart—a Dart port of [Polymer](http://www.polymer-project.org)—to
build structured, encapsulated, client-side web apps with Dart and
web components.

![Paper sampler on mobile](images/iconbutton-small.png)
![Paper sampler on desktop](images/iconbutton-big.png){: .thinborder}

With polymer.dart, you can:

* Use Polymer custom elements.
* Design your own HTML tags to encapsulate style, structure, and behavior.
* Create live, two-way bindings between Dart objects and DOM nodes.
* Use emerging web standards—Custom Elements, HTML Imports, Shadow DOM,
  and more—today.

{% comment %}
PENDING: Talk about advantages of polymer.dart development process
(why you should use it instead of polymer.js).
{% endcomment %}

<aside class="alert alert-info" markdown="1">
**Questions?**
If you don't find your answers in these pages, check out the
[Polymer FAQ](faq.html).
</aside>

<aside class="alert alert-info" markdown="1">
**Note:**
The code samples on this page reflect **polymer.dart 0.14.0**.
{% comment %}
UPDATE version each release
{% endcomment %}
For information about polymer.dart versions, see the
[Release Notes](/polymer/reference/release-notes/).
</aside>

<hr>
## Structuring your app

Apps that use polymer.dart follow the
[pub package layout conventions](/tools/pub/package-layout.html).
As a consequence, the source code for a polymer.dart app
starts with a top directory containing a
`pubspec.yaml` file and a `web` directory:

![app/pubspec.yaml, app/web/index.html](images/dir-simplest-structure.png)

The `web` directory contains HTML files that are
_entry points_—pages that users can visit.
Other files (Dart files, CSS, images, and so on)
can also be in the `web` directory.

The `pubspec.yaml` file has metadata about the app,
such as the pub packages that it depends on.

Learn more at
[Imports and Your App's Directory Structure](app-directories.html).

<hr>
## Installing polymer.dart

Get polymer.dart from pub.dartlang.org,
the Dart package hosting service. Add the following to
your `pubspec.yaml` file:

{% prettify yaml %}
dependencies:
  polymer: ">=0.14.0 <0.15.0"
{% endprettify %}
{% comment %}
UPDATE version each release
{% endcomment %}

Then, run `pub get` to download the package and link it into your app.


<hr>
## Using custom elements

Here's an example of some HTML code
that uses a `<paper-input>` element
from the paper_elements package:

<!-- from polymer/get_element/web/index.html -->
{% prettify html %}
<head>
  ...
  <script src="packages/web_components/dart_support.js"></script>
  <link rel="import" href="[[highlight]]packages/paper_elements/paper_input.html[[/highlight]]">
  ...
</head>
<body unresolved>
  [[highlight]]<paper-input label="Type something..."></paper-input>[[/highlight]]
  ...
  <script type="application/dart">export 'package:polymer/init.dart';</script>
</body>
{% endprettify %}

For more information, see [Using Custom Elements](using-elements/).


<hr>
## Creating custom elements

You can extend the lexicon of HTML with your own custom elements,
as described in
[Creating Custom Elements](creating-elements/).


<hr>
## Tools

Polymer.dart works well with Dart tools, such as Dart Editor and Pub.

### Generating warnings

Polymer.dart offers a linter that reports syntax or usage warnings.
Using a special `build.dart` file,
you can connect the linter to Dart Editor to display warnings directly
at the source.

Create a `build.dart` file at the root of your project:

{% prettify dart %}
import 'package:polymer/builder.dart';

void main(List<String> args) {
  lint(entryPoints: ['web/index.html'], options: parseOptions(args));
}
{% endprettify %}

<aside class="alert alert-info" markdown="1">
**Note:**
As of polymer.dart 0.14.1, the `build.dart` file can be a single line:

`export 'package:polymer/default_build.dart';`

{% comment %}
UPDATE for 0.15.0.
{% endcomment %}
</aside>

Dart Editor runs `build.dart` after a file is saved, and
displays warnings from the linter.

Learn more about [Dart Editor](/tools/editor/).

<img src="polymer-warning-in-editor.png">

### Building

Use `pub build` to compile your polymer.dart app into JavaScript so that
it can run across the modern web. The build process also concatenates files
for faster loading.

You can use `entry_points` to specify which pages under `web`
the user can navigate to.
(By default, all pages under `web` are entry points.)
For example:

{% prettify yaml %}
transformers:
- polymer:
    entry_points: web/index.html
{% endprettify %}

Run `pub build` from the root of your project to generate a `build`
directory.

{% prettify bash %}
> pub build
{% endprettify %}

The `build` directory contains the HTML, JavaScript, and other assets
required to run the application. You can then deploy the `build` directory
to your favorite web server.

Learn more about [pub build](/tools/pub/cmd/pub-build.html).

<hr>

## Tutorials and code labs

The [Dart tutorials](/docs/tutorials/) use polymer.dart:

[Define a Custom Element](/docs/tutorials/polymer-intro/)
: Provides a detailed introduction to using polymer.dart
  to create custom elements.

[Other examples](/docs/tutorials/polymer-intro/#what-next)
: Lists other tutorials with examples that use Polymer.

The following code lab uses polymer.dart:

[Polymer Dart Code Lab](/codelabs/polymer/)
: Walks you through building a single-page admin console
and the custom elements it requires.
<hr>

## Additional reading

The cultured Dartisan studies the specifications and articles that cover
the lower-level primitives and features of the polymer.dart libraries.

### Polymer

* Read the documentation at [polymer-project.org](http://www.polymer-project.org/).
* Watch Matthew McNulty's [Introduction to Polymer](https://www.youtube.com/watch?v=8-Zq2KUN6jM)
  or the complete video of SFHTML5's
  [All About Polymer](http://www.meetup.com/sfhtml5/events/169452272/) event.

### Articles

* [HTML5Rocks - Shadow DOM 101](http://www.html5rocks.com/en/tutorials/webcomponents/shadowdom/)
* [HTML5Rocks - Shadow DOM 201: CSS and Styling](http://www.html5rocks.com/tutorials/webcomponents/shadowdom-201/)
* [HTML5Rocks - Shadow DOM 301: Advanced Concepts & DOM APIs](http://www.html5rocks.com/tutorials/webcomponents/shadowdom-301/)
* [HTML5Rocks - Custom Elements: Defining new elements in HTML](http://www.html5rocks.com/en/tutorials/webcomponents/customelements/)

### Specifications

Much of polymer.dart is built upon new and emerging web specifications.
Polymer.dart offers polyfills for the following features.

Heads up: These are specs written for implementors. Lots of details ahead.

[Custom elements][custom-elements-spec]
: A method for enabling the author to define and use new types of DOM elements.

[Shadow DOM][shadow-dom-spec]
: An encapsulation primitive for DOM subtrees. It provides a method of
establishing and maintaining functional boundaries between DOM trees and how
these trees interact with each other within a document, thus enabling better
functional encapsulation within the DOM.

[Template element][template-spec]
: A method for declaring inert DOM subtrees in HTML and manipulating them
to instantiate document fragments with identical contents.

[HTML Imports][html-imports-spec]
: A way to include and reuse HTML documents in other HTML documents.


[polymer]: http://www.polymer-project.org
[so]: http://stackoverflow.com/tags/dart
[web-list]: https://groups.google.com/a/dartlang.org/forum/#!forum/web
[polymer-dev-list]: https://groups.google.com/forum/?fromgroups=#!forum/polymer-dev
[dartbug]: http://dartbug.com/new
[custom-elements-spec]: https://dvcs.w3.org/hg/webcomponents/raw-file/tip/spec/custom/index.html
[shadow-dom-spec]: https://dvcs.w3.org/hg/webcomponents/raw-file/tip/spec/shadow/index.html
[html-imports-spec]: https://dvcs.w3.org/hg/webcomponents/raw-file/tip/spec/imports/index.html
[template-spec]: https://dvcs.w3.org/hg/webcomponents/raw-file/tip/spec/templates/index.html


<hr>

## Support and more

We actively encourage your feedback and questions.

* Ask your [how-to questions][so] on StackOverflow.
* Join the [general discussion about polymer.dart][web-list] on our mailing
  list.
* Send [feedback on the web components family of specifications][polymer-dev-list]
  to the polymer-dev mailing list.
  (Note: That list isn't Dart specific.)
* Please file [bugs and feature requests][dartbug] for polymer.dart.


### Upgrading from Web UI

Polymer.dart is the next evolution of Web UI.
[Upgrading to Polymer.dart from Web UI](upgrading-to-polymer-from-web-ui.html)
provides a non-exhaustive set of tips to help you upgrade.


### Compatibility

Polymer.dart is tested against IE10, IE11, Safari 6, latest Chrome,
latest Firefox, and latest Chrome for Android.

The Dart team collaborates with the Polymer team to
ensure that polymer.dart elements and polyfills
(code that implements features not yet built into a web browser)
are fully compatible with Polymer.


### Source code

Polymer.dart is open source. You can view the source to polymer.dart,
and its many component packages, at [dart.googlecode.com/](https://code.google.com/p/dart/source/browse/branches/bleeding_edge/dart/pkg/).
[Get the source](https://code.google.com/p/dart/wiki/GettingTheSource)
to inspect the code and contribute patches.
