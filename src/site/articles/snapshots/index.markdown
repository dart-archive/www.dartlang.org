---
layout: default
title: "Snapshots in Dart"
rel:
  author: siva-annamalai
description: "Learn how snapshots can help your apps start up faster."
has-permalinks: true
article:
  written_on: 2013-02-13
  collection: language-details
---

# {{ page.title }}

<em>Written by Siva Annamalai <br />
<time pubdate date="2013-02-13">February 2013</time>
</em>

This article talks about snapshots in Dart—both
what they are and how they can make Dart apps start up faster.
If you write command-line apps,
you should be able to improve their startup time
by generating your own snapshots,
following the instructions in this article.

If you write web apps, you don’t need to do anything:
browsers with the Dart VM can snapshot your app automatically.
The next time your web app runs,
the browser can retrieve the snapshot from the browser cache
and use it to start your app faster.


{% include toc.html %}


## What is a snapshot?

A snapshot is a sequence of bytes
that represents a serialized form
of one or more Dart objects.
This representation closely corresponds to
the way these Dart objects are represented
in an isolate’s heap in memory.

The Dart VM uses snapshots for two main reasons:

* **Speeding up initial startup time**
  for an application.
  A snapshot of the core libraries and application script
  typically contains preparsed data for
  the core libraries and the application script.
  This means it is not necessary to parse and tokenize
  the libraries and script during startup.

* **Passing objects**
  from one isolate to another isolate.
 
The Dart VM uses the following kinds of snapshots:

* A **full snapshot**,
  which is a complete representation of
  an isolate’s heap after it is initialized.
  This is used by the Dart VM for
  fast startup and initialization of
  the entire Dart core library and other libraries
  such as dart:uri, dart:io, dart:utf, dart:json, dart:isolate, and so on.

* A **script snapshot**,
  which is a complete representation of
  an application script in an isolate’s heap
  after the script is loaded into the isolate,
  but before the script starts executing.
  This is used by the Dart VM for
  fast startup and initialization of applications.
  For example, the script that starts dart2js
  uses a pre-created script snapshot of the dart2js application.

* An **object snapshot**.
  Messaging from one isolate to another
  is implemented in the Dart VM by
  creating a snapshot of the Dart object
  that needs to be sent to the other isolate.


## How the browser can use snapshots

A browser that contains the Dart VM uses
a full snapshot for fast startup and initialization
of the main Dart isolate.
This snapshot contains the entire Dart core library and other libraries
such as dart:uri, dart:utf, dart:json, dart:isolate, and dart:html.

In addition, the browser could potentially generate
a script snapshot of an application that has been loaded
and cache it in the browser cache.
This cached script snapshot could then be used for
subsequent reloads of the application for faster application startup.


## How to generate and use script snapshots

You can generate and use script snapshots using the Dart VM (dart).

<aside class="alert alert-info" markdown="1">
**Note:**
Don't bother creating a script
snapshot for a program that you're going to run
just a few times.
A script snapshot is useful only for deployed applications
where the cost of creating the snapshot
is amortized over many launches.
</aside>

To generate a script snapshot,
use dart with the `--snapshot` option.
You can use the `--package_root` option
to specify the location of packages used in imports
(`import 'package:...'`).

<pre>
dart <em>[</em>--package_root=<em>path]</em> --snapshot=<em>out-file</em> <em>dart-script-file</em>
</pre>

The `--snapshot` option writes
a script snapshot of _dart-script-file_ to _out-file_.
For example, the following command creates
a snapshot of the Dart script `dart2js.dart`,
putting it into a file called `dart2js.snapshot`.

{% prettify sh %}
dart --snapshot=dart2js.snapshot \ 
    dart-sdk/lib/dart2js/lib/_internal/compiler/implementation/dart2js.dart
{% endprettify %}

To execute a script from its snapshot,
specify the snapshot file on the command line:

<pre>
dart <em>snapshot-file</em> <em>args</em>
</pre>

Any _args_ you specify are passed to the script.
For example, you can run dart2js like this,
passing `myscript.dart -oout.js` as command-line arguments to dart2js:

{% prettify sh %}
dart dart2js.snapshot myscript.dart -oout.js
{% endprettify %}

## How to generate full snapshots

Read this section if you’re working on
one of the rare projects that embed the Dart VM (for example, Dartium).
The gen_snapshot tool writes a full snapshot
(corelibs, dart:uri, dart:io, dart:utf, dart:json, dart:isolate, ...)
to _out-file_:

<pre>
gen_snapshot <em>[options]</em> --snapshot=<em>out-file</em>
</pre>

You can use the following _options_:

<table class="table">
  <tr style="text-align:left">
    <th>Option</th> <th>Description</th>
  </tr>
  <tr>
    <td class="nowrap">
      --package_root=<em>path</em>
    </td>
    <td>
      Specifies the location of packages used in imports
      (<code>import 'package:...'</code>).</td>
  </tr>
  <tr>
    <td class="nowrap">
      --url_mapping=<em>mapping</em>
    </td>
    <td>
      Provides a URL mapping on the command line for URI resolution
      during library imports.</td>
  </tr>
</table>


## Summary

We are currently working on trying to make the size of snapshots smaller,
as that has a direct impact on startup times.
As a part of this exercise,
some of the less frequently used libraries
might be removed from the full snapshot.

You can find more information about snapshots
and how they are implemented by browsing the files in the
[dart/runtime/vm directory](http://code.google.com/p/dart/source/browse/#svn%2Fbranches%2Fbleeding_edge%2Fdart%2Fruntime%2Fvm).
Start by looking for "Snapshot" in
[snapshot.h](http://code.google.com/p/dart/source/browse/branches/bleeding_edge/dart/runtime/vm/snapshot.h).
Note that the code might move as the implementation changes.
