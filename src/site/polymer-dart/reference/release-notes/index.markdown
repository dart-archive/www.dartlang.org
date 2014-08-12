---
layout: default
title: "Release Notes"
subsite: "Polymer.dart"
description: "Details about each major polymer.dart release"
has-permalinks: true
---

{% include breadcrumbs.html %}

# {{ page.title }}


This page describes each polymer.dart release, starting with 0.12.
For information about earlier releases, see the CHANGELOG.md tab of the 
[polymer.dart pub page](http://pub.dartlang.org/packages/polymer)
and the release announcements in the
[Dart web forum](https://groups.google.com/a/dartlang.org/forum/#!forum/web).

{% include default_toc.html %}


## 0.12.1 {#0-12-1}

This release contains some new productivity features worth highlighting.

### Making error messages more useful

**Visible warnings:**
When you run Pub serve we are doing lots of checks to
detect common mistakes that have tripped us in the past.
Many of us used to ignore warning messages because
they were only reported in the console.
So, starting with polymer-0.12.1, they will be more visible.
When you you load your app via Pub serve,
we'll show you on the bottom-right corner of your page
a collapsible dialog with these messages. For example:

![Warnings and errors on top of app.](images/warnings-and-errors-0.12.1.png)

**Fail forward:**
Some errors are clear indications that something is really wrong,
for example a broken import.
We heard that many were frustrated that when there was an error like this,
Pub serve would fail and not serve you the content at all.
Now, we'll try to fail forward and serve your application as if
the piece that caused the error wasn't there.
We don't want to deploy a broken app though,
so we'll continue to fail and stop the Pub build process if
the app still contains error at that point.

**Better highlighting of errors:**
We also heard that it is hard to find the errors in the console logs
because they are mixed with all the warnings and HTTP messages
from Pub serve.
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


## 0.12.0 {#0-12}

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
