---
layout: tutorial
title: "Beware the Nest o' Pirates: Write a Server App"
description: "Learn how you can easily write a RESTful server using Dart."
has-permalinks: true
tutorial:
  id: server
header:
  css: ["/codelabs/darrrt/darrrt.css"]
---

# {{ page.title }}

Learn how to create a RESTful web server using the
Dart language and libraries, featuring the
[RPC package](https://github.com/dart-lang/rpc).
In this code lab, you create a server with API methods exposed as
GET, POST, and DELETE requests.  Once the server's API is complete,
you use it to generate the corresponding API for a Dart client app.
Finally, you extend the server using the HTTP server library
to serve the Dart client directly.

This code lab assumes that you are comfortable reading Dart code.
If you'd like a more thorough introduction to the Dart language, see
the [client code lab](/codelabs/darrrt/) or the
[language tour](/docs/dart-up-and-running/ch02.html).

**This app lets you store a list of pirates to a Dart server. Try it!**

<iframe class="running-app-frame"
        style="width:900px;height:410px;"
        src="https://pirates-nest.appspot.com/piratebadge.html">
</iframe>

<hr>

<div class="piratemap" markdown="1" style="min-height:325px">

## Map

* [Step 0: Set up](#set-up)
* [Step 1: View the server code](#step-one)
* [Step 2: Annotate the server API](#step-two)
* [Step 3: Launch the server](#step-three)
* [Step 4: Extend the server API](#step-four)
* [Step 5: Generate the client API](#step-five)
* [Step 6: Connect the client to the server](#step-six)
* [Step 7: Serve the client from the server](#step-seven)
* [What next?](#whatnext)
* [Summary](#summary)

</div>

<hr>

## Step 0: Set up {#set-up}

In this step, you download Dart and get the sample code.

### <i class="fa fa-anchor"> </i> Get Dart.

<div class="trydart-step-details" markdown="1">
If you haven't already done so,
[download the Dart SDK](/downloads/).
Unzip the archive, which creates a directory called `dart-sdk`.

The Dart SDK download includes several Dart
tools that you'll need, incuding `dart`, `pub`, and `dartanalyzer`.
If `dart` is not recognized at the command line,
add `<path-to-the-SDK>/dart-sdk/bin` to your path.

<aside class="alert alert-info" markdown="1">
**Note:**
This code lab works with any IDE or editor, but the instructions
assume that you're using the command line.
</aside>

</div>

### <i class="fa fa-anchor"> </i> Get Dartium.

You need a way to test the client app.
You have two options. You can:

* Compile the app to JavaScript and open the page in any browser.
* Open the app in Dartium.

If you prefer the latter option, and you don't have Dartium already,
[download Dartium](https://www.dartlang.org/downloads/archive/).
Note that the executable is called Chromium on your file system.

### <i class="fa fa-anchor"> </i> Get the sample code.

<div class="trydart-step-details" markdown="1">
Download the sample code from the
[one-hour-codelab GitHub repo](https://github.com/dart-lang/one-hour-codelab/tree/server2)
using one of the following options:

<ul markdown="1">
<li markdown="1">
  Download the zip file, 
  [one-hour-codelab-master.zip](https://github.com/dart-lang/one-hour-codelab/archive/master.zip).
  Unzip the ZIP file, which creates a directory called
  `one-hour-codelab-master`.
</li>

<li markdown="1">
  Clone the repo. For example, from the command line:

{% prettify sh %}
git clone https://github.com/dart-lang/one-hour-codelab.git
{% endprettify %}

This creates a directory named `one-hour-codelab`.
</li>
</ul>

</div>

### <i class="fa fa-anchor"> </i> Look at the one-hour-codelab sample.

<div class="trydart-step-details" markdown="1">
The `server` directory contains the following files and directories:

`1-starter`
: Basic server (does not run)

`2-simple`
: Supports a few simple methods using GET requests

`3-*`
: Intentionally omitted as Step 3 does not require additional code

`4-extended`
: Adds more advanced methods including support for POST, and DELETE requests

`5-generated`
: Includes the generated client API

`6-client`
: Includes the PirateBadge client app,
  modified to use the server for storing and retrieving pirate names

`7-serve`
: Includes the final version of the server, 
  modified to serve the client app

`working-dir`
: A work area that initially contains directories and files from `1-starter`

</div>

<div class="row"> <div class="col-md-7" markdown="1">

</div> <div class="col-md-5" markdown="1">

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

### <i class="fa fa-anchor"> </i> Get the curl utility.

You need a way to test the server.
You can do some of the testing in a browser,
but Step 4 requires a tool, such as curl, that lets you construct
POST and DELETE requests.

_curl_ is a tool used for transferring data to or from a server using
a supported protocol, such as HTTP, FTP, or IMAP.
(Other tools, such as wget, perform the same function, but
this code lab uses curl.)
curl is already installed on most Macs and many Linux distributions.

If you don't have curl, go to the
[curl download](http://curl.haxx.se/download.html) page, 
scroll down until you find the right version for your OS,
and then download and install it.
On Linux, you might be able to get curl by running:

{% prettify bash %}
apt-get install curl
{% endprettify %}


##Step 1: View the server code {#step-one}

In this step, you open the source files for the server and familiarize
yourself with the code. Note that this version of the server doesn't run.
You'll fix the code in [Step 2](#step-two).

<div class="trydart-note" markdown="1">
<strong>Note:</strong>
Throughout this code lab, edit the files in `working-dir`.
You can use the files in the numbered directories to compare to your code
or to recover if you get off track.
</div>

<div class="trydart-step-details" markdown="1">
Initially, the `working-dir` files and directories are identical to
those in `1-starter`:

![The 1-starter directory structure](images/server-directory-structure.png)

`messages.dart`
: Specifies the message format used between client and server.

`piratesapi.dart`
: Specifies the methods that the server makes remotely available.
  
`piratesnest.dart` 
: Contains a `main()` function, which implements the main server entrypoint.

`utils.dart`
: Contains utility methods for generating and validating pirate names.

</div>

### <i class="fa fa-anchor"> </i> Walk through the code.

<div class="trydart-step-details" markdown="1">
Get familiar with the server code.

<aside class="alert alert-info" markdown="1">
**Tip:**
If you see only 1 column in this code lab, widen your window to see the
explanation next to the code.
</aside>
</div>

<div class="trydart-step-details" markdown="1">
#### lib/server/piratesapi.dart
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
library pirate.server;

import 'package:rpc/api.dart';

import '../common/messages.dart';
import '../common/utils.dart';

// This class defines the interface that the server provides.
class PiratesApi {
  final Map<String, Pirate> [[highlight]]_pirateCrew[[/highlight]] = {};
  final PirateShanghaier [[highlight]]_shanghaier[[/highlight]] =
      new PirateShanghaier();

  PiratesApi() {
    var captain = new Pirate.fromString('Lars the Captain');
    _pirateCrew[captain.toString()] = captain;
  }

  // Returns a list of the pirate crew.
  List<Pirate> [[highlight]]listPirates()[[/highlight]] {
    return _pirateCrew.values.toList();
  }

  // Generates (shanghais) and returns a new pirate.
  // Does not add the new pirate to the crew.
  Pirate [[highlight]]shanghaiAPirate()[[/highlight]] {
    var pirate = _shanghaier.shanghaiAPirate();
    if (pirate == null) {
      throw new InternalServerError('Ran out of pirates!');
    }
    return pirate;
  }
}
{% endprettify %}
</div>
<div class="trydart-filename">lib/server/piratesapi.dart</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* The server maintains a list (stored as a Map) of pirates, `_pirateCrew`,
  which constitutes the "nest of pirates." This list initially contains
  only "Lars the Captain".

* The server creates `_shanghaier`, an instance of PirateShanghaier,
  which handles the generation of pirate names.
   Generating a pirate name is referred to as "shanghaiing a pirate".

* The PiratesApi class defines two methods:
  `listPirates()` returns the `_pirateCrew` as a list;
  `shanghaiAPirate()` returns a new Pirate object with a valid pirate name
   (example: Anne the Brave).

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

<div class="trydart-step-details" markdown="1">
#### bin/piratesnest.dart 
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
library piratesnest;

import 'dart:io';

import 'package:logging/logging.dart';
import 'package:rpc/rpc.dart';

import 'package:server_code_lab/server/piratesapi.dart';

[[highlight]]final ApiServer _apiServer = new ApiServer(prettyPrint: true);[[/highlight]]

[[highlight]]main()[[/highlight]] async {
  // Add a bit of logging...
  [[highlight]]Logger.root..level = Level.INFO[[/highlight]]
             [[highlight]]..onRecord.listen(print);[[/highlight]]

  // Set up a server serving the pirate API.
  [[highlight]]_apiServer.addApi(new PiratesApi());[[/highlight]]
  [[highlight]]HttpServer server =[[/highlight]]
      [[highlight]]await HttpServer.bind(InternetAddress.ANY_IP_V4, 8088);[[/highlight]]
  [[highlight]]server.listen(_apiServer.httpRequestHandler);[[/highlight]]
  [[highlight]]print('Server listening on http://${server.address.host}:'[[/highlight]]
        [[highlight]]'${server.port}');[[/highlight]]
}
{% endprettify %}
</div>
<div class="trydart-filename">bin/piratesnest.dart</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* The RPC package requires you to create an `ApiServer` instance for
  routing the HTTP requests to your methods.

* This file contains the entrypoint for the server&mdash;the `main()`
  function. Running this file starts up the server.

* After creating an instance of HttpServer and binding it to port 8088,
  the server listens to that port using the API specified in the PiratesApi
  class.

* The logging code generates print statements for each
  message that the server handles.

</div> </div>

<div class="trydart-step-details" markdown="1">
#### lib/common/utils.dart
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
library pirate.utils;

import 'dart:math' show Random;

import 'messages.dart';

// Proper pirate names.
const List<String> [[highlight]]pirateNames[[/highlight]] = const [
  "Anne", "Bette", "Cate", "Dawn", "Elise", "Faye", "Ginger",
  "Harriot", "Izzy", "Jane", "Kaye", "Liz", "Maria", "Nell",
  "Olive", "Pat", "Queenie", "Rae", "Sal", "Tam", "Uma",
  "Violet", "Wilma", "Xana", "Yvonne", "Zelda", "Abe",
  "Billy", "Caleb", "Davie", "Eb", "Frank", "Gabe", "House",
  "Icarus", "Jack", "Kurt", "Larry", "Mike", "Nolan",
  "Oliver", "Pat", "Quib", "Roy", "Sal", "Tom", "Ube",
  "Val", "Walt", "Xavier", "Yvan", "Zeb"
];

// Proper pirate appellations.
const List<String> [[highlight]]pirateAppellations[[/highlight]] = const [
  "Awesome", "Captain", "Even", "Fighter", "Great",
  "Hearty", "Jackal", "King", "Lord", "Mighty",
  "Noble", "Old", "Powerful", "Quick", "Red",
  "Stalwart", "Tank", "Ultimate", "Vicious",
  "Wily", "aXe", "Young", "Brave", "Eager",
  "Kind", "Sandy", "Xeric", "Yellow", "Zesty"
];

// Clearly invalid pirate appellations.
const List<String> [[highlight]]_forbiddenAppellations[[/highlight]] = const [
  '', 'sweet', 'handsome', 'beautiful', 'weak', 'wuss',
  'chicken', 'fearful'
];

// Helper method for validating whether the given pirate is truly a pirate!
bool [[highlight]]truePirate(Pirate pirate)[[/highlight]] => pirate.name != null &&
    pirate.name.trim().isNotEmpty &&
    pirate.appellation != null &&
    !_forbiddenAppellations
        .contains(pirate.appellation.toLowerCase());

// Shared class for shanghaiing (generating) pirates.
class PirateShanghaier {
  static final Random indexGen = new Random();

  Pirate [[highlight]]shanghaiAPirate({String name, String appellation})[[/highlight]] {
    var pirate = new Pirate();
    pirate.name = name != null
        ? name
        : pirateNames[indexGen.nextInt(pirateNames.length)];
    pirate.appellation = appellation != null
        ? appellation
        : pirateAppellations[
        indexGen.nextInt(pirateAppellations.length)];
    return truePirate(pirate) ? pirate : null;
  }
}
{% endprettify %}
</div>
<div class="trydart-filename">lib/common/utils.dart</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* Servers and other command-line apps generally rely on the dart:io library.
  Client apps generally rely on the dart:html library.
  `utils.dart` doesn't rely on dart:io or dart:html and can be used by both
  the server and the client, so it lives in `lib/common/`.

* The `pirateNames` list contains first names (like "Anne" and "Mike");
  `pirateAppellations` contains labels (like "Old" and "Mighty").
  These are used to generate valid pirate names ("Anne the Mighty").

* Thanks to the `truePirate()` function, the server rejects any pirate name
  that uses one of the `_forbiddenAppellations`;
  for example "Markus the Wuss" is not allowed.
  
&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}
</div> </div>

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

<div class="trydart-step-details" markdown="1">
#### lib/common/messages.dart
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
library pirate.messages;

// This class is used to send data back and forth between the
// client and server. It is automatically serialized and
// deserialized by the RPC package.
[[highlight]]class Pirate[[/highlight]] {
  String name;
  String appellation;

  // A message class must have a default constructor taking no
  // arguments.
  [[highlight]]Pirate()[[/highlight]];

  // It is fine to have other named constructors.
  [[highlight]]Pirate.fromString(String pirateName)[[/highlight]] {
    var parts = pirateName.split(' the ');
    name = parts[0];
    appellation = parts[1];
  }

  String toString() => name.isEmpty ? '' : '$name the $appellation';
}
{% endprettify %}
</div>
<div class="trydart-filename">lib/common/messages.dart</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* `messages.dart` specifies the message format used between client and server.
  Both apps share the code, which is possible because it does not rely
  on dart:io or dart:html.

* Besides defining properties, the Pirate class can convert Pirate objects
  to and from their string components.

</div> </div>

##Step 2: Annotate the server API {#step-two}

In this step, you add annotations to the server's API so the RPC library
understands which methods are to be exposed as remotely available.

### <i class="fa fa-anchor"> </i> Run pub get.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

The pub package manager makes sure that you have all the packages that
the app needs.

{% prettify lang-sh %}
pub get
{% endprettify %}
</div>
</div> <div class="col-md-5" markdown="1">

</div></div>

### <i class="fa fa-anchor"> </i> Edit lib/server/piratesapi.dart.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

Add an `@ApiClass` annotation to the `PiratesApi` class.
Add `@ApiMethod` annotations to the `listPirates()` and
`shanghaiAPirate()` methods.

{% prettify dart %}
library pirate.server;

import 'package:rpc/api.dart';

import '../common/messages.dart';
import '../common/utils.dart';

// This class defines the interface that the server provides.
[[highlight]]@ApiClass(version: 'v1')[[/highlight]]
class PiratesApi {
  final Map<String, Pirate> _pirateCrew = {};
  final PirateShanghaier _shanghaier = new PirateShanghaier();

  PiratesApi() {
    var captain = new Pirate.fromString('Lars the Captain');
    _pirateCrew[captain.toString()] = captain;
  }

  // Returns a list of the pirate crew.
  [[highlight]]@ApiMethod(path: 'pirates')[[/highlight]]
  List<Pirate> listPirates() {
    return _pirateCrew.values.toList();
  }

  // Generates (shanghais) and returns a new pirate.
  // Does not add the new pirate to the crew.
  [[highlight]]@ApiMethod(path: 'shanghai')[[/highlight]]
  Pirate shanghaiAPirate() {
    var pirate = _shanghaier.shanghaiAPirate();
    if (pirate == null) {
      throw new InternalServerError('Ran out of pirates!');
    }
    return pirate;
  }
}
{% endprettify %}
</div>
<div class="trydart-filename">lib/server/piratesapi.dart</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* The [RPC](https://github.com/dart-lang/rpc) package allows
  you to create RESTful server-side Dart APIs.

* Identify the top-level API class with the `ApiClass` annotation
  to expose this class as a public API. A version number is required.

* Identify remotely accessible methods with the `ApiMethod` annotation.
  Unless otherwise specified with the optional `method` parameter,
  all methods are assumed to send GET requests.

* The required `path` parameter in the `ApiMethod` annotation specifies
  how to invoke the method via an HTTP request, as you will see in
  [Step 3](#step-three).

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> <div class="col-md-5" markdown="1">

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

##Step 3: Launch the server {#step-three}

In this step, you start up the server and make an HTTP request to
verify that it's running.

### <i class="fa fa-anchor"> </i> Check the code.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

Use `dartanalyzer` to check the code for errors
(unless you're using a tool, such as Dart Editor or WebStorm
that automatically analyzes code).
To run [dartanalyzer](/tools/analyzer/) from the command line,
do the following from the `working-dir` directory:

{% prettify lang-sh %}
dartanalyzer lib/server/piratesapi.dart
{% endprettify %}

You should see `No issues found.` If the code has problems, you
can fix it or use the code from `2-simple`.

</div>
</div> <div class="col-md-5" markdown="1">

</div></div>

### <i class="fa fa-anchor"> </i> Start up the server.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

Use the `dart` command to launch the server:

{% prettify lang-sh %}
dart bin/piratesnest.dart
{% endprettify %}

You should see the following output:

{% prettify bash %}
[INFO] rpc: Adding /piratesApi/v1 to set of valid APIs.
Server listening on http://0.0.0.0:8088
{% endprettify %}
</div>
</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

<ul markdown="1">
<li markdown="1">The `INFO` message is displayed by the logging code.
</li>

<li markdown="1"> When you start up the server, 
  you might see a dialog asking, 'Do you want the application "dart"
  to accept incoming network connections?' This dialog,
  from the computer's firewall, is asking if you want to be able to
  connect to the Dart server from a different computer. Since you
  are using localhost, you can "Deny" the request and it will still work.
</li>

<li markdown="1"> If you are running the server from an IDE,
  you might also see:

{% prettify bash %}
Observatory listening on http://127.0.0.1:53264
{% endprettify %}

  Observatory is Dart's profiling tool&mdash;you can ignore this message.
</li>
</ul>

</div></div>

### <i class="fa fa-anchor"> </i> Test the server.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

You can test the server in a browser, or by using the curl utility.

<aside class="alert alert-info" markdown="1">
**Note:**
Open a new shell to run any curl commands. Logging messages
appear in the shell where you launched the server.
</aside>

To make an HTTP request to the server, first construct a URL. For example:

<img src="images/url.png" width="75%" alt="a sample HTTP request" />

The server listens on `localhost:8088`, as specified in the
`main()` method. The class name, version,
and method name are specified in the ApiClass.

You can test the server either in a browser, or by using curl.

For example, to request the list of pirates from the server,
do one of the following:

<ul markdown="1">
<li markdown="1">Navigate to
  [http://localhost:8088/piratesApi/v1/pirates](http://localhost:8088/piratesApi/v1/pirates)
  in a browser.
</li>

<li markdown="1">Type the following at the command line:

{% prettify bash %}
curl http://localhost:8088/piratesApi/v1/pirates 
{% endprettify %}
</li>
</ul>

Initially, the crew contains only the captain:

{% prettify bash %}
[
 {
  "name": "Lars",
  "appellation": "Captain"
 }
]
{% endprettify %}

The window running the server displays logging messages for
this GET command.

</div>
</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

<ul markdown="1">
<li markdown="1"> Don't be alarmed if you see the following warning
when messaging the server from the browser:

{% prettify bash %}
[WARNING] rpc: 
Response
  Status Code: 400
  ...
  RPC Error with status: 400 and message: Invalid request, missing API name
  and/or version: http://localhost:8088/favicon.ico.
{% endprettify %}
</li>
</ul>

</div></div>

##Step 4: Extend the server API {#step-four}

In this step, you extend the server API to support POST 
and DELETE requests so that you can store and delete pirate names
in the list of pirates.

### <i class="fa fa-anchor"> </i> Edit lib/server/piratesapi.dart.

<div class="trydart-step-details" markdown="1">

To support adding a pirate,
add a `hirePirate()` method to the PiratesApi class.
</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

{% prettify dart %}
// This class defines the interface that the server provides.
@ApiClass(version: 'v1')
class PiratesApi {
  ...
  [[highlight]]@ApiMethod(method: 'POST', path: 'pirate')[[/highlight]]
  [[highlight]]Pirate hirePirate(Pirate newPirate) {[[/highlight]]
    [[highlight]]// Make sure this is a real pirate...[[/highlight]]
    [[highlight]]if (!truePirate(newPirate)) {[[/highlight]]
      [[highlight]]throw new BadRequestError([[/highlight]]
          [[highlight]]'$newPirate cannot be a pirate. \'Tis not a pirate name!');[[/highlight]]
    [[highlight]]}[[/highlight]]
    [[highlight]]var pirateName = newPirate.toString();[[/highlight]]
    [[highlight]]if (_pirateCrew.containsKey(pirateName)) {[[/highlight]]
      [[highlight]]throw new BadRequestError([[/highlight]]
          [[highlight]]'$newPirate is already part of your crew!');[[/highlight]]
    [[highlight]]}[[/highlight]]

    [[highlight]]// Add the pirate to the crew.[[/highlight]]
    [[highlight]]_pirateCrew[pirateName] = newPirate;[[/highlight]]
    [[highlight]]return newPirate;[[/highlight]]
  [[highlight]]}[[/highlight]]
  ...
}
{% endprettify %}
</div>
<div class="trydart-filename">lib/server/piratesapi.dart</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key Information </strong>

* Annotating the method with `ApiMethod` exposes it as available remotely.

* The optional `method` parameter identifies the request type:
  `hirePirate` is a POST request.

* The required `path` parameter specifies how to access this method
  from an HTTP request.

* For POST requests, the RPC package requires that the method take a message
  class as a parameter. A message class must have a public constructor and
  public fields. Our message class, Pirate, is defined in `messages.dart`.

* If the pirate is successfully added to the crew, the server returns the
  Pirate object as a response message.

* The POST request's body (which is in JSON) is automatically deserialized
  into a Pirate object, and the returned Pirate object is
  automatically serialized into the response body as JSON.

</div></div>

<div class="trydart-step-details" markdown="1">

<p></p>
To support deleting a pirate, 
add a `firePirate()` method to the PiratesApi class.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
// This class defines the interface that the server provides.
@ApiClass(version: 'v1')
class PiratesApi {
  ...
  [[highlight]]@ApiMethod([[/highlight]]
      [[highlight]]method: 'DELETE', path: 'pirate/{name}/the/{appellation}')[[/highlight]]
  [[highlight]]Pirate firePirate(String name, String appellation) {[[/highlight]]
    [[highlight]]var pirate = new Pirate()[[/highlight]]
      [[highlight]]..name = Uri.decodeComponent(name)[[/highlight]]
      [[highlight]]..appellation = Uri.decodeComponent(appellation);[[/highlight]]
    [[highlight]]var pirateName = pirate.toString();[[/highlight]]
    [[highlight]]if (!_pirateCrew.containsKey(pirateName)) {[[/highlight]]
      [[highlight]]throw new NotFoundError('Could not find pirate \'$pirate\'!' +[[/highlight]]
          [[highlight]]'Maybe they\'ve abandoned ship!');[[/highlight]]
    [[highlight]]}[[/highlight]]
    [[highlight]]return _pirateCrew.remove(pirateName);[[/highlight]]
  [[highlight]]}[[/highlight]]
  ...
}
{% endprettify %}
</div>
<div class="trydart-filename">lib/server/piratesapi.dart</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key Information </strong>

* Annotating the method with `ApiMethod` exposes it as available remotely.

* The optional `method` parameter identifies `firePirate` as a DELETE request.

* The required path parameter, set here to '`pirate/{name}/the/{appellation}`',
  specifies how to access this method from an HTTP request.
  `name` and `appellation` are path parameters that are parsed by the
  RPC package and passed to the method as String values.

</div></div>

### <i class="fa fa-anchor"> </i> Check the code.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

Run `dartanalyzer` on `piratesapi.dart`. From the top of `working-dir`:

{% prettify lang-sh %}
dartanalyzer lib/server/piratesapi.dart
{% endprettify %}

If the analyzer finds issues, you can debug them, or you can
use the code in `4-extended`.

</div>

</div> <div class="col-md-5" markdown="1">

</div> </div>

### <i class="fa fa-anchor"> </i> Start up the server.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

Restart the server.

{% prettify lang-sh %}
dart bin/piratesnest.dart
{% endprettify %}

</div>

</div> <div class="col-md-5" markdown="1">

</div> </div>

### <i class="fa fa-anchor"> </i> Test the new API.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

Verify the new API for adding and deleting pirates.
This step requires curl.

Constructing a curl command for a POST or DELETE request is
a little different than for a GET request.
If you recall, we annotated the `hirePirate` method like this:

{% prettify dart %}
@ApiMethod(method: 'POST', path: '[[highlight]]pirate[[/highlight]]')
{% endprettify %}

To access the `hirePirate` method, use `pirate` as the last bit of the URL.
You can pass data in curl using the `-d` parameter, so the following command
adds "Shams the Destroyer" to the list of pirates:

On Mac and Linux:

{% prettify bash %}
curl -d '{"name":"Shams", "appellation":"Destroyer"}' http://localhost:8088/piratesApi/v1/pirate
{% endprettify %}

On Windows:

{% prettify bash %}
curl -d "{\"name\":\"Shams\",\"appellation\":\"Destroyer\"}" http://localhost:8088/piratesApi/v1/pirate
{% endprettify %}

The `firePirate` method was annotated like this:

{% prettify dart %}
@ApiMethod(method: 'DELETE', path: '[[highlight]]pirate/{name}/the/{appellation}[[/highlight]]')
{% endprettify %}

The following command deletes "Shams the Destroyer":

{% prettify bash %}
curl -X DELETE http://localhost:8088/piratesApi/v1/pirate/Shams/the/Destroyer
{% endprettify %}

Play with the server by adding and deleting pirates.
You might try the following:

* Add the same pirate twice.
* Delete the same pirate twice.
* Add a pirate with a _forbidden_ appellation (as defined in `utils.dart`),
  such as "Brad the Beautiful" or "Horatio the Wuss".

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* The DELETE request (`firePirate`) demonstrates how to specify parameters
  directly in the HTTP request. The POST request (`hirePirate`) demonstrates
  how to use a message class for passing values.
  Either approach is valid depending on your needs:

    * Only path and query parameters can be specified in the URL directly.

    * The message class enables using more advanced data structures.

</div> </div>

##Step 5: Generate the client API {#step-five}

In the previous step, you added POST and DELETE methods to the
PiratesApi class.
In this step, you use the generator from the RPC package to
create a PiratesApi class that can be used by a client app.
After you have completed this step, a new `lib/client/`
directory contains the generated API.

![The 5-generated directory structure](images/generated-clientapi-directory-structure.png)

### <i class="fa fa-anchor"> </i> Create the client API using the RPC generator. 

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

From within the `working-dir` directory run the following commands:

{% prettify lang-sh %}
pub global activate rpc
pub global run rpc:generate client -i lib/server/piratesapi.dart -o lib/client
{% endprettify %}

You should see the following output:

{% prettify bash %}
[SUCCESS] piratesapi v1 @ lib/client
{% endprettify %}

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* The RPC generator creates a <code>lib/client/<em>name</em>.dart</code> file,
  where _name_ is based on the name of the server API class. For example,
  if PiratesApi were defined in a file named `lib/server/ahoy.dart`,
  the client filename would still be `lib/client/piratesapi.dart`.
  
* This file allows you to connect your client app to the server, as you will
  see in [Step 6](#step-six).

* If you are using Dart Editor, you can update the file listing
  by right-clicking the package name and choosing
  **Refresh** from the menu that pops up.

</div> </div>

### <i class="fa fa-anchor"> </i> View the generated RESTful API.

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details" markdown="1">

You can view the full listing of the generated file in the
`lib/client/` directory, but let's look an overview of the code:

{% prettify dart %}
library server_code_lab.piratesApi.client;
...

[[highlight]]class PiratesApi[[/highlight]] {

  final commons.ApiRequester _requester;

  [[highlight]]PiratesApi(http.Client client, {core.String rootUrl: "http://localhost:8080/", core.String servicePath: "piratesApi/v1/"}) :[[/highlight]]
    ...

  async.Future<Pirate> [[highlight]]firePirate(core.String name,[[/highlight]]
                                  [[highlight]]core.String appellation)[[/highlight]] {
    ...
  }

  async.Future<Pirate> [[highlight]]hirePirate(Pirate request)[[/highlight]] {
    ...
  }

  async.Future<core.List<Pirate>> [[highlight]]listPirates()[[/highlight]] {
    ...
  }

  async.Future<Pirate> [[highlight]]shanghaiAPirate()[[/highlight]] {
    ...
  }
}

class PirateFactory {
  static Pirate fromJson(core.Map _json) {
    ...
  }

  static core.Map toJson(Pirate message) {
    ...
  }
}
{% endprettify %}
</div>
<div class="trydart-filename">lib/client/piratesapi.dart</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* For each method marked with `ApiMethod` in `server/piratesapi.dart`,
  the RPC generator creates a corresponding method in `client/piratesapi.dart`.
  
* The RPC generator assumes that the server is messaging on
  `http://localhost:8080/`.  Our server uses port 8088,
  so the client app must override the default URL when instantiating
  this class, as you will see in the next step.

* These generated methods return Futures, indicating that they
  return before their work is complete. In the next step you'll see
  how to write code that uses these asynchronous methods.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div></div>

##Step 6: Connect the client to the server {#step-six}

This step shows how to call the server from
a Dart client using the generated client API.

To save time, we've modified the Pirate example from the
[client code lab](/codelabs/darrrt/) with additional UI
for creating and maintaining a nest of pirates. 
We've also updated the UI to use
[material design](http://www.google.com/design/spec/material-design/introduction.html#introduction-goals),
as shown in the following screen shot:

<img src="images/piratebadgeUI.png" alt="The PirateBadge UI" style="border:1px solid #021a40" >

### <i class="fa fa-anchor"> </i> Get the client app.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

**Copy the `web` directory from `6-client` to your package.**

After you have copied the `web` directory to your working directory,
the package should look like this:

![The 6-starter directory structure](images/client-server-directory-structure.png)

The bolded files implement the client app, PirateBadge.

`piratebadge.css`
: The styling for the browser page.

`piratebadge.dart`
: The Dart code specifying the app's behavior.

`piratebadge.html`
: The browser page for displaying the PirateBadge app.

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* If you are using Dart Editor, you can update the file listing
  by right-clicking the package name and choosing
  **Refresh** from the menu that pops up.

</div> <div class="col-md-5" markdown="1">

</div> </div>

### <i class="fa fa-anchor"> </i> View the code.

<div class="trydart-step-details" markdown="1">

You can view the full listing of the client code in the
`web/` directory, but let's look at an overview of piratebadge.dart:

</div>

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">
{% prettify dart %}
...

import 'package:http/browser_client.dart';
import 'package:server_code_lab/client/piratesapi.dart';
import 'package:server_code_lab/common/messages.dart';
import 'package:server_code_lab/common/utils.dart';

...

// By default the generated client code uses
// 'http://localhost:8080/'. Since our server is running on
// port 8088 we override the default url when instantiating
// the generated PiratesApi class.
[[highlight]]final String _serverUrl = 'localhost:8088/';[[/highlight]]
final BrowserClient _client = new BrowserClient();
[[highlight]]PiratesApi _api;[[/highlight]]
[[highlight]]PirateShanghaier _shanghaier;[[/highlight]]

Future main() async {
  // We need to determine if the client is using http or https
  // and use the same protocol for the client stub requests
  // (the protocol includes the ':').
  var protocol = window.location.protocol;
  [[highlight]]_api = new PiratesApi(_client, rootUrl: '$protocol//$_serverUrl');[[/highlight]]
  _shanghaier = new PirateShanghaier();

  ...
}

Future refreshList() async {
  [[highlight]]List<Pirate> pirates = await _api.listPirates();[[/highlight]]
  ...
}

void updateBadge(Event e) {
  String inputName = (e.target as InputElement).value.trim();
  [[highlight]]var pirate = _shanghaier.shanghaiAPirate(name: inputName);[[/highlight]]
  ...
}

Future storeBadge(Event e) async {
  var pirateName = badgeNameElement.text;
  if (pirateName == null || pirateName.isEmpty) return null;
  var pirate = new Pirate.fromString(pirateName);
  try {
    [[highlight]]await _api.hirePirate(pirate);[[/highlight]]
  } catch (error) {
    ...
  }
  ...
}

...

Future removeBadge(Event e) async {
  ...
  var option = pirateList.options.elementAt(idx);
  var pirate = new Pirate.fromString(option.label);
  try {
    [[highlight]]await _api.firePirate(pirate.name, pirate.appellation);[[/highlight]]
  } catch (error) {
    ...
  }
  ...
}

Future removeAllBadges(Event e) async {
  for (var option in pirateList.options) {
    var pirate = new Pirate.fromString(option.label);
    try {
      [[highlight]]await _api.firePirate(pirate.name, pirate.appellation);[[/highlight]]
    } catch (error) {
      // ignoring errors.
    }
  }
  ...
}

void generateBadge(Event e) {
  var pirate = _shanghaier.shanghaiAPirate();
  setBadgeName(pirate);
}

...

void [[highlight]]addRippleEffect(MouseEvent e)[[/highlight]] {
  ...
}
{% endprettify %}
</div>
<div class="trydart-filename">web/piratebadge.dart</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* The generated server API assumes that the server uses `localhost:8080`,
  but our server is actually serving on port 8088, so the client has to set
  it explicitly.

* The client creates `_api`, an instance of the client-side PiratesApi class.

* The client calls the server through the `_api` instance, using
  the API generated in [Step 5](#step-five).
  For example, the client fetches the current pirate crew asynchronously by
  calling `_api.listPirates()`.

* The client's UI uses
  [material design](http://www.google.com/design/spec/material-design/introduction.html#introduction-goals).
  The material design visuals are mostly implemented in `piratebadge.css`.
  When clicked,
  a material design button animates&mdash;a wave ripples outward from the
  point of contact. The `addRippleEffect` method,
  implemented in Dart code, provides this effect.

&nbsp; {% comment %} non-breaking space required for bootstrap/markdown bogosity {% endcomment %}

</div> </div>

### <i class="fa fa-anchor"> </i> Run the code.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

Before launching the client, run `pub get` and launch the server.

{% prettify lang-sh %}
pub get
dart bin/piratesnest.dart
{% endprettify %}

You have a few options for launching the client.

<ul markdown="1">
<li markdown="1">Launch the client using Dartium.

Start up Dartium (remember that it's called Chromium on your file system).
Use **File > Open File...** and select `piratebadge.html` from the `web`
directory of your package.
</li>

<li markdown="1">Launch the client using your IDE.
Right-click `web/piratebadge.html` and choose the `Run in Dartium` option
(or equivalent) from the menu.
</li>

<li markdown="1"> Run `pub build` and launch the generated version in any browser.
The following opens the app in your default browser on a Mac.

{% prettify lang-sh %}
pub build
open build/web/piratebadge.html
{% endprettify %}
</li>
</ul>

</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* Running `pub build` prints the following:

  "WARNING: dart:mirrors support in dart2js is
  experimental, and not recommended.
  This implementation of mirrors is
  incomplete, and often greatly increases
  the size of the generated JavaScript code."

  You can ignore this warning. The HTTP library uses mirrors to instantiate
  platform-specific classes on the VM and, in this case,
  does not cause code bloat.

* When running the client app, you might see these logging statements:

  Refused to set unsafe header "user-agent"<br>
  Refused to set unsafe header "content-length"

  These messages are caused by the generated code trying to set these
  header fields. You can ignore these messages.

* If Dartium's status indicator spins indefinitely, don't worry.
  The PirateBadge app might well be loaded and running.

</div></div>

##Step 7: Serve the client from the server {#step-seven}

In this step, you modify the server so that it serves the client
in the browser&mdash;you no longer have to explicitly launch the
client app.

### <i class="fa fa-anchor"> </i> Edit pubspec.yaml, and run pub get.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

Add the `http_server` dependency to the `pubspec.yaml` file, which
is directly under `working-dir`.

{% prettify yaml %}
name: server_code_lab
version: 0.1.0
author: Dart Team <misc@dartlang.org>
description: Code-lab server sample.
environment:
  sdk: '>=1.9.0 <2.0.0'
dependencies:
  _discoveryapis_commons: ^0.1.0
  browser: ^0.10.0+2
  crypto: ^0.9.0
  http: ^0.11.1
  [[highlight]]http_server: ^0.9.5+1[[/highlight]]
  logging_handlers: ^0.8.0
  rpc: ^0.3.0
{% endprettify %}
<div class="trydart-filename">pubspec.yaml</div>

<p>&nbsp;</p>
Update the dependencies:

{% prettify lang-sh %}
pub get
{% endprettify %}

</div>

</div> <div class="col-md-5" markdown="1">

* If you aren't familiar with caret syntax for pubspec files, see
  [Caret syntax](/tools/pub/dependencies.html#caret-syntax), a
  section in [Pub Dependencies](/tools/pub/dependencies.html).

</div></div>

### <i class="fa fa-anchor"> </i> Edit bin/piratesnest.dart.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

Import the `dart:async` and `http_server` packages.

{% prettify dart %}
[[highlight]]import 'dart:async';[[/highlight]]
import 'dart:io';

[[highlight]]import 'package:http_server/http_server.dart';[[/highlight]]
import 'package:logging/logging.dart';
import 'package:rpc/rpc.dart';
{% endprettify %}
</div>
<div class="trydart-filename">bin/piratesnest.dart</div>

</div> <div class="col-md-5" markdown="1">

<i class="fa fa-key key-header"> </i> <strong> Key information </strong>

* The `http_server` package is used to serve the client app.

</div></div>

<div class="trydart-step-details" markdown="1">

<p></p>
Add the following code to create a virtual directory for serving the
client from the `build/web` directory.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
final ApiServer _apiServer = new ApiServer(prettyPrint: true);

[[highlight]]final String _buildPath =[[/highlight]]
    [[highlight]]Platform.script.resolve('../build/web/').toFilePath();[[/highlight]]
[[highlight]]final VirtualDirectory _clientDir = [[/highlight]]
    [[highlight]]new VirtualDirectory(_buildPath);[[/highlight]]
{% endprettify %}
</div>
<div class="trydart-filename">bin/piratesnest.dart</div>

</div> <div class="col-md-5" markdown="1">

<!-- * xxx abc -->

</div></div>

<div class="trydart-step-details" markdown="1">

<p></p>
Add a request handler that examines the request and vectors it to
the right place.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
[[highlight]]Future requestHandler(HttpRequest request) async {[[/highlight]]
  [[highlight]]if (request.uri.path.startsWith('/piratesApi')) {[[/highlight]]
    [[highlight]]// Handle the API request.[[/highlight]]
    [[highlight]]var apiResponse;[[/highlight]]
    [[highlight]]try {[[/highlight]]
      [[highlight]]var apiRequest = new HttpApiRequest.fromHttpRequest(request);[[/highlight]]
      [[highlight]]apiResponse =[[/highlight]]
          [[highlight]]await _apiServer.handleHttpApiRequest(apiRequest);[[/highlight]]
    [[highlight]]} catch (error, stack) {[[/highlight]]
      [[highlight]]var exception =[[/highlight]]
          [[highlight]]error is Error ? new Exception(error.toString()) : error;[[/highlight]]
      [[highlight]]apiResponse = new HttpApiResponse.error([[/highlight]]
          [[highlight]]HttpStatus.INTERNAL_SERVER_ERROR, exception.toString(),[[/highlight]]
          [[highlight]]exception, stack);[[/highlight]]
    [[highlight]]}[[/highlight]]
    [[highlight]]return sendApiResponse(apiResponse, request.response);[[/highlight]]
  [[highlight]]} else if (request.uri.path == '/') {[[/highlight]]
    [[highlight]]// Redirect to the piratebadge.html file. This will initiate[[/highlight]]
    [[highlight]]// loading the client application.[[/highlight]]
    [[highlight]]request.response.redirect(Uri.parse('/piratebadge.html'));[[/highlight]]
  [[highlight]]} else {[[/highlight]]
    [[highlight]]// Serve the requested file (path) from the virtual directory,[[/highlight]]
    [[highlight]]// minus the preceeding '/'. This will fail with a 404 Not Found[[/highlight]]
    [[highlight]]// if the request is not for a valid file.[[/highlight]]
    [[highlight]]var fileUri = new Uri.file(_buildPath)[[/highlight]]
        [[highlight]].resolve(request.uri.path.substring(1));[[/highlight]]
    [[highlight]]_clientDir.serveFile(new File(fileUri.toFilePath()), request);[[/highlight]]
  [[highlight]]}[[/highlight]]
[[highlight]]}[[/highlight]]
{% endprettify %}
</div>
<div class="trydart-filename">bin/piratesnest.dart</div>

</div> <div class="col-md-5" markdown="1">

* If the incoming request begins with the `/piratesApi` string
  (for example, if it's a curl command) vector that request to ApiServer.

* If the incoming request doesn't specify any file,
  serve `/piratebadge.html` (the default); this loads the client app.

* Otherwise, serve the requested file. Specifying an invalid file
  results in a 404 error.

</div></div>

<div class="trydart-step-details" markdown="1">

<p></p>
Instruct the server to listen on the `requestHandler` method.
</div>

<div class="row"> <div class="col-md-7">

<div class="trydart-step-details">
{% prettify dart %}
main() async {
  // Add a bit of logging...
  Logger.root..level = Level.INFO
             ..onRecord.listen(print);

  // Set up a server serving the pirate API.
  _apiServer.addApi(new PiratesApi());
  HttpServer server =
      await HttpServer.bind(InternetAddress.ANY_IP_V4, 8088);
  server.listen([[highlight]]requestHandler[[/highlight]]);
  print('Server listening on http://${server.address.host}:'
        '${server.port}');

}
{% endprettify %}
</div>
<div class="trydart-filename">bin/piratesnest.dart</div>

</div> <div class="col-md-5" markdown="1">

<!-- * xxx abc -->

</div></div>

### <i class="fa fa-anchor"> </i> Run the code.

<div class="row"> <div class="col-md-7" markdown="1">

<div class="trydart-step-details" markdown="1">

Update the dependencies.

{% prettify lang-sh %}
pub get
{% endprettify %}

Run the analyzer on the code, if your IDE or editor didn't already do so.

{% prettify lang-sh %}
dartanalyzer bin/piratesnest.dart
{% endprettify %}

Build the client app.

{% prettify lang-sh %}
pub build
{% endprettify %}

Kill any previous instances of the server and relaunch.

{% prettify lang-sh %}
dart bin/piratesnest.dart
{% endprettify %}

In your browser, navigate to
<a href="http://localhost:8088/piratebadge.html" target="_blank">http://localhost:8088/piratebadge.html</a>.

Play with the server by creating a pirate crew.

Can you add the same pirate twice?
: The client's UI protects you from some of the errors that
  you could trigger when constructing an HTTP request.

Can you create a pirate name with a custom appellation, such as Magnus the Magnificent?
: The client app doesn't use the full functionality
  that the server provides&mdash;and that's ok!

</div>
</div> <div class="col-md-5" markdown="1">

<!-- * xxx -->

</div> </div>

##What next? {#whatnext}

Now that you've played with a Dart server,
what is next? Here are some suggestions.

### <i class="fa fa-anchor"> </i> Deploy your application to AppEngine.

<div class="trydart-step-details" markdown="1">

[Step 8](https://github.com/dart-lang/one-hour-codelab/tree/appengine-auth/server/8-appengine)
of the appengine-auth branch of the one-hour-codelab repo
modifies the server so that you can deploy it to AppEngine.
</div>

### <i class="fa fa-anchor"> </i> Add authentication.

<div class="trydart-step-details" markdown="1">

[Step 9](https://github.com/dart-lang/one-hour-codelab/tree/appengine-auth/server/9-auth)
of the appengine-auth branch of the one-hour-codelab repo
modifies the server to require a Google Account login.
</div>

### <i class="fa fa-anchor"> </i> Make your server API discoverable.

<div class="trydart-step-details" markdown="1">

The RPC package allows you to expose your API in the Discovery document format.
This means that clients can download the API description in JSON and generate
client stubs to call the server API using a Discover document generator,
such as the 
[Discovery API generator for Dart](https://github.com/dart-lang/discoveryapis_generator).

You can read more at
[Google APIs Discovery Service](https://developers.google.com/discovery/).
</div>

### <i class="fa fa-anchor"> </i> Read the tutorials.

<div class="trydart-step-details" markdown="1">
Learn more about Dart from [The Dart Tutorials](/docs/tutorials/).
In particular,
the [Write HTTP Clients & Servers](/docs/tutorials/httpserver/)
tutorial has more information on server-side programming.
</div>

<hr>

##Summary {#summary}

This code lab introduced you to the RPC package,
a powerful tool for creating a RESTful server API
without writing a lot of boilerplate code.

You learned:

* How to specify a server's API, using the RPC package.

* How to create the corresponding client API using the RPC generator.

* How to create libraries that a client and server can share, by writing
  code that depends on neither dart:io nor dart:html.

* How to use the API generated by the RPC package.

* How to modify the server to serve the client directly.

### <i class="fa fa-anchor"> </i> Feedback

<div class="trydart-step-details" markdown="1">

Please provide feedback to the appropriate repo:

* [www.dartlang.org repo](https://github.com/dart-lang/www.dartlang.org/issues)
* [one-hour-codelab repo](https://github.com/dart-lang/one-hour-codelab/issues)
* [rpc repo](https://github.com/dart-lang/rpc/issues)

</div>
