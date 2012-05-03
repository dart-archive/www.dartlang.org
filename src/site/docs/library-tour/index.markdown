---
layout: default
title: "A Tour of the Dart Libraries"
description: "Learn how to use each major Dart library feature."
---

# {{ page.title }} 

<section class="overview" markdown="1">

Welcome to the Dart library tour!
We'll show you how to use each major Dart library feature,
including the core, HTML, JSON, server IO libraries, and more.

This tour only serves to provide an overview of
library functionality, it is by no means comprehensive.
Consult the
[Dart API reference](http://api.dartlang.org/)
for the full details about a library or interface.

<aside class="note" markdown="1">
**Note:** Expect major changes to the Dart libraries before a 1.0
release.
</aside>

#### Contents {#toc}

1. ToC
{:toc .toc}

</section>

## Core libraries

The Dart core libraries form a small but critical set of built-in functionality.

### Collections

Dart ships with a core Collections API. Included are interfaces for Lists,
Maps, and Sets.

#### Lists

A [List](http://api.dartlang.org/dart_core/List.html) in Dart is an ordered
collection of items. List is analogous to an array in other languages.
Lists are zero indexed, and may contain duplicate items.

{% pc dart 0 %}
// list literal
var fruits = ['applies', 'oranges'];

// list constructor
var fruits = new List();

// add to a list
fruits.add('applies');

// add multiple items to a list
fruits.addAll(['oranges', 'bananas']);

// get the list length
assert(fruits.length == 3);

// access a list item by index
assert(fruits[0] == 'apples');

// find an item in a list
assert(fruits.indexOf('apples') == 0);

// sort a list
fruits.sort((a, b) => a.compareTo(b));
assert(fruits[1] == 'bananas');

// remove a single item
var appleIndex = fruits.indexOf('apples');
fruits.removeRange(appleIndex, 1);
assert(fruits.length == 2);

// remove all elements from a list
fruits.clear();
assert(fruits.length == 0);
{% endpc %}

Lists are parameterized types, so you can specify the type that a list
should contain.

{% pc dart 0 %}
// this list should contain only strings
var fruits = new List&lt;String>();

fruits.add('apples');
var fruit = fruits[0];
assert(fruit is String);

// generates static analysis warning, num is not a string
// throws exception in checked mode
fruits.add(5);  // BUG!
{% endpc %}

#### Sets

Sets are unordered collections of unique items. A set will guarantee that
there are no duplicate items in the collection. Because a set is unordered,
it does not support access items by index (position).

{% pc dart 0 %}
var ingredients = new Set();
ingredients.addAll(['gold', 'titanium', 'xenon']);
assert(ingredients.length == 3);

// adding a duplicate item has no effect
ingredients.add('gold');
assert(ingredients.length == 3);

// check if an item is in the set
assert(ingredients.contains('titanium') == true);

// check if all the items are in the set
assert(ingredients.containsAll(['titanium', 'xenon']) == true);

// create the intersection of two sets
var nobleGasses = new Set.from(['xenon', 'argon']);
var intersection = ingredients.intersection(nobleGasses);
assert(intersection.length == 1);
assert(intersection[0] == 'xenon');

// check if this set is a subset of another collection
// that is, if another collection contains all the items of this set
var allElements = ['hydrogen', 'helium', 'lithium', 'beryllium', '...',
                   'gold', 'titanium', 'xenon', '...'];
assert(ingredients.isSubsetOf(allElements) == true);

// remove item from a set
ingredients.remove('gold');
assert(ingredients.length == 2);
{% endpc %}

#### Common collection methods

Both List and Set extend the
[Collection](http://api.dartlang.org/dart_core/Collection.html) interface.
As such, they share common functionality found in all collections.

All the following examples work with any interface that extends Collection.

{% pc dart 0 %}
var teas = ['green', 'black', 'camomile', 'earl grey'];

// use forEach() to apply a function to every item in a collection
teas.forEach((tea) => print('I drink $tea'));

// use map() to create a new collection by applying a function to each
// item and collecting the results
var loudTeas = teas.map((tea) => tea.toUpperCase());
assert(loudTeas[0] == 'GREEN');

// camomile is not caffeinated
isDecaffeinated(String teaName) => teaName == 'camomile';

// use filter() to create a new collection with only the items
// that return true from the provided function
var decaffinatedTeas = teas.filter((tea) => isDecaffeinated(tea));
// or teas.filter(isDecaffeinated)

// use some() to check if at least one item in the collection
// satisfies a condition
assert(teas.some(isCaffeinated) == true);

// use every() to check if all the items in a collection
// satisfy a condition
assert(teas.every(isCaffeinated) == false);
// fyi: camomile does not have caffeine

// use isEmpty() to check if a collection has no items
assert(teas.isEmpty() == false);
{% endpc %}

#### Maps

Maps, also commonly known as dictionaries or hashes, are unordered
key/value pairs. Maps associate a key to some value for easy retrieval.

Unlike JavaScript, Dart objects are not all Maps.
Also, the Map interface does not extend Collection.

{% pc dart 0 %}
// map literals use strings as keys
var hawaiianBeaches = {
  "oahu" : ['waikiki', 'kailua', 'waimanalo'],
  "big island" : ['wailea bay', 'pololu beach'],
  "kauai" : ['hanalei', 'poipu']
};

// maps from constructors can use any hashable object as a key
var nobleGases = new Map();

// maps are parameterized types, you can specific what types
// the key and value should be
nobleGases = new Map&lt;int, String>();

// associate a key with a value
nobleGases[54] = 'xenon';

// retrieve a value with a key
assert(nobleGases[54] == 'xenon');

// check if a map contains a key
assert(nobleGases.containsKey(54) == true);

// remove a key, and its value
nobleGases.remove(54);
assert(nobleGases.containsKey(54) == false);
{% endpc %}

### Dates and times

A [Date](http://api.dartlang.org/dart_core/Date.html) is a point in time.
You can make a point in time relative to a
location with a [TimeZone](http://api.dartlang.org/dart_core/TimeZone.html).

#### Constructing dates

{% pc dart 0 %}
// get the current date and time
var now = new Date.now();

// create a new Date with the local time zone
var y2k = new Date(2000, 1, 1, 0, 0, 0, 0);

// specify all the parts of a date and time with a time zone
y2k = new Date.withTimeZone(2000, 1, 1, 0, 0, 0, 0, const TimeZone.utc());

// specify a date and time with the unix epoch, in ms
y2k = const Date.fromEpoch(1336017592000, const TimeZone.utc());

// parse a ISO 8601 date
y2k = new Date.fromString('2000-01-01T00:00:00Z');
{% endpc %}

#### The epoch

To get the number of milliseconds since the epoch,
use the `value` getter.

{% pc dart 0 %}
var y2k = new Date.fromString('2000-01-01T00:00:00Z');
var milliseconds = now.value;
assert(milliseconds == 946684800000);
{% endpc %}

#### Calculations

Use the [Duration](http://api.dartlang.org/dart_core/Duration.html) class to
calculate the difference between two dates
and to shift a date's time forward or backwards.

{% pc dart 0 %}
var y2k = new Date.fromString('2000-01-01T00:00:00Z');

// add one year
var y2001 = y2k.add(const Duration(366, 0, 0, 0, 0));
assert(y2001.year == 2001);

// subtract 30 days
var december2000 = y2001.subtract(const Duration(30, 0 ,0, 0, 0));
assert(december2000.year == 2000);
assert(december2000.month == 12);

// calculate the difference between two dates, returns a Duration
var duration = y2001.difference(y2k);
assert(duration.inDays == 366);
{% endpc %}

### Utility interfaces

The core library also contains various utility interfaces, useful for
sorting, maps, and iterating.

#### Comparing an object

Use the Comparable interface to indicate that an object can be compared
to another object, usually for sorting. The `compareTo` method
returns &lt; 0 for _smaller_,
0 for the _same_, and &gt; 0 for _bigger_.

{% pc dart 0 %}
class Line implements Comparable {
  final length;
  const Line(this.length);
  int compareTo(Line other) => length - other.length;
}

main() {
  var short = const Line(1);
  var long = const Line(100);
  assert(short.compareTo(long) < 0);
}
{% endpc %}

#### Acting as a key for maps

The Hashable interface indicates that an object can provide an integer
hashcode. The default implementation of Map, the HashMap, requires that its
keys implement Hashabe.

If you have an object that will be used as a key for a map, it should
implement Hashable. If two objects are equal, then their hashcodes must
be equal, too. A hashcode does not have to be unique, but it should
be well distributed.

{% pc dart 0 %}
// hashable demo
{% endpc %}

#### Iteration

Two interfaces make up iteration abilities in Dart. Implementing the Iteratable
interface implies the object can be iterated over. The Iterator iterface
defines the actual iteration ability.

An iterable object can provide an iterator, and an iterator is used to
iterate over an object.

{% pc dart 0 %}
// iteration demo
{% endpc %}

### Math and numbers

The Math class provides common functionality like sin/cos, max/min,
parsing strings into numbers, and constants like PI and E.

#### Trigonometry

Use the Math class for the basic trig functions.

{% pc dart 0 %}
// trig demos
{% endpc %}

#### Max and min

Optimized max and min methods are also provided by Math.

{% pc dart 0 %}
// max and min demo
{% endpc %}

#### Converting strings to numbers

You can convert a string into either an integer or double with the Math class.

{% pc dart 0 %}
// convert demo
{% endpc %}

#### Math constants

Find your favoritates, like PI and E, in Math.

{% pc dart 0 %}
// constants
{% endpc %}

#### Random number generator

Generate random numbers between 0.0 and 1.0 with the Math class.

{% pc dart 0 %}
// random
{% endpc %}

<aside class="note">
  <b>Note:</b> The current implementation of random() for the
  Dart VM is not random at all. Follow
  <a href="http://code.google.com/p/dart/issues/detail?id=499">bug 499</a>
  for the status.
</aside>

### Strings and regular expressions

Strings are immutable ordered lists of unicode code points.
Regular expressions are used by the string interface for
searching and replacing.

#### Searching inside a string

You can find particular locations within a string, as well as check
if a string begins with or ends with a particular pattern.

{% pc dart 0 %}
// basic string demos
{% endpc %}

#### Upper and lower case

Easily convert strings to their upper and lower case variants.

{% pc dart 0 %}
// upper and lower
{% endpc %}

#### Trimming and empty strings

Remove all leading and trailing whitespace with trim(), and check
if a string is empty (length is zero) with isEmpty().

{% pc dart 0 %}
// trim a string
assert('  hello  '.trim() == 'hello');

// check if a string is empty
assert(''.isEmpty() == true);

// strings with only whitespace are not empty
assert('  '.isEmpty() == false);
{% endpc %}

#### Regular expressions

Dart regular expressions have the same capabilities as JavaScript
regular expressions. Use regular expressions for efficient searching
and pattern matching of strings.

{% pc dart 0 %}
// regular expression demo
{% endpc %}

### Async programming

The use of asynchronous programming is on the rise, and Dart provides
a [Future](http://api.dartlang.org/dart_core/Future.html) interface as an
alternative to callback functions. A Future is
like a promise for a result to be provided "sometime in the future".

A Future's friend is the
[Completer](http://api.dartlang.org/dart_core/Completer.html). A Complete
helps by producing a Future
and later supplyng a value to it.

{% pc dart 0 %}
Future&lt;bool> longExpensiveSearch() {
  var completer = new Completer();
  database.search(() {
    // perform exhaustive search
    // ...
    // sometime later,
    // found it!!
    complete.complete(true);
  });
  return completer.future;
}

Future&lt;bool> result = longExpensiveSearch();

// when the search is complete, then() will be called
result.then((success) {
  print("The item was found: $success");
});
{% endpc %}

#### Chaining multiple async methods

The Future interface specifices a chain() method, which is a useful way
to write multiple async methods that are run in order.

{% pc dart 0 %}
Future result = costlyQuery();
result.handleException((exception) => print("DOH!"));

result.chain((value) => expensiveWork())
      .chain((value) => lengthyComputation())
      .then((value) => print("done!"));
{% endpc %}

In the above example, the methods run in the following order:

1. costlyQuery()
1. expensiveWork()
1. lengthyComputation()

#### Waiting for multiple futures

Sometimes your algorithm needs to initiate many asynchronous methods
and wait for each one to complete before continuing. Use the Futures class
to manage multiple Futures and wait for them all to complete.

{% pc dart 0 %}
Future deleteDone = deleteLotsOfFiles();
Future copyDone = copyLotsOfFiles();
Future checksumDone = checksumLotsOfOtherFiles();

Futures.join([deleteDone, copyDone, checksumDone]).then(() {
  print('Done with all the long steps');
});
{% endpc %}

### Exceptions

The Dart core library includes various common exceptions. Some of those
exceptions include:

[NoSuchMethodException](http://api.dartlang.org/dart_core/NoSuchMethodException.html)
: Thrown when a receiving object does not implement a method.

[NullPointerException](http://api.dartlang.org/dart_core/NullPointerException.html)
: Thrown when the program tries to call a method or access a field of a
null object.

[IllegalArgumentException](http://api.dartlang.org/dart_core/IllegalArgumentException.html)
: Can be thrown by a method that encounters an unexecpted argument.

There are many more built-in exceptions in the core library.

## Isolates

The [dart:isolate library](http://api.dartlang.org/dart_isolate.html) provides
interfaces for working with Dart's answer to parallel processing: the isolate.

Isolates are essentially discrete running programs inside a Dart environment.
Isolates are useful for securely partitioning your code into isolated
memory heaps. You can also use isolates to take advantage of multiple cores
on your machine, because each isolate can run concurrently on different
threads or processes.

Isolates do not share any memory, and thus are safer than threads for concurrent
programming. Isolates compile to web workers in JavaScript.

Isolates communicate by asynchronously exchanging messages. Each message
is copied when delivered to an isolate, ensuring no state is shared.

### Create an isolate

### Send and receive messages

## IO

The [dart:io library](http://api.dartlang.org/io.html) provides capabilities
for the Dart VM when running as a server on the command line. These libraries
are not yet available to Dart programs targeting the web browser.

### Files and directories

### Sockets

### HTTP server and client

### Web socket server

## JSON

## URI

## UTF

## Crypto

{% include syntax-highlighting.html %}