---
layout: article
title: "API Naming Guide"
rel:
  author: lasse-nielsen
description: "Choose good names to make your API easier to understand."
has-permalinks: true
article:
  written_on: 2015-02-03
  collection: everyday-dart
---

{% include toc.html %}
{% include breadcrumbs.html %}

# {{ page.title }}

<em>Written by Lasse Nielsen & Istvan Soos<br />
<time pubdate date="2015-02-03">February 2015</time>
</em>

This guide aims to help you pick good names for the Dart APIs that you create.
Although this advice is intended mostly for public APIs,
you can make all of your code easier to understand
by following these guidelines for all names—public,
private, or local.

<aside class="alert alert-info">
**Have feedback?**
Please [file an issue](https://github.com/dart-lang/www.dartlang.org/issues/new)
or add to an [existing issue](https://github.com/dart-lang/www.dartlang.org/issues?q=is%3Aopen+is%3Aissue+label%3AStyleGuide).
</aside>

Most of the guidelines here are common sense.
The goal, as always, is nice, readable, maintainable code.
If you feel that breaking the guidelines makes your code
easier to read or remember,
then go ahead and break the rules—but
only after careful consideration.

<aside class="alert alert-info">
**Note:**
The Dart libraries have some examples that don't follow these guidelines,
mostly because they're hard to change without breaking user code.
</aside>

See also these related articles:

* [Guidelines for Doc Comments](/articles/doc-comment-guidelines/):
  How to write API docs.
* [Dart Style Guide](/articles/style-guide/):
  General code conventions.
  Includes a [Names section](/articles/style-guide/#names)
  with rules that can be mechanically checked.
  For example:

  * Type names use UpperCamelCase.
  * Identifiers (including constants) use lowerCamelCase.
  * Libraries use lowercase_with_underscores,
    prefixed with the package name and a dot-separated path.


## General guidelines

The most important rule is to be consistent,
both within your API and with precedents set by
commonly used libraries.


### Be consistent

Use the same name for the same thing, throughout your API.
If a precedent already exists outside your API
that your API's users are likely to know,
follow that precedent.

<div class="good">
{% prettify dart %}
pageCount         // a field
updatePageCount() // consistent with pageCount
toSomething()     // consistent with Iterable's toList()
asSomething()     // consistent with List's asMap()
Point             // a familiar concept
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
countPages()         // confusingly different from pageCount
convertToSomething() // inconsistent with toX() precedent
wrappedAsSomething   // inconsistent with asX() precedent
Cartesian            // unfamiliar to most users
{% endprettify %}
</div>

Having one case be slightly longer or harder to use,
as long as it's consistent with the other cases, is still a win.


### Avoid abbreviations

Unless an abbreviation is more common than the unabbreviated term,
don't abbreviate.
If you do abbreviate,
[capitalize acronyms and abbreviations over two letters like words](/articles/style-guide/#do-capitalize-acronyms-and-abbreviations-longer-than-two-letters-like-words).

<div class="good">
{% prettify dart %}
pageCount
buildRectangles
IOStream
HttpRequest
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
numPages  // num is an abbreviation of number(of)
buildRects
InputOutputStream
HypertextTransferProtocolRequest
{% endprettify %}
</div>



### Put the most descriptive noun last

The last word should be the most descriptive of what the thing is.
You can prefix it with other words, such as adjectives,
to further describe the thing.

<div class="good">
{% prettify dart %}
pageCount             // a count (of pages)
ConversionSink        // a sink for doing conversions
ChunkedConversionSink // a ConversionSink that's chunked
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
numPages              // NOT pages
LinkedList            // NOT a List
{% endprettify %}
</div>

The LinkedList example would be fine if
[LinkedList](https://api.dartlang.org/apidocs/channels/dev/dartdoc-viewer/dart:collection.LinkedList)
implemented the
[List](https://api.dartlang.org/apidocs/channels/dev/dartdoc-viewer/dart:core.List)
interface, but it doesn't.
Another problem is that LinkedList has the same name as
a Java class that _is_ a List,
which is likely to confuse Dart programmers who have a Java background.


### Make code read like a sentence

When in doubt about naming,
write some code that uses your API,
and try to read it like a sentence.

<div class="good">
{% prettify dart %}
// if errors is empty...
if (errors.isEmpty)

// _subscription:cancel!
_subscription.cancel();

// stream:listen for data, and do something with that data.
stream.listen((data) => ...)

// Skip while x is even.
skipWhile((x) => x.isEven)
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
// errors:empty or errors is empty?
if (errors.empty)

// What does false mean?
_subscription.changeState(false);

// stream:register a listener for some kind of data?
stream.registerListener((data) => ...)

// Get a sublist... when? of what?
sublistStartingAfter((x) => x.isEven)
{% endprettify %}
</div>

Throughout this page, blue boxes marked **Readability note**
go into more detail about this guideline.


## Specific guidelines {#specific-guidelines}

Follow these guidelines when naming fields,
functions (including methods), and parameters.


### Non-booleans

Use noun phrases for non-boolean fields, getters, setters, and parameters.

<div class="good">
{% prettify dart %}
iterator
length
rampagingSwampBeast
{% endprettify %}
</div>

<aside class="alert alert-info">
  **Note:**
  Avoid write-only fields (setters without getters).
</aside>


### Booleans

Start boolean getters with a verb.

<div class="good">
{% prettify dart %}
bool get isEmpty
bool get hasElements
bool get canClose
bool get willCodeForMoney
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
empty        // hard to parse: adjective or verb?
withElements // sounds like it might hold elements
closeable    // sounds like an interface
codeForMoney // unclear
{% endprettify %}
</div>

<aside class="alert alert-info">
  **Readability note:**
  `canClose` is better than `closeable`
  because it reads better as a sentence.
  For example, `if (thingy.canClose) thingy.close()` reads as
  _if thingy can close, thingy:close!_
</aside>

The names of boolean fields or setters depend on the property.
Often, instead of having a field or setter,
it makes more sense to have a getter and
one or more state-changing methods.

<div class="good">
{% prettify dart %}
bool get isPaused
pause()
resume()
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
bool isPaused
{% endprettify %}
</div>

Sometimes a boolean property is (and will always be) simple,
and setting the property has only obvious consequences with no side effects.
In this case,
name the field or setter just like a boolean getter.

<div class="good">
{% prettify dart %}
bool shouldConsumeInput
{% endprettify %}
</div>

Boolean function parameters can omit the verb.
For example, the third argument to Isolate's `spawn()` method is `paused`,
not `isPaused`, because it's not a property.
(The isolate doesn't even exist, much less have properties,
until after the call to `spawn()`.)

<div class="good">
{% prettify dart %}
Isolate.spawn(function, argument, {paused: false, packageRoot})
{% endprettify %}
</div>


### Functions

Use verb phrases for most functions (including methods)
and function variables.

<div class="good">
{% prettify dart %}
add()
remove()
insertAfter()
updateRecord()
{% endprettify %}
</div>

If parts of a function name refer to the arguments (explicitly or implicitly),
try to keep the arguments in the same order.
Often it's OK to omit a word from the name if it's just
repeating the type or name of the argument.

<div class="good">
{% prettify dart %}
collection.remove(element)            // collection:remove element
parent.insertNodeBefore(node1, node2) // parent:insert node1 before node2
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
collection.removeElement(element) // "Element" is redundant.
parent.insertBefore(node1, node2) // parent:insert before node1: node2?
{% endprettify %}
</div>

<aside class="alert alert-info">
**Note:**
Some Dart API designers lean toward omitting words—preferring `insertBefore`
over `insertNodeBefore`, for example.
Whatever you choose to do,
be consistent and try to maximize code readability.
</aside>


### Parameterized properties

Methods such as `elementAt()` represent a property of an object,
and thus you should name them after the property,
without the redundant _get_ prefix.
Without any arguments, these methods would be getters,
but Dart doesn't support arguments for getters.

<div class="good">
{% prettify dart %}
elementAt(...)
{% endprettify %}
</div>

In some cases you can drop the `at` or `for` at the end,
but only if the method takes at least one required argument.
The List `sublist()` method is an example.

<div class="good">
{% prettify dart %}
sublist(int start, [int end])
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
sublist()
{% endprettify %}
</div>


### Optional parameters

Optional parameters can be either _positional_ (unnamed) or _named_.

Use **positional** optional parameters for values that users often provide,
and that have a logical progression.
Users should almost never need to provide a later positional argument without
also wanting to provide the former ones.

<div class="good">
{% prettify dart %}
String.fromCharCodes(Iterable source, [int start = 0, int end])
DateTime(year, month, day, [hours, minutes, seconds, milliseconds])
{% endprettify %}
</div>

Use **named** optional parameters for all boolean flags,
as well as for variables that apply independently of each other.

<div class="good">
{% prettify dart %}
toList({growable: true})
Duration({days: 0, hours: 0, minutes: 0, seconds: 0, milliseconds: 0, microseconds: 0})
{% endprettify %}
</div>

<aside class="alert alert-info" markdown="1">
**Dart language note:**
You can't use both positional and named optional parameters in the same 
function.
For example, we'd like to add `{bool isUtc:false}` to `DateTime()`,
but we can't.
A result can be inconsistencies when two similar functions use
positional and named parameters for the same things.
To be notified if Dart adds support for using both
positional and named optional parameters in the same function,
subscribe to notifications on
[issue 7056](https://github.com/dart-lang/sdk/issues/7056).
</aside>


## API choices

This section aims to help you choose between different kinds of API.
For now, it covers only choosing between a getter and a method.

### Getters vs. methods

If you're unsure whether to create a getter or a no-argument method,
ask these questions:

* Does the getter/method give different results if
  called multiple times in a row?
  <br>
  If so, make it a method.
* Does the getter/method have any other side effects?
  <br>
  If so, make it a method.
* Does the _user_ of the getter/method care more
  about the _computation_ the getter/method performs
  than the result?
  <br>
  If so, make it a method.

Otherwise, make it a getter.

Whichever you choose, name it according to the conventions in the
[Specific guidelines](#specific-guidelines) section.

## Precedents to follow

If your API converts objects, specifies ranges, or manages collections,
follow these precedents.


### toX() and asX()

For consistency with established APIs,
use `toX()` when making a copy,
and `asX()` when the returned value is backed by the original object
and represents the whole object.
When the returned value represents only part of the original object,
then instead of `asX()` use normal field or getter names—for example,
Map's `keys` and `values` properties.

Both `toX()` and `asX()` are methods, despite not having verbs.
The `asX()` method should probably have been a getter,
but `List.asMap()` sets the precedent to follow.


### Ranges

When specifying a range in a sequence with a length,
use _start_ (inclusive) and _end_ (exclusive)
to be consistent with existing APIs such as
[sublist()](https://api.dartlang.org/apidocs/channels/stable/dartdoc-viewer/dart:core.List#id_sublist).

<div class="good">
{% prettify dart %}
sublist(int start, [int end])
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
sublist(int from, [int to])
{% endprettify %}
</div>


### Collections

Collection classes usually omit _element_ from names,
since it's understood that you're operating on
a collection of elements.
Also, since collections are used frequently,
their names tend to omit verbs and, generally,
be shorter than usual.

<div class="good">
{% prettify dart %}
elementAt       // just "at" would be too short
first           // get the first element
firstWhere(...) // get the first element where ...
forEach(...)    // for each element, do ...
where(...)      // get all elements where ...
{% endprettify %}
</div>

<aside class="alert alert-info">
**Readability note:**
The `where()` method is especially cryptic,
but it's a little less so in usage.
For example, you can read
`iterable.where((element) => element.isEven)` as
_iterable elements where the element is even._
</aside>

