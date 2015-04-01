---
layout: default
title: "Dartium: Chromium with the Dart VM"
short-title: "Dartium"
description: "Download and use Dartium, a build of Chromium with an embedded Dart VM."
has-permalinks: false
---

{% include toc.html %}
{% include breadcrumbs.html %}

# {{ page.title }}

Dartium is a special build of Chromium that includes the Dart VM.
Using Dartium means you don't have to compile your code to JavaScript
until you're ready to test on other browsers.

<aside class="alert alert-warning" markdown="1">
**Warning:** This browser is a technical preview,
and it might have security and stability issues.
**Do not use Dartium as your primary browser,
and do not distribute Dartium to users!**
</aside>

To learn about other tools you can use for Dart development,
see [Dart Tools](/tools/).

## Getting Dartium

If you have an up-to-date version of [Dart Editor](/tools/editor/),
you already have Dartium.

Otherwise, you can <a href="/tools/download.html">download Dartium</a> directly.

<aside class="alert alert-info" markdown="1">
**Note:**
The Dartium binary expires after 1 year. When that happens,
you’ll need to download a new binary unless you're using the
Dartium binary that comes with Dart Editor.
(Dart Editor automatically updates its Dartium binary.)
</aside>

## Installing Dartium

You don’t usually need to do anything special to install Dartium:
just unarchive the ZIP file.
If you want Dart Editor to launch a particular copy of Dartium,
then put that copy inside the `dart-sdk` directory
of your Dart Editor installation directory,
replacing its original copy of Chromium.

<aside class="alert alert-info" markdown="1">
**Note**: While this tool is _referred to_ as Dartium,
the executable is named `Chromium`. In the Dart Editor bundle,
it is located in the `chromium` directory.
</aside>

## Launching Dartium

To launch Dartium, navigate to its directory in your finder, and
double-click the Chromium executable file. Or launch a web app
in Dart Editor, or at the command line as described in
[Using command-line flags](#using-command-line-flags).

<aside class="alert alert-warning" markdown="1">
**Warning if you already use Chromium:**
If another version of Chromium is open,
then you could have a profile conflict. To avoid this, you can open
Dartium or Chromium from the command line with the [--user-data-dir
flag.](http://www.chromium.org/user-experience/user-data-directory)
</aside>

## Linking to Dart source

Use a script tag with a type `application/dart` to link to your Dart
source file. Example:

{% prettify html %}
<!DOCTYPE html>
<html>
  <body>
    <script type="application/dart" src="app.dart"></script>

    <!-- Support for non-Dart browsers. -->
    <script src="packages/browser/dart.js"></script>
  </body>
</html>
{% endprettify %}

<aside class="alert alert-info" markdown="1">
**Note:**
Dart Editor automatically adds both the `application/dart` script tag
and the `dart.js` script tag into the project’s main HTML file.
</aside>

For more information on linking to source code, see the article
[Embedding Dart in HTML.](/articles/embedding-in-html/)

## Advanced use cases

This section contains advanced information. If you need to detect whether
Dart is supported in the browser, set the API keys in order to use one
of the Google APIs, or specify Dartium flags at the command line,
read on. Otherwise, you can skip this section.

### Detecting Dart support

You can check whether a browser supports Dart with this JavaScript code:

{% prettify js %}
// In JavaScript code:
if (navigator.userAgent.indexOf('(Dart)') == -1) {
  // No native Dart support...
  window.addEventListener("DOMContentLoaded", function (e) {
      // ...Fall back to compiled JS...
    }
  }, false);
}
{% endprettify %}

### Setting API keys

To use some features in the Google APIs, such as geolocation 
from the Google Maps API, you need to set the API keys in Dartium.
You can either build a special version of Dartium with the API
keys baked in, or you can specify the keys at runtime.
For more information on how to acquire and use API keys, see
[API Keys](http://www.chromium.org/developers/how-tos/api-keys).

### Using command-line flags

Because Dartium is based on Chromium, all [Chromium
flags](http://www.chromium.org/developers/how-tos/run-chromium-with-flags)
should work. In some cases, you might want to specify Dart-specific
flags so that you can tweak the embedded Dart VM’s behavior. For
example, while developing your web app, you might want the VM to verify
type annotations and check assertions. To achieve that, you can enable
checked mode (the VM’s `--checked` flag).

On Linux, you can specify flags by starting Dartium as follows:

{% prettify sh %}
DART_FLAGS='--checked' path/chrome
{% endprettify %}

On Mac:

{% prettify sh %}
DART_FLAGS='--checked'              \
  path/Chromium.app/Contents/MacOS/Chromium
{% endprettify %}

Or (also on Mac):

{% prettify sh %}
DART_FLAGS='--checked'              \
   open path/Chromium.app
{% endprettify %}

<aside class="alert alert-info" markdown="1">
**Note:**
You can see the command-line flags and executable path of any
Chromium-based browser by going to `chrome://version`.
</aside>

## Filing bugs and feature requests

To file a bug, use the
[Dartium issue template](https://code.google.com/p/dart/issues/entry?template=Defect%20report%20for%20Dartium).
To see existing issues, go to the
[Dartium issue list](https://code.google.com/p/dart/issues/list?can=2&amp;q=label%3AArea-Dartium).
