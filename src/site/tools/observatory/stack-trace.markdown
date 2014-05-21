---
layout: default
title: "Stack Trace"
description: "Use Observatory's Stack Trace screen to get a snapshot of the sequence of nested function calls for your Dart application."
header:
  css: ["observatory.css"]
---

{% include breadcrumbs.html %}

# {{ page.title }}

<h4>Contents</h4>
<ol class="toc">
  <li> <a href="#overview">Overview</a> </li>
  <li> <a href="#no-stack">What does "No stack" mean?</a> </li> 
  <ol>
    <li> <a href="#standalone-apps">Standalone apps</a> </li> 
    <li> <a href="#web-apps">Web apps</a> </li> 
  </ol>
</ol>

## Overview {#overview}

The Stack Trace screen displays the active stack frames,
as a tree, for any isolate. To get to the stack trace,
choose the **stack trace** link on the VM screen, or on
an isolate screen, or from the pulldown menu on the
isolate's name in the blue bar.

The following screenshot shows a stack trace for the root isolate
of a simple standalone application:

<img src="images/StackTrace.png" alt="A sample stack trace">

You can expand nodes in the tree to see more information:

<img src="images/StackTraceExpanded.png" alt="A sample stack trace, with one of the nodes expanded">

Sometimes you might see a _No stack_ message when you request a
stack trace.

## What does "No stack" mean? {#no-stack}

A _No stack_ message occurs if the isolate is idle at the time of the request.

### Standalone apps {#standalone-apps}

Perhaps you've specified the `--pause-isolate-on-start` or 
`--pause-isolate-on-exit` option when starting your app.
A _No stack_ message occurs if the isolate is paused.

### Web apps {#web-apps}

A web app, by definition, displays inside of a browser.
The browser, not Dart, performs the drawing code.
Perhaps you have an app that performs animations and you are using
Observatory inside of Dartium to examine your app.
The CPU is likely to spend more time performing the
drawing for the animation than it spends inside your Dart code. 

A _No stack_ message occurs if the request is made while the CPU
is updating the display. If you continue to refresh the screen,
a stack trace eventually appears if that isolate is still performing work.

{% include observatory_new_fyi.html %}

