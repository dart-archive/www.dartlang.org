---
layout: default
title: A Basic WebSockets Example
live_example_url: example/index.html

header:
  css: ["/samples/samples.css"]
---

## {{ page.title }}

A simple example of using WebSockets for communication.

You can learn about the basics of WebSockets by reading the
[Introducing WebSockets: Bringing Sockets to the Web](http://www.html5rocks.com/en/tutorials/file/filesystem/)
article on HTML5Rocks.

WebSocket is a protocol providing full-duplex communications channels over a
single TCP connection.

This example opens a WebSocket connection to an echo server
(`ws://echo/websocket.org`), sends data to the server, and then displays the
response on the web page.

You can open the example in Dart Editor and run it by clicking `index.html`.

Read the
[source](https://github.com/dart-lang/dart-samples/tree/master/web/html5/websockets/basics).

<iframe class="running-app-frame"
        style="height:500px;width:100%;"
        src="{{page.live_example_url}}">
</iframe>

See all [samples](/samples/).
