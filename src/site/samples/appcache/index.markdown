---
layout: default
title: Using Application Cache
live_example_url: example/index.html

header:
  css: ["/samples/samples.css"]
---

## {{ page.title }}

A simple example to show the use of the Application Cache interface.

For a thorough exploration of this topic, read
[A Beginner's Guide to Using the Application
Cache](http://www.html5rocks.com/en/tutorials/appcache/beginner/),
an article by Eric Bidelman originally published on HTML5Rocks.

Application Cache allows you to specify which files the browser should cache
and make available to offline users. Your app will
load and work correctly, even if the user presses the refresh button while
offline.

You can run the example by running `pub serve` from the `dart-samples/html5`
directory, and then visiting 
[localhost:8080/appcache/beginner/](http://localhost:8080/appcache/beginner/).

To see this example in action, make changes to `index.html` and then reload
the app. Your changes don't show up because the browser displays a cached
version of `index.html`. Next, change the date or version number in
appcache.mf, and reload once more. You'll be prompted to load the new version.

Read the
[source](https://github.com/dart-lang/dart-samples/tree/master/html5/web/appcache/beginner).

<iframe class="running-app-frame"
        style="height:500px;width:100%;"
        src="{{page.live_example_url}}">
</iframe>

See all [samples](/samples/).
