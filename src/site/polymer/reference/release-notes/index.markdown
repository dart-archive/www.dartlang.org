---
layout: default
title: "Release Notes"
subsite: "Polymer.dart"
description: "Details about each major polymer.dart release"
has-permalinks: true
---

{% include breadcrumbs.html %}

# {{ page.title }}


This page describes each stable release of polymer.dart, starting with 0.10.
For information about earlier releases and interim versions,
see the CHANGELOG.md tab of the
[polymer.dart pub page](http://pub.dartlang.org/packages/polymer)
and the release announcements in the
[Dart web forum](https://groups.google.com/a/dartlang.org/forum/#!forum/web).

{% include default_toc.html %}

## 0.14.0
{: #0-14-0}

This new release updates polymer to match the current release (0.4.0) of
polymer.js.

### Polymer changes

The polymer-specific polyfills have been moved from platform.js into the polymer
package. This should be completely transparent.

### Changes in platform.js

This release updates the `web_components` package to version 0.7.0. This brings
platform.js to the 0.4.0 release, with the addition of two cherrypicks,
[3627e](https://github.com/Polymer/ShadowDOM/commit/36272eb15b3253f34af3080b2b181dac9a79451b)
and
[7c8b9](https://github.com/Polymer/ShadowDOM/commit/7c8b9084a5b192a48ec055f1bd32936e24257a1d).

The platform.js script has been stripped down, and is no longer required in
Chrome or Dartium. You can now remove this from your projects for development,
and it will be injected when running pub build or pub serve.

If you would like the option to not inject platform.js at all in the built
output (if you are deploying to chrome exclusively), please star this
bug http://dartbug.com/20865.

### Core and paper elements

Together with this release, we updated `core_elements` to 0.2.1, and
`paper_elements` to 0.2.0. This brings the elements packages up to date with
the changes in the Javascript version 0.4.0. Two new elements were added
(`paper_dropdown` and `core_popup_menu`), and one was removed
(`paper_menu_button_overlay`).

## 0.13.0
{: #0-13-0}

This new release updates polymer to match the current release (0.3.5) of
polymer.js.

### Polymer changes
There should be no noticeable changes with this release.

### Changes in platform.js

Internally this release includes updates to the `web_components` package to
version 0.6.0. This brings platform.js to the latest Javascript version
(including changes in master for ShadowDOM at
[57232d](https://github.com/Polymer/ShadowDOM/commit/57232dc6d07dd921009679dfbab622b52174df80)).
This is because the polyfills at version 0.3.5
had some bugs in IE that got fixed afterwards.

One bug worth highlighting: platform.js also introduced a subtle bug on
querySelector when children of a host node are not distributed to the shadow
tree ([see details](https://github.com/Polymer/ShadowDOM/issues/495)). The
situation when this happens is rare, so we expect few people will run into this,
but we decided to bump our version as a breaking change just in case.

### Core and paper elements

Together with this release, we updated `core_elements` to 0.2.0+1, and
`paper_elements` to 0.1.1+2. This brings the elements packages up to date with
the changes in the Javascript version 0.3.5. The main highlights are that
a new element was added (`core-dropdown`), and icons in `core_elements` moved
two levels up in the directory layout. So for example, you now need to import
`packages/core_elements/image_icons.html` instead of
`packages/core_elements/core_icons/iconsets/image_icons.html`.


## 0.12.1
{: #0-12-1}

This release contains some new productivity features worth highlighting.

To use Polymer 0.12.1, you must use **Dart 1.6**.


### Using Dart 1.6

Polymer 0.12.1 depends on Dart 1.6.
(This dependence started with interim version 0.12.0+1.)

### Making error messages more useful

**Visible warnings:**
When you run `pub serve` we are doing lots of checks to
detect common mistakes that have tripped us in the past.
Many of us used to ignore warning messages because
they were only reported in the console.
So, starting with polymer-0.12.1, they will be more visible.
When you you load your app via `pub serve`,
we'll show you on the bottom-right corner of your page
a collapsible dialog with these messages. For example:

![Warnings and errors on top of app.](images/warnings-and-errors-0.12.1.png)

**Fail forward:**
Some errors are clear indications that something is really wrong,
for example a broken import.
We heard that many were frustrated that when there was an error like this,
`pub serve` would fail and not serve you the content at all.
Now, we'll try to fail forward and serve your application as if
the piece that caused the error wasn't there.
We don't want to deploy a broken app though,
so we'll continue to fail and stop the `pub build` process if
the app still contains error at that point.

**Better highlighting of errors:**
We also heard that it is hard to find the errors in the console logs
because they are mixed with all the warnings and HTTP messages
from `pub serve`.
So the new dialog will display errors in a separate tab.

### Templates to create elements and entrypoints

There is unfortunately a bunch of boilerplate involved in
declaring an entry point or a custom element.
For example, you need to include certain script tags, imports,
include a @CustomTag, call super.created, etc.
To make this easier, we have two commands that can create things for you.
For example, you can invoke:

    pub run polymer:new_element element-name [-o out_dir]

And we'll create an example element for you. Or you can invoke:

    pub run polymer:new_entry web/index.html

And we'll create an entry point and make sure to add it to
the polymer transformer section in your pubspec file.

### And more...

Besides these new features, polymer 0.12.1 has some bug fixes with respect to
allowing bindings inside url attributes,
and build options to control how css is inlined.
For more details check the change logs in the package site here.

There are many features, tweaks, and improvements we are still working on,
but if you have ideas/suggestions on what can be done to
improve your experience developing with polymer.dart,
do let us know and file a request in our bug tracker.


## 0.12.0
{: #0-12}

We just uploaded a new stable version of
the polymer, core, and paper packages,
bringing us up to date with the latest release of polymer.js and
its related libraries (js version 0.3.4 as of today).

Here's what's changed since 0.11.0+5. 

###Better support for two-way data-binding with JavaScript polymer elements

This should make it much easier to use core and paper elements in your apps
([example](https://github.com/dart-lang/core-elements/commit/bbf89c7dcdd843acee7102ebf9d66e2a52c28252)).

### Change in @published

There is a variation for how to declare @published properties. 
Instead of writing this:

{% prettify dart %}
@published String foo;
{% endprettify %}

We suggest you write this:

{% prettify dart %}
@published
String get foo => readValue(#foo);
set foo(String value) => writeValue(#foo, value);
{% endprettify %}

The old style will continue to work,
but the new style has a more predictable timing.
In particular, say you use 'foo' in a binding,
someone updates that binding,
and later you read 'foo'.
The old style has no guarantees about what you'll read out of 'foo'.
If notifications have been propagated through the system,
you'll see the latest value,
but if not, you may see the old value.
The new style guarantees that you'll see the new value in the binding
regardless of the state of the notifications.
This also matches how things work in polymer.js elements.

<aside class="alert alert-info" markdown="1">
**Note:** We're looking into a way to automatically generate this code,
so you don't have to write so much boilerplate.
</aside>

###@ComputedProperty

A new annotation has been introduced that
lets you define a property in terms of other observable properties.
For example you can write:

{% prettify dart %}
@ComputedProperty('a + b')
String get aPlusB => readValue(#aPlusB);
{% endprettify %}

You can find more details in the dart docs for
[ComputedProperty](http://www.dartdocs.org/documentation/polymer/0.12.0/index.html#polymer/polymer.ComputedProperty).

###PropertyPath

The syntax of property path changed.
This is only relevant if you are not using polymer expressions, 
but use template-binding directly with its default syntax.
(See the changelog for
[observe](http://pub.dartlang.org/packages/observe) 0.11.0)

###Many bug fixes

The fixes are especially around handling `packages/` URLs,
URLs with bindings, sanitizing file names, CSS shim of link-rels,
and CSP support.

### Core 0.1.0+1, paper 0.1.0+1

The core and paper packages have been updated, too.
They now have the Dart API associated with the 0.3.4 js elements.
Many of the examples have been updated to use some of the changes above
(like the better js-interop features).


## 0.11.0
{: #0-11-0}

This release has a few important changes that
will affect you when you upgrade your project.

### Simple fixes for breaking changes

#### Include platform.js and then dart_support.js before any HTML imports in your app

`platform.js` used to be included in `polymer.html`,
but now you need to include it yourself.
This split helps have a clear separation between polymer and the polyfills.
`platform.js` has polyfills for many features that
are not available yet natively in browsers
(like html imports, and template binding).
One day, when browsers implement all these new standards,
`platform.js` will not be necessary,
but everything loaded by `polymer.html` will continue to be useful.

`dart_support.js` also used to be included as part of `polymer.html`.
Its main purpose is to complement what we have in `platform.js` to
make it work well with Dart.
It contains hooks to make dart2js understand
how `platform.js` patches the DOM,
and it contains extra logic to provide a Dart API for
custom elements written in JavaScript
(see web_components/interop.dart for details).

By having `dart_support.js` separate from `platform.js`
we were able to keep `platform.js` identical to
the one used in polymer.js projects.
So you can easily swap out one version of `platform.js`
for another if you want.

<aside class="alert alert-info" markdown="1">
**Note:**
Only your entrypoints need to import `platform.js` and `dart_support.js`.
Don't include these scripts in HTML files that define elements.
</aside>

#### Import polymer.html before using polymer-element

`polymer.html` defines the `<polymer-element>` element,
so you should import it before defining polymer elements.
Unless you define a polymer-element in the entry point of your app,
you no longer need to include `polymer.html` there
(`platform.js` and `dart_support.js` are all you need). 

#### Replace enteredView and leftView with attached and detached, respectively

This follows a change in dart:html that affects all custom elements.
Unfortunately, you won't see a deprecation message.
@deprecated is great to announce that you should call a different method,
but it can't indicate that you need to change a declaration.


#### If necessary, change @published to @PublishedProperty(reflect:true)

A `@published` property is no longer reflected as an attribute,
for performance reasons.
Although `@published` continues to support two-way bindings,
changes in the property might not be visible through the normal HTML APIs
if you try to inspect the attribute
(for example, if you read `node.attributes['attributename']`)
or if you try to query for it using a CSS selector either in Dart code
or in a `.css` file.

To make a published property reflect back to an attribute,
change `@published` to `@PublishedProperty(reflect: true)`.


### Examples of old vs. new HTML code

Here are some examples that summarize the HTML code changes.

#### App (entrypoint) HTML code

You used to write an app's HTML code (say, `web/index.html`)
like this:

<div class="bad">
{% prettify html %}
<link rel="import" href="packages/polymer/polymer.html">
<link rel="import" href="x_tag.html">
<body>
<x-tag></x-tag>
<script type="application/dart">export "package:polymer/init.dart";</script>
{% endprettify %}
</div>

Instead, use code like this:

<div class="good">
{% prettify html %}
<script src="packages/web_components/platform.js"></script>
<script src="packages/web_components/dart_support.js"></script>
<link rel="import" href="x_tag.html">
<body>
<x-tag></x-tag>
<script type="application/dart">export "package:polymer/init.dart";</script>
{% endprettify %}
</div>

#### Element HTML code

For an element under `web` (say, `web/x_tag.html`),
you used to write HTML code like this:

<div class="bad">
{% prettify html %}
<polymer-element name="x-tag">...</polymer-element>
<script type="application/dart" src="x_tag.dart"></script>
{% endprettify %}
</div>

Instead, use code like this:

<div class="good">
{% prettify html %}
<!-- in web/x_tag.html-->
<link rel="import" href="packages/polymer/polymer.html">
<polymer-element name="x-tag">...</polymer-element> 
<script type="application/dart" src="x_tag.dart"></script>   
{% endprettify %}
</div>

For an element under `lib` (say, `lib/components/x_tag.html`),
you need to use one more `../` in the path to `packages`
than you might expect. For example:

<div class="good">
{% prettify html %}
<!-- in lib/components/x_tag.html-->
<link rel="import" href="../../../packages/polymer/polymer.html">
<polymer-element name="x-tag">...</polymer-element> 
<script type="application/dart" src="x_tag.dart"></script>   
{% endprettify %}
</div>

For more information about paths, see
[dartbug.com/20076](http://dartbug.com/20076).


## 0.10.0
{: #0-10-0}

Here is a summary of what changed since our last stable release (0.9.5+2).

### New features

* Interop with polymer-js elements works!

* Polymer polyfills are now consolidated in the
  [web_components package](http://pub.dartlang.org/packages/web_components).
  Instead of our own `shadow_dom.js`,
  we now can simply use a `platform.js` from
  [polymer-project.org](http://polymer-project.org).

* The output of `pub build` no longer uses mirrors.
  We replace all uses of mirrors with code generation.
  You no longer need to use the @reflectable annotation!

* `@ObserveProperty('foo bar.baz') myMethod() {...}` will
  cause myMethod to be called when "foo" or "bar.baz" changes.

* Errors that occur within bindings are no longer reported on a logger
  (which were silently hidden if you were not using loggers).
  We now throw errors asycnhronously,
  but are looking into making them throw synchronously
  ([17789](https://code.google.com/p/dart/issues/detail?id=17789)).


### Noticeable breaking changes

* Declaring a polymer app requires an extra import:

      <link rel="import" href="packages/polymer/polymer.html">

  (See the
  [todomvc example](https://code.google.com/p/dart/source/browse/branches/bleeding_edge/dart/samples/third_party/todomvc/web/index.html?r=36852),
  or check out the
  [tutorial](https://www.dartlang.org/docs/tutorials/polymer-intro/).)

* "noscript" polymer-elements are created by polymer.js,
  and therefore cannot be extended (subtyped) in Dart.
  They can still be used by Dart elements or applications, however.

* @initMethod and @CustomTag are only supported on
  public methods and classes, respectively.

* Because we remove uses of mirrors during `pub build`,
  packages that rely on reflective APIs
  (like observe, and polymer_expressions) need a special setup.
  The polymer transformers take care of this for you automatically,
  but if you don't use our transformers and
  you use observe or polymer_expressions on their own,
  you'll need to do something special in your app
  (see [observe's changelog](http://pub.dartlang.org/packages/observe)
  for a simple workaround).
