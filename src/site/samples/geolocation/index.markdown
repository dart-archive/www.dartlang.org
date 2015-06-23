---
layout: default
title: A Basic Geolocation Example
live_example_url: example/index.html
header:
  css: ["/samples/samples.css"]
---

## {{ page.title }}

The Geolocation API lets you track a user's location. The API is
device agnostic; the underlying mechanism might be via GPS,
wifi, or simply asking the user to enter their location manually. Since
these lookups can take some time, the API is asynchronous, and you
pass it a callback method whenever you request a location.

The Trip Meter example displays the user's initial location, and it
tracks the distance the user has travelled since the page was loaded.

You can run the example by running `pub serve` from the `dart-samples/html5` 
directory, and then visiting
[localhost:8080/geolocation/trip_meter/](http://localhost:8080/geolocation/trip_meter/).

<iframe class="running-app-frame"
        style="height:300px;width:100%;"
        src="{{page.live_example_url}}">
</iframe>

Read the
[source](https://github.com/dart-lang/dart-samples/tree/master/html5/web/geolocation/trip_meter).

See all [samples](/samples/).
