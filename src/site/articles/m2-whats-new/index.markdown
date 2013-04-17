---
layout: default
title: "What's New with Dart's M2 Release"
rel:
  author: seth-ladd
description: "A brief introduction to some of the SDK changes that rolled out
              in the M2 release for Dart."
has-permalinks: true
article:
  written_on: 2012-12-01
  collection: language-details
---

# {{ page.title }}

_Written by Seth Ladd <br>
December 2012_

Milestone 2 is the second beta release of the Dart SDK.
During the Milestone 2 cycle, the team gave a first round of TLC
to the Dart libraries. Also included in the M2 cycle are major new
features like self-service uploads to pub, SSL in the VM, theme support in Dart
Editor, the Web UI package, and much more.

While not an exhaustive list, here are some of the highlights from M2.

{% include toc.html %}


## dart2js shrinks generated code size, gets a startup boost
{:#dart2js-shrinks-output}

The dart2js tool compiles Dart code into ECMAScript 5 JavaScript. During the
second milestone, the team worked on reducing the size of the generated
JavaScript. They approached this challenge from two angles.

First, a top-to-bottom review of dart:html helped dart2js figure out which DOM
classes can't possibly be in use. If a class isn't used, it can be "shaken" out
and not included in the generated code. The results of this work were
impressive, often reducing by half the contribution of dart:html to the
application size.

Second, work has started on a more aggressive minifier. Early stats are
promising, especially when you factor in gzip. For example, here are some stats
from a real-life sample:

* Dart size: 302k
* JavaScript size: 505k (167% of Dart size)
* Minified JS size: 238k (79% of Dart size, 47% of JS size)
* Gzipped minified size: 71.2k (23% of Dart size, 14% of JS size)

There's still more work to do but we're encouraged by the early progress in this
front. The feedback is loud and clear, dart2js output size is a top priority for
the team.

In other dart2js news, the Dart-to-JavaScript compiler removed support for old
language features. For example, the following are no longer allowed in code
compiled by dart2js:

* \#import
* interface declarations
* getters with ()
* === and !==
* Dynamic

To greatly speed up the time it takes to run the tool, the Dart SDK now includes
a snapshot of dart2js. A snapshot is a binary, serialized file of parsed Dart
code, taken before the program starts to execute. The Dart VM can experience up
to a 10X startup improvement with snapshots, because the VM avoids loading and
parsing textual source code.

## Library refactorings

The team made some sweeping changings to the core libraries during M2.

To start, many exceptions are now errors. For example, IndexOutOfRangeException
is now RangeError, and NotImplementedException is now UnimplementedError. The
library designers feel that many traditionally named exceptions are really
unrecoverable errors.

Related, NullPointerException is gone, replaced by NoSuchMethodError. The
original NullPointerException had two major issues: there are no pointers in
Dart, and it is not an exception. Remember, null is an object in Dart (as is
everything else). If code calls a method that does not exist on the null object,
noSuchMethod will handle it by simply throwing NoSuchMethodError. You can read
more about the justifications for this change.

The dart:coreimpl library is no more. Any functionality worth keeping will find
itself moved to other libraries. This reduces confusion about what the Dart
SDK's library surface area is.

The core libraries have embraced getters and setters. For example, the following
changes occurred during the M2 cycle:

* Map.getKeys() ⇒ Map.keys
* Map.getValues() ⇒ Map.values
* Match.start() / Match.end() / Match.groupCount() ⇒ Match.start / Match.end / Match.groupCount
* Iterator.hasNext() ⇒ Iterator.hasNext
* num.isNaN() / num.isInfinite() / num.isEven() / ... ⇒ num.isNaN / num.isInfinite / num.isEven / ...

While the following features did not launch during the M2 cycle, the Dart team
did announce a sneak peak at the
[Streams API](http://news.dartlang.org/2012/11/introducing-new-streams-api.html)
and continued clarifying the Mixins
proposal. Keep these on your radar for future milestones.

## dart:html simplifications
{:#dart-html-simplifications}

The dart:html library continues to be simplified and refactored to feel more
like Dart.

Many names have been changed to conform to Dart style. For example:

* DOMURL is now Url
* innerHTML is now innerHtml
* addText and addHtml are now appendText and appendHtml

In some cases, functionality that is generally considered to be an anti-pattern
was removed. For example, Window.prompt is no longer supported. And by "no
longer supported" I mean, "removed from dart:html".

Some functionality that didn't quite work out was also removed. The asynchronous
Element.getBoundingClientRect(), which used to return a Future, is now
synchronous. The original thinking was that a Future-based query for DOM element
dimensions would mitigate the potential to trigger a reflow (a costly
operation). In practice, though, it seemed to cause more harm than good. Based
on feedback from the community, Element.getBoundingClientRect() simply returns a
ClientRect.

However, reflows and layout measurements can still be costly. The dart:html
library now has a requestLayoutFrame function, which will call a callback when
the next batch of browser layout measurements has completed.

The dart:html library added new classes for the different types of input fields.
For example, you can instantiate a RadioButtonInputElement, instead of setting
the right properties on an InputElement. See
[InputElement API docs](http://api.dartlang.org/docs/bleeding_edge/dart_html/InputElement.html)
for a complete list.

The DOM is a tree, and elements have children, so it only made sense to rename
Element.elements to Element.children.

Large sets of functionality have been moved over to their own libraries,
cleaning up the old monolithic DOM namespace. For example, SVG, Web Audio, and
IndexedDB have been pulled out into their own libraries.

## Dart VM gets SSL and performance improvements
{:#dart-vm-gets-ssl}

Big news for authors of libraries that need to connect to public web services:
the Dart VM now supports SSL. You can create a web server that speaks HTTPS, or
connect to HTTPS resources.

With the language spec stabilized, the VM team has focused on performance.
Initial measurements show a 50% improvement over V8 on some benchmarks. Much
more work needs to be done here, but check out
[dartlang.org/performance/](/performance/) for charts
and details.

Prompted by performance work while integrating Dart VM into Chromium, the VM and
the language spec now define strings as UTF-16 code units (no longer treating
strings as Unicode code points). This primarily means it is now faster to get
strings in and out of the VM when embedded in a browser. While the language
spec was changed in M1, the VM implemented this change in M2.

## Documentation for new web developers and game developers
{:#new-docs}

If you are comfortable with object-oriented software development, but new to
browser programming, the Dart team launched a set of
[tutorials](https://www.dartlang.org/docs/tutorials/) just for you.
These exercises lead you through browser basics (DOM, elements, attributes,
and so on) and into the new Web UI package.

There is also a
[code lab](http://news.dartlang.org/2012/12/new-dart-web-ui-codelab.html)
that walks you through building a web app using Web UI.
This lab takes you step by step through the client and the server code.

Dart's performance and structure are especially interesting to game developers.
You can find articles and tutorials about building modern browser games with
Dart at [dartgamedevs.org](http://dartgamedevs.org/).

## Pub lets authors publish their own libraries
{:#pub-uploads}

Pub is a package manager for Dart. It helps developers install and update their
third-party dependencies, and now it supports self-service uploads of packages
to [pub.dartlang.org](http://pub.dartlang.org/). This means that developers can
easily share their libraries for others to use.

Thanks to this new publishing workflow, the SDK packages such as unittest,
logging, meta, and more are now found in pub. These packages, which previously
lived in the pkg directory of the SDK, now have a permanent home at
[pub.dartlang.org](http://pub.dartlang.org/). You need to
[update your pubspec.yaml](http://news.dartlang.org/2012/12/sdk-packages-now-available-on-pub.html)
files accordingly.

Learn more at [pub.dartlang.org](http://pub.dartlang.org/).

## Dart Editor helps developers manage more code
{:#dart-editor}

The editor added a GUI for editing pubspec.yaml, the file that declares a
package's dependencies. This GUI helps reduce syntax errors.

For developers that like to tweak their editor's syntax highlighting and colors,
Dart Editor now supports themes. The editor comes pre-bundled with many
different styles, and you can import your own.

A new WebGL sample was added to the editor's welcome screen. Try the Solar 3D
demo to see how pub, Dart vector math, and WebGL work together.

The editor can now recommend a union of declared and checked types for better
code completion. See the following screenshot for an example:

<img src="imgs/union-types-code-completion.png"
     alt="Code completion in Dart Editor">

Notice how, inside of the if block, the editor presents options for warrior
containing both the methods in Warrior as well as Ninja.

More cleanups were added to help developers stay up to date as the VM and
dart2js implement more M1 features and library changes. For example, a cleanup
can replace interface declarations with abstract classes and redirecting
constructors. See the following screenshot for an example of this in action:

<img src="imgs/dart-editor-clean-up.png"
     alt="Clean up old code with Dart Editor">

Dart Editor had a steady stream of weekly releases; read the full list of
[editor changes](http://news.dartlang.org/search/label/editor).

## Web UI builds on Web Components
{:#web-ui}

The Dart team released a preview of Web UI, a new package for building modern
web apps. Built on Web Components, and inspired by model-driven views, Web UI
helps you build custom components that encapsulate their style, behavior, and
structure. You can also create live templates with one-way and two-way data
binding.

Included in Web UI is a compiler that converts the Dart and Web Components code
into vanilla JavaScript and HTML. This means you can deploy your Web UI code
across modern browsers today.

Learn more about building structured web apps with a
[tutorial](/docs/tutorials/web-ui/), a
[code lab](http://news.dartlang.org/2012/12/new-dart-web-ui-codelab.html), and
[full documentation](/articles/dart-web-components/).

## New http, oauth2, and serialization packages
{:#new-packages}

Sharing is caring, so the Dart team extracted some libraries they use in their
projects and published them to pub.dartlang.org.

The [serialization package](http://pub.dartlang.org/packages/serialization)
provides
a general serialization facility for Dart
objects. The serialization library works using either reflection
or a more explicit declarative API.

The [http package](http://pub.dartlang.org/packages/http) provides a library
that has a Future-based composable API for making HTTP requests. This
library makes it easier to connect to HTTP resources from command-line Dart
apps.

The [oauth2 package](http://pub.dartlang.org/packages/oauth2) provides a
library for authenticating with a remote service
via OAuth2 on behalf of a user, and making authorized HTTP requests with the
user's OAuth2 credentials. This library works only with command-line Dart apps.

## Conclusion

We fixed many other bugs and made minor changes and clean-ups, but those
are the big ticket items. As always, your feedback, questions, and comments are
welcome on the
[mailing list](http://dartlang.org/mailing-list) and our
[issue tracker](http://dartbug.com).
