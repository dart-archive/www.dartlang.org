---
layout: default
title: Removing Elements from the DOM
live_example_url: /docs/tutorials/remove-elements/examples/todo_with_delete/todo_with_delete.html
header:
  css: ["/samples/samples.css"]
---

## {{ page.title }}

Enter text in the input field and press return. Point the mouse cursor at an
item in the list. Click the item to delete it.

This app shows how to programmatically remove an element from the DOM.

In this example, when you click an item in the list, the event handler for
the <li> element removes itself from the DOM tree. When the DOM tree
changes, the web page refreshes.

Read this [tutorial](/docs/tutorials/remove-elements/) for
more detail, or read the
[source](https://github.com/dart-lang/dart-tutorials-samples/tree/master/web/todo_with_delete).

<iframe class="running-app-frame"
        style="height:400px;width:40%;"
        src="{{page.live_example_url}}">
</iframe>

See all [samples](/samples/).
