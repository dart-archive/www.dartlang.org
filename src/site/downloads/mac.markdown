---
layout: default
title: "Installing the Dart SDK on Mac"
description: "Installing and updating Dart on your Mac."
---

{% include breadcrumbs.html %}

# {{ page.title }}

We recommend using Homebrew
to manage your Dart installation.
Another option is [downloading Dart manually](#zip).


## Using Homebrew {#homebrew}

With [Homebrew](http://brew.sh/),
installing and updating Dart is easy.
You can use the default location or
[specify a custom location for Dart](#homebrew-custom-location).
If you're developing a web app,
you should also [install Dartium](#homebrew-install-dartium).


### Installing the Dart SDK {#homebrew-install-dart}

The **dart** package contains the [Dart SDK](/tools/sdk/),
which includes the Dart VM, libraries, and command-line Dart tools such as
[dart](/tools/dart-vm/), [dart2js](/tools/dart2js/),
[dartanalyzer](/docs/dart-up-and-running/contents/ch04-tools-dart_analyzer.html),
[pub](/tools/pub/), and [dartdocgen](/tools/dartdocgen/).

To install Dart, run:

{% prettify huge %}
$ brew tap dart-lang/dart
$ brew install dart
{% endprettify %}

<aside class="alert alert-info" markdown="1">
**Want the dev channel?**
To install dev channel releases instead of stable releases,
add `--devel`:
`brew install dart --devel`
</aside>

#### SDK location

Many tools, such as editors, ask you to specify the Dart SDK
installation directory. If you installed Dart SDK via homebrew,
you should use `HOMEBREW_INSTALL/opt/dart/libexec` as the SDK
directory. Be sure to replace `HOMEBREW_INSTALL` with the location
where homebrew installs software, which is often `/usr/local`.

### Updating the Dart SDK {#homebrew-update-dart}

To update Dart once you've installed it using Homebrew, run:

{% prettify huge %}
$ brew update
$ brew upgrade dart
{% endprettify %}


### Installing Dartium {#homebrew-install-dartium}

The **dartium** package contains a special build of Chromium
(nicknamed [Dartium](/tools/dartium/)) that includes a Dart VM.
Use it to test and
debug Dart web apps without first compiling them to JavaScript.

To install Dartium, run:

{% prettify huge %}
$ brew tap dart-lang/dart
$ brew install dartium
{% endprettify %}

<aside class="alert alert-info" markdown="1">
**Want the dev channel?**
`brew install dartium --devel`
</aside>

To update Dartium, run:

{% prettify huge %}
$ brew update
$ brew upgrade dartium
{% endprettify %}


### Specifying a custom location {#homebrew-custom-location}

By default, Homebrew downloads to `/usr/local`, which might require using
`sudo` to handle issues with file permissions. If you prefer, you can
download to another location where you have write permissions, such
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
