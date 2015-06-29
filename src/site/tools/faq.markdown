---
layout: default
title: "Tools FAQ"
short-title: "FAQ"
description: "FAQ and other tips for using Dart Tools."
has-permalinks: false
---

{% include breadcrumbs.html %}

# {{ page.title }}

I am having trouble running the Linux distribution of Dart on my Linux platform.
: Some flavors of Linux require that you manually build the Dart SDK.
  This may require that you update to a more recent version of
  the GCC library.
  The following resources may be useful: 

  * [Building Dart on CentOS, Red Hat, Fedora and Amazon Linux AMI](https://github.com/dart-lang/sdk/wiki/Building-Dart-on-CentOS,-Red-Hat,-Fedora-and-Amazon-Linux-AMI)
  * [Building Dart SDK on Ubuntu 10.04 Server](https://github.com/dart-lang/sdk/wiki/Building-Dart-SDK-on-Ubuntu-10.04-Server)


Can all Dart files be put into a source code repository?
: Dart tools generate some files that should be local only.
  The [What Not to Commit](/tools/private-files.html) page
  has some advice on what not to put into your source repo.


How do you debug an app once it has been compiled to JavaScript?
: Dart web apps are easiest to debug with an IDE, like WebStorm,
  and Dartium. However,
  the [debugging](/tools/dart2js/#debugging)
  section of the dart2js documentation
  has some tips for specific browsers.

