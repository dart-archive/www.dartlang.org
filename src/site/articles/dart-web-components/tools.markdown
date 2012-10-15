---
layout: default
title: Tools for Dart Web Components
description: "Tools for creating a project with Dart web components"
rel:
  author: siggi-cherem
---
# {{ page.title}}
_Written by Siggi Cherem<br />
October 2012_


Dart web components provide templates, data binding, and encapsulation to help
you write web applications at scale. You can learn about Dart web components in
our [explainer article](index.html). This article describes tools that will
help you create and deploy projects that use Dart web
components.


## The overall approach: a compiler in disguise

We use a compiler to generate efficient code for your Dart web components.
You'll sometimes invoke this compiler from the command line, but often you might
not even know that it's there. 

Special support is available for both [Dartium][dartium] and the [Dart
Editor][editor] to provide you with a smooth edit/refresh cycle.  Below you'll
find quick instructions to setup the Dart Editor to do background compilation,
and to set up Dartium to compile your code on demand.  Under the hood, the Dart
Editor and Dartium will be invoking our compiler.  When it's time to deploy,
you'll then use the command-line API and then use [dart2js][] to compile all the way
to JavaScript.

## Set up

Dart web components is available under the `web_components` pub package. Simply
add a dependency to your `pubspec.yaml` file:

    ...
    dependencies:
      web_components: any

Then run `pub install` and you'll have everything you need to get started. You
can use `package:web_components/...` imports in your code, and you will be able
to access our compiler under `packages/web_components/dwc.dart`.

## Command-line API

You can invoke the compiler from the command line by invoking the `dwc` script
on the entry point of your application. For instance, the following example
shows how to compile an application under the directory `web`, whose entry point
is `app.html`.

    > packages/web_components/dwc.dart web/app.html

You can pass an argument after the input HTML filename to indicate the directory
where output will be written.

<aside><div class="alert alert-info">
<strong>Note:</strong> If you specify an output directory, and your code has
relative path imports to other .dart files, those files will not be copied to
the output directory. This limitation may be lifted in the future.
</div></aside>

The compiler generates many files that start with a leading underscore and
that have double extensions (e.g. `_app.html.dart`). The entry point to your app
is the file named  `_app.html.html`. Navigate Dartium to that file and see it
run.

You can use `dart2js` to generate JavaScript code that will run in other
browsers. The entry point Dart file to compile is the file
`_app.html_boostrap.dart`.

    > dart2js _app.html_bootstrap.dart -o_app.html_bootstrap.dart.js

If you name the output `_app.html_boostrap.dart.js` then the same
`_app.html.html` will work in all [modern browsers][mb].

Recent versions of Chrome have experimental support for [shadow DOM][sd], and
our generated code will use it if it is available. This feature is not enabled
by default, but you can turn it on by passing the special flag
`--enable-experimental-webkit-features` to Chrome. This flag is enabled by
default in Dartium.  During development, you might find it useful to pass two
additional flags: `--allow-file-access-from-files` and
`--enable-devtools-experiments`. The first lets your files make HttpRequests for
resources from your file system.  The second will display `#shadowroot` in the
web inspector for elements that have a ShadowRoot.

## Editor background compilation

We can make the Dart Editor compile your code every time a project file
is modified, so when you are ready to test your app, the compiled code will be
ready to go.

The Dart Editor provides a hook that let's you execute a script whenever changes
are detected on a project's files. We provide a library that makes it really
easy to create a script that automatically calls our compiler. Create a file
named `build.dart` in the same directory as your `pubspec.yaml` file with the
following contents:

{% highlight dart %}
import 'package:web_components/component_build.dart';
import 'dart:io';

void main() {
  build(new Options().arguments, ['web/app.html']);
}
{% endhighlight %}

This script will invoke `dwc` on `web/app.html` every time the Dart
Editor detects that you changed a file in your project.  When you want to
launch your app, you can find the generated file `_app.html.html` in your
editor, and request the editor to launch it in Dartium.

## Dartium on-demand compilation

If you use Dartium and your own editor, you can
install a browser extension that will invoke the compiler on demand. This
on-demand approach is equivalent to what *polyfill* scripts do today for web
components in JavaScript.  The extension creates the illusion that Dart web
components are supported natively in Dartium. 

<aside><div class="alert alert-info">
<strong> Note: </strong>
The extension requires that your HTML and Dart files are served through an HTTP
server. This limitation may be lifted in the future. Meanwhile, you can use the
extension by running a local web server. Running a standard server like
<code>python -m SimpleHTTPServer</code> or any development server that comes
with your server stack would do the trick.
</div></aside>

You can install the extension as follows:

  * [Download the extension][extension].
  * Open the `chrome://extensions` tab in Dartium
  * Drag and drop the extension file into this tab (tip: if you downloaded the
    extension within Dartium, you can start dragging directly from the
    _download icon_ on the bottom of the page):

<img style="position:relative;left:100px;width:600px;height:auto"
     src="drag_and_drop.png">

  * Finally click to accept the extension.

Once you installed the extension, you can open `app.html` directly in Dartium
(using an HTTP URL for now), and the extension will take care of everything
else.



[dwc]: https://github.com/dart-lang/dart-web-components/
[extension]: http://dart-lang.github.com/dart-web-components/extension/dwc.crx
[dartium]: http://www.dartlang.org/dartium/
[editor]: http://www.dartlang.org/docs/editor/
[dart2js]: http://www.dartlang.org/docs/dart2js/
[mb]: http://www.dartlang.org/support/faq.html#what-browsers-supported
[sd]: http://dvcs.w3.org/hg/webcomponents/raw-file/tip/spec/shadow/index.html
