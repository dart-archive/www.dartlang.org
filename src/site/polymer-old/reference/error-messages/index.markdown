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

{% raw %}The transformers processing your code were trying to resolve a URL and identify
a file that they correspond to. Currently only relative paths can be resolved.
{% endraw %}

----

### Invalid URL to reach another package [#2](#code_transformers_2)
{: #code_transformers_2}

{% raw %}To reach an asset that belongs to another package, use `package:` URLs in
Dart code, but in any other language (like HTML or CSS) use relative URLs that
first go all the way to the `packages/` directory.

The rules for correctly writing these imports are subtle and have a lot of
special cases. Please review
<https://www.dartlang.org/polymer/app-directories.html> to learn
more.
{% endraw %}

----

### Incomplete URL to asset in another package [#3](#code_transformers_3)
{: #code_transformers_3}

{% raw %}URLs that refer to assets in other packages need to explicitly mention the
`packages/` directory. In the future this requirement might be removed, but for
now you must use a canonical URL form for it.

For example, if `packages/a/a.html` needs to import `packages/b/b.html`,
you might expect a.html to import `../b/b.html`. Instead, it must import
`../../packages/b/b.html`.

See [issue 15797](http://dartbug.com/15797) and
<https://www.dartlang.org/polymer/app-directories.html> to learn more.
{% endraw %}

----

## Messages from package `observe`

----

### `@observable` not supported on libraries [#1](#observe_1)
{: #observe_1}

{% raw %}Only instance fields on `Observable` classes can be observable,
and you must explicitly annotate each observable field as `@observable`.

Support for using the `@observable` annotation in libraries, classes, and
elsewhere is deprecated.
{% endraw %}

----

### `@observable` not supported on top-level fields [#2](#observe_2)
{: #observe_2}

{% raw %}Only instance fields on `Observable` classes can be observable,
and you must explicitly annotate each observable field as `@observable`.

Support for using the `@observable` annotation in libraries, classes, and
elsewhere is deprecated.
{% endraw %}

----

### `@observable` not supported on classes [#3](#observe_3)
{: #observe_3}

{% raw %}Only instance fields on `Observable` classes can be observable,
and you must explicitly annotate each observable field as `@observable`.

Support for using the `@observable` annotation in libraries, classes, and
elsewhere is deprecated.
{% endraw %}

----

### `@observable` not supported on static fields [#4](#observe_4)
{: #observe_4}

{% raw %}Only instance fields on `Observable` classes can be observable,
and you must explicitly annotate each observable field as `@observable`.

Support for using the `@observable` annotation in libraries, classes, and
elsewhere is deprecated.
{% endraw %}

----

### `@observable` field not in an `Observable` class [#5](#observe_5)
{: #observe_5}

{% raw %}Only instance fields on `Observable` classes can be observable,
and you must explicitly annotate each observable field as `@observable`.

Support for using the `@observable` annotation in libraries, classes, and
elsewhere is deprecated.
{% endraw %}

----

## Messages from package `polymer`

----

### Import not found [#1](#polymer_1)
{: #polymer_1}

{% raw %}An HTML import seems to be broken. This could be because the file doesn't exist
or because the link URL is incorrect.
{% endraw %}

----

### Duplicate definition [#2](#polymer_2)
{: #polymer_2}

{% raw %}Custom element names are global and can only be defined once. Some common
reasons why you might get two definitions:

  * Two different elements are declared with the same name.
  * A single HTML file defining an element, has been imported using two different
    URLs.
{% endraw %}

----

### Missing import to polymer.html [#3](#polymer_3)
{: #polymer_3}

{% raw %}Starting with polymer 0.11.0, each file that uses the definition
of polymer-element must import it either directly or transitively.
{% endraw %}

----

### Invalid import inside <polymer-element> [#4](#polymer_4)
{: #polymer_4}

{% raw %}HTML imports are expected at the top of each document, outside of any
polymer-element definitions. The polymer build process combines all your HTML
files together so you can deploy a single HTML file with your application. This
build process ignores imports that appear to be in the wrong location.
{% endraw %}

----

### Missing call to `initPolymer()` [#5](#polymer_5)
{: #polymer_5}

{% raw %}Your application entry point didn't have any Dart script tags, so it's missing
some initialization needed for polymer.dart.
{% endraw %}

----

### Script tags with experimental bootstrap [#6](#polymer_6)
{: #polymer_6}

{% raw %}This experimental feature is no longer supported.{% endraw %}

----

### Multiple Dart script tags per document [#7](#polymer_7)
{: #polymer_7}

{% raw %}Dartium currently allows only one script tag per document. Any
additional script tags might be ignored or result in an error. This will
likely change in the future, but for now, combine the script tags together into
a single Dart library.
{% endraw %}

----

### Imports before script tags [#8](#polymer_8)
{: #polymer_8}

{% raw %}It is good practice to put all your HTML imports at the beginning of the
document, above any Dart script tags. Today, the execution of Dart script tags
is not synchronous in Dartium, so the difference is not noticeable. However,
Dartium that will eventually change and make the timing of script tags execution
match how they are in JavaScript. At that point the order of your imports with
respect to script tags will be important. Following the practice of putting
imports first protects your app from a future breaking change in this respect.
{% endraw %}

----

### Missing href on a `<link>` tag [#9](#polymer_9)
{: #polymer_9}

{% raw %}All `<link>` tags should have a valid URL to a resource.{% endraw %}

----

### `<element>` is deprecated [#10](#polymer_10)
{: #polymer_10}

{% raw %}Long ago `<polymer-element>` used to be called `<element>`. You probably ran
into this error if you were migrating code that was written on a very early
version of polymer.
{% endraw %}

----

### Definition of a custom element not found [#11](#polymer_11)
{: #polymer_11}

{% raw %}The polymer build was not able to find the definition of a custom element. This
can happen if an element is defined with a `<polymer-element>` tag, but you are
missing an HTML import or the import link is incorrect.

This warning can also be a false alarm. For instance, when an element is defined
programatically using `document.registerElement`. In that case the polymer build
will not be able to see the definition and will produce this warning.
{% endraw %}

----

### Empty script tag [#12](#polymer_12)
{: #polymer_12}

{% raw %}Script tags should either have a `src` attribute or a non-empty body.{% endraw %}

----

### Expected Dart mime-type [#13](#polymer_13)
{: #polymer_13}

{% raw %}You seem to have a `.dart` extension on a script tag, but the mime-type
doesn't match `application/dart`.
{% endraw %}

----

### Expected Dart file extension [#14](#polymer_14)
{: #polymer_14}

{% raw %}You are using the `application/dart` mime-type on a script tag, so
the URL to the script source URL should have a `.dart` extension.
{% endraw %}

----

### Script with both src and inline text [#15](#polymer_15)
{: #polymer_15}

{% raw %}You have a script tag that includes both a `src` attribute and inline script
text. You must choose one or the other.
{% endraw %}

----

### Incorrect instantiation: missing base tag in instantiation [#16](#polymer_16)
{: #polymer_16}

{% raw %}When you declare that a custom element extends from a base tag, for example:

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
{% endraw %}

----

### Incorrect instantiation: extra `is` attribute or missing `extends` in declaration [#17](#polymer_17)
{: #polymer_17}

{% raw %}Creating a custom element using the syntax:

    <ul is="my-example">

means that the declaration of `my-example` extends transitively from `ul`. This
error message is shown if the definition of `my-example` doesn't declare this
extension. It might be that you no longer extend from the base element, in which
case the fix is to change the instantiation to:

    <my-example>

Another possibility is that the declaration needs to be fixed to include the
`extends` attribute, for example:

    <polymer-element name="my-example" extends="ul">
{% endraw %}

----

### Incorrect instantiation: base tag seems wrong [#18](#polymer_18)
{: #polymer_18}

{% raw %}It seems you have a declaration like:

    <polymer-element name="my-example" extends="div">

but an instantiation like:

    <span is="my-example">

Both the declaration and the instantiation need to match on the base type. So
either the instantiation needs to be fixed to be more like:

    <span is="my-example">

or the declaration should be fixed to be like:

    <polymer-element name="my-example" extends="span">
{% endraw %}

----

### No dashes allowed in custom attributes [#19](#polymer_19)
{: #polymer_19}

{% raw %}Polymer used to recognize attributes with dashes like `my-name` and convert them
to match properties where dashes were removed, and words follow the camelCase
style (for example `myName`). This feature is no longer available. Now simply
use the same name as the property.

Because HTML attributes are case-insensitive, you can also write the name of
your property entirely in lowercase. Just be sure that your custom-elements
don't declare two properties with the same name but different capitalization.
{% endraw %}

----

### Event handlers not supported here [#20](#polymer_20)
{: #polymer_20}

{% raw %}Bindings of the form `{{ }}` are supported inside `<template>` nodes, even outside
of `<polymer-element>` declarations. However, those bindings only support binding
values into the content of a node or an attribute.

Inline event handlers of the form `on-click="{{method}}"` are a special feature
of polymer elements, so they are only supported inside `<polymer-element>`
definitions.
{% endraw %}

----

### No expressions allowed in event handler bindings [#21](#polymer_21)
{: #polymer_21}

{% raw %}Unlike data bindings, event handler bindings of the form `on-click="{{method}}"`
are not evaluated as expressions. They are meant to just contain a simple name
that resolves to a method in your polymer element's class definition.
{% endraw %}

----

### Nested polymer element definitions not allowed [#22](#polymer_22)
{: #polymer_22}

{% raw %}Because custom element names are global, there is no need to have a
`<polymer-element>` definition nested within a `<polymer-element>`. If you have
a definition inside another, move the second definition out.

You might see this error if you have an HTML import within a polymer element.
You should be able to move the import out of the element definition.
{% endraw %}

----

### Polymer element definitions without a name [#23](#polymer_23)
{: #polymer_23}

{% raw %}Polymer element definitions must have a name. You can include a name by using
the `name` attribute in `<polymer-element>` for example:

    <polymer-element name="my-example">
{% endraw %}

----

### Custom element name missing a dash [#24](#polymer_24)
{: #polymer_24}

{% raw %}Custom element names must have a dash (`-`) and can't be any of the following
reserved names:

  * `annotation-xml`
  * `color-profile`
  * `font-face`
  * `font-face-src`
  * `font-face-uri`
  * `font-face-format`
  * `font-face-name`
  * `missing-glyph`


{% endraw %}

----

### Error while inlining an import [#25](#polymer_25)
{: #polymer_25}

{% raw %}An error occurred while inlining an import in the polymer build. This is often
the result of a broken HTML import.
{% endraw %}

----

### Error while inlining a stylesheet [#26](#polymer_26)
{: #polymer_26}

{% raw %}An error occurred while inlining a stylesheet in the polymer build. This is
often the result of a broken URL in a `<link rel="stylesheet" href="...">`.
{% endraw %}

----

### URL to a script file might be incorrect [#27](#polymer_27)
{: #polymer_27}

{% raw %}An error occurred trying to read a script tag on a given URL. This is often the
result of a broken URL in a `<script src="...">`.
{% endraw %}

----

### Attribute missing "_" prefix [#28](#polymer_28)
{: #polymer_28}

{% raw %}Not all browsers support bindings to certain attributes, especially URL
attributes. Some browsers might sanitize attributes and result in an
incorrect value. For this reason polymer provides a special set of attributes
that let you bypass any browser internal attribute validation. The name of the
attribute is the same as the original attribute, but with a leading underscore.
For example, instead of writing:

    <img src="{{binding}}">

you can write:

    <img _src="{{binding}}">

For more information, see <http://goo.gl/5av8cU>.
{% endraw %}

----

### Attribute with extra "_" prefix [#29](#polymer_29)
{: #polymer_29}

{% raw %}A special attribute exists to support bindings on URL attributes. For example,
this correctly binds the `src` attribute in an image:

    <img _src="{{binding}}">

However, this special `_src` attribute is only available for bindings. If you
just have a URL, use the normal `src` attribute instead.
{% endraw %}

----

### Internal error: don't know how to include a URL [#30](#polymer_30)
{: #polymer_30}

{% raw %}Sorry, you just ran into a bug in the polymer transformer code. Please file a
bug at <http://dartbug.com/new> including, if possible, some example code that
can help the team reproduce the issue.
{% endraw %}

----

### Internal error: phases run out of order [#31](#polymer_31)
{: #polymer_31}

{% raw %}Sorry, you just ran into a bug in the polymer transformer code. Please file a
bug at <http://dartbug.com/new> including, if possible, some example code that
can help the team reproduce the issue.
{% endraw %}

----

### `@CustomTag` used on a private class [#32](#polymer_32)
{: #polymer_32}

{% raw %}The `@CustomTag` annotation is currently only supported on public classes. If
you need to register a custom element whose implementation is a private class
(that is, a class whose name starts with `_`), you can still do so by invoking
`Polymer.register` within a public method marked with `@initMethod`.
{% endraw %}

----

### `@initMethod` is on a private function [#33](#polymer_33)
{: #polymer_33}

{% raw %}The `@initMethod` annotation is currently only supported on public top-level
functions.
{% endraw %}

----

### Missing argument in annotation [#34](#polymer_34)
{: #polymer_34}

{% raw %}The annotation expects one argument, but the argument was not provided.{% endraw %}

----

### Invalid argument in annotation [#35](#polymer_35)
{: #polymer_35}

{% raw %}The polymer transformer was not able to extract a constant value for the
annotation argument. This can happen if your code is currently in a state that
can't be analyzed (for example, it has parse errors) or if the expression passed
as an argument is invalid (for example, it is not a compile-time constant).
{% endraw %}

----

### No polymer initializers found [#36](#polymer_36)
{: #polymer_36}

{% raw %}No polymer initializers were found. Make sure to either 
annotate your polymer elements with @CustomTag or include a 
top level method annotated with @initMethod that registers your 
elements. Both annotations are defined in the polymer library (
package:polymer/polymer.dart).
{% endraw %}

----

### Event bindings with @ are no longer supported [#37](#polymer_37)
{: #polymer_37}

{% raw %}For a while there was an undocumented feature that allowed users to include
expressions in event bindings using the `@` prefix, for example:

    <div on-click="{{@a.b.c}}">
    
This feature is no longer supported.
{% endraw %}

----

### Private symbol in event handler [#38](#polymer_38)
{: #polymer_38}

{% raw %}Currently private members can't be used in event handler bindings. So you can't
write:

    <div on-click="{{_method}}">

This restriction might be removed in the future, but for now, you need to make
your event handlers public.
{% endraw %}

----

### Private symbol in binding expression [#39](#polymer_39)
{: #polymer_39}

{% raw %}Private members can't be used in binding expressions. For example, you can't
write:

    <div>{{a.b._c}}</div>
{% endraw %}

----

### A warning was found while parsing the HTML document [#40](#polymer_40)
{: #polymer_40}

{% raw %}The polymer transformer uses a parser that implements the HTML5 spec
(`html5lib`). This message reports a
warning that the parser detected.
{% endraw %}

----

### Possible flash of unstyled content [#41](#polymer_41)
{: #polymer_41}

{% raw %}Custom element found in document body without an "unresolved" attribute on it or
one of its parents. This means your app probably has a flash of unstyled content
before it finishes loading. See <http://goo.gl/iN03Pj> for more info.
{% endraw %}

----

### A css file was inlined multiple times. [#42](#polymer_42)
{: #polymer_42}

{% raw %}Css files are inlined by default, but if you import the same one in multiple
places you probably want to change this behavior to prevent duplicate code.

There are three typical options for dealing with this:

1. **Recommended**: Use the `core-style` element from the `core_elements`
    package.

    The easiest way to do this is change your `*.css` file into a `*.html` file,
    and wrap the entire thing in a `core-style` with an id, something like the
    following:

        <core-style id="my-theme">
          p {
            color: red;
          }
        </core-style>

    Now, in the files where you were previously including the
    `<link rel="stylesheet">` tag, add an html import to the top of your
    document pointing to the new html file. Once that is done, replace the
    `<link>` tag with a `<core-style>` tag which has a `ref` attribute that is
    the same as the `id` attribute on the `<core-style>` you created. So your
    original html:

        <polymer-element name="my-element">
          <template>
            <link rel="stylesheet" href="my_theme.css">
          </template>
        </polymer-element>

    Becomes:

        <link rel="import" href="my_theme.html">
        <polymer-element name="my-element">
          <template>
            <core-style ref="my-theme"></core-style>
          </template>
        </polymer-element>

2. Opt out of the inlining for this file in your pubspec.yaml:

        transformers:
        - polymer:
            inline_stylesheets:
              web/my_file.css: false

    **Warning**: `<link rel="stylesheet">` tags are not natively supported in
    shadow-dom. Polymer will do an xhr request for the stylesheet and inject an
    inline style with its contents in each place this stylesheet occurs.

3. Opt into multiple inlining in your pubspec.yaml:

        transformers:
        - polymer:
            inline_stylesheets:
              web/my_file.css: true

    **Warning**: You should only ever do this if your stylesheet is very small.
    Even then stylesheets tend to grow quickly and almost never decrease in size
    so this method is highly discouraged.
{% endraw %}

----

### "dart_support.js" injected automatically [#43](#polymer_43)
{: #polymer_43}

{% raw %}The script `packages/web_components/dart_support.js` is still used, but you no
longer need to put it in your application's entrypoint.

In the past this file served two purposes:

  * to make dart2js work well with the web_components polyfills, and
  * to support registering Dart APIs for JavaScript custom elements.

Now, the code from `dart_support.js` is split in two halves. The half for
dart2js is now injected by the polymer transformers automatically during `pub
build`. The `web_components` package provides an HTML file containing the other
half.  Developers of packages that wrap JavaScript custom elements (like
`core_elements` and `paper_elements`) will import that file directly, so
application developers don't have to worry about it anymore.
{% endraw %}

----

### Dart script file included more than once. [#44](#polymer_44)
{: #polymer_44}

{% raw %}Duplicate dart scripts often happen if you have multiple html imports that
include the same script. The simplest workaround for this is to move your dart
script to its own html file, and import that instead of the script (html imports
are automatically deduped).

For example:

    <script type="application/dart" src="foo.dart"></script>

Should turn into:

    <link rel="import" href="foo.html">

And `foo.html` should look like:

    <script type="application/dart" src="foo.dart"></script>
{% endraw %}

----

### "webcomponents.js" injected automatically [#45](#polymer_45)
{: #polymer_45}

{% raw %}The script `packages/web_components/webcomponents.js` is still used, but you no
longer need to put it in your application's entrypoint.

The polyfills provided by this file are no longer required in chrome and will
automatically be added during `pub build` and `pub serve`.
{% endraw %}

----

### "platform.js" renamed to "webcomponents.js". [#46](#polymer_46)
{: #polymer_46}

{% raw %}The script `packages/web_components/platform.js` has been renamed to
`packages/web_components/webcomponents.js`. This is automatically fixed in
`pub serve` and `pub build` but we may remove this functionality in the next
breaking version of Polymer.

In addition, it is no longer required that you include this file directly, as
`pub build` and `pub serve` will inject it for you, and its not required when
running in dartium with a local server.
{% endraw %}

----

### Missing Dart script tag in entry point. [#47](#polymer_47)
{: #polymer_47}

{% raw %}All entry points should have a dart script file. This can sometimes happen if
you are using the default entry_points value in your polymer transformer
configuration but have files which are not entry points in your `web` or `test`
directory. Moving these files to your `lib` folder or specifying all your entry
points in your configuration will fix this.
{% endraw %}

----

### polymer.dart not imported. [#48](#polymer_48)
{: #polymer_48}

{% raw %}It is required that your application contains an import to
`package:polymer/polymer.dart`.
{% endraw %}

----

## Messages from package `web_components`

----

### URL to a script file might be incorrect [#0](#web_components_0)
{: #web_components_0}

{% raw %}An error occurred trying to read a script tag on a given URL. This is often the
result of a broken URL in a `<script src="...">`.
{% endraw %}

----

### Dart script file included more than once. [#1](#web_components_1)
{: #web_components_1}

{% raw %}Duplicate dart scripts often happen if you have multiple html imports that
include the same script. The simplest workaround for this is to move your dart
script to its own html file, and import that instead of the script (html imports
are automatically deduped).

For example:

    <script type="application/dart" src="foo.dart"></script>

Should turn into:

    <link rel="import" href="foo.html">

And `foo.html` should look like:

    <script type="application/dart" src="foo.dart"></script>
{% endraw %}

----

### Each entry point html file should contain exactly one dart script tag. [#2](#web_components_2)
{: #web_components_2}

{% raw %}Each entry point html file should contain exactly one dart script tag.{% endraw %}

----

### Internal error: don't know how to include a URL [#3](#web_components_3)
{: #web_components_3}

{% raw %}Sorry, you just ran into a bug in the web_components transformer code. Please
file a bug at <https://github.com/dart-lang/web-components/issues/new>
including, if possible, some example code that can help the team reproduce the
issue.
{% endraw %}

----

### Error while inlining an import [#4](#web_components_4)
{: #web_components_4}

{% raw %}An error occurred while inlining an import in the web_components build. This is
often the result of a broken HTML import.

One possible cause is using an @HtmlImport containing a relative path from
within an inline script tag, see http://goo.gl/ZgrhaV. The workaround currently
is to use a `package:` url instead, move the code to a dart file, or simply
adding a real html import (since you are already in an html file).
{% endraw %}

----

