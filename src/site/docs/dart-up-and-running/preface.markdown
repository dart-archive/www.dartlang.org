---
layout: book
title: "Preface"
subsite: "Dart Up and Running"
description: "Read the preface of Dart: Up and Running (published by O'Reilly)."
prev-chapter: foreword.html
prev-chapter-title: "Foreword"
next-chapter: ch01.html
next-chapter-title: "Quick Start"
---

{% include toc.html %}
{% include book-nav.html %}

# {{ page.title }}

You don’t need to be an expert web developer to build web apps. With
Dart, you can be productive as you build high-performance apps for the
modern web.

Our aim for this book is to be a useful introduction to the Dart
language, libraries, and tools. For the latest
news, keep an eye on this site and
[news.dartlang.org](http://news.dartlang.org/).

The text for this work is available at the
[www.dartlang.org GitHub project](https://github.com/dart-lang/www.dartlang.org)
(at [src/site/docs/dart-up-and-running/](https://github.com/dart-lang/www.dartlang.org/tree/master/src/site/docs/dart-up-and-running/))
under the [Creative Commons
Attribution-Noncommercial-No Derivative Works 3.0 United States
License.](http://creativecommons.org/licenses/by-nc-nd/3.0/us/) Source
code files for this book’s [samples](https://github.com/dart-lang/dart-up-and-running-book/tree/master/code)
are also on GitHub.

If you find an error in the sample code or text, please [create an
issue.](https://github.com/dart-lang/www.dartlang.org/issues/new)

## Conventions used in this book

The following typographical conventions are used in this book:

* _Italic_:
  Indicates new terms, URLs, email addresses, filenames, and file
  extensions.

* `Constant width`:
  Used for program listings, as well as within paragraphs to refer to
  program elements such as variable or function names, databases, data
  types, environment variables, statements, and keywords.

* <b><code>Constant width bold</code></b>:
  Shows commands or other text that should be typed literally by the
  user.

* <em><code>Constant width italic</code></em>:
  Shows text that should be replaced with user-supplied values or by
  values determined by context.

<aside class="alert alert-info" markdown="1">
**Note:**
A tip, suggestion, or general note.
</aside>

<!-- TODO: Make sure warnings are formatted as warnings. -->

<aside class="alert alert-warning" markdown="1">
  **Warning:**
  A warning or caution.
</aside>

## Using code examples

Supplemental material (code examples, exercises, etc.) is available for
download at
[*https://github.com/oreillymedia/dart\_up\_and\_running*](https://github.com/oreillymedia/dart_up_and_running).

This book is here to help you get your job done. In general, if example
code is offered with this book, you may use it in your programs and
documentation. You do not need to contact us for permission unless
you’re reproducing a significant portion of the code. For example,
writing a program that uses several chunks of code from this book does
not require permission. Selling or distributing a CD-ROM of examples
from O’Reilly books does require permission. Answering a question by
citing this book and quoting example code does not require permission.
Incorporating a significant amount of example code from this book into
your product’s documentation does require permission.

We appreciate, but do not require, attribution. An attribution usually
includes the title, author, publisher, and ISBN. For example: “*Dart: Up
and Running* by Kathy Walrath and Seth Ladd (O’Reilly). Copyright 2014
Kathy Walrath and Seth Ladd, 978-1-449-33089-7.”

If you feel your use of code examples falls outside fair use or the
permission given above, feel free to contact us at
<permissions@oreilly.com>.


## Content updates {#preface-updates}

This section gives details about how the book has changed between each
of its printings, and how the online content has changed after the most
recent printing.


### Changes after the third printing

Added documentation for language features introduced after 1.0:

- Null-aware operators:
  - [??](ch02.html#conditional-expressions)
  - [??=](ch02.html#assignment-operators)
  - [?.](ch02.html#other-operators)
- [Enumerated types](ch02.html#enums)
- [Deferred loading](ch02.html#deferred-loading)
- [Asynchrony support](ch02.html#asynchrony)

Updated the [Keywords](ch02.html#keywords) section
to add the following words,
which are associated with new or proposed features:

- async
- async*
- await
- deferred
- sync*
- yield
- yield*

Moved the contents of [Chapter 4 (Tools)](ch04.html) out of the book,
and into [Dart Tools](/tools/).

Removed Chapter 5, "Walkthrough: Dartiverse Search".
For information on writing a Dart server, see the
[server code lab](https://dart-lang.github.io/server/codelab/).

Fixed a few bugs:

-   Stopped saying that local variables are lazily initialized.
-   Improved the code for the sin() example.
-   Improved the comments and code for the hide elements example.
-   Changed an example to use FormatException instead of the
    non-existent ExpectException.
-   Updated a few links.

Went through all the code samples and made them comply with the latest
[Dart Style Guide](/articles/style-guide/) recommendations.

For 1.9, went through all the code samples in chapters 2 & 3,
changing `then()` to `await` almost everywhere.
Also changed `listen()` to `await for` as appropriate.


### Changes in the third printing: February 19, 2014

We've changed the text and examples to reflect these language changes:

-   Instance variables can no longer be `const`. Use `static
              const` variables instead.

-   The `?` operator for testing whether an optional parameter has been
    set is no longer in the language.

-   Keys in map literals no longer need to be strings.

-   Dart now has Symbols and symbol literals (`#`).

-   Function equality testing is easier.

-   Bitwise operators have higher precedence than they used to.

We've also updated the content to reflect API changes. In dart:core:

-   Set’s `isSubsetOf()` method is gone. Instead, use the Set
    `containsAll()` method. You can convert any Iterable to a Set using
    `toSet()`.

-   The Collection class is gone, so we’ve changed the way we talked
    about sets, lists, and maps, and we talk more about Iterable.

-   The functionality in the former dart:uri library is now in the Uri
    class in dart:core. The top-level functions `encodeUri()`,
    `encodeUriComponent()`, `decodeUri()`, and `decodeUriComponent()`
    are now static methods in Uri named (respectively) `encodeFull()`,
    `encodeComponent()`, `decodeFull()`, and `decodeComponent()`. To
    create a Uri from a string, you now use the static `parse()` method.
    Uri now has a single constructor, which takes the arguments that the
    `Uri.fromComponents()` constructor used to take. Finally, the
    `domain` field is now named `host`.

-   The @deprecated, @override, and @proxy annotations moved from the
    meta package to dart:core.

In dart:io:

-   File’s `openWrite()` method now has no required parameters but two
    optional named parameters. The `mode` parameter has a default value
    of `FileMode.WRITE`.

-   File’s `readAsString()` and `readAsLines()` methods no longer
    require a parameter. Instead, they have an optional named parameter
    (`encoding`), with a default value of `Encoding.UTF_8`.

-   IOSink’s methods for writing data have changed. To write string
    data, instead of `addString()` use `write()`. The method for writing
    binary data was temporarily renamed to `writeBytes()`, but reverted
    back to `add()`.

A new dart:convert library replaces dart:json and dart:uri:

-   Instead of a StringDecoder, use `UTF8.decoder` to convert UTF-8
    characters into a Dart string.

-   Instead of a LineTransformer, use a LineSplitter object to split a
    stream of strings into a stream of individual lines.

-   Where you used to use dart:json's top-level `parse()` and
    `stringify()` functions, use `JSON.decode()` and `JSON.encode()`,
    respectively.

-   Where you used to use dart:uri's top-level `decodeUri()` and
    `encodeUri()` functions, use `UTF8.decode()` and `UTF8.encode()`,
    respectively.

Other API changes include:

-   In dart:html, the `query()` and `queryAll()` methods changed to
    `querySelector()` and `querySelectorAll()`, respectively.

-   The dart:crypto library moved out of the SDK (to
    <https://pub.dartlang.org/packages/crypto>).

-   The AsyncError class was removed (from dart:async).

-   The dart:isolate library was refactored to have only core
    primitives. We removed its coverage from the book but expect higher
    level APIs to come along that make using isolates easier.

-   The main() function now takes an optional argument (List\<String\>).

The sections that talk about tools have changed, too:

-   The dart\_analyzer tool has been replaced by dartanalyzer.

-   Command-line arguments for many tools have changed.

-   The pub tool now has build and serve commands, which work with
    transformers to convert your source files into their final format.

-   We fleshed out the dart2js docs.

-   We removed the dartdoc coverage from the book, since we expect the
    interface to change significantly.

We also added new coverage of previously undocumented features and
tweaked existing coverage. In the language tour:

-   Added the section
    <a href="ch02.html#adding-features-to-a-class-mixins">Adding
    features to a class: mixins</a>.

-   In the <a href="ch02.html#keywords">keywords</a> section,
    marked which keywords are built-in identifiers and discussed
    how they differ from reserved words.

-   Added coverage of the + operator for strings.

-   Discussed using expressions (such as function calls) as arguments to
    a non-default constructor.

-   Added examples of using the @override and @proxy annotations.

-   Changed the doc comment example to match the latest guidelines, and
    pointed to [Guidelines for Dart Doc
    Comments](/articles/doc-comment-guidelines/).

In the library tour:

-   Added <a href="ch03.html#dartmirrors---reflection">dart:mirrors - reflection</a>.

-   Added examples of parsing non-decimal numbers.

-   Removed the incorrect `new` from the example of using Future.wait().

-   Removed coverage of Completer, which is no longer recommended.

-   Added the <a href="ch03.html#stream">Stream</a> section.

Throughout the book, we updated links to related topics.

Finally, we completely rewrote
the final, walkthrough chapter
to feature a new example (Dartiverse Search).

### Changes in the second printing: March 29, 2013

We’ve updated the content to reflect the following changes since the
first printing:

-   Using `part of` in additional library files is now *required*, not
    optional.

-   In M2, several APIs changed:

    -   In the dart:html library, the `elements` property of Element
        changed to `children`.

    -   Names in dart:html changed to conform to Dart naming standards.
        In particular, `innerHTML` became `innerHtml`.

    -   The `charCodes()` method of String became a getter, so we
        removed the parentheses from all references to `charCodes`.

    -   The `readAsText()` method of File became `readAsString()`.

    -   Constructors for the Date class changed.

    -   NullPointerException no longer exists.

    -   RegExp no longer has a const constructor.

    -   The return type of StringBuffer’s `add()` method changed to
        void. Code that used to chain calls to `add()` should now use
        method cascades instead.

-   The recommended way for web apps to use `dart.js` is now to have a
    local copy, preferably one downloaded using the `browser` pub
    package.

-   Metadata support was added to the language.

-   We added references to the [Web UI
    package](/articles/web-ui/), which provides a
    higher level, scalable approach to creating UIs for web apps.

-   In M3, mixins were added to the language, enabling code re-use
    between classes.

-   The core libraries were greatly revised in M3 or shortly afterward.
    Changes include:

    -   Some methods changed to fields or getters. This meant we had to
        remove the `()` after `hashCode`, `isEmpty`, and `isNan`. We
        also changed `getKeys()` to `keys`, and `getValues()` to
        `values`.

    -   The Iterable class was beefed up, affecting all Collections such
        as Lists and Sets. The former Collection methods `filter()` and
        `map()` moved to Iterable, and the name of `filter()` changed to
        `where()`. (`map()` was briefly renamed to `mappedBy()`, but due
        to public feedback that decision was reversed.) The `some()`
        method changed to `any()`. Many values returned by Iterables are
        now lazily-filled Iterables; you can use `toList()` or `toSet()`
        to force evaluation. We recommend *extending* Iterable rather
        than just implementing it, so you can take advantage of added
        functionality.

    -   The Iterator interface changed from `next()` and `hasNext()` to
        `current` and `moveNext()`.

    -   The dart:json library no longer has a JSON class. Former JSON
        static methods such as `parse()` and `stringify()` are now
        top-level functions.

    -   Date is now named DateTime, and the `fromString()` constructor
        is now a static method named `parse()`.

    -   Event-handler registration used to be
        <code>.on.<em>event</em>.add()</code>; now it’s
        <code>.on<em>Event</em>.listen</code>.

    -   The dart:html HttpRequest `get()` method was replaced by
        `getString()` and `request()`, which return Future\<String\> and
        Future\<HttpRequest\>, respectively.

    -   The dart:html Window `setTimeout()` method is gone; instead, use
        `Future.delayed()` or, if you know what you’re doing, a Timer.

    -   Timer and Completer moved from dart:isolate to a new library
        called dart:async. The Timer constructors now take a Duration
        instead of an int.

    -   The Future `chain()` and `handleException()` methods are gone,
        replaced by `then()` and `catchError()`.

    -   The String `splitChars()` method is gone; instead, use `split()`
        with an empty string argument. String’s `charCodes` getter and
        `charCodeAt()` method are gone; to get UTF-16 code units, use
        String’s `codeUnits` or `codeUnitAt()` instead.

    -   The StringBuffer `add()` and `addAll()` methods were replaced by
        `write()` and `writeAll()`, respectively.

    -   The dart:io library changed significantly after M3, as did all
        I/O in Dart. I/O now centers around the dart:async library’s
        Stream and Future classes, instead of callbacks. The InputStream
        and OutputStream classes were replaced with classes implementing
        [Stream](http://api.dartlang.org/docs/releases/latest/dart_async/Stream.html)
        and [IOSink.](http://api.dartlang.org/dart_io/IOSink.html) A new
        [FileSystemEntity](http://api.dartlang.org/dart_io/FileSystemEntity.html)
        class is the superclass of File and Directory. To create a new
        HttpServer, you now use the static `bind()` method. For more
        information, see the
        [announcement.](http://news.dartlang.org/2013/02/io-library-now-uses-streams.html)

    -   The most used dart:crypto methods for hashes changed from
        `update()` and `digest()` to `add()` and `close()`.

We corrected or clarified some text, such as:

-   Bitwise operators are implemented in **int**, not num.

-   The `is` and `as` examples (in
    <a href="ch02.html#type-test-operators">Type test operators</a>)
    aren’t completely equivalent.

We also added sections for some pre-existing features:

-   Keywords
-   Lexical scope
-   Function equality
-   The dart\_analyzer tool

Finally, the first figure in
<a href="ch01.html#why-google-created-dart">Why Google created Dart</a>
now uses a more recent benchmark and has the latest numbers.


## Acknowledgments

We’d like to thank the many people who contributed to this book. We hope
we haven’t forgotten anyone, but we probably have.

The following Dart engineers and managers gave us prompt, helpful
reviews and information for the sections corresponding to their areas of
responsibility: Mads Ager, Peter von der Ahé, Justin Fagnani, Emily
Fortuna, Søren Gjesse, Dan Grove, Matthias Hausner, Florian Loitsch,
Ryan Macnak, Sam McCall, John McCutchan, Vijay Menon, John Messerly,
Anton Muhin, Lasse R.H. Nielsen, Bob Nystrom, Keerti Parthasarathy, Ivan
Posva, Konstantin Scheglov, Brian Wilkerson, and Jaime Wren.

We’d especially like to thank the people who reviewed even bigger swaths
of the book or contributed in other, large ways:

-   JJ Behrens, whose careful look at the first draft of the book helped
    us catch errors and inconsistencies, as well as rework
    the walkthrough to be more
    interesting, and less of a laundry list. He also created a system
    for testing our samples.

-   Shailen Tuli, who helped test our examples although he didn’t even
    work for Google.

-   Mary Campione, whose stream-of-consciousness review of the entire
    book, performed while she was first learning the language, helped us
    find and fix many confusing spots, as well as some errors. Later she
    reviewed and updated our samples, and she implemented continuous
    build testing for our samples on drone.io.

-   Phil Quitslund, who did a big-picture review of the book and gave us
    guidance and encouragement.

-   Kasper Lund, whose review caught issues that only someone with his
    expert, comprehensive knowledge of the Dart language and libraries
    could have found.

-   Gilad Bracha, the language spec writer whose reviews of the language
    chapter were invaluable for getting language details right. We
    couldn’t cover everything, so we look forward to his future work on
    making all the corners of the language understandable to all Dart
    programmers.

-   Anders Johnsen, who wrote the Dartiverse Search app and reviewed
    Chapter 5's walkthrough of that app.

Other Googlers helped, as well. Vivian Cromwell, the head of Chrome
Developer Relations, supported our work on this book. Andres Ferrate,
the Google Press liaison to O’Reilly, helped simplify the process of
getting the book published. Myisha Harris gave us excellent legal
advice.

The people at O’Reilly were extremely helpful. Meghan Blanchette, our
editor, kept everything going smoothly, monitoring our progress in the
nicest possible way. Christopher Hearse, Marisa LaFleur, and Melanie
Yarbrough checked our work and helped us make some last-minute fixes
that improved the final result. We’d also like to thank the good people
who manage the author workflow and make working on an O’Reilly book such
a pleasure. We personally worked with Sarah Schneider, Jessica Hosman,
and Rachel James.

Finally, we thank Lars Bak and Kasper Lund for writing the foreword, and
most of all for creating Dart.


<hr>
{% include book-nav.html %}
