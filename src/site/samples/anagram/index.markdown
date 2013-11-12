---
layout: default
title: Moving Elements within the DOM Tree
live_example_url: /docs/tutorials/add-elements/examples/anagram/anagram.html">
header:
  css: ["/samples/samples.css"]
---

## {{ page.title }}

Form a word by clicking the letter tiles.

This app shows how to programmatically move an element on the page.

To move an element on the page, change its parent element. An element can have
only one parent, so changing the parent moves the element in the DOM tree. In
this example, when you click on a tile, the click handler changes the tile’s
parent.

Read this [tutorial](/docs/tutorials/add-elements/#moving-elements) for
more detail, or read the
[source](https://github.com/dart-lang/dart-tutorials-samples/tree/master/web/anagram).

<iframe class="running-app-frame"
        style="height:400px;width:100%;"
        src="{{page.live_example_url}}">
</iframe>

See all [samples](/samples/).
