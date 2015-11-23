---
layout: default
title: "Building Single Page Apps using Polymer.dart"
subsite: "Polymer.dart"
description: "The Polymer.dart approach to building single page applications"
has-permalinks: true
---

<style>
paper-button.blue {
  background: #4285f4;
  color: #fff;
}
paper-button.blue:hover {
  background: #2a56c6;
}
</style>

{% include toc.html %}
{% include breadcrumbs.html %}

# {{ page.title }}

<p layout vertical center style="float:right;margin: 0 0 0 10px;">
  <a href="https://dart-lang.github.io/polymer-spa-example/final/" target="_blank"><img src="images/screenshot.png" style="width:300px;"></a>
</p>


<aside class="alert alert-warning" markdown="1">
**Note:**
The links to the running demos in this article are broken.

This article describes a pre-1.0 version of polymer.dart.
For information about the latest version, go to the
[Polymer Dart project](https://github.com/dart-lang/polymer-dart/wiki).
</aside>

This page shows you how to build a full-featured single page
application that:

- Is built using Polymer's
  [core elements](https://www.polymer-project.org/docs/elements/core-elements.html)
- Practices responsive design
- Transitions between views that use data-binding features
- Features URL routing and deep linking
- Is keyboard accessible

<aside class="alert alert-info" markdown="1">
**Note:**
This page is based on the Polymer article
[Building single page apps using web components](https://www.polymer-project.org/articles/spa.html).
It shows how to implement the same single-page app (SPA) example using Dart.

The code samples used by this page reflect **polymer.dart 0.16**.
For information about polymer.dart versions, see the
[Release Notes](/polymer-old/reference/release-notes/).
</aside>

<p layout horizontal center-center>
<a href="https://dart-lang.github.io/polymer-spa-example/final/" target="_blank">
  <paper-button raised class="blue">
    <core-icon icon="arrow-forward"></core-icon>Launch the demo
  </paper-button>
</a>
</p>

If you like to eat dessert first,
you can find the files for the finished demo,
[polymer-spa-example](https://github.com/dart-lang/polymer-spa-example),
on GitHub. This page uses three branches from the GitHub repo,
where each branch builds on the previous one:

* [example-1-styles](https://github.com/dart-lang/polymer-spa-example/tree/example-1-styles):
  The basic example uses only one file, index.html.
  The [App structure](#app-structure) section uses this example.
* [example-2](https://github.com/dart-lang/polymer-spa-example/tree/example-2):
  The intermediate example uses Dart and implements data binding. 
  The [Creating views](#creating-views) section uses this example.
* [master](https://github.com/dart-lang/polymer-spa-example):
  The completed example adds URL routing and keyboard navigation.
  The [Setting up URL Routing](#routing) section (and beyond) uses
  this example.

## App structure
{:style="clear:both"}

Designing a layout is one of the first tasks when starting a project.
As part of its
[core element collection](https://www.polymer-project.org/docs/elements/core-elements.html),
Polymer has several
[layout elements](https://www.polymer-project.org/docs/elements/layout-elements.html)
for scaffolding an application's structure.
These components are useful by themselves,
but for a quick start,
we're going to focus on the `<core-scaffold>` layout element.
It starts you off with a responsive mobile layout by assembling several
of the foundational elements.

`<core-scaffold>`'s children are arranged by specifying attributes
or using specific tags. For example, using a `<nav>` element creates
the app drawer. Alternatively, you can use the `navigation` attribute on
any element (for example, `<core-header-panel navigation>`).
The `tool` attribute identifies the toolbar.
All other children end up in the main content area.

The following HTML shows the overall structure:

{% prettify html %}
<body unresolved fullbleed>
  <core-scaffold id="scaffold">
    <nav>...Left drawer...</nav>
    <core-toolbar tool>...Application...</core-toolbar>
    <div>...Main content...</div>
  </core-scaffold>
</body>
{% endprettify %}

The following Dart imports add support for the core elements used;
the export initializes the Polymer application.

{% prettify dart %}
<script type="application/dart">
  import 'package:core_elements/core_scaffold.dart';
  import 'package:core_elements/core_toolbar.dart';
  export 'package:polymer/init.dart';
</script>
{% endprettify %}

Let's dive deeper into each of these sections.

### Drawer

Markup that you put in the navigation element ends up in a slide-away app
drawer.  For our purposes, we'll stick with a heading
(`<core-toolbar>`) and navigational links (`<core-menu>`):

{% prettify html %}
<nav>
  <core-toolbar><span>Single Page Polymer</span></core-toolbar>
  <core-menu selected="0">
    <paper-item noink>
      <core-icon icon="label-outline"></core-icon>
      <a href="#one">Single</a>
    </paper-item>
    <paper-item noink>
      <core-icon icon="label-outline"></core-icon>
      <a href="#two">page</a>
    </paper-item>
    ...
  </core-menu>
</nav>
{% endprettify %}

<aside class="alert alert-info" markdown="1">
**Note:**
Right now, `<core-menu selected="0">` is hard coded to select the
first item.  We'll [make that dynamic](#databinding) later.
</aside>

### Toolbar

A toolbar spans the top of the page and contains functional icon buttons.
A perfect element for that type of behavior is `<core-toolbar>`:

{% prettify html %}{% raw %}
<!-- flex makes the bar span across the top of the main content area -->
<core-toolbar tool flex>
  <div flex>{{selectedPage.name}}</div>
  <core-icon-button icon="refresh"></core-icon-button>
  <core-icon-button icon="add"></core-icon-button>
</core-toolbar>
{% endraw %}{% endprettify %}

### Main content {#maincontent}

The last section is left for your content! It can be any type of element.
A `<div>` is perfectly fine:

{% prettify html %}
<div layout horizontal center-center fit>
  <!-- fill with pages -->
</div>
{% endprettify %}

The `fit` attribute instructs the main area to take up the full width
and height of its parent. The `layout horizontal center-center` attributes
center that content horizontally and vertically using flexbox.

## Creating views

Multiple views (or pages) can be created with `<core-pages>` or
`<core-animated-pages>`. Both elements are useful for displaying
only one child at a time. The benefit of `<core-animated-pages>`
is that it provides more defaults and slick transitions between pages.

The demo uses `<core-animated-pages>` with the `slide-from-right`
transition. The first thing to do is import the element definition
and the `slide-from-right` transition. 

First import the necessary packages:

{% prettify dart %}
<script type="application/dart">
  import 'package:core_elements/core_animated_pages.dart';
  import 'package:core_elements/core_animated_pages/transitions/slide_from_right.dart';
  ...
</script>
{% endprettify %}

Then drop in your content. The following code is from
[index.html](https://github.com/dart-lang/polymer-spa-example/blob/example-1-styles/web/index.html).

{% prettify html %}
<div layout horizontal center-center fit>
  <[[highlight]]core-animated-pages[[/highlight]] id="pages" [[highlight]]selected="0"[[/highlight]]>
    <section layout vertical center-center>
      <div>Single</div>
    </section>
    <section layout vertical center-center>
      <div>page</div>
    </section>
    ...
  <[[highlight]]/core-animated-pages[[/highlight]]>
</div>
{% endprettify %}

<aside class="alert alert-info" markdown="1">
**Note:**
Right now, `<core-animated-pages selected="0">` is hard coded to
select the first page. We'll [make that dynamic](#databinding) later.
</aside>

By now you should have
<a href="https://dart-lang.github.io/polymer-spa-example/example-1-without-styles/" target="_blank">a
basic app</a>, but did you notice **something subtle**? Thanks to Polymer's
[layout attributes](https://www.polymer-project.org/docs/polymer/layout-attrs.html)
and the
[default styles](https://www.polymer-project.org/articles/styling-elements.html#default-styles)
provided by each element, you've **achieved a responsive app without
writing any CSS**! Of course, with a little inspiration from the
[material design color palette](http://www.google.com/design/spec/style/color.html),
writing
[fewer than 10 CSS rules](https://github.com/dart-lang/polymer-spa-example/blob/master/lib/src/example_app.css)
turns the app into something beautiful.

<p layout horizontal center-center>
<a href="https://dart-lang.github.io/polymer-spa-example/example-1-without-styles/" target="_blank">
  <paper-button raised class="blue">
    <core-icon icon="arrow-forward"></core-icon>Demo: without CSS
  </paper-button>
</a>
<a href="https://dart-lang.github.io/polymer-spa-example/example-1-with-styles/" target="_blank">
  <paper-button raised class="blue">
    <core-icon icon="arrow-forward"></core-icon>Demo: with CSS
  </paper-button>
</a>
</p>

<p layout horizontal center-center>
<a href="https://github.com/dart-lang/polymer-spa-example/blob/example-1-styles/web/index.html" target="_blank">

  <paper-button raised class="blue">
    <core-icon icon="arrow-forward"></core-icon>See the HTML 
  </paper-button>
</a>

<a href="https://github.com/dart-lang/polymer-spa-example/blob/example-1-styles/web/index.css" target="_blank">
  <paper-button raised class="blue">
    <core-icon icon="arrow-forward"></core-icon>See the CSS
  </paper-button>
</a>
</p>

### Using data binding {#databinding}

We have an app, but it's nothing to write home about.
It's far from D.R.Y. (Don't Repeat Yourself).
Similar markup is repeated all over the place:

{% prettify js %}
<nav>
  <core-toolbar><span>Single Page Polymer</span></core-toolbar>
  <core-menu selected="0">
    <paper-item noink>
      <core-icon icon="label-outline"></core-icon>
      <a href="#one">Single</a>
    </paper-item>
    <paper-item noink>
      <core-icon icon="label-outline"></core-icon>
      <a href="#two">page</a>
    </paper-item>
    <paper-item noink>
      <core-icon icon="label-outline"></core-icon>
      <a href="#three">app</a>
    ...
  </core-menu>
</nav>
{% endprettify %}

It's also not dynamic.
When a user selects a menu item, the view doesn't update.
Luckily, both of these problems are easily solved by
creating a top-level element, as shown in the following section.

#### Creating a top-level element {#creating-top-level}

To implement data binding in your app,
create a top-level element that extends `PolymerElement`.
This element represents the entire app&mdash;only one top-level element
exists at a time, and all other elements are children of this element.

Here's how to implement the top-level element:

<ol markdown="1">
<li markdown="1"> Move the contents of the original HTML body to an
     `example_app.html` file, and then wrap it in a
     `<polymer-element>` tag. The body of the new
     `index.html` file should contain only the following code:

{% prettify HTML %}
<example-app></example-app>

<script type="application/dart">
  import 'package:polymer_spa_example/example_app.dart';
  export 'package:polymer/init.dart';
</script>
{% endprettify %}
</li>

<li markdown="1"> Rename `index.css` to `example_app.css`,
     and reference it inside an HTML template.
     We created an `example_app.html` file and referenced 
     the CSS like this:

{% prettify html %}
<polymer-element name="example-app">
    <template>
        <link rel="stylesheet" [[highlight]]href="example_app.css"[[/highlight]]>
        <!-- Old index.html body here -->
    </template>
</polymer-element>
{% endprettify %}
</li>

<li markdown="1"> Move the imports from the old inline script tag into
     `example_app.dart`, and add an `@HtmlImport` annotation to
     `example_app.html`.

{% prettify html %}
// The HTML import containing our <polymer-element>
[[highlight]]@HtmlImport('src/example_app.html')[[/highlight]]
library polymer_core_and_paper_examples.spa.app;

// Moved all imports from the inline script tag into this file.
import 'package:core_elements/core_animated_pages.dart';
import 'package:core_elements/core_animated_pages/transitions/slide_from_right.dart';
import 'package:core_elements/core_icon.dart';
import 'package:core_elements/core_icon_button.dart';
import 'package:core_elements/core_menu.dart';
import 'package:core_elements/core_scaffold.dart';
import 'package:core_elements/core_toolbar.dart';
import 'package:core_elements/roboto.dart';
import 'package:paper_elements/paper_item.dart';

@CustomTag('example-app')
class ExampleApp extends PolymerElement {
  ExampleApp.created() : super.created();
  ...
}
{% endprettify %}

#### Simplifying the markup using a data model {#datamodel}

You can greatly **reduce the amount of markup you write by generating
it from a data model**. The `Page` class defines our data model&mdash;we
use it to create a list of 5 pages.

{% prettify dart %}
class Page {
  final String name;
  final String path;
  final bool isDefault;
  const Page(this.name, this.path, {this.isDefault: false});

  String toString() => '$name';
}

@CustomTag('example-app')
class ExampleApp extends PolymerElement {
  ExampleApp.created() : super.created();

  /// The list of pages in our app.
  final List<Page> pages = const [
    const Page('Single', 'one', isDefault: true),
    const Page('page', 'two'),
    const Page('app', 'three'),
    const Page('using', 'four'),
    const Page('Polymer', 'five'),
  ];

  /// The current route.
  @observable var route;
}
{% endprettify %}

The menu items and pages are rendered with a `<template repeat>` tag:

{% prettify html %}{%raw%}
<core-menu id="menu" valueattr="path" selected="{{route}}">
  [[highlight]]<template repeat="{{page in pages}}">[[/highlight]]
    <paper-item path="{{page.path}}" noink>
      <core-icon
        icon="label{{route != page.path ? '-outline' : ''}}">
      </core-icon>
      <a _href="#{{page.path}}">{{page.name}}</a>
    </paper-item>
  <[[highlight]]/template[[/highlight]]>
</core-menu>

<core-animated-pages id="pages" selected="{{route}}"
                     valueattr="path"
                     transitions="slide-from-right"
                     on-tap="{{cyclePages}}">
  [[highlight]]<template repeat="{{page in pages}}">[[/highlight]]
    <section path="{{page.path}}" layout vertical center-center>
      <div>{{page.name}}</div>
    </section>
  <[[highlight]]/template[[/highlight]]>
</core-animated-pages>
{%endraw%}{% endprettify %}

Notice that `<core-animated-pages>` and `<core-menu>`
are **linked by binding their `selected` attributes** together.
Now, when a user clicks on a nav item the view updates accordingly.
The `valueattr="path"` attribute tells both elements to use the `path`
attribute on each item as the selected value.

{% prettify html %}{%raw%}
<!-- data-bind the menu selection with the page selection -->
<core-menu id="menu" [[highlight]]valueattr="path"[[/highlight]] selected="{{route}}">
...
<core-animated-pages id="pages" selected="{{route}}"
                     [[highlight]]valueattr="path"[[/highlight]]
                     transitions="slide-from-right"
                     on-tap="{{cyclePages}}">
{%endraw%}{% endprettify %}

<p layout horizontal center-center>
<a href="https://dart-lang.github.io/polymer-spa-example/example-2/" target="_blank">
  <paper-button raised class="blue">
    <core-icon icon="arrow-forward"></core-icon>Demo
  </paper-button>
</a>

<a href="https://github.com/dart-lang/polymer-spa-example/blob/example-2/lib/src/example_app.html" target="_blank">
  <paper-button raised class="blue">
    <core-icon icon="arrow-forward"></core-icon>See the HTML
  </paper-button>
</a>

<a href="https://github.com/dart-lang/polymer-spa-example/blob/example-2/lib/example_app.dart" target="_blank">
  <paper-button raised class="blue">
    <core-icon icon="arrow-forward"></core-icon>See the Dart code
  </paper-button>
</a>
</p>

## Setting up URL routing {#routing}

URL routing support is provided by the
[route_hierarchical](https://pub.dartlang.org/packages/route_hierarchical)
library. The router instance is created and configured by the
`ExampleApp` class.
When the user selects a new page, the path for that page is retrieved
from the list of pages, and the routing package loads the content for
that URL, as shown in the routing code:

{% prettify dart %}
import 'package:route_hierarchical/client.dart';

@CustomTag('example-app')
class ExampleApp extends PolymerElement {

  /// The path of the current [Page].
  @observable var route;

  /// The [Router] that controls the app.
  final Router router = new Router(useFragment: true);

  domReady() {
    // Set up the routes for all the pages.
    for (var page in pages) {
      router.root.addRoute(
          name: page.name, path: page.path,
          defaultRoute: page.isDefault,
          enter: enterRoute);
    }
    router.listen();
  }

  /// Updates [selectedPage] and the current route whenever
  /// the route changes.
  void routeChanged() {
    if (route is! String) return;
    if (route.isEmpty) {
      selectedPage = pages.firstWhere((page) => page.isDefault);
    } else {
      selectedPage =
        pages.firstWhere((page) => page.path == route);
    }
    router.go(selectedPage.name, {});
  }

  /// Updates [route] whenever we enter a new route.
  void enterRoute(RouteEvent e) {
    route = e.path;
  }
}
{% endprettify %}

## Enabling keyboard navigation {#keyboard}

Keyboard support is not only important for accessibility
but also makes your SPA feel more like an app.

The following code shows how keyboard support is implemented.
`<core-a11y-keys>` is a drop-in component, provided
by Polymer, for normalizing browser keyboard events.

HTML:

{% prettify html %}{% raw %}
<!-- Keyboard nav controller. -->
<core-a11y-keys id="keys" target="{{body}}"
                keys="up down left right space space+shift"
                on-keys-pressed="{{keyHandler}}"></core-a11y-keys>
{% endraw %}{% endprettify %}

Dart:

{% prettify dart %}
class ExampleApp extends PolymerElement {

  CoreA11yKeys get keys => $['keys'];

  domReady() {

    // Set up the number keys to send you to pages.
    int i = 0;
    var keysToAdd = pages.map((page) => ++i);
    keys.keys = '${keys.keys} ${keysToAdd.join(' ')}';
  }
}
{% endprettify %}

The `key` attribute contains a space-separated list of keys to listen for.
When one of those combinations is pressed, `<core-a11y-keys>` fires a
`keys-pressed` event and invokes your callback.

The handler for the keys-pressed event uses `CoreAnimatedPage`'s
`selectNext()` and `selectPrevious()` methods to advance to the
next page or go back to the previous page:

{% prettify dart %}
CoreAnimatedPages get corePages => $['pages'];

/// Handler for key events.
void keyHandler(e) {
  var detail = new [[highlight]]JsObject[[/highlight]].fromBrowserObject(e)['detail'];

  switch (detail['key']) {
    case 'left':
    case 'up':
      [[highlight]]corePages.selectPrevious(false);[[/highlight]]
      return;
    case 'right':
    case 'down':
      [[highlight]]corePages.selectNext(false);[[/highlight]]
      return;
    case 'space':
      detail['shift'] ? [[highlight]]corePages.selectPrevious(false)[[/highlight]]
                      : [[highlight]]corePages.selectNext(false);[[/highlight]]
      return;
  }

  // Try to parse as a number if we didn't recognize
  // it as something else.
  try {
    var num = int.parse(detail['key']);
    if (num <= pages.length) {
      route = pages[num - 1].path;
    }
    return;
  } catch (e) {}
}
{% endprettify %}

The `JsObject` class is part of the
[js-interop](https://github.com/dart-lang/js-interop) package.
This package provides high-level interoperability between Dart and
JavaScript.

## Finishing touches {#extras}

Use these final tips to polish your app.

### Clicking a menu item closes the app drawer 
{:.no_toc}

HTML:

{% prettify html %}{% raw %}
<paper-item path="{{page.path}}"
                  [[highlight]]on-click="{{menuItemClicked}}"[[/highlight]] noink>
{% endraw %}{% endprettify %}

Dart:

{% prettify dart %}
class ExampleApp extends PolymerElement {
  ...

  CoreScaffold get scaffold => $['scaffold'];

  void menuItemClicked(_) {
    scaffold.closeDrawer();
  }
}
{% endprettify %}

### Tapping on a page cycles through the pages
{:.no_toc}

HTML:

{% prettify html %}{% raw %}
<core-animated-pages id="pages" selected="{{route}}"
                     valueattr="path"
                     transitions="slide-from-right"
                     [[highlight]]on-tap="{{cyclePages}}"[[/highlight]]>
{% endraw %}{% endprettify %}

Dart:

{% prettify dart %}
class ExampleApp extends PolymerElement {
  ...

  /// Cycles pages on click.
  void cyclePages(Event e, detail, sender) {
    var event = new JsObject.fromBrowserObject(e);
    // Clicks on links should not cycle pages.
    if (event['target'].localName == 'a') {
      return;
    }

    event['shiftKey'] ?
      [[highlight]]sender.selectPrevious(true) : sender.selectNext(true);[[/highlight]]
  }
}
{% endprettify %}


## Completed example

And that's it! You can see the final source code or play with
the example at the following links.

<p layout horizontal center-center>
<a href="https://dart-lang.github.io/polymer-spa-example/final/" target="_blank">
  <paper-button raised class="blue">
    <core-icon icon="arrow-forward"></core-icon>Launch the demo
  </paper-button>
</a>

<a href="https://github.com/dart-lang/polymer-spa-example/" target="_blank">
  <paper-button raised class="blue">
    <core-icon icon="arrow-forward"></core-icon>See the Dart code
  </paper-button>
</a></p>

If you find bugs in the code, or have a question, please 
[file an issue](https://github.com/dart-lang/polymer-spa-example/issues).

