---
layout: default
title: "Installing the Dart SDK on Mac"
description: "Installing and updating Dart on your Mac."
---

{% include breadcrumbs.html %}

# {{ page.title }}

The Dart SDK contains the VM, analyzer, formatter, dart2js compiler,
documentation generator, package manager, and the core libraries.

We recommend using [Homebrew](#homebrew)
to manage your Dart installation.
Another option is [downloading Dart manually](#zip).


## Installing and upgrading with Homebrew {#homebrew}

Homebrew is a package manager for Mac OS.
With [Homebrew](http://brew.sh/),
installing and updating Dart is easy.

### Installing Dart {#homebrew-install-dart}

[Install homebrew](http://brew.sh/), and then run:

{% prettify huge %}
$ brew tap dart-lang/dart
$ brew install dart
{% endprettify %}

If you use Dart for web development work, we recommend that you also
install Dartium and Content Shell:

{% prettify huge %}
$ brew tap dart-lang/dart
$ brew install dart --with-content-shell --with-dartium
{% endprettify %}

### Installing dev-channel releases

To get early access to new features and fixes,
you can use the dev-channel. Head's up: dev-channel
releases are not as heavily tested as the stable release.

To choose the dev channel version of whatever Dart software you install,
use `--devel`:

{% prettify huge %}
$ brew install dart --devel
{% endprettify %}

You can use any combination of the
`--devel`,
`--with-dartium`, and
`--with-content-shell` options.


#### Installation locations

Many tools, such as editors, ask you to specify the Dart SDK
installation directory and the location of Dartium.
Homebrew uses the following locations,
where you replace `HOMEBREW_INSTALL` with the
the homebrew installation directory
(which you can get using `brew --prefix`):

* SDK directory: `HOMEBREW_INSTALL/opt/dart/libexec`
* Dartium: `HOMEBREW_INSTALL/opt/dart/Chromium.app`


### Updating Dart {#homebrew-update-dart}

To update Dart once you've installed it using Homebrew, run:

{% prettify huge %}
$ brew update
$ brew upgrade dart
{% endprettify %}

{% comment %}
PENDING: clarify what arguments you should supply,
depending on what arguments you used before.
{% endcomment %}


### Specifying a custom installation location {#homebrew-custom-location}

By default, Homebrew downloads to `/usr/local`.
If your Mac is set up so that installing to `/usr/local` requires
using `sudo`, we recommend
downloading to another location where you have write permissions, such
as your home directory.

1. Go to the directory above where you want
   Homebrew and Dart to live.
   For example, if you want Homebrew and Dart to live under
   `~/homebrew`, go to `~`.

   {% prettify none %}
   $ cd ~    # The directory that will contain Homebrew and Dart
   {% endprettify %}

2. Clone Homebrew. This creates a `homebrew` directory.

   {% prettify none %}
   $ git clone https://github.com/Homebrew/homebrew.git
   {% endprettify %}

3. Add the `homebrew/bin` directory to your PATH.

4. Follow the `brew` instructions in
[Installing Dart](#homebrew-install-dart).
Dart will be installed under `homebrew`.


## Downloading the Dart SDK manually {#zip}

Follow these steps to download Dart manually.
You'll need to download it again
whenever you need the latest APIs and bug fixes.

1. <a
    data-bits="32" data-os="macos" data-tool="sdk"
    class="download-link"
    href="{{ site.custom.downloads.dartarchive-stable-url-prefix }}/latest/sdk/dartsdk-macos-ia32-release.zip">
   Download the Dart SDK.</a>
   Unzip the downloaded file to get the SDK.

   <aside class="alert alert-info" markdown="1">
   **Other downloads:**
   If you need a bigger heap or access to much more memory,
   download the <a
    data-bits="64" data-os="macos" data-tool="sdk"
    class="download-link"
    href="{{ site.custom.downloads.dartarchive-stable-url-prefix }}/latest/sdk/dartsdk-macos-x64-release.zip">
   64-bit Dart SDK</a>.
   You can download other releases from the
   [download index](/downloads/archive/).
   </aside>

2. Add `<sdk>/bin` to your `PATH`.

3. If you're developing a web app, <a
    data-bits="32" data-os="macos" data-tool="dartium"
    class="download-link"
    href="{{ site.custom.downloads.dartarchive-stable-url-prefix }}/latest/dartium/dartium-macos-ia32-release.zip">
  download Dartium</a>.
  Unzip it to get a special version of
  [Chromium with the Dart VM](/tools/dartium/).
  This binary expires after 1 year. When that happens,
  you'll need to download a new copy to continue using Dartium.
