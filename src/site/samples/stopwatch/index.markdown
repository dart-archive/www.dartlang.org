---
layout: default
title: Defining a Custom Element
live_example_url: /docs/tutorials/polymer-intro/examples/stopwatch/out/web/index.html
header:
  css: ["/samples/samples.css"]
---

## {{ page.title }}

Start and stop the stopwatch. Reset the stopwatch to 00:00 using the Reset
button.

This example shows how to implement a custom element using Polymer.

In this example, the stopwatch is a custom element. The definition of a custom
element encapsulates and hides the implementation details. With custom
elements, you can easily create new kinds of elements that have semantically
meaningful tags and that are easy to share, reuse, and read. For example, to
put a stopwatch element on the page, you write:

`<tute-stopwatch></tute-stopwatch>`

The counting text is a String in Dart that changes dynamically based on a
Timer. Polymer’s one-way data binding feature keeps the UI in sync with the
data as it changes.

Declarative event handler binding lets you set up event handlers for UI
elements on the HTML-side.

Read this [tutorial](/docs/tutorials/polymer-intro) for
more detail, or read the
[source](https://github.com/dart-lang/dart-tutorials-samples/tree/master/web/stopwatch).


<iframe class="running-app-frame"
        style="height:300px;width:300px;"
        src="{{page.live_example_url}}">
</iframe>

See all [samples](/samples/).
