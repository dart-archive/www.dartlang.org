---
# WARNING: GENERATED FILE. DO NOT EDIT.
#
#   This file was generated automatically from the polymer package.
#   To regenerate this file, from the top directory of the polymer package run:
#
#     dart tool/create_message_details_page.dart -s -o path_to_this_file
layout: default
title: "Error Messages"
subsite: "Polymer.dart"
description: "Details about error messages from polymer and related packages."
---

{% include breadcrumbs.html %}

# {{ page.title }}

<style>
h3 > a {
  display: none;
}

h3:hover > a {
  display: inline;
}

</style>


This page contains a list of error messages produced during `pub build` and `pub
serve` by transformers in polymer and its related packages. You can find here
additional details that can often help you figure out how to fix the underlying
problem.


## Messages from package `code_transformers`

----

### Absolute paths not allowed [#1](#code_transformers_1)
{: #code_transformers_1}

The transformers processing your code were trying to resolve a URL and identify
a file that they correspond to. Currently only relative paths can be resolved.


----

### Invalid URL to reach another package [#2](#code_transformers_2)
{: #code_transformers_2}

To reach an asset that belongs to another package, use `package:` URLs in
Dart code, but in any other language (like HTML or CSS) use relative URLs.

These are the rules you must follow to write URLs that refer to files in other
packages:

  * If the file containing the relative URL is an entrypoint under `web`, use
    `packages/package_name/path_to_file`

  * If the file containing the URL is under `web`, but in a different directory
    than your entrypoint, walk out to the same level as the entrypoint first,
    then enter the `packages` directory.

    **Note**: If two entrypoints include the file under `web` containing the
    URL, either both entrypoints have to live in the same directory, or you need
    to move the file to the `lib` directory.

  * If the file containing the URL lives under `lib`, walk up as many levels as
    directories you have + 1. This is because code in `lib/a/b` is loaded from
    `packages/package_name/a/b`.

The rules are easier to follow if you know how the code is laid out for
Dartium before you build, and how it is laid out after you build it with `pub
build`. Consider the following example:

   package a
      lib/
        |- a1.html

      web/
        |- a2.html

   package b
      lib/
        |- b1.html
        |- b2/
            |- b3.html

   package c
      lib/
        |- c3.html

      web/
        |- index.html
        |- index.dart
        |- c1/
            |- c2.html

If your app is package `c`, then `pub get` generates a packages directory under
the web directory, like this:

      web/
        |- index.html
        |- index.dart
        |- c1/
        |   |- c2.html
        |- packages/
            |- a/
            |   |- a1.html
            |- b/
            |   |- b1.html
            |   |- b2/
            |       |- b3.html
            |- c/
                |- c3.html

Note that no `lib` directory is under the `packages` directory.
When you launch `web/index.html` in Dartium, Dartium loads `package:` imports from
`web/packages/`.

If you need to refer to any file in other packages from `index.html`, you can
simply do `packages/package_name/path_to_file`. For example
`packages/b/b2/b3.html`. From `index.html` you can also refer to files under the
web directory of the same package using a simple relative URL, like
`c1/c2.html`.

However, if you want to load `a1.html` from `c2.html`, you need to reach out to
the packages directory that lives next to your entrypoint and then load the file
from there, for example `../packages/a/a1.html`. Because pub generates symlinks
to the packages directory also under c1, you may be tempted to write
`packages/a/a1.html`, but that is incorrect - it would yield a canonicalization
error (see more below).

If you want to load a file from the lib directory of your own package, you
should also use a package URL. For example, `packages/c/c3.html` and not
`../lib/c3.html`. This will allow you to write code in `lib` in a way that it
can be used within and outside your package without making any changes to it.

Because any time you reach inside a `lib/` directory you do so using a
`packages/` URL, the rules for reaching into other files in other packages are
always consistent: go up to exit the `packages` directory and go back inside to
the file you are looking for.  For example, to reach `a1.html` from `b3.html`
you need to write `../../../packages/a/a1.html`.

The motivation behind all these rules is that URLs need to work under many
scenarios at once:

  * They need to work in Dartium without any code transformation: resolving the
    path in the context of a simple HTTP server, or using `file:///` URLs,
    should yield a valid path to assets. The `packages` directory is safe to use
    because pub already creates it next to entrypoints of your application.

  * They need to be canonical. To take advantage of caching, multiple URLs
    reaching the same asset should resolve to the same absolute URL.
    
    Also, in projects that use HTML imports (like polymer) tools support that
    you reach a library with either Dart imports or HTML imports, and correctly
    resolve them to be the same library. The rules are designed to allow tools
    to support this.

    For example, consider you have an import might like:

        <link rel=import href=packages/a/a.html>

    where a.html has `<script type="application/dart" src="a.dart">`. If your
    Dart entrypoint also loads `"package:a/a.dart"`,  then a tool need to make
    sure that both versions of `a.dart` are loaded from the same URL. Otherwise,
    you may see errors at runtime like: `A is not a subtype of A`, which can be
    extremely confusing.

    When you follow the rules above, our tools can detect the pattern in the
    HTML-import URL containing `packages/` and canonicalize the import
    by converting `packages/a/a.dart` into `package:a/a.dart` under the hood.

  * They need to continue to be valid after applications are built.
    Technically this could be done automatically with pub transformers, but to
    make sure that code works also in Dartium with a simple HTTP Server,
    existing transformers do not fix URLs, they just detect inconsistencies and
    produce an error message like this one, instead.


----

### Incomplete URL to asset in another package [#3](#code_transformers_3)
{: #code_transformers_3}

URLs that refer to assets in other packages need to explicitly mention the
`packages/` directory. In the future this requirement might be removed, but for
now you must use a canonical URL form for it.

For example, if `packages/a/a.html` needs to import `packages/b/b.html`,
you might expect a.html to import `../b/b.html`. Instead, it must import
`../../packages/b/b.html`.
See [issue 15797](http://dartbug.com/15797).


----

## Messages from package `observe`

----

### `@observable` not supported on libraries [#1](#observe_1)
{: #observe_1}

Only instance fields on `Observable` classes can be observable,
and you must explicitly annotate each observable field as `@observable`.

Support for using the `@observable` annotation in libraries, classes, and
elsewhere is deprecated.


----

### `@observable` not supported on top-level fields [#2](#observe_2)
{: #observe_2}

Only instance fields on `Observable` classes can be observable,
and you must explicitly annotate each observable field as `@observable`.

Support for using the `@observable` annotation in libraries, classes, and
elsewhere is deprecated.


----

### `@observable` not supported on classes [#3](#observe_3)
{: #observe_3}

Only instance fields on `Observable` classes can be observable,
and you must explicitly annotate each observable field as `@observable`.

Support for using the `@observable` annotation in libraries, classes, and
elsewhere is deprecated.


----

### `@observable` not supported on static fields [#4](#observe_4)
{: #observe_4}

Only instance fields on `Observable` classes can be observable,
and you must explicitly annotate each observable field as `@observable`.

Support for using the `@observable` annotation in libraries, classes, and
elsewhere is deprecated.


----

### `@observable` field not in an `Observable` class [#5](#observe_5)
{: #observe_5}

Only instance fields on `Observable` classes can be observable,
and you must explicitly annotate each observable field as `@observable`.

Support for using the `@observable` annotation in libraries, classes, and
elsewhere is deprecated.


----

## Messages from package `polymer`

----

### Import not found [#1](#polymer_1)
{: #polymer_1}

An HTML import seems to be broken. This could be because the file doesn't exist
or because the link URL is incorrect.


----

### Duplicate definition [#2](#polymer_2)
{: #polymer_2}

Custom element names are global and can only be defined once. Some common
reasons why you might get two definitions:

  * Two different elements are declared with the same name.
  * A single HTML file defining an element, has been imported using two different
    URLs.


----

### Missing import to polymer.html [#3](#polymer_3)
{: #polymer_3}

Starting with polymer 0.11.0, each file that uses the definition
of polymer-element must import it either directly or transitively.


----

### Invalid import inside <polymer-element> [#4](#polymer_4)
{: #polymer_4}

HTML imports are expected at the top of each document, outside of any
polymer-element definitions. The polymer build process combines all your HTML
files together so you can deploy a single HTML file with your application. This
build process ignores imports that appear to be in the wrong location.


----

### Missing call to `initPolymer()` [#5](#polymer_5)
{: #polymer_5}

Your application entry point didn't have any Dart script tags, so it's missing
some initialization needed for polymer.dart.


----

### Script tags with experimental bootstrap [#6](#polymer_6)
{: #polymer_6}

This experimental feature is no longer supported.

----

### Multiple Dart script tags per document [#7](#polymer_7)
{: #polymer_7}

Dartium currently allows only one script tag per document. Any
additional script tags might be ignored or result in an error. This will
likely change in the future, but for now, combine the script tags together into
a single Dart library.


----

### Imports before script tags [#8](#polymer_8)
{: #polymer_8}

It is good practice to put all your HTML imports at the beginning of the
document, above any Dart script tags. Today, the execution of Dart script tags
is not synchronous in Dartium, so the difference is not noticeable. However,
Dartium that will eventually change and make the timing of script tags execution
match how they are in JavaScript. At that point the order of your imports with
respect to script tags will be important. Following the practice of putting
imports first protects your app from a future breaking change in this respect.


----

### Missing href on a `<link>` tag [#9](#polymer_9)
{: #polymer_9}

All `<link>` tags should have a valid URL to a resource.

----

### `<element>` is deprecated [#10](#polymer_10)
{: #polymer_10}

Long ago `<polymer-element>` used to be called `<element>`. You probably ran
into this error if you were migrating code that was written on a very early
version of polymer.


----

### Definition of a custom element not found [#11](#polymer_11)
{: #polymer_11}

The polymer build was not able to find the definition of a custom element. This
can happen if an element is defined with a `<polymer-element>` tag, but you are
missing an HTML import or the import link is incorrect.

This warning can also be a false alarm. For instance, when an element is defined
programatically using `document.registerElement`. In that case the polymer build
will not be able to see the definition and will produce this warning.


----

### Empty script tag [#12](#polymer_12)
{: #polymer_12}

Script tags should either have a `src` attribute or a non-empty body.

----

### Expected Dart mime-type [#13](#polymer_13)
{: #polymer_13}

You seem to have a `.dart` extension on a script tag, but the mime-type
doesn't match `application/dart`.


----

### Expected Dart file extension [#14](#polymer_14)
{: #polymer_14}

You are using the `application/dart` mime-type on a script tag, so
the URL to the script source URL should have a `.dart` extension.


----

### Script with both src and inline text [#15](#polymer_15)
{: #polymer_15}

You have a script tag that includes both a `src` attribute and inline script
text. You must choose one or the other.


----

### Incorrect instantiation: missing base tag in instantiation [#16](#polymer_16)
{: #polymer_16}

When you declare that a custom element extends from a base tag, for example:

    <polymer-element name="my-example" extends="ul">

or:

    <polymer-element name="my-example2" extends="ul">
    <polymer-element name="my-example" extends="my-example2">

You should instantiate `my-example` by using this syntax:

    <ul is="my-example">

And not:

    <my-example>

Only elements that don't extend from existing HTML elements are created using
the latter form.

This is because browsers first create the base element, and then upgrade it to
have the extra functionality of your custom element. In the example above, using
`<ul>` tells the browser which base type it must create before
doing the upgrade.


----

### Incorrect instantiation: extra `is` attribute or missing `extends` in declaration [#17](#polymer_17)
{: #polymer_17}

Creating a custom element using the syntax:

    <ul is="my-example">

means that the declaration of `my-example` extends transitively from `ul`. This
error message is shown if the definition of `my-example` doesn't declare this
extension. It might be that you no longer extend from the base element, in which
case the fix is to change the instantiation to:

    <my-example>

Another possibility is that the declaration needs to be fixed to include the
`extends` attribute, for example:

    <polymer-element name="my-example" extends="ul">


----

### Incorrect instantiation: base tag seems wrong [#18](#polymer_18)
{: #polymer_18}

It seems you have a declaration like:

    <polymer-element name="my-example" extends="div">

but an instantiation like:

    <span is="my-example">

Both the declaration and the instantiation need to match on the base type. So
either the instantiation needs to be fixed to be more like:

    <span is="my-example">

or the declaration should be fixed to be like:

    <polymer-element name="my-example" extends="span">


----

### No dashes allowed in custom attributes [#19](#polymer_19)
{: #polymer_19}

Polymer used to recognize attributes with dashes like `my-name` and convert them
to match properties where dashes were removed, and words follow the camelCase
style (for example `myName`). This feature is no longer available. Now simply
use the same name as the property.

Because HTML attributes are case-insensitive, you can also write the name of
your property entirely in lowercase. Just be sure that your custom-elements
don't declare two properties with the same name but different capitalization.


----

### Event handlers not supported here [#20](#polymer_20)
{: #polymer_20}

Bindings of the form `{{ }}` are supported inside `<template>` nodes, even outside
of `<polymer-element>` declarations. However, those bindings only support binding
values into the content of a node or an attribute.

Inline event handlers of the form `on-click="{{method}}"` are a special feature
of polymer elements, so they are only supported inside `<polymer-element>`
definitions.


----

### No expressions allowed in event handler bindings [#21](#polymer_21)
{: #polymer_21}

Unlike data bindings, event handler bindings of the form `on-click="{{method}}"`
are not evaluated as expressions. They are meant to just contain a simple name
that resolves to a method in your polymer element's class definition.


----

### Nested polymer element definitions not allowed [#22](#polymer_22)
{: #polymer_22}

Because custom element names are global, there is no need to have a
`<polymer-element>` definition nested within a `<polymer-element>`. If you have
a definition inside another, move the second definition out.

You might see this error if you have an HTML import within a polymer element.
You should be able to move the import out of the element definition.


----

### Polymer element definitions without a name [#23](#polymer_23)
{: #polymer_23}

Polymer element definitions must have a name. You can include a name by using
the `name` attribute in `<polymer-element>` for example:

    <polymer-element name="my-example">


----

### Custom element name missing a dash [#24](#polymer_24)
{: #polymer_24}

Custom element names must have a dash (`-`) and can't be any of the following
reserved names:

  * `annotation-xml`
  * `color-profile`
  * `font-face`
  * `font-face-src`
  * `font-face-uri`
  * `font-face-format`
  * `font-face-name`
  * `missing-glyph`




----

### Error while inlining an import [#25](#polymer_25)
{: #polymer_25}

An error occurred while inlining an import in the polymer build. This is often
the result of a broken HTML import.


----

### Error while inlining a stylesheet [#26](#polymer_26)
{: #polymer_26}

An error occurred while inlining a stylesheet in the polymer build. This is
often the result of a broken URL in a `<link rel="stylesheet" href="...">`.


----

### URL to a script file might be incorrect [#27](#polymer_27)
{: #polymer_27}

An error occurred trying to read a script tag on a given URL. This is often the
result of a broken URL in a `<script src="...">`.


----

### Attribute missing "_" prefix [#28](#polymer_28)
{: #polymer_28}

Not all browsers support bindings to certain attributes, especially URL
attributes. Some browsers might sanitize attributes and result in an
incorrect value. For this reason polymer provides a special set of attributes
that let you bypass any browser internal attribute validation. The name of the
attribute is the same as the original attribute, but with a leading underscore.
For example, instead of writing:

    <img src="{{binding}}">

you can write:

    <img _src="{{binding}}">

For more information, see <http://goo.gl/5av8cU>.


----

### Attribute with extra "_" prefix [#29](#polymer_29)
{: #polymer_29}

A special attribute exists to support bindings on URL attributes. For example,
this correctly binds the `src` attribute in an image:

    <img _src="{{binding}}">

However, this special `_src` attribute is only available for bindings. If you
just have a URL, use the normal `src` attribute instead.


----

### Internal error: don't know how to include a URL [#30](#polymer_30)
{: #polymer_30}

Sorry, you just ran into a bug in the polymer transformer code. Please file a
bug at <http://dartbug.com/new> including, if possible, some example code that
can help the team reproduce the issue.


----

### Internal error: phases run out of order [#31](#polymer_31)
{: #polymer_31}

Sorry, you just ran into a bug in the polymer transformer code. Please file a
bug at <http://dartbug.com/new> including, if possible, some example code that
can help the team reproduce the issue.


----

### `@CustomTag` used on a private class [#32](#polymer_32)
{: #polymer_32}

The `@CustomTag` annotation is currently only supported on public classes. If
you need to register a custom element whose implementation is a private class
(that is, a class whose name starts with `_`), you can still do so by invoking
`Polymer.register` within a public method marked with `@initMethod`.


----

### `@initMethod` is on a private function [#33](#polymer_33)
{: #polymer_33}

The `@initMethod` annotation is currently only supported on public top-level
functions.


----

### Missing argument in annotation [#34](#polymer_34)
{: #polymer_34}

The annotation expects one argument, but the argument was not provided.

----

### Invalid argument in annotation [#35](#polymer_35)
{: #polymer_35}

The polymer transformer was not able to extract a constant value for the
annotation argument. This can happen if your code is currently in a state that
can't be analyzed (for example, it has parse errors) or if the expression passed
as an argument is invalid (for example, it is not a compile-time constant).


----

### No polymer initializers found [#36](#polymer_36)
{: #polymer_36}

No polymer initializers were found. Make sure to either 
annotate your polymer elements with @CustomTag or include a 
top level method annotated with @initMethod that registers your 
elements. Both annotations are defined in the polymer library (
package:polymer/polymer.dart).


----

### Event bindings with @ are no longer supported [#37](#polymer_37)
{: #polymer_37}

For a while there was an undocumented feature that allowed users to include
expressions in event bindings using the `@` prefix, for example:

    <div on-click="{{@a.b.c}}">
    
This feature is no longer supported.


----

### Private symbol in event handler [#38](#polymer_38)
{: #polymer_38}

Currently private members can't be used in event handler bindings. So you can't
write:

    <div on-click="{{_method}}">

This restriction might be removed in the future, but for now, you need to make
your event handlers public.


----

### Private symbol in binding expression [#39](#polymer_39)
{: #polymer_39}

Private members can't be used in binding expressions. For example, you can't
write:

    <div>{{a.b._c}}</div>


----

### A warning was found while parsing the HTML document [#40](#polymer_40)
{: #polymer_40}

The polymer transformer uses a parser that implements the HTML5 spec
(`html5lib`). This message reports a
warning that the parser detected.


----

### Possible flash of unstyled content [#41](#polymer_41)
{: #polymer_41}

Custom element found in document body without an "unresolved" attribute on it or
one of its parents. This means your app probably has a flash of unstyled content
before it finishes loading. See <http://goo.gl/iN03Pj> for more info.


----

### A css file was inlined multiple times. [#42](#polymer_42)
{: #polymer_42}

Css files are inlined by default, but if you import the same one in multiple
places you probably want to override this behavior to prevent duplicate code.
To do this, use the following pattern to update your pubspec.yaml:

    transformers:
    - polymer:
      inline_stylesheets:
        web/my_file.css: false

If you would like to hide this warning and keep it inlined, do the same thing
but assign the value to true.


----

