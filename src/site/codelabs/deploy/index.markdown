---
layout: tutorial
title: "Weigh Anchor: Deploy a Server and App"
description: "Deploy a Dart server and serve a Dart app."
has-permalinks: true
tutorial:
  id: buildanddeploy
js:
- url: /js/os-switcher.js
  defer: true
- url: /js/editor-downloads-analytics.js
  defer: true
- url: /js/editor-version.js
  defer: true
header:
  css: ["/codelabs/darrrt/darrrt.css"]
---

# {{ page.title }}

<div style="font-size:64px;font-weight:bold;color:#DCDCDC">
BETA
</div>

Please send feedback to [dartbug.com](http://dartbug.com/new).

<hr>

In this code lab, you deploy an client application (web app) to the Heroku hosting service.
This code lab focuses on the server-side programming aspect of this project.

<div class="trydart-note" markdown="1">
<strong>Note:</strong>
This code lab is for those who want to learn
how to write a DIY server for deploying a web app.
If you are not interested in server-side programming,
this code lab is probably not for you.
Perhaps you'd prefer the
[Avast, Ye Pirates](/codelabs/darrrt/) code lab
for building a web app.
</div>

To put your client app on the internet, you need to deploy it.
For that, you need a client app, a web server, and a hosting service.

<div class="trydart-step-details" markdown="1">

![The process for deploying a Web app](images/process.png)

</div>

You can use any web server to serve your Dart client app.
Because Dart can run on the server side, as well as on
the client side,
you can use Dart for both your client app and your web server.
One benefit of doing so is that the client and web server
can share code.
The Dart Virtual machine (Dart VM) runs on Windows, Linux, or Mac systems.

* **Web Server**&mdash;In this code lab, you learn how to build a web server in Dart
that can serve static files (those that have no dynamic content).
You use this web server to respond to HTTP requests for the web app's pages.

* **Host**&mdash;In addition to a web server, you need a host for your web app.
Many public hosting services are available.
We chose the Heroku hosting service for this project
because it has a free tier and is easy to use.

* **Client App**&mdash;As for the client app,
  you will be deploying the Pirate Badge web app from the
  [Avast, Ye Pirates](/codelabs/darrrt/) code lab.

* **Fun debugging on mobile devices**&mdash;In addition,
you learn how to use DevTools to inspect and debug your app on a mobile device.

<hr>

<div markdown="1">

## Contents

* [Step 0: Set up](#step-zero)
* [Step 1: Run the app in Dartium](#step-one)
* [Step 2: Build the app and run as JavaScript](#step-two)
* [Step 3: Walk through the static file server's code](#step-three)
* [Step 4: Inspect your app on a mobile device](#step-four)
* [Step 5: Deploy to Heroku](#step-five)
* [Step 6: Run the app on the web and on a mobile device](#step-six)
* [What next?](#whatnext)
* [Summary and resources](#resources)

</div>

<hr>

##Step 0: Set up {#step-zero}

In this step, you download Dart and get the code for the app that you will be deploying.
This code lab uses Dart Editor.

### <i class="fa fa-anchor"> </i> Get Dart.

<div class="trydart-step-details" markdown="1">
If you haven't already done so, get the Dart download.
Unzip the ZIP file, which creates a directory called `dart`.
(For more options, go to the [download page](/tools/download.html).)

<!--style here is a hack to remove the arrow, which was only partially showing. -->
<div style="padding-left: 10px">
  {% include downloads/_dart-editor.html buttonclass="btn btn-primary btn-lg" %}
</div>

<p class="os-choices" markdown="1">
  The Dart tools
  work in recent versions of
  {% include os-choices.html %}
</p>
</div>

### <i class="fa fa-anchor"> </i> Start Dart Editor.

<div class="trydart-step-details" markdown="1">
Go to the `dart` directory and double-click **DartEditor**.

**Got questions? Having trouble?** Go to the
[Troubleshooting Dart Editor](/tools/editor/troubleshoot.html) page.

</div>

### <i class="fa fa-anchor"> </i> Get the code.

<div class="trydart-step-details" markdown="1">
<a href="https://github.com/dart-lang/deploy-codelab/archive/master.zip">Download</a>
the code for the app that you will be deploying.
Unzip the ZIP file,
which creates a directory called `deploy-codelab-master`.
</div>

### <i class="fa fa-anchor"> </i> Open deploy-codelab-master.

<div class="trydart-step-details" markdown="1">
In Dart Editor,
use **File > Open Existing Folder...**
to open the `deploy-codelab-master` directory.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

![The files and directories in the deploy-codelab-master directory](images/filesanddirs.png)

<div class="trydart-note" markdown="1">
<strong>Note:</strong>
If you see <span style="color:red">red X's</span> at the left of the
filenames,
the packages are not properly installed.
Right click `pubspec.yaml` and select **Pub Get**.
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key Information </strong>

* The `packages` directory contains links to 3rd party libraries.
  Those libraries are defined as dependencies in the `pubspec.yaml` file.
  The `pubspec.lock` file lists the currently installed
  versions for those libraries.

* The `web` directory contains the Pirate Badge app to deploy.

* The `bin` directory contains Dart scripts that run from the command line.
  For example, scripts that run web servers live in `bin`.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

### <i class="fa fa-anchor"> </i> Get some extras.

<div class="trydart-step-details" markdown="1">

Now is a good time to install some other
prerequisite software and optional hardware.
You have an opportunity to get them later as well.

For Step 4: (optional step)

* Android mobile device with Chrome for Android 31 or later, with USB cable
* Chrome 32 or higher on your computer

For Step 5:

* [git](http://git-scm.com/downloads)
* [Heroku](https://devcenter.heroku.com/articles/quickstart)

</div>

<hr>

##Step 1: Run the app in Dartium {#step-one}

Open the code for the Pirate Badge web app and run it locally.

### <i class="fa fa-anchor"> </i> Expand the `web` directory.

<div class="trydart-step-details" markdown="1">
In Dart Editor, expand the `web` directory
by clicking the little arrow
![wee arrow](images/wee-arrow.png) to the left of its name.
The directory contains four files:

![Files for the app to deploy](images/appfiles.png)

</div>

### <i class="fa fa-anchor"> </i> Look at `piratebadge.html`.

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details" markdown="1">

Double-click `piratebadge.html` to open it.

{% prettify html %}
...
<head>
  <meta charset="utf-8">
  <title>Pirate badge</title>
  [[highlight]]<meta name="viewport"[[/highlight]]
        [[highlight]]content="width=device-width, initial-scale=1.0">[[/highlight]]
  <link rel="stylesheet" href="piratebadge.css">
</head>
<body>
  ...
  [[highlight]]<script type="application/dart" src="piratebadge.dart"></script>[[/highlight]]
  [[highlight]]<script src="packages/browser/dart.js"></script>[[/highlight]]

  ...
</body>
...
{% endprettify %}

</div>

<div class="trydart-filename">piratedbadge.dart</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key Information </strong>

* The <code>&lt;meta&gt;</code> tag sets attributes to
  make the app scale correctly on mobile devices.

* The first `script` tag identifies the script,
  `piratebadge.dart`, that contains the web app.

* `dart.js` is a script that determines if the browser supports Dart,
  and if it does, runs the app natively.
  If it does not, the script loads the JavaScript version of the app.

* `dart.js` is part of the `browser` pub package.

</div></div>

### <i class="fa fa-anchor"> </i> Run the app.


<div class="row"> <div class="col-md-7">

<div class="trydart-step-details" markdown="1">

Right-click `piratebadge.html`
and choose **Run in Dartium** from the menu.

![Run the app using the menu](images/runtheapp.png)

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key Information </strong>

* Dart Editor launches *Dartium*&mdash;a special build of Chromium
  that has the Dart Virtual Machine built in&mdash;and loads the app.

* At this time, Dartium is the only browser that has the Dart VM built in.
  To run a Dart app in other browsers you need to convert it to JavaScript,
  which you do in the next step.

</div></div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details" markdown="1">

</div>

<iframe class="running-app-frame"
        style="height:220px;width:550px;margin-top:20px;margin-bottom:20px"
        src="/codelabs/darrrt/examples/6-piratebadge/piratebadge.html">
</iframe>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key Information </strong>

* The Pirage Badge app should appear.

* Try out the app running to the left.
  Click the button or type in the text field to generate a pirate name.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div></div>

<hr>

##Step 2: Build the app and run as JavaScript {#step-two}

In this step, you use [`pub build`](http://pub.dartlang.org/doc/pub-build.html)
to generate the assets for the app and put them into a new directory named
`build`. In addition to other tasks, this process generates minified JavaScript
that works in any modern browser.

### <i class="fa fa-anchor"> </i> Check out pubspec.yaml

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details" markdown="1">

Double-click the `pubspec.yaml` file to open it.
Click the **Source** tab at the bottom of the editing pane.
The list under `dependencies` lists the packages that this app requires.
The `pub` command installs these packages.
`pub` might install multiple `packages` directories, as needed.

{% prettify dart %}
name: deploy_codelab
description: A sample deployment
dependencies:
  [[highlight]]browser: any[[/highlight]]
  [[highlight]]http_server: any[[/highlight]]
  [[highlight]]path: any[[/highlight]]
{% endprettify %}

</div>

<div class="trydart-filename">pubspec.yaml</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key Information </strong>

* A `pubspec.yaml` file in a directory identifies the directory
  and its contents as a package.

* `pubspec.yaml` provides meta-data for the application,
  such as its name.

* The `pubspec.yaml` file also lists the packages on which the app depends.
  The three packages needed by this app are all hosted on
  [pub.dartlang.org](https://pub.dartlang.org/).

* `any` selects the latest possible package version that satisfies all the
   dependencies.

</div></div>

### <i class="fa fa-anchor"> </i> Look at the packages directory

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details" markdown="1">

In Dart Editor, expand the top-level `packages` directory.

![Packages contains the code for the package dependencies](images/packagesfiles.png)

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key Information </strong>

*  The `packages` directory contains the code for all of the dependencies
   listed in the `pubspec.yaml` file.
   These are installed automatically by Dart Editor.

* The `browser` package contains the `dart.js` script
  that checks for native Dart support.

* The `http_server` package makes it easier to write HTTP server by providing a
  high-level HTTP server API.

* The `path` package provides common path manipulation operations,
  such as joining, splitting, and normalizing.

* The `mime` package is included because `http_server` depends on it.

* You're likely to see multiple `packages` directories. One is installed
  for every subdirectory that needs it.

</div></div>

### <i class="fa fa-anchor"> </i> Run pub build

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details" markdown="1">

With `pubspec.yaml` still selected, select **Tools > Pub Build**.
The output looks something like this:

{% prettify bash %}
--- Jan 16, 2014 4:14:36 PM Running pub build ... ---
Building deploy_codelab.....
[Info from Dart2JS]:
Took 0:00:06.811770 to compile deploy_codelab|web/piratebadge.dart.
Built 10 files!
{% endprettify %}

</div>

<div class="trydart-filename">terminal</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key Information </strong>

*  The `pub build` command creates a `build` directory that contains
   everything your app needs to be deployed, including a minified
   JavaScript file and the required packages.

</div></div>

### <i class="fa fa-anchor"> </i> Look at the `build` directory

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details" markdown="1">

The `pub build` command creates a `build` directory
under `deploy-codelab-master`.

![The build directory contains everything you need to deploy.](images/builddir.png)
</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key Information </strong>

* The `piratebadge.dart.js` file is a JavaScript file that has been minified.
  When deployed, this file runs in the browser.

* The `packages` directory contains the package dependencies.

* Note that the `build` directory contains no `piratebadge.dart` file.
  It is not needed to deploy the app to JavaScript.

</div></div>


### <i class="fa fa-anchor"> </i> Run the app as JavaScript

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details" markdown="1">

Open the app.
Select **File > Open File...**
in a browser such a Firefox or Safari
and select the
`deploy-codelab-master/build/piratebadge.html` file.

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key Information </strong>

* The app is running on the local machine using the `file` protocol.
  To share your app with others, you need to deploy the app to a hosting service,
  such as Heroku.

</div></div>

<hr>

##Step 3: Walk through the static file server's code {#step-three}

You can build full HTTP servers with Dart. The HTTP libraries and packages
support serving both static files and dynamic responses. For this code lab,
we focus on serving static files.

You need to provide a static file server for this project
because Heroku requires one for deployment.
Also, it's fun to serve your Dart client app with a server built with Dart!
The code you downloaded for this project contains a static file server.
This step walks through the code for the static file server, which uses some
interesting Dart APIs and two helpful pub packages.

Links to the relevant API docs are
provided in [Summary and Resources](#resources).

### <i class="fa fa-anchor"> </i> Setting the path to the app.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

Double click `bin/basic_http_server.dart` to open it. The beginning of
the code is as follows:

{% prettify dart %}
import 'dart:io' show File, HttpServer, [[highlight]]Platform[[/highlight]];
import 'dart:async' show runZoned;
import 'package:http_server/http_server.dart' show VirtualDirectory;
import 'package:path/path.dart' show [[highlight]]join, dirname;[[/highlight]]

void main() {
  [[highlight]]// Assumes the server lives in bin/ and that `pub build` ran.[[/highlight]]
  [[highlight]]var buildUri = Platform.script.resolve('../build');[[/highlight]]

  ...
}
{% endprettify %}
</div>

<div class="trydart-filename">basic_http_server.dart</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key Information </strong>

* This code assumes that `pub build` has run, because it relies on the `build`
  directory existing.

* In the next step, you will configure a Heroku buildpack (a collection of
  scripts) that runs `pub build` when you upload your app.

* This code uses `resolve` to get the URI of the `build` directory based on the
  path of the running script.

* The top-level `Platform` object provides information about the environment in
  which the application is running.
  Here, `Platform.script` returns the absolute URI of the script being run.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

### <i class="fa fa-anchor"> </i> Serving `piratebadge.html`.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

{% prettify dart %}
import 'dart:io' show [[highlight]]File[[/highlight]], HttpServer, Platform;
import 'dart:async' show runZoned;
import 'package:http_server/http_server.dart' show [[highlight]]VirtualDirectory;[[/highlight]]
import 'package:path/path.dart' show join, dirname;

void main() {
  ...
  [[highlight]]var staticFiles = new VirtualDirectory(buildUri.toFilePath());[[/highlight]]

  [[highlight]]staticFiles[[/highlight]]
      [[highlight]]..allowDirectoryListing = true;[[/highlight]]
      [[highlight]]..directoryHandler = (dir, request) {[[/highlight]]
        [[highlight]]// Redirect directory-requests to piratebadge.html file.[[/highlight]]
        [[highlight]]var indexUri = new Uri.file(dir.path).resolve('piratebadge.html');[[/highlight]]
        [[highlight]]staticFiles.serveFile(new File(indexUri.toFilePath()), request);[[/highlight]]
      [[highlight]]};[[/highlight]]
  ...
}
{% endprettify %}
</div>

<div class="trydart-filename">basic_http_server.dart</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key Information </strong>

* The `VirtualDirectory` class from the `http_server` package provides a
  high-level interface for serving static files and directory listings.

* This code overrides the directory index requests to serve `piratebadge.html`,
  which is the main HTML file for this app.

* The `serveFile` method serves the requested static file to the client.

* The `http_server` package enables writing more concise code. The lower-level
  APIs provided by `dart:io` would require making use of `HttpServer`,
  `HttpRequest`, `HttpResponse` classes.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

### <i class="fa fa-anchor"> </i> Using variable port numbers.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

{% prettify %}
import 'dart:io' show File, HttpServer, [[highlight]]Platform[[/highlight]];
import 'dart:async' show runZoned;
import 'package:http_server/http_server.dart' show VirtualDirectory;
import 'package:path/path.dart' show join, dirname;

void main() {
  ...
  [[highlight]]var portEnv = Platform.environment['PORT'];[[/highlight]]
  [[highlight]]var port = portEnv == null ? 9999 : int.parse(portEnv);[[/highlight]]
  ...
}
{% endprettify %}
</div>

<div class="trydart-filename">basic_http_server.dart</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key Information </strong>

* Heroku uses variable ports. Heroku sets the `$PORT` environment variable
  with the port number that your app should listen to.

* This code uses the port specified in the `$PORT` environment variable,
  if present. Otherwise, it uses port 9999.

* The `$PORT` environment variable might not be present if the web server is
  running outside of the Heroku environment.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>


### <i class="fa fa-anchor"> </i> Using `runZoned()`.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">


{% prettify dart %}
import 'dart:io' show File, HttpServer, Platform;
import 'dart:async' show [[highlight]]runZoned[[/highlight]];
import 'package:http_server/http_server.dart' show VirtualDirectory;
import 'package:path/path.dart' show join, dirname;

void main() {
  ...
  [[highlight]]runZoned(() {[[/highlight]]
     ...
  [[highlight]]},[[/highlight]]
  [[highlight]]onError: (e, stackTrace) => print('Oh noes! $e $stackTrace'));[[/highlight]]
}
{% endprettify %}
</div>

<div class="trydart-filename">basic_http_server.dart</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key Information </strong>

* `runZoned` helps provide stability to your program.
  It catches exceptions from all call stacks within its bounds,
  allowing your program to continue running in spite of errors.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

### <i class="fa fa-anchor"> </i> Listening for HTTP requests.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">


{% prettify dart %}
import 'dart:io' show File, [[highlight]]HttpServer[[/highlight]], Platform;
import 'dart:async' show runZoned;
import 'package:http_server/http_server.dart' show VirtualDirectory;
import 'package:path/path.dart' show join, dirname;

void main() {
  ...
  runZoned(() {
    [[highlight]]HttpServer.bind('0.0.0.0', port).then((server) {[[/highlight]]
      [[highlight]]server.listen(staticFiles.serveRequest);[[/highlight]]
    [[highlight]]});[[/highlight]]
  },
  onError: (e, stackTrace) => print('Oh noes! $e $stackTrace'));
}
{% endprettify %}
</div>

<div class="trydart-filename">basic_http_server.dart</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key Information </strong>

* `HttpServer.bind()` creates an HTTP server, which responds to HTTP requests
  for this app.

* The HTTP server binds to a host `0.0.0.0`.
  which is a special address that is guaranteed
  to receive requests from any network socket.
  If you don't know what specific IP to listen to, you can use 0.0.0.0.

* A Stream provides an asynchronous sequence of data. Using the
  `listen()` method, a stream client
  registers a callback function that gets called when
  data is available.

* HTTP requests are served over a stream.

* Here, the `VirtualDirectory` object named `staticFiles`
  provides the callback function for the HTTP requests.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>


### <i class="fa fa-anchor"> </i> Run the web server, run the app

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

In Dart Editor,
right click `bin/basic_http_server.dart` and select `Run`.
Dart Editor brings up a new output pane in which the web server
displays its output, if any.

Now, open `0.0.0.0:9999` in your browser
(or, on Windows, open `127.0.0.1:9999`).
The app appears and you can generate pirate names.


<strong>Leave the web server running.</strong>

</div>


</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key Information </strong>

* 0.0.0.0:9999 requests the root directory of that host and port.
  The static file server resolves that request to `piratebadge.html`
  and returns the contents of that file.

* 0.0.0.0:9999 requests work only on your local machine.
  Another machine cannot run your app using that URL.
  In [Step 5](#step-five), you deploy your app to Heroku,
  which gives you a public URL.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

<hr>

##Step 4: Inspect your app on a mobile device {#step-four}

Before deploying your app,
you can use the Chrome DevTools to check, debug, and modify
your app on a mobile device.
DevTools can debug Android devices natively
and other devices using
[Mobile Emulation](https://developers.google.com/chrome-developer-tools/docs/mobile-emulation).
This section shows you how to use DevTools with your app on an Android device.

You don't need to do this step to deploy your app.
You can skip and move on to [Step 5](#step-five).
However, this does help you to test and debug your app on mobile devices
and it's pretty cool.

### <i class="fa fa-anchor"> </i> Set up your computer and device

<div class="trydart-step-details" markdown="1">

Follow the instructions at
[Remote Debugging Chrome on Android](https://developers.google.com/chrome-developer-tools/docs/remote-debugging)
to set up your device, Chrome, and your computer.

</div>

### <i class="fa fa-anchor"> </i> Run the app on your mobile device

<div class="trydart-step-details" markdown="1">

Make sure your web server is still running from [Step 3](#step-three).

On your mobile device, bring up Chrome,
and open `0.0.0.0:9999` in your browser.

<img src="images/calebthebrave.png" height="400">

</div>

### <i class="fa fa-anchor"> </i> Bring up the Devices page

<div class="trydart-step-details" markdown="1">

In Chrome on your computer,
click the Android icon at the right side of any window
and select **View Inspection Targets**.
As of Chrome 32,
you can just visit `about:inspect` and verify
that **Discover USB Devices** is checked.

![Click the Android icon](images/androidicon.png)

The Devices page appears and an entry for your app appears.
Note the green dots. Make sure that one of them has the label `:9999`.
If not, you need to click the **Port forwarding...** button
and turn on port forwarding for `0.0.0.0:9999`.

![Your tab appears under the Chrome heading](images/tabappears.png)


</div>

### <i class="fa fa-anchor"> </i> Bring up DevTools for the app

<div class="trydart-step-details" markdown="1">

On the Devices page, click `inspect` under the entry for your app.
A DevTools window appears that is attached to your app running
on the mobile device.
You are now inspecting the client app running on your mobile device.

![Your tab appears under the Chrome heading](images/devtoolsforphone.png)

</div>

### <i class="fa fa-anchor"> </i> Experiment with changing the app

<div class="trydart-step-details" markdown="1">

Experiment by using DevTools to modify the font size or color.
The change happens instantly on your mobile device.

</div>


<hr>
##Step 5: Deploy to Heroku {#step-five}

In this step, you deploy your web server and app to Heroku.
Heroku is a cloud hosting service that has
a free tier and can run arbitrary VMs,
which is why we're using it here.

### <i class="fa fa-anchor"> </i> Get Heroku and a Heroku account

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

Follow Steps 1, 2, and 3 at
[Getting Started with Heroku](https://devcenter.heroku.com/articles/quickstart)
to download the Heroku tools and get an account with Heroku.

</div>

</div> <div class="col-md-5" markdown="1">


</div> </div>


### <i class="fa fa-anchor"> </i> Create a `Procfile`

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

In the `deploy-codelab-master` directory, create a file
named `Procfile` and add the following line to it.

{% prettify bash %}

web: ./dart-sdk/bin/dart bin/basic_http_server.dart

{% endprettify %}

</div>

<div class="trydart-filename">Procfile</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key Information </strong>

* A `Procfile` tells Heroku what part of your app can be executed.

* The `Procfile` for this example defines a web process type
  in which the dart VM runs the static file server.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>


### <i class="fa fa-anchor"> </i> Commit your changes to your local `deploy-codelab-master` git repo

<div class="trydart-step-details" markdown="1">

`git` is a software configuration management system
and the means for deploying apps to Heroku.
If you don't already have `git`, you need to download it.
Refer to the
[git website](http://git-scm.com/downloads)
for downloads and documentation.

Before you can push an app to Heroku,
you need to initialize a local `git` repo and commit your files to it.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

{% prettify bash %}
$ cd deploy-codelab-master
$ git init
$ git add -A .
$ git commit -am "Hoist the mizzen!"
$
{% endprettify %}

</div>

<div class="trydart-filename">terminal</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key Information </strong>

* With `git init` you create a local repo.

* Next, `git add` adds the specified files to the local repo.

* Finally, `git commit` saves the files to your local git repo.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

### <i class="fa fa-anchor"> </i> Create a Heroku app and configure it.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

<strong>Important:</strong> Replace
`myfirstdartappforheroku` with something **unique**.

{% prettify bash %}
$ heroku create [[highlight]]myfirstdartappforheroku[[/highlight]] -s cedar
$ heroku labs:enable user-env-compile
$ heroku config:set DART_SDK_URL=https://github.com/selkhateeb/heroku-vagrant-dart-build/releases/download/latest/dart-sdk.tar
$ heroku config:add BUILDPACK_URL=https://github.com/igrigorik/heroku-buildpack-dart.git
$
{% endprettify %}

</div>

<div class="trydart-filename">terminal</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key Information </strong>

* With the first command, `heroku create`, you create a Heroku app
  with the specified name.
  Provide it with a **unique** name (not `myfirstdartappforheroku`).

* Enabling `user-env-compile` allows environment variables
  to be passed to the build script during deploy.

* Official builds of Dart do not support Heroku due to mismatched glibc versions.
  The `DART_SDK_URL` specifies
  the (unsupported) [Vagrant Dart Build](https://github.com/selkhateeb/heroku-vagrant-dart-build),
  which is a special build of the Dart SDK that is compatible with Heroku.

* A buildpack extends Heroku. The buildpack used here extends Heroku
  to support Dart apps. The location of the buildpack
  is specified with the `BUILDPACK_URL`.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

### <i class="fa fa-anchor"> </i> Push your app to Heroku

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

Type the `git push` command as shown.
Some output has been replaced with ellipses to save space,
but the output from the push command will look something this:


{% prettify bash %}
$ [[highlight]]git push heroku master[[/highlight]]
Initializing repository, done.

...
-----> Fetching custom git buildpack... done
-----> Dart app detected
...
Dart VM version: 1.0.0.5_r30248_vagrant (Thu Nov 14 13:43:29 2013) on "linux_x64"
...
*** Running pub build
Building with "pub build"
Building deploy_codelab....................
[Info in Dart2JS]:
Generated deploy_codelab|web/piratebadge.dart.js (97701 characters) in 0:01:19.685114
Built 6 files!
...
-----> Launching... done, v6
       [[highlight]]http://myfirstdartappforheroku.herokuapp.com deployed to Heroku[[/highlight]]

To git@heroku.com:myfirstdartappforheroku.git
 * [new branch]      master -> master
$
{% endprettify %}


</div>

<div class="trydart-filename">terminal</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key Information </strong>


* Your local `git` repository becomes associated with a remote Heroku repository,
  usually named `heroku`, when you push.

* Every time you push, Heroku runs the buildpack that you specified.

* In addition to other tasks, this buildpack runs `pub build`.

* When the push is finished, the process displays a URL for your app.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

### <i class="fa fa-anchor"> </i> Specify the scale

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

{% prettify bash %}
$ heroku ps:scale web=1
$
{% endprettify %}

</div>

<div class="trydart-filename">terminal</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key Information </strong>

* Scale to one _dyno_, which is a Heroku lightweight container
  that runs a single user-specified command.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

<hr>

##Step 6: Run the app on the web and on a mobile device {#step-six}

Now that your app is deployed, you can run it on the web
and on a mobile device.

### <i class="fa fa-anchor"> </i> Run the app in a browser

<div class="row"> <div class="col-md-7" markdown="1">

<iframe class="running-app-frame"
        style="height:220px;width:550px;"
        src="/codelabs/darrrt/examples/6-piratebadge/piratebadge.html">
</iframe>


</div> <div class="col-md-5" markdown="1">
<i class="fa fa-key key-header"> </i> <strong> Key Information </strong>

* Use the URL displayed by the previous step to visit your app:
  `http://myfirstdartappforheroku.herokuapp.com`

</div> </div>


### <i class="fa fa-anchor"> </i> Run the app on a mobile device

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

<img src="images/calebthebrave.png" height="400">

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key Information </strong>

* Use the URL from the previous step to load the app
  into a browser on your mobile device.
  `http://myfirstdartappforheroku.herokuapp.com`

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>


### <i class="fa fa-anchor"> </i> Share your app with the world!

<div class="trydart-step-details" markdown="1">

Share your Heroku URL with your followers and circles.

* <a href="https://twitter.com/share" class="twitter-share-button" data-text="Arrr! I've deployed me app. http://dartlang.org/codelab/deploy/" data-count="none" data-hashtags="dartlang">Tweet</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>

{% comment %}
* <p class="share-button twitter">
<a href="https://twitter.com/share"
   class="twitter-share-button external-link"
   data-count="none"
   data-text="Arrr! I've deployed me app. http://dartlang.org/codelab/deploy/"
   data-hashtags="dartlang">Tweet</a> </p>
{% endcomment %}

* <p>
<script src="https://apis.google.com/js/plusone.js"></script>
<g:plus action="share"></g:plus> </p>

</div>

<hr>

##What next? {#whatnext}

Now that your app is deployed for the world to use,
what do you do now?
Here are some suggestions.

### <i class="fa fa-anchor"> </i> Jump to another ship.

<div class="trydart-step-details" markdown="1">

If you never went through the [Avast, Ye Pirates](/codelabs/darrrt/) code lab,
do it now.

</div>

### <i class="fa fa-anchor"> </i> Check out the samples

<div class="trydart-step-details" markdown="1">
For more command-line application and server code,
visit [Dart by Example](/dart-by-example/)
and the [samples](/samples/) page.
</div>

### <i class="fa fa-anchor"> </i> Read the tutorials

<div class="trydart-step-details" markdown="1">
Learn more about command-line apps and servers,
read the [tutorials](/docs/tutorials/),
in particular the [command-line app tutorial](/docs/tutorials/cmdline/)
and [Get Input from a Form](/docs/tutorials/forms/),
which contains an HTTP server.
</div>


### <i class="fa fa-anchor"> </i> Go write some awesome code.


<hr>

##Summary and resources {#resources}

For more information about the tools and libraries used
in this code lab, check out these resources.

### <i class="fa fa-anchor"> </i> Think about what you've done!

<div class="trydart-step-details" markdown="1">
This code lab provided a small example of a static file server.
You learned some interesting features of Dart,
the Dart SDK, some Dart tools, and a few pub packages:

* `runZoned()` keeps your program running in spite of exceptions
* `HttpServer.bind()` creates an HTTP server and binds it to a host and port
* `listen()` registers a callback function for Stream events
* `Platform` provides system environment information
* `File` represents

* `VirtualDirectory` makes HTTP operations easier

* `pub get` installs packages
* `pub build` builds an app for deployment
* `pub build` generates JavaScript so your app can run on any modern browser

* Heroku is a hosting service with a free tier
* DevTools allows you to inspect and debug your app on a mobile device

</div>

### <i class="fa fa-anchor"> </i> Online documentation

<div class="trydart-step-details" markdown="1">

#### SDK libraries, classes, and functions

* The API docs for the
<a href="https://api.dartlang.org/dart_io/File.html" target="_blank">File</a>,
<a href="https://api.dartlang.org/dart_io/HttpServer.html" target="_blank">HttpServer</a>, and
<a href="https://api.dartlang.org/dart_io/Platform.html" target="_blank">Platform</a>
classes from the
<a href="https://api.dartlang.org/dart_io.html" target="_blank">dart:io</a>
library.
* The API docs for the
<a href="https://api.dartlang.org/dart_async/Stream.html" target="_blank">Stream</a>
class and
<a href="https://api.dartlang.org/dart_async.html#runZoned" target="_blank">runZoned()</a>
function from the
<a href="https://api.dartlang.org/dart_async.html" target="_blank">dart:async</a> library.

#### Classes and functions from pub packages

* The code for the
<a href="https://pub.dartlang.org/packages/http_server">http_server</a> pub package,
in particular
<a href="https://api.dartlang.org/http_server/VirtualDirectory.html" target="_blank">VirtualDirectory</a>
class.
* The code for the
<a href="http://pub.dartlang.org/packages/path">path</a> pub package,
in particular the
<a href="https://api.dartlang.org/path.html#join" target="_blank">join()</a>
and
<a href="https://api.dartlang.org/path.html#dirname" target="_blank">dirname()</a>
functions.

#### Heroku tools

* The <a href="https://devcenter.heroku.com/">Heroku Dev Center</a>.
* The Heroku-compatible build of the Dart SDK:
[heroku-vagrant-dart-build](https://github.com/selkhateeb/heroku-vagrant-dart-build).
* The Heroku buildpack for Dart:
[heroku-buildpack-dart](https://github.com/igrigorik/heroku-buildpack-dart).

#### The example code

* The [deploy-codelab](https://github.com/dart-lang/deploy-codelab)
example code.

</div>

