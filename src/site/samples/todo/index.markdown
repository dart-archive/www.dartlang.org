---
layout: default
title: Adding Elements to the DOM
live_example_url: /docs/tutorials/add-elements/examples/todo/todo.html
header:
  css: ["/samples/samples.css"]
---

## {{ page.title }}

Enter text in the input field and press return.

This app shows how to programmatically add an element to the DOM.

In this example, when you press return, the event handler for the input
field creates a new <li> element and adds it to an existing <ul> list in the
DOM tree. When the DOM tree changes, the web page refreshes.

Read this [tutorial](/docs/tutorials/add-elements/) for
more detail, or read the
[source](https://github.com/dart-lang/dart-tutorials-samples/tree/master/web/todo).

<iframe class="running-app-frame"
        style="height:400px;width:40%;"
        src="{{page.live_example_url}}">
</iframe>

See all [samples](/samples/).
