---
layout: default
title: "Dart SDK for Debian and Ubuntu with Apt"
description: "Installing the Dart SDK on your Debian or Ubuntu machine is easy with Apt."
has-permalinks: false
js:
- url: /js/download-info.js
  defer: true
---

# {{ page.title }}

If you are developing Dart apps on your Debian or Ubuntu machine
(perhaps you are writing server-side code),
you can get a 64-bit version of the
SDK that allows for easy installation of the Dart VM and tools.

<aside class="alert alert-info" markdown="1">
**Note:** 
These instructions are for the Dart SDK only. To download Dartium
or Dart Editor, use the [download](/tools/download.html) page.
</aside>

You can install the **stable channel** release, the **dev channel** release,
or both.  (The dev channel is also referred to as _unstable_.)
The dev channel allows you to try new features ahead of the stable release.

Depending on how you prefer to manage your downloads, you can
[install using apt-get](#install-with-apt-get) or you can
[download the Debian package](#download-debian-package). Either way,
your package manager can update the SDK automatically when new
versions are released.

## Using apt-get to install the Dart SDK {#install-with-apt-get}

These instructions use the Advanced Packaging Tool (apt).

To install the Dart SDK with apt-get, you first need to do some setup.

### Set up for the stable channel {#set-up-stable-channel}

The following one-time commands set up the install for the stable channel.

{% prettify lang-sh %}
# Enable HTTPS for apt.
$ sudo apt-get update
$ sudo apt-get install apt-transport-https
# Get the Google Linux package signing key.
$ sudo sh -c 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
# Set up the location of the stable repository.
$ sudo sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
$ sudo apt-get update
{% endprettify %}

### Set up for the dev channel {#set-up-dev-channel}

The following one-time command sets up the install for the dev channel.
Do this in addition to the [set up for stable channel](#set-up-stable-channel).

{% prettify lang-sh %}
# Before running this command, follow the instructions in
# "Set up for the stable channel".
$ sudo sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_unstable.list > /etc/apt/sources.list.d/dart_unstable.list'
{% endprettify %}

### Install the Dart SDK {#install-dart-sdk}

The following command installs the highest available version 
based on your setup.

{% prettify lang-sh %}
$ sudo apt-get install dart
{% endprettify %}

If you have set up your environment for both the stable and dev channel
releases, the previous command always installs the dev channel, as that
has a higher version number.
If you want to install the stable channel instead of the dev channel,
or a specific version number, see the next section.

### Install a specific version {#install-specific-version}

The dev channel has a higher version number than the stable channel.
To force installation of the stable version, use the following command.

{% prettify lang-sh %}
$ sudo apt-get install dart/stable
{% endprettify %}

To install a particular release, specify the version,
as shown in the following examples.

{% prettify lang-sh %}
$ sudo apt-get install dart=1.5.8-1
$ sudo apt-get install dart=1.6.*
$ sudo apt-get install dart=1.7.0-dev.0.1.*
{% endprettify %}

## Downloading the Dart SDK as a Debian package {#download-Debian-package}

Use one of the following buttons to download the stable or
dev channel release in the `.deb` package format.

{% include downloads/_debian.html buttonclass="btn btn-primary btn-lg" %}

