---
layout: article
title: Tools for Web UI
description: "Tools for creating a project with Web UI"
rel:
  author: sigmund-cherem
---

{% include toc.html %}

# {{ page.title}}

<aside class="alert alert-danger" markdown="1">
<strong>Web UI is deprecated.</strong>
Instead, use [Polymer.dart](/polymer-dart/),
which supersedes Web UI beginning with version 0.5
and provides many fixes and improvements.
We encourage Web UI users to upgrade to Polymer.dart.
The information on this page applies only to Web UI.
</aside>

_Written by Sigmund Cherem<br />
October 2012 (Updated December 2012)_


The Web UI package (Web UI for short) provides web components and templates to
help you write web applications at scale. You can learn about this package in
our [explainer article](/articles/web-ui/). This article describes tools that will help
you create and deploy projects that use Web UI.

## The overall approach: a compiler in disguise

We use a compiler to generate efficient code for applications that use the Web
UI package.  You'll sometimes invoke this compiler from the command line, but
often you might not even know that it's there.

Special support is available for both [Dartium][dartium] and the [Dart
Editor][editor] to provide you with a smooth edit/refresh cycle.  Below you'll
find quick instructions to setup the Dart Editor to do background compilation,
and to set up Dartium to compile your code on demand.  Under the hood, the Dart
Editor and Dartium will be invoking our compiler.  When it's time to deploy,
you'll then use the command-line API and then use [dart2js][] to compile all the way
to JavaScript.

## Set up

Web UI is available under the `web_ui` pub package. Simply add a dependency to
your `pubspec.yaml` file:

    ...
    dependencies:
      web_ui: any

Then run `pub install` and you'll have everything you need to get started. You
can use `package:web_ui/...` imports in your code, and you will be able
to access our compiler under `packages/web_ui/dwc.dart`.

## Command-line API

You can invoke the compiler from the command line by invoking the `dwc` script
on the entry point of your application. For instance, the following example
shows how to compile an application under the directory `web`, whose entry point
is `app.html`.

    > dart --package-root=packages/ packages/web_ui/dwc.dart --out web/out/ web/app.html

<aside><div class="alert alert-info">
<strong>Note:</strong> This command will get simpler in the future. We
expect that <em>pub</em> will allow to directly run scripts deployed with a
package.  At that point, you'll be able to run the command above without the
<code>--package-root</code> argument and without reaching into the
<code>packages/</code> directory.
</div></aside>

The `--out web/out/` option indicates that we want the generated files to be
written under `web/out/`. If the option is not specified, the compiler will
generate files in the same folder of your entry point by default. In that case,
all generated files will be mangled to avoid name collisions. For instance, file
names will start with a leading underscore and have double extensions (for
example, `_app.html.dart`).  When you specify an output dir, the compiler avoids
mangling file names.

In our example above, the application's main HTML file is `web/out/app.html`.
Navigate Dartium to that file and see it run.  If you don't specify an output
directory, the main file will be `web/_app.html.html`.

You can use `dart2js` to generate JavaScript code that will run in other
browsers. The entry point Dart script you need to compile is
`app.html_boostrap.dart`.

    > cd web/out/
    > dart2js app.html_bootstrap.dart -oapp.html_bootstrap.dart.js

Note that we made the output file name exactly the input file name followed by
an extra `.js` extension. This makes it possible to reuse the same HTML file
under `web/out/app.html` on any [modern browsers][mb].

Recent versions of Chrome have experimental support for [shadow DOM][sd], and
our generated code can use it if it is available. This feature is not enabled
by default. To turn it on, you need to:

  * Import `package:web_ui/web_ui.dart` and
    set `useShadowDom = true` in your app's main script.
  * Provide the special flag `--enable-experimental-webkit-features` to Chrome
    or Dartium.

When developing with the Shadow DOM, you'll find these two additional flags very
useful: `--allow-file-access-from-files` and `--enable-devtools-experiments`.
The first lets your files make HttpRequests for resources from your file system.
The second will display `#shadowroot` in the web inspector for elements that
have a ShadowRoot.

## Editor background compilation

We can make the Dart Editor compile your code every time a project file
is modified, so when you are ready to test your app, the compiled code will be
ready to go.

The Dart Editor provides a hook that lets you execute a script whenever changes
are detected on a project's files. We provide a library that makes it really
easy to create a script that automatically calls our compiler. Create a file
named `build.dart` in the same directory as your `pubspec.yaml` file with the
following contents:

{% prettify dart %}
import 'package:web_ui/component_build.dart';
import 'dart:io';

void main() {
  build(new Options().arguments, ['web/app.html']);
}
{% endprettify %}

This script will invoke `dwc` on `web/app.html` every time the Dart Editor
detects that you changed a file in your project.  When you want to launch your
app, you can directly launch the input HTML file `web/app.html` and the editor
will automatically redirect to run the generated file. You can also find the
generated file under `web/out/app.html`, and request the editor to launch it
directly.

For more information about hooking into the Dart Editor build, see
[Build.dart and the Dart Editor Build System](/tools/editor/build.html).


[dwc]: https://github.com/dart-lang/web-ui/
[extension]: http://dart-lang.github.com/web-ui/extension/web_ui.crx
[dartium]: /tools/dartium/
[editor]: /tools/editor/
[dart2js]: /docs/dart-up-and-running/contents/ch04-tools-dart2js.html
[mb]: /support/faq.html#what-browsers-supported
[sd]: http://dvcs.w3.org/hg/webcomponents/raw-file/tip/spec/shadow/index.html
