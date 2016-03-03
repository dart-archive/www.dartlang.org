---
layout: codelab
title: "What Next?"
codelab-name: "Avast, Ye Pirates: Write a Web App"
description: "Take your first step to learning Dart fast."
snippet_img: images/piratemap.jpg
prev: 6-readjsonfile.html
prev-title: "Step 6: Read a JSON File"
next: resources.html
next-title: "Resources"
header:
  css: ["/codelabs/ng2/darrrt.css"]
---

{% include codelab-nav.html %}

# {{ page.title }}

Now that you've written your app, what do you do next?
Here are some suggestions.

## <i class="fa fa-anchor"> </i> Work through the guides on angular.io.

<div class="trydart-step-details" markdown="1">
Work through the [QuickStart](https://angular.io/docs/dart/latest/quickstart.html)
and [Developer](https://angular.io/docs/dart/latest/guide/) Guides
on [angular.io](https://angular.io/docs/dart/latest/).
</div>

## <i class="fa fa-anchor"> </i> Build your app to run in any browser.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
You can test your app in other browsers by right-clicking
index.html and choosing **Open in browser &gt;** from the pop up menu.

To compile the app into JavaScript that runs in any modern browser,
use **pub build**.  Build the app in WebStorm, as follows:

<ol markdown="1">
<li markdown="1">Open the pubspec and click **Build...**.
</li>

<li markdown="1">From the dialog,
choose **Release** or **Debug**, as desired.
The third option allows you to
[specify a mode](/tools/pub/cmd/pub-build.html#options)
to `pub build`.
</li>
</ol>

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-lightbulb-o key-header"> </i> <strong> Not using WebStorm? </strong>

* To compile a deployable version of your app from the command line,
  use the [pub build](/tools/pub/cmd/pub-build.html) command.

</div></div>

## <i class="fa fa-anchor"> </i> Deploy a server and your app.

<div class="trydart-step-details" markdown="1">

The [server side code lab](https://dart-lang.github.io/server/codelab/)
allows you create a pirate crew by storing pirate names to a RESTful
Dart server.

Also, see the [Write HTTP Clients & Servers](/docs/tutorials/httpserver/)
tutorial if you are interested in server-side programming.
</div>

## <i class="fa fa-anchor"> </i> Read the tutorials.

<div class="trydart-step-details" markdown="1">
Learn more about Dart from
the [Dart tutorials](/docs/tutorials/).
</div>

<hr>

{% include codelab-nav.html %}
