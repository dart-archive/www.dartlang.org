---
layout: default
title: "Observatory: A Profiler for Dart Apps"
description: "Observatory is a tool for profiling and debugging your Dart application."
snippet_img: "images/AllocationProfileScreen.png"
short-title: "Observatory"
header:
  css: ["observatory.css"]
---

# {{ page.title }}

Observatory is a tool for profiling and debugging your
Dart applications.

{% include observatory_new_fyi.html %}

Observatory allows you to peek inside a running Dart virtual 
machine (VM) on demand and provides live, immediate reporting of data.
You can use it to browse most aspects of an application.
Some of Observatory's features allow you to:

- Determine where an **app is spending its time**.
- Examine **allocated memory**.
- See which lines of **code have executed**.
- Debug **memory leaks**.
- Debug **memory fragmentation**.

You can use Observatory to examine the internals of a running 
Dart VM in real time, at any time.

In the following video, recorded at the recent
[Dart Developer Summit](/events/2015/summit/),
John McCutchan and Todd Turnidge show how
to profile and debug a Dart applicaton.

<iframe style="display:block;margin: 0 auto;" width="560" height="315" src="https://www.youtube.com/embed/y39pZCExsOs?list=PLOU2XLYxmsIIQorIS8gagUiMau9S84vZV" frameborder="0" allowfullscreen></iframe>

## Using Observatory

To get started with Observatory, read the following:

* [Getting Started with Observatory](get-started.html)

To learn about specific features, read these pages:

* [Allocation Profile](allocation-profile.html)
* [Code Coverage](code-coverage.html)
* [CPU Profile](cpu-profile.html)
* [Debugger](debugger.html)
* [Evaluating Expressions](evaluate.html)
* [Heap Map](heap-map.html)
* [Isolate](isolate.html)
* [Metrics](metrics.html)
* [User and VM Tags](tags.html)

The following pages have reference information about Observatory:

* [dart: The Standalone VM](/tools/dart-vm/#observatory)
* [Glossary of VM Terms](glossary.html)
* [Screens in Observatory](screens.html)

## Support and discussion

Join the [Observatory discussion mailing list][list] to ask questions and chat
with users.

## Filing bugs and feature requests

To see existing issues or create a new one directly, see all
[Observatory issues](https://github.com/dart-lang/sdk/labels/Area-Observatory).

{% include observatory_footer.html %}

[list]: https://groups.google.com/a/dartlang.org/forum/#!forum/observatory-discuss
