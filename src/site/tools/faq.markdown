---
layout: default
title: "Tools FAQ"
description: "FAQ and other tips for using Dart Tools."
has-permalinks: false
---

# {{ page.title }}

I am having trouble running the Linux distribution of Dart on my Linux platform.
: Some flavors of Linux require that you manually build the Dart SDK.
  This may require that you update to a more recent version of
  the GCC library.
  The following resources may be useful: 

  * [Building Dart on CentOS, Red Hat, Fedora and Amazon Linux AMI](https://code.google.com/p/dart/wiki/BuildingOnCentOS)
  * [Building Dart SDK on Ubuntu 10.04 Server](https://code.google.com/p/dart/wiki/BuildDartSDKOnUbuntu10_04)
  <br /><br />

Can all Dart files be put into a source code repository?
: Dart tools generate some files that should be local only.
  The [What Not to Commit](/tools/private-files.html) page
  has some advice on what not to put into your source repo.
  <br /><br />

How do you debug an app once it has been compiled to JavaScript?
: Dart web apps are easiest to debug with Dart Editor
  and Dartium. However, the [Debugging code produced by dart2js](/docs/dart-up-and-running/contents/ch04-tools-dart2js.html#tools-dart2js-debugging)
  page has some tips for specific browsers.
  <br />

**What other tools should I know about?**

  * [HOP](http://pub.dartlang.org/packages/hop) - task framework
  <br /><br />

