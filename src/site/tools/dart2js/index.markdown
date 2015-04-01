---
layout: default
title: "dart2js: The Dart-to-JavaScript Compiler"
short-title: "dart2js"
---

{% include toc.html %}
{% include breadcrumbs.html %}

# {{ page.title }} 

---
Use the _dart2js_ tool to compile Dart code to JavaScript.
[Dart Editor](/tools/editor/) uses dart2js behind the scenes whenever Dart
Editor compiles to JavaScript. The [`pub serve`](/tools/pub/cmd/pub-serve.html),
[`pub run`](/tools/pub/cmd/pub-run.html), and
[`pub build`](/tools/pub/cmd/pub-build.html) commands also use dart2js.
If you are using dart2js through one of the pub commands, see [Configuring
the Built-in dart2js Transformer for Pub](/tools/pub/dart2js-transformer.html)
for information on how to specify dart2js flags in your pubspec file.

The dart2js tool provides hints for improving your Dart code and removing
unused code. You can get these hints for all kinds of code—even command-line
apps. Also see [dartanalyzer](/tools/analyzer/),
which performs a similar analysis but, as of 1.0,
has a different implementation.

This page tells you how to use dart2js on the command line. It also give tips
on debugging the JavaScript that dart2js generates.

## Basic usage {#basic-usage}

Here’s an example of compiling a Dart file to JavaScript:

{% prettify sh %}
dart2js --out=test.js test.dart
{% endprettify %}

This command produces a file that contains the JavaScript equivalent of your
Dart code. It also produces a source map, which can help you debug the
JavaScript version of the app more easily.

## Usage in pubspec {#pubspec-usage}

You can also configure dart2js options in the pubspec file.
For more information, see
[Configuring the Built-in dart2js Transformer for
Pub](/tools/pub/dart2js-transformer.html).

## Options {#options}

Common command-line options for dart2js include:

`-o <file>` or `--out=<file>`
: Generate the output into `<file>`. If not specified,
  the output goes in a file named `out.js`.
            
`-c` or `--checked`
: Insert runtime type checks, and enable assertions (checked mode).

`-m` or `--minify`
: Generate minified output.

`-h` or `--help`
: Display help. (Use `-vh` for information about all options.)

Some other handy options include:

`-p <path>` or `--package-root=<path>`
: Specify where to find "package:" imports.

`-D<flag>=<value>`
: Define an environment variable.

