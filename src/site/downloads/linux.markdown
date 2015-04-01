---
layout: default
title: "Installing the Dart SDK on Linux"
description: "Installing and updating Dart on Linux."
js:
- url: /js/download-info.js
  defer: true
---

{% comment %}
  NO toc.html include because it breaks the buttons
{% endcomment %}
{% include breadcrumbs.html %}

# {{ page.title }}

If you're using Debian/Ubuntu, you can choose two options,
both of which can update the SDK automatically
when new versions are released.

* [Installing using apt-get](#install-with-apt-get)
* [Downloading the Debian package](#download-debian-package)

Other options are:

* [Downloading Dart manually](#other)
* [Compiling Dart from source](#compiling)


## Using apt-get {#install-with-apt-get}

To install the Dart SDK with apt-get, you first need to do some setup.

### Setting up for the stable channel {#set-up-stable-channel}

The following one-time commands set up the install for the stable channel.

{% prettify sh %}
# Enable HTTPS for apt.
$ sudo apt-get update
$ sudo apt-get install apt-transport-https
# Get the Google Linux package signing key.
$ sudo sh -c 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
# Set up the location of the stable repository.
$ sudo sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
$ sudo apt-get update
{% endprettify %}


### Setting up for the dev channel {#set-up-dev-channel}

The following one-time command sets up the install for the dev channel.
Do this in addition to the [set up for stable channel](#set-up-stable-channel).

{% prettify sh %}
# Before running this command, follow the instructions in
# "Set up for the stable channel".
$ sudo sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_unstable.list > /etc/apt/sources.list.d/dart_unstable.list'
{% endprettify %}


### Installing the SDK {#install-dart-sdk}

The following command installs the highest available version
of the Dart SDK, based on your setup.

{% prettify sh %}
$ sudo apt-get install dart
{% endprettify %}

If you have set up your environment for both the stable and dev channel
releases, the previous command always installs the dev channel, as that
has a higher version number.
If you want to install the stable channel instead of the dev channel,
or to install a specific version number, see the next section.


### Installing a specific version {#install-specific-version}

The dev channel has a higher version number than the stable channel.
To force installation of the stable version, use the following command.

{% prettify sh %}
$ sudo apt-get install dart/stable
{% endprettify %}

To install a particular release, specify the version.
For example:

{% prettify sh %}
$ sudo apt-get install dart=1.5.8-1
$ sudo apt-get install dart=1.6.*
$ sudo apt-get install dart=1.7.0-dev.0.1.*
{% endprettify %}


## Downloading as a Debian package {#download-debian-package}

Use one of the following buttons to download the stable or
dev channel release in the `.deb` package format.

{% include downloads/_debian.html buttonclass="download-btn btn btn-primary btn-lg" %}

## Installing from a zip file {#other}

You can manually download and extract the Dart SDK from a zip file:

<div class="downloads download-buttons">
{% capture platform_name %}64-bit Linux{% endcapture %}
{% include downloads/_sdk-button.html name=platform_name buttonclass=btn-primary bits="64" os="linux" arch="x64" %}

{% capture platform_name %}32-bit Linux{% endcapture %}
{% include downloads/_sdk-button.html name=platform_name buttonclass=btn-primary bits="32" os="linux" arch="ia32" %}
</div>

<br >

<aside class="alert alert-info" markdown="1">
 **Other versions:**
 You can download other releases from the
 [download index](/downloads/archive/).
</aside>

If you're creating Dart web apps, also download Dartium:

<p>
<div class="downloads download-buttons">
{% include downloads/_dartium.html name="Linux" buttonclass=btn-primary bits="64" os="linux" arch="x64" %}
</div>
</p>

The Dartium binary expires after 1 year.
When that happens, you need to
download a new copy to continue using Dartium.


## Compiling from source {#compiling}

You can [build the SDK](https://code.google.com/p/dart/wiki/Building) yourself.
If your system uses an older version of Ubuntu,
you might need to update to GCC 4.6 or later.
See the [Tools FAQ](/tools/faq.html) for more information.
