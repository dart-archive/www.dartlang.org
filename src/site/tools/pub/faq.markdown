---
layout: default
title: "Frequently Asked Questions about Pub"
---

{% include toc.html %}

# {{ page.title }}

Here are some frequently asked questions about [pub](/tools/pub/).

### What are pub's system requirements?

Pub runs on any platform that supports the Dart VM. That basically means
relatively recent versions of Mac, Linux and Windows.

However, Windows has some limitations:

* Windows XP is not supported.
* FAT32 file systems are not supported.
* Packages cannot be stored on a different drive than your user directory.
* Packages cannot be stored on network shares.

Pub relies on junction points for core functionality, and those aren't
available on the above. We realize these limitations are painful and we're
hoping to address the root cause but it will take a while to get there.

### What are all the "packages" directories for?

After you run pub, you'll notice that your package has little `packages`
directories sprinkled all over it. These are needed to make "package:" imports
work. When your code has an import with the "package" scheme, a Dart
implementation like the VM or dart2js translates that to a path or URL using a
simple rewriting rule:

 1. Take the URI of your application's [entrypoint](glossary.html#entrypoint).
 2. Strip off the trailing file name.
 3. Append "/packages/" followed by the rest of the import URL.

For example, if you app's entrypoint is `/dev/myapp/web/main.dart` then:

{% prettify dart %}
import 'package:unittest/unittest.dart';
{% endprettify %}

Magically turns into:

{% prettify dart %}
import '/dev/myapp/web/packages/unittest/unittest.dart';
{% endprettify %}

Then Dart loads that as normal. This behavior is a [specified][spec] part of
the Dart language. The example only works if you have a directory named
`packages` inside your `web` directory and that directory in turn contains the
packages that your app uses.

[spec]: http://www.dartlang.org/docs/spec/

Pub creates these directories for you. The main one it creates is in the root
of your package. Inside that, it creates symlinks pointing to the `lib`
directories of each package your app [depends][] on. (The dependencies
themselves will usually live in your [system cache][].)

[depends]: glossary.html#dependency
[system cache]: glossary.html#system-cache

After creating the main `packages` directory in your package's root, pub then
creates secondary ones in every [directory in your package where a Dart
entrypoint may appear](glossary.html#entrypoint-directory). Currently that's
`benchmark`, `bin`, `example`, `test`, `tool`, and `web`.

Pub also creates `packages` symlinks in *subdirectories* of any of those that
point back to the main one. Since you may have entrypoints under, for example,
`web/admin/controllers/`, pub makes sure a `packages` directory
is always nearby. Otherwise the imports won't work.

### I found a bug in pub. How do I report it?

We use the main [Dart bug tracker][]. Feel free to file a ticket. When you do,
please include:

[dart bug tracker]: https://code.google.com/p/dart/issues/list

* Your platform (Windows, Mac, Linux, etc.).
* The version you are running. (Run `pub version`.)
* If possible, include a log by running `pub --verbose <your command>`.

### How do I delete a package?

Once a package is published, you're strongly discouraged from deleting it.
After all, some user could already be depending on it! If you accidentally
include your password or something similarly secret in the package,
[file an issue][delete-request] and the Pub authors will take down your
package. You'll need to use a different version when you re-upload it.

[delete-request]: http://code.google.com/p/dart/issues/entry?summary=Request%20to%20delete%20package%20from%20pub&status=Triaged&labels=Type-Task,Priority-Medium,Area-Pub,Pub-DeleteRequest

### I get a timeout when I run pub. What do I do?

The [pub package server][] is hosted on [App Engine][]. We've seen a few times
where App Engine has run slowly for us and other users, leading to some
timeouts. If this happens, send us a note on the [mailing list][] and we'll
look into it. Usually it resolves itself in a few hours.

[pub package server]: http://pub.dartlang.org
[app engine]: https://appengine.google.com
[mailing list]: https://groups.google.com/a/dartlang.org/forum/?fromgroups#!forum/misc

### Why doesn't pub do ___?

Probably because we haven't implemented it yet. Pub is still under active
development. If you would like to see specific features, please
[file a ticket][dart bug tracker] after searching to make sure it hasn't
already been requested yet. If it has, star it so we know what things are
important to users.

Also, patches are more than welcome! Pub is [open source][] and we love outside
contributions. Both the [client][] and [server][] are well-tested,
well-documented, and, we hope, easy to contribute to.

[open source]: https://code.google.com/p/dart/wiki/GettingTheSource?tm=4
[client]: https://code.google.com/p/dart/source/browse/#svn%2Fbranches%2Fbleeding_edge%2Fdart%2Fsdk%2Flib%2F_internal%2Fpub
[server]: https://github.com/dart-lang/pub-dartlang

### What is the roadmap for pub?

We don't generally make public roadmaps for pub. The Dart project is very fluid
and priorities and schedules change very frequently. If we make promises for
the future, we are likely to end up disappointing users when plans change.

You can usually get a picture for what we are working on now by seeing which
[bugs we have started][started].

[started]: https://code.google.com/p/dart/issues/list?can=2&q=Area%3DPub+status%3AStarted+&colspec=ID+Type+Status+Priority+Area+Milestone+Owner+Summary&cells=tiles

### I still have questions. What should I do?

Send an email to the main Dart [mailing list][] and we'll see it.
