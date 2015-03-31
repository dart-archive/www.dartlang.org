---
layout: default
title: "Installing Dart on Mac"
description: "Installing and updating Dart on your Mac."
---

{% include breadcrumbs.html %}

# {{ page.title }}

We recommend using Homebrew
to manage your Dart installation.

{% comment %}
[PENDING: link to other options. Put everything under a download directory? test dev channel info]
{% endcomment %}


## Using Homebrew {#homebrew}

If you have [Homebrew](http://brew.sh/),
installing and updating Dart is easy.
You can also specify a custom location for Dart.


### Installing Dart {#homebrew-install-dart}

To install Dart, run:

{% prettify huge %}
$ brew tap dart-lang/dart
$ brew install dart dartium
{% endprettify %}

The **dart** package contains the [Dart SDK](/tools/sdk/),
which includes the Dart VM, libraries, and command-line Dart tools such as
[dart](/tools/dart-vm/), [dart2js](/tools/dart2js/),
[dartanalyzer](/docs/dart-up-and-running/contents/ch04-tools-dart_analyzer.html),
[pub](/tools/pub/), and [dartdocgen](/tools/dartdocgen/).

<aside class="alert alert-info" markdown="1">
**Want the dev channel?**
To install dev channel releases instead of stable releases,
add `--devel` after `brew` commands:
`brew install dart --devel`
</aside>

The **dartium** package contains a special build of Chromium
(nicknamed [Dartium](/tools/dartium/)) that includes a Dart VM.
Use it to test and
debug Dart web apps without first compiling them to JavaScript.

<aside class="alert alert-info" markdown="1">
**Writing server-side code?**
If you don't write Dart web apps,
you don't need to install `dartium`.
</aside>


### Updating Dart {#homebrew-update-dart}

To update Dart once you've installed it using Homebrew, run:

{% prettify huge %}
$ brew update
$ brew upgrade dart dartium
{% endprettify %}


### Specifying a custom location

By default, Homebrew downloads to `/usr/local`. This requires using
`sudo` to handle issues with file permissions. If you prefer, you can
download to another location where you have write permissions, such
as your home directory.

1. Go to the directory above where you want
   Homebrew and Dart to live.
   For example, if you want Homebrew and Dart to live under
   `~/homebrew`, go to `~`.

   {% prettify sh %}
   $ cd ~    # The directory that will contain Homebrew and Dart
   {% endprettify %}

2. Clone Homebrew. This creates a `homebrew` directory.

   {% prettify none %}
   $ git clone https://github.com/Homebrew/homebrew.git
   {% endprettify %}

3. Add the `homebrew/bin` directory to your PATH.

4. Follow the `brew` instructions at the beginning of
[Step 1](#install-dart). Dart will be installed under `homebrew`.


## Downloading Dart manually

You'll need to perform the following steps
periodically to update your software.

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
   [download archive](/tools/download-archive/).
   </aside>

2. Add `<sdk>/bin` to your `PATH`.

3. If you're developing a web app, <a
    data-bits="32" data-os="macos" data-tool="dartium"
    class="download-link"
    href="{{ site.custom.downloads.dartarchive-stable-url-prefix }}/latest/dartium/dartium-macos-ia32-release.zip">
  download Dartium</a>.
  Unzip it to get special version of
  [Chromium with the Dart VM](/tools/dartium/).
  This binary expires after 1 year. When that happens,
  you need to download a new copy to continue using Dartium.
