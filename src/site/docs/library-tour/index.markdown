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

## Strings, collections, and other core functionality

The Dart core library forms a small but critical set of built-in functionality.
This library is automatically imported into your Dart program.

### Collections

Dart ships with a core Collections API. Included are interfaces for Lists,
Maps, and Sets.

#### Lists

A [List](http://api.dartlang.org/dart_core/List.html) in Dart is an ordered
collection of items. List is analogous to an array in other languages.
Lists are zero indexed, and they can contain duplicate items.

##### Adding and removing

{% pc dart 0 %}
// list literal
var fruits = ['apples', 'oranges'];

// list constructor
fruits = new List();

// add to a list
fruits.add('applies');

// add multiple items to a list
fruits.addAll(['oranges', 'bananas']);

// get the list length
assert(fruits.length == 3);

// remove a single item
var appleIndex = fruits.indexOf('apples');
fruits.removeRange(appleIndex, 1);
assert(fruits.length == 2);

// remove all elements from a list
fruits.clear();
assert(fruits.length == 0);
{% endpc %}

##### Accessing and finding items

Lists use zero-based indexing, where zero
is the index of the first element, and
`list.length-1` is the index of the last
element. Use `indexOf()` to find
the index of an object in a list.

{% pc dart 0 %}
var fruits = ['apples', 'oranges'];

// access a list item by index
assert(fruits[0] == 'apples');

// find an item in a list
assert(fruits.indexOf('apples') == 0);
{% endpc %}

##### Sorting

Sort a list using the `sort()` method, and provide
a sorting function that compares two objects, returning
&lt; 0 for smaller, 0 for same, and &gt; 1 for larger.

{% pc dart 0 %}
var fruits = ['bananas', 'apples', 'oranges'];

// sort a list
fruits.sort((a, b) => a.compareTo(b));
assert(fruits[1] == 'bananas');
{% endpc %}

##### Generics

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

&rarr; Refer to the full
[List API docs](http://api.dartlang.org/dart_core/List.html)
for a full list of methods.

[Back to contents.](#toc)
{:.up-to-toc}

#### Sets

A [Set](http://api.dartlang.org/dart_core/Set.html)
is an unordered collection of unique items.
Because a set is unordered,
you can't get a set's items by index (position).

##### Adding and removing

{% pc dart 0 %}
var ingredients = new Set();
ingredients.addAll(['gold', 'titanium', 'xenon']);
assert(ingredients.length == 3);

// adding a duplicate item has no effect
ingredients.add('gold');
assert(ingredients.length == 3);

// remove an item from a set
ingredients.remove('gold');
assert(ingredients.length == 2);
{% endpc %}

##### Checking membership

Use `contains()` and `containsAll()` to check whether
an object or objects exists in the set.

{% pc dart 0 %}
var ingredients = new Set();
ingredients.addAll(['gold', 'titanium', 'xenon']);

// check whether an item is in the set
assert(ingredients.contains('titanium') == true);

// check whether all the items are in the set
assert(ingredients.containsAll(['titanium', 'xenon']) == true);
{% endpc %}

##### Intersection and subset

An intersection is a set whose items are in two other sets.
A subset has all of its items included
in another, potentially larger, collection.

{% pc dart 0 %}
var ingredients = new Set();
ingredients.addAll(['gold', 'titanium', 'xenon']);

// create the intersection of two sets
var nobleGasses = new Set.from(['xenon', 'argon']);
var intersection = ingredients.intersection(nobleGasses);
assert(intersection.length == 1);
assert(intersection[0] == 'xenon');

// check whether this set is a subset of another collection
// that is, does another collection contains all the items of this set
var allElements = ['hydrogen', 'helium', 'lithium', 'beryllium', '...',
                   'gold', 'titanium', 'xenon', '...'];
assert(ingredients.isSubsetOf(allElements) == true);
{% endpc %}

&rarr; Refer to the full
[Set API docs](http://api.dartlang.org/dart_core/Set.html)
for a full list of methods.

[Back to contents.](#toc)
{:.up-to-toc}

#### Common collection methods

Both List and Set extend the
[Collection](http://api.dartlang.org/dart_core/Collection.html) interface.
As such, they share common functionality found in all collections.

The following examples work with any object that extends Collection.

##### Check if empty

{% pc dart 0 %}
var teas = ['green', 'black', 'chamomile', 'earl grey'];

// use isEmpty() to check whether a collection has no items
assert(teas.isEmpty() == false);
{% endpc %}

##### Apply a function to each item

{% pc dart 0 %}
var teas = ['green', 'black', 'chamomile', 'earl grey'];

// use forEach() to apply a function to every item in a collection
teas.forEach((tea) => print('I drink $tea'));

// use map() to create a new collection by applying a function to each
// item and collecting the results
var loudTeas = teas.map((tea) => tea.toUpperCase());
assert(loudTeas[0] == 'GREEN');
{% endpc %}

##### Filter and check items

Use `forEach()` and `map()` to apply a function to each
element of the collection. Use `some()` and `every()`
to check if some or all items in a collection apply
match some condition.

{% pc dart 0 %}
var teas = ['green', 'black', 'chamomile', 'earl grey'];

// chamomile is not caffeinated
isDecaffeinated(String teaName) => teaName == 'chamomile';

// use filter() to create a new collection with only the items
// that return true from the provided function
var decaffinatedTeas = teas.filter((tea) => isDecaffeinated(tea));
// or teas.filter(isDecaffeinated)

// use some() to check whether at least one item in the collection
// satisfies a condition
assert(teas.some(isCaffeinated) == true);

// use every() to check whether all the items in a collection
// satisfy a condition
assert(teas.every(isCaffeinated) == false);
{% endpc %}

&rarr; Refer to the full
[Collection API docs](http://api.dartlang.org/dart_core/Collection.html)
for a full list of methods.

[Back to contents.](#toc)
{:.up-to-toc}

#### Maps (aka dictionaries or hashes)

The [Map](http://api.dartlang.org/dart_core/Map.html)
interface, also commonly known as a dictionary or hash,
is an unordered collection of key-value pairs.
Maps associate a key to some value for easy retrieval.

Unlike in JavaScript, Dart objects are not all Maps.

<aside class="note">
  <b>Note:</b> The Map
  interface does not extend Collection.
</aside>

##### Declaring a map

You can declare a map using a terse literal syntax,
or a traditional constructor.

{% pc dart 0 %}
// map literals use strings as keys
var hawaiianBeaches = {
  "oahu" : ['waikiki', 'kailua', 'waimanalo'],
  "big island" : ['wailea bay', 'pololu beach'],
  "kauai" : ['hanalei', 'poipu']
};

// maps can be built from a constructor
var nobleGases = new Map();

// maps are parameterized types; you can specify what types
// the key and value should be
nobleGases = new Map&lt;int, String>();
{% endpc %}

##### Adding, retrieving, and removing items

Add and retrieve items from a map using the bracket syntax.
Use `remove()` to remove a key and its value from a map.

{% pc dart 0 %}
// maps from constructors can use any Hashable object as a key
// for example, int implements Hashable
nobleGases[54] = 'xenon';

// associate a key with a value
nobleGases[54] = 'xenon';

// retrieve a value with a key
assert(nobleGases[54] == 'xenon');

// check whether a map contains a key
assert(nobleGases.containsKey(54) == true);

// only add a key-value pair if the key does not yet exist in the map
var value = nobleGases.putIfAbsent(36, () => 'krypton');
assert(value == 'krypton');

// remove a key and its value
nobleGases.remove(54);
assert(nobleGases.containsKey(54) == false);
{% endpc %}

##### Iterating through a map

You can retrieve all the values or all the keys from
a map. You can also iterate through the key-value
mappings.

{% pc dart 0 %}
var hawaiianBeaches = {
  "oahu" : ['waikiki', 'kailua', 'waimanalo'],
  "big island" : ['wailea bay', 'pololu beach'],
  "kauai" : ['hanalei', 'poipu']
};

// get all the keys as an unordered collection
var keys = hawaiianBeaches.getKeys();

assert(keys.length == 3);
assert(new Set.from(keys).contains('oahu') == true);

// get all the values as an unordered collection
var values = hawaiianBeaches.getValues();
assert(values.length == 3);
assert(values.some((v) => v.indexOf('waikiki') != -1) == true);

// iterate through the key-value pairs
// do not depend on iteration order
hawaiianBeaches.forEach((k,v) {
  print("I want to visit $k and swim at $v");
  // I want to visit oahu and swim at [waikiki, kailua, waimanalo]
});
{% endpc %}

&rarr; Refer to the full
[Map API docs](http://api.dartlang.org/dart_core/Map.html)
for a full list of methods.

[Back to contents.](#toc)
{:.up-to-toc}

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
var millisecondsSinceEpoch = now.value;
assert(millisecondsSinceEpoch == 946684800000);
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

&rarr; Refer to the full
[Date API docs](http://api.dartlang.org/dart_core/Date.html)
and
[Duration API docs](http://api.dartlang.org/dart_core/Duration.html)
for a full list of methods.

[Back to contents.](#toc)
{:.up-to-toc}

### Utility interfaces

The core library also contains various utility interfaces, useful for
sorting, maps, and iterating.

#### Comparing an object

Use the [Comparable](http://api.dartlang.org/dart_core/Comparable.html)
interface to indicate that an object can be compared
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

&rarr; Refer to the full
[Comparable API docs](http://api.dartlang.org/dart_core/Comparable.html)
for a full list of methods.

[Back to contents.](#toc)
{:.up-to-toc}

#### Acting as a key for maps

The [Hashable](http://api.dartlang.org/dart_core/Hashable.html) interface
indicates that an object can provide an integer
hashcode. The default implementation of Map, the HashMap, requires that its
keys implement Hashabe.

Only objects that implement Hashable can be used as a key for a map.
Objects that are equal (via ==) must also have identical hashcodes.
A hashcode does not have to be unique, but it should
be well distributed.

{% pc dart 0 %}
class Person implements Hashable {
  String firstName, lastName;
  
  Person(this.firstName, this.lastName);

  // strategy from Effective Java, Chapter 11
  int hashCode() {
    int result = 17;
    result = 37 * result + firstName.hashCode();
    result = 37 * result + lastName.hashCode();
    return result;
  }
}

main() {
  var p1 = new Person('bob', 'smith');
  var p2 = new Person('bob', 'smith');
  assert(p1.hashCode() == p2.hashCode());
}
{% endpc %}

&rarr; Refer to the full
[Hashable API docs](http://api.dartlang.org/dart_core/Hashable.html)
for a full list of methods.

[Back to contents.](#toc)
{:.up-to-toc}

#### Iteration

Two interfaces make up iteration abilities in Dart, and allow objects
to take part in for-in loops. Implementing the
[Iterable](http://api.dartlang.org/dart_core/Iterable.html)
interface signals that an object can provide an Iterator.
The [Iterator](http://api.dartlang.org/dart_core/Iterator.html) iterface
defines the actual iteration ability.

{% pc dart 0 %}
// mythical processes object that lets you iterate through all processes

class ProcessIterator implements Iterator&lt;Process> {
  bool hasNext() {
    // true if a call to next() returns a non-null process
  }

  Process next() {
    // returns the next process, or throws NoMoreElementsException if no more
  }
}

class Processes implements Iterable&lt;Process> {
  Iterator&lt;Process> iterator() {
    // return a new ProcessIterator
  }
}

main() {
  // objects that implement Iterable can be used with for-in
  for (var process in new Processes()) {
    // use the process
  }
}
{% endpc %}

&rarr; Refer to the full
[Iterable API docs](http://api.dartlang.org/dart_core/Iterable.html)
and
[Iterator API docs](http://api.dartlang.org/dart_core/Iterator.html)
for a full list of methods.

[Back to contents.](#toc)
{:.up-to-toc}

### Math and numbers

The [Math](http://api.dartlang.org/dart_core/Math.html) class
provides common functionality like sin/cos, max/min,
parsing strings into numbers, and constants like PI and E.

#### Converting strings to numbers

You can convert a string into either an integer or double with the Math class.

{% pc dart 0 %}
assert(Math.parseInt('42') == 42);
assert(Math.parseDouble("0.50") == 0.5);
{% endpc %}

#### Convert a number to a string

Use the built-in toString() to convert an int or double to a String.

To control the numbers of digits to the left of the decimal,
use toStringAsFixed(). To control the precision of the toString(),
use toStringAsPrecision().

{% pc dart 0 %}
// converting an integer
assert(42.toString() == '42');

// converting a decimal
assert(123.456.toString() == '123.456');

// toStringAsFixed will round the decimal value
assert(123.456.toStringAsFixed(2) == '123.46');

// control the precision
assert(123.456.toStringAsPrecision(2) == '1.2e+2');
assert(Math.parseDouble('1.2e+2') == 120.0);
{% endpc %}

#### Trigonometry

Use the Math class for the basic trig functions.

<aside class="note">
<b>Note:</b> These methods use radians, not degrees!
</aside>

{% pc dart 0 %}
// cosine
assert(Math.cos(Math.PI) == -1.0);

// sin
var degrees = 30;
var radians = degrees * (Math.PI / 180);
// radians is now 0.52359
var sinOf30degrees = Math.sin(radians);

// truncate the decimal places to 2
assert(Math.parseDouble(sinOf30degrees.toStringAsPrecision(2)) == 0.5);
{% endpc %}

The Math class also contains methods for asin, atan, and atan2.

#### Max and min

Optimized max and min methods are also provided by Math.

{% pc dart 0 %}
assert(Math.max(1, 1000) == 1000);
assert(Math.min(1, -1000) == -1000);
{% endpc %}

#### Math constants

Find your favoritates, like PI, E, and more, in Math.

{% pc dart 0 %}
// some examples, see the Math class for others

print(Math.E); // 2.718281828459045
print(Math.PI); // 3.141592653589793
print(Math.SQRT2); // 1.4142135623730951
{% endpc %}

#### Random number generator

Generate random numbers between 0.0 and 1.0 with the Math class.

{% pc dart 0 %}
var rand = Math.random();
{% endpc %}

<aside class="note">
  <b>Note:</b> The current implementation of random() for the
  Dart VM is not random at all. Follow
  <a href="http://code.google.com/p/dart/issues/detail?id=499">bug 499</a>
  for the status.
</aside>

&rarr; Refer to the full
[Math API docs](http://api.dartlang.org/dart_core/Math.html)
for a full list of methods.

[Back to contents.](#toc)
{:.up-to-toc}

### Strings and regular expressions

A [String](http://api.dartlang.org/dart_core/String.html) is
an immutable ordered lists of unicode code points.
Regular expressions are used by the string interface for
searching and replacing.

The [Pattern](http://api.dartlang.org/dart_core/Pattern.html)
interface is implemented by both String and
[RegExp](http://api.dartlang.org/dart_core/RegExp.html),
and is used for methods like
[split](http://api.dartlang.org/dart_core/String.html#split) and
[contains](http://api.dartlang.org/dart_core/String.html#contains).

#### Searching inside a string

You can find particular locations within a string, as well as check
whether a string begins with or ends with a particular pattern.

{% pc dart 0 %}
// use contains() to check whether a string contains another string
assert("Never odd or even".contains("odd") == true);

// does a string start with another string?
assert("Never odd or even".startsWith("Never") == true);

// does a string end with another string?
assert("Never odd or even".endsWith("even") == true);

// find the location of a string inside a string
assert("Never odd or even".indexOf("odd") == 6);
{% endpc %}

#### Extracting data from a string

You can get the individual characters (as strings)
or individual character codes (as integers) from a string.

You can also extract a substring or split a string
into a list of substrings.

{% pc dart 0 %}
// grab a substring
assert("Never odd or even".substring(6, 9) == 'odd');

// split a string using a string pattern
var parts = "structured web apps".split(" ");
assert(parts.length == 3);
assert(parts[0] == 'structured');

// get the character (as a string) by index
assert("Never odd or even"[0] == "N");

// use splitChars() to get a list of all characters (as string)
// good for iterating
for (var char in "hello".splitChars()) {
  print(char);
}

// get the char code at an index
assert("Never odd or even".charCodeAt(0) == 78);

// get all the char codes as a list of integers
var charCodes = "Never odd or even".charCodes();
assert(charCodes.length == 17);
assert(charCodes[0] == 78);
{% endpc %}

#### Upper and lower case

Easily convert strings to their upper and lower case variants.

{% pc dart 0 %}
// convert to upper case
assert("structured web apps".toUpperCase() == 'STRUCTURED WEB APPS');

// convert to lower case
assert("STRUCTURED WEB APPS".toLowerCase() == 'structured web apps');
{% endpc %}

#### Trimming and empty strings

Remove all leading and trailing whitespace with trim(), and check
whether a string is empty (length is zero) with isEmpty().

{% pc dart 0 %}
// trim a string
assert('  hello  '.trim() == 'hello');

// check whether a string is empty
assert(''.isEmpty() == true);

// strings with only whitespace are not empty
assert('  '.isEmpty() == false);
{% endpc %}

#### Regular expressions

The [RegExp](http://api.dartlang.org/dart_core/RegExp.html)
interface has the same capabilities as JavaScript
regular expressions. Use regular expressions for efficient searching
and pattern matching of strings.

{% pc dart 0 %}
// a regular expression for one or more digits
var numbers = const RegExp(@'\d+');

var allCharacters = "llamas live fifteen to twenty years";
var someDigits = "llamas live 15 to 20 years";

// contains() can use a regular expression
assert(allCharacters.contains(numbers) == false);
assert(someDigits.contains(numbers) == true);

// replace every match with another string
var exedOut = someDigits.replaceAll(numbers, "XX");
assert(exedOut == 'llamas live XX to XX years');
{% endpc %}

You can work directly with the RegExp class, too.
The [Match](http://api.dartlang.org/dart_core/Match.html) interface
provides access to a regular expression match.

{% pc dart 0 %}
var numbers = const RegExp(@'\d+');
var someDigits = "llamas live 15 to 20 years";

// check whether the reg exp has a match in a string
assert(numbers.hasMatch(someDigits) == true);

// loop through all matches
for (Match match in numbers.allMatches(someDigits)) {
  print(match.group(0)); // 15, then 20
}
{% endpc %}

&rarr;  Refer to the full
[String API docs](http://api.dartlang.org/dart_core/String.html)
for a full list of methods.

[Back to contents.](#toc)
{:.up-to-toc}

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

&rarr;  Refer to the full
[Future API docs](http://api.dartlang.org/dart_core/Future.html)
for a full list of methods.

[Back to contents.](#toc)
{:.up-to-toc}

### Exceptions

The Dart core library includes various common exceptions,
all extending the base
[Exception](http://api.dartlang.org/dart_core/Exception.html)
interface.

Learn more about throwing and catching exceptions
in the [Exceptions section](http://www.dartlang.org/docs/language-tour/#exceptions)
of the Dart Language Tour.

#### Common exceptions

Some common exceptions include:

[NoSuchMethodException](http://api.dartlang.org/dart_core/NoSuchMethodException.html)
: Thrown when a receiving object does not implement a method.

[NullPointerException](http://api.dartlang.org/dart_core/NullPointerException.html)
: Thrown when the program tries to call a method or access a field of a
null object.

[IllegalArgumentException](http://api.dartlang.org/dart_core/IllegalArgumentException.html)
: Can be thrown by a method that encounters an unexecpted argument.

There are many more built-in exceptions in the core library.

#### Defining your own exception

Throwing an application specific exception is a common way to indicate
an error has occurred. You can define a custom exception
by implementing the Exception interface.

{% pc dart 0 %}
class FooException implements Exception {
  final String msg;
  const FooException([this.msg]);
  String toString() => msg == null ? 'FooException' : msg;
}
{% endpc %}

&rarr;  Refer to the full
[Exception API docs](http://api.dartlang.org/dart_core/Exception.html)
for a full list of methods.

[Back to contents.](#toc)
{:.up-to-toc}

## Concurrency with isolates

{% render language-tour/isolates/index.markdown %}

&rarr;  Refer to the full
[Isolate API docs](http://api.dartlang.org/dart_isolate/Isolate.html)
for a full list of methods.

[Back to contents.](#toc)
{:.up-to-toc}

## Files and sockets with IO

The [dart:io library](http://api.dartlang.org/io.html) provides
file and socket capabilities
for the Dart VM when running from the command-line. These libraries
are not yet available to Dart programs targeting the web browser.

In general, the `dart:io` library promotes an asynchronous API. Most operations
return results via callbacks or event listeners. The API discourages use
of synchronous operations, although you will encounter a few sync methods
(clearly marked with a Sync suffix on the method name).

### Import the IO library

The IO functionality can be found in the `dart:io` library.

{% pc dart 0 %}
#import('dart:io');
{% endpc %}

### Files and directories

You can read and write files and browse directories in command-line Dart
applications.

#### Handle errors

You can register an error callback with `onError()` to be
notified whenever a problem occurs with handling a file
or directory.

{% pc dart 0 %}
#import('dart:io');

main() {
  var config = new File('config.txt');
  config.onError = (e) => print(e);
}
{% endpc %}

#### Read entire file contents as text

When reading a text file, you can read the entire file
contents with `readAsText()`. When the individual lines are
important, you can use `readAsLines()`. In both cases,
the contents of the file are returned as text.

{% pc dart 0 %}
#import('dart:io');

main() {
  var config = new File('config.txt');
  config.onError = (e) => print(e);

  config.readAsText(Encoding.UTF_8, (String contents) {
    print("The entire file is ${contents.length} characters long");
  });

  // if you want the contents as individual lines from the file
  config.readAsLines(Encoding.UTF_8, (List&lt;String> lines) {
    print("The entire file is ${lines.length} lines long");
  });
}
{% endpc %}

#### Read entire file contents as binary

The following code will read an entire file into a list of bytes (as ints).
If your file is too large for memory or you want to stream the file,
refer to the streaming examples below.

{% pc dart 0 %}
#import('dart:io');

main() {
  var config = new File('config.txt');
  config.onError = (e) => print(e);

  config.readAsBytes((List&lt;int> contents) {
    print("The entire file is ${contents.length} bytes long");
  });
}
{% endpc %}

In the examples above, the API uses callbacks to signal completion.
This technique is preferred for performance reasons.
However, you have the option to use synchronous and blocking
methods: `readAsTextSync()`, `readAsLinesSync()`, and `readAsBytesSync()`.

#### Stream file contents

Use an [InputStream](http://api.dartlang.org/io/InputStream.html)
to stream a file. An InputStream will run the `onData`
callback when data
is ready to be read by the application. When the InputStream
is finished reading the file, the `onClosed` callback is run.

{% pc dart 0 %}
#import('dart:io');

main() {
  var config = new File('config.txt');
  config.onError = (e) => print(e);

  var inputStream = config.openInputStream();
  inputStream.onError = (e) => print(e);
  inputStream.onClosed = () => print("file is now closed");
  inputStream.onData = () {
    List<int> bytes = inputStream.read();
    print("Read ${bytes.length} bytes from stream");
  };
}
{% endpc %}

#### List files in a directory

Finding all files and subdirectories for a directory is an asynchronous
operation. You can register callback handlers to be notified when
a file is encountered (using `onFile`) or when a directory is
encountered (using `onDir`).

There is no equivalent synchronous API for walking a directory
tree.

{% pc dart 0 %}
#import('dart:io');

main() {
  var dir = new Directory('/tmp');
  dir.onError = (e) => print(e);
  dir.onFile = (String name) => print("Found file ${name}");
  dir.onDir = (String name) => print("Found dir ${name}");

  // begin walking the directory tree, recursively
  dir.list(recursive:true);
}
{% endpc %}

&rarr;  Refer to the full
[File API docs](http://api.dartlang.org/io/File.html)
and
[Directory API docs](http://api.dartlang.org/io/Directory.html)
for a full list of methods. For more information,
read [An introduction to the dart:io library](/articles/io/).

[Back to contents.](#toc)
{:.up-to-toc}

### Sockets

Coming soon.

### HTTP server and client

Coming soon.

### Web socket server

Coming soon.

## JSON

Coming soon.

## URI

Coming soon.

## UTF

Coming soon.

## Crypto

Coming soon.

{% include syntax-highlighting.html %}