---
layout: default
title: "Dart Plugin for Eclipse"
description: "Use Dart in the Eclipse IDE."
has-permalinks: false
---

{% include toc.html %}
{% include breadcrumbs.html %}
  
# {{ page.title }}

The Dart plugin for Eclipse
provides much of the functionality of Dart Editor
within your existing Eclipse installation.
The Eclipse plugin is not supported on Windows.
**Do not use the Eclipse plugin on Windows.**
To learn about other tools you can use for Dart development,
see [Dart Tools](/tools/).

<aside class="alert alert-info" markdown="1">
**Note:**
Your version of Eclipse must be **3.7, 3.8, or 4.X**.
</aside>


## Getting and installing the Dart plugin

In Eclipse, choose **Help > Install new software...**
and add this URL:

    http://www.dartlang.org/eclipse/update/channels/stable/

<aside class="alert alert-info" markdown="1">
**Important:** Click **OK** if, when you're installing this plugin,
you see a security dialog that states,
  "Warning: You are installing software that contains unsigned content.
  The authenticity or validity of this software cannot be established.
  Do you want to continue with this installation?"

  This warning occurs because the Eclipse plugin is not signed.
</aside>

Want to get new features a few weeks earlier than
users on the stable channel? Try the dev channel:

    http://www.dartlang.org/eclipse/update/channels/dev/

After Eclipse installs the plugin and downloads the latest SDK,
restart Eclipse.

## Getting Dartium

To run and debug Dart applications natively,
you must install a copy of [Dartium](/tools/dartium/)
(a Chromium build with a Dart VM) into Eclipse.
The Dartium executable expires after 1 year, and a new stable version
of Dart is released approximately every 6 weeks,
so you should update Dartium, the plugin, and the SDK periodically.

To install or update Dartium,
first open the Eclipse **Preferences** dialog and
go to the **Dart > SDK** page.
Its Dartium section tells you:

* Whether Dartium is currently installed
* Where to install Dartium
* The URL where you can download [Dartium](/tools/dartium/)

## Updating the SDK

Every time you update Dartium or the Dart plugin,
you should also update the Dart SDK.

To update, go to the **Preferences** dialog's **Dart < SDK** page,
and click the **Upgrade SDK** button.
That page also shows current version of the SDK that is installed.

## Filing bugs and feature requests

To see existing issues or create a new one, go to the
[plugin issue list](https://code.google.com/p/dart/issues/list?can=2&amp;q=Editor%3DPlugin).
Because the plugin shares much of its code with
[Dart Editor](/tools/editor/), you might also want to check
[Dart Editor issues](https://code.google.com/p/dart/issues/list?can=2&amp;q=label%3AArea-Editor).
