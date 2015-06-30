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
**Warning:** This browser is intended for Dart development.
As a reminder, the following message appears on launch:
"You are using an unsupported command-line flag:
--no-sandbox. Stability and security will suffer."

**Do not use Dartium as your primary browser,
and do not distribute Dartium to users!**
</aside>

To learn about other tools you can use for Dart development,
see [Dart Tools](/tools/).

## Getting Dartium

If you use [Homebrew on the Mac](/downloads/mac.html),
you can include Dartium as part of the Dart SDK download.

Otherwise, you can download Dartium directly:

* <a
    data-bits="32" data-os="windows" data-tool="dartium"
    class="download-link"
    href="{{ site.custom.downloads.dartarchive-stable-url-prefix }}/latest/dartium/dartium-windows-ia32-release.zip">Dartium for Windows</a>
* <a
    data-bits="64" data-os="linux" data-tool="dartium"
    class="download-link"
    href="{{ site.custom.downloads.dartarchive-stable-url-prefix }}/latest/dartium/dartium-linux-x64-release.zip">Dartium for Linux</a>
* <a
    data-bits="32" data-os="macos" data-tool="dartium"
    class="download-link"
    href="{{ site.custom.downloads.dartarchive-stable-url-prefix }}/latest/dartium/dartium-macos-ia32-release.zip">Dartium for Mac</a>

For other versions of Dartium, including dev channel releases, see the
[download index](/downloads/archive/).

<aside class="alert alert-info" markdown="1">
**Note:**
The Dartium binary expires after 1 year. When that happens,
you’ll need to download a new binary.
</aside>

## Installing Dartium

You don’t usually need to do anything special to install Dartium.
However, you may need to configure your IDE so that it can find Dartium.
In WebStorm, for example, you can do this
in **Preferences** > **Languages & Frameworks** > **Dart**.
In the **Dartium path** field,
type or browse to the location of the **Chromium** executable.

<aside class="alert alert-info" markdown="1">
**Note**: While this tool is _referred to_ as Dartium,
the executable is named `Chromium`.
</aside>

## Launching Dartium

To launch Dartium, navigate to its directory in your finder, and
double-click the Chromium executable file. Or launch a web app
from your IDE, or at the command line as described in
[Using command-line flags](#using-command-line-flags).

<aside class="alert alert-warning" markdown="1">
**Warning if you already use Chromium:**
If another version of Chromium is open,
then you could have a profile conflict. To avoid this, you can open
Dartium or Chromium from the command line with the [--user-data-dir
flag.](http://www.chromium.org/user-experience/user-data-directory)
</aside>

## Linking to Dart source

Use a script tag with a type `application/dart` to link to your main Dart
source file. Example:

{% prettify html %}
<!DOCTYPE html>
<html>
  <body>
    <script type="application/dart" src="main.dart"></script>

    <!-- Support for non-Dart browsers. -->
    <script src="packages/browser/dart.js"></script>
  </body>
</html>
{% endprettify %}

<aside class="alert alert-info" markdown="1">
**Note:**
If your IDE or code editor uses the 
[Stagehand](https://pub.dartlang.org/packages/stagehand)
project generator to create sample content, these script tags
are added for you in the generated code.
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

To see existing issues, view 
[Dartium bugs in the SDK project](https://github.com/dart-lang/sdk/labels/Area-Dartium).
You can file a bug on 
[GitHub](https://github.com/dart-lang/sdk/issues).