`--enable-enum`
: Enable support for enumerated types. For more information on this
  language feature, see
  [Enumerated types](/docs/dart-up-and-running/ch02.html#enumerated-types).

`--version`
: Display version information for dart2js.

The following options help you control the output of dart2js:

`--suppress-warnings`
: Don't display warnings.

`--suppress-hints`
: Don't display hints.

`--terse`
: Emit diagnostics, but don't suggest how to get rid of the diagnosed problems.

`-v` or `--verbose`
: Display lots of information.

The following options control the analysis that dart2js performs on Dart code:

`--analyze-all`
: Analyze even the code that isn't reachable from `main()`. This option
  is useful for finding errors in libraries, but using it can result in
  bigger and slower output.

`-analyze-only`
: Analyze the code, but don't generate code.

`--analyze-signatures-only`
: Like `--analyze-only`, but skip analysis of method bodies and field
  initializers.

`--enable-diagnostic-colors`
: Add colors to diagnostic messages.  

`--show-package-warnings`
: Show warnings and hints generated from packages.

`--csp`
: If true, disables dynamic generation of code in the generated output.
  This is necessary to satisfy CSP restrictions
  (see [W3C Content Security Policy](http://www.w3.org/TR/CSP/)).
  The default is false.

<aside class="alert alert-info" markdown="1">
**Version note:** Before Dart 1.8, the CSP version of JavaScript was generated
automatically, and saved with the extension `.precompiled.js`.
As of the 1.8 release, you must specify the CSP format using the `--csp` flag,
and the resulting file is saved with the normal `.js` extension.
</aside>

`--categories=Server`
: Use with `--analyze-only` to analyze a command-line app. The default
  category is `Client`, which tells dart2js to expect a web app. This option is only for dart2dart.

`--dump-info`
: Generates an `out.info.json` file with information about the generated code.
  You can inspect the generated file with the [viewer](http://dart-lang.github.io/dump-info-visualizer/build/web/viewer.html). 

`--output-type=dart`
: Output Dart code instead of JavaScript. If you are looking for dart2dart, use this option.    

## Helping dart2js generate better code {#helping-dart2js-generate-efficient-code}
            
You can do a couple of things to improve the code that dart2js generates:

* Write your code in a way that makes type inference easier.

* Once you’re ready to deploy your app, use the dart2js `--minify` option to
  reduce code size.

<aside class="alert alert-info" markdown="1">
**Note:**
Don’t worry about the size of your app’s included libraries. The dart2js tool
performs tree shaking to omit unused classes, functions, methods, and so on.
Just import the libraries you need, and let dart2js get rid of what you don’t
need.
</aside>

Follow these practices to help dart2js do better type inference, so it can generate smaller and faster JavaScript code:

* Avoid using the dart:mirrors library, directly or indirectly.  If you must
  use it, provide `@MirrorsUsed` annotations.

* Don't use `Function.apply()`.

* Don't override `noSuchMethod()`.

* Avoid setting variables to null.

* Be consistent with the types of arguments you pass into each function or
  method.

## Debugging {#debugging}
          
This section gives tips for debugging dart2js-produced code in Chrome, Firefox,
and Safari. Debugging the JavaScript produced by dart2js is easiest in
browsers such as Chrome that support source maps.

Whichever browser you use, you should enable pausing on at least
uncaught exceptions, and perhaps on all exceptions. For frameworks such
as dart:isolate and dart:async that wrap user code in try-catch, we
recommend pausing on all exceptions.
      
### Chrome {#dart2js-debugging-chrome}

To debug in Chrome:

1. Open the Developer Tools window, as described in the
   [Chrome DevTools documentation](https://developer.chrome.com/devtools/index).

2. Turn on source maps, as described in the video
   [SourceMaps in Chrome](http://bit.ly/YugIUY).

3. Enable debugging, either on all exceptions or only on uncaught exceptions,
   as described in [Pause on Uncaught
   Exceptions](https://developer.chrome.com/devtools/docs/javascript-debugging#pause-on-uncaught-exceptions).

4. Reload your application.
            
### Internet Explorer {#dart2js-debugging-ie}

To debug in Internet Explorer:

1. Update to the latest version of Internet Explorer. (Source-map support
   was added to IE in April 2014).

2. Load **Developer Tools** (**F12**). For more information, see
   [Using the F12 developer tools](http://msdn.microsoft.com/library/ie/bg182326(v=vs.85)).

3. Reload the application. The **debugger** tab shows source-mapped files.

4. Exception behavior can be controlled through **Ctrl+Shift+E**;
   the default is **Break on unhandled exceptions**.

### Firefox {#dart2js-debugging-firefox}

Firefox doesn’t yet support source maps (see [bug #771597](https://bugzilla.mozilla.org/show_bug.cgi?id=771597)).

To debug in Firefox:

<ol>
<li>Enable the Developer Toolbar, as described in Kevin Dangoor’s blog post,
   <a href="https://hacks.mozilla.org/2012/08/new-firefox-command-line-helps-you-develop-faster/">New Firefox Command Line Helps You Develop
   Faster"</a>.<br /><br /></li>
            
<li>Click <strong>Pause on exceptions</strong>, as shown in the
   following figure.<br /></li>
            
<img src="/tools/images/daur_0408.png" alt="Firefox Toolbar"><br /><br />

<li>Reload your application.</li>
</ol>

### Safari {#dart2js-debugging-safari}

To debug in Safari:

1. Turn on the Develop menu, as described in the [Safari Web Inspector Guide](https://developer.apple.com/library/safari/documentation/AppleApplications/Conceptual/Safari_Developer_Guide/GettingStarted/GettingStarted.html#//apple_ref/doc/uid/TP40007874-CH2-SW1).

2. Enable breaks, either on all exceptions or only on uncaught exceptions. See Figure 4-2 on the Safari [Debugging](https://developer.apple.com/library/safari/documentation/AppleApplications/Conceptual/Safari_Developer_Guide/Debugger/Debugger.html#//apple_ref/doc/uid/TP40007874-CH5-SW1) page.

3. Reload your application.
