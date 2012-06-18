---
layout: default
title: "A Tour of the Dart Libraries"
description: "Learn how to use each major Dart library feature."
---

# {{ page.title }}

Welcome to the Dart library tour!
We'll show you how to use the major features in each library
that comes with Dart.

This tour is just an overview of
library functionality; it is by no means comprehensive.
Consult the
[Dart API reference](http://api.dartlang.org/)
for the full details about a class or interface.

<aside class="note" markdown="1">
**Note:** Expect major changes to the Dart libraries before Dart's
first release.
</aside>

#### Contents {#toc}

1. [dart:core - Strings, collections, and more](#dartcore---strings-collections-and-more)
    1. [Collections](#collections)
        1. [Lists](#lists)
        1. [Sets](#sets)
        1. [Common collection methods](#common-collection-methods)
        1. [Maps (aka dictionaries or hashes)](#maps-aka-dictionaries-or-hashes)
    1. [Dates and times](#dates-and-times)
    1. [Utility interfaces](#utility-interfaces)
    1. [Math and numbers](#math-and-numbers)
    1. [Strings and regular expressions](#strings-and-regular-expressions)
    1. [Asynchronous programming](#asynchronous-programming)
    1. [Exceptions](#exceptions)
1. [dart:isolate - Concurrency with isolates](#dartisolate---concurrency-with-isolates)
    1. [Isolate concepts](#isolate-concepts)
    1. [Using isolates](#using-isolates)
        1. [Sending messages](#sending-messages)
        1. [Receiving messages](#receiving-messages)
        1. [Receiving replies](#receiving-replies)
1. [dart:io - File and socket I/O for command-line apps](#dartio---file-and-socket-io-for-command-line-apps)
    1. [Files and directories](#files-and-directories)
    1. Sockets (coming soon)
    1. HTTP Server (coming soon)
    1. HTTP Client (coming soon)
    1. Web socket server (coming soon)
1. HTML (coming soon)
1. [dart:json - Encoding and decoding objects](#json)
1. [dart:uri - Manipulating URLs](#uri)
1. [dart:utf - Strings and Unicode](#utf)
1. [dart:crypto - Hash codes and more](#crypto)
{:.toc}

## dart:core - Strings, collections, and more

The Dart core library provides a small but critical set of built-in functionality.
This library is automatically imported into every Dart program.

### Collections

Dart ships with a core collections API, which includes interfaces for Lists,
Maps, and Sets.

#### Lists

A [list](http://api.dartlang.org/dart_core/List.html) in Dart is an ordered
collection of items, analogous to an array in other languages.
Lists are zero indexed, and they can contain duplicate items.

The language tour has
[more information about lists](/docs/language-tour/#lists).

##### Creating, adding, and removing

As the language tour shows, you can create and initialize lists using literals.
Alternatively, use one of the [List
constructors](http://api.dartlang.org/dart_core/List.html#List). The List class
also provides several methods for adding items to and removing items from lists.

{% pc dart 0 %}
// Use a list constructor.
var vegetables = new List();

// Or simply use a list literal.
var fruits = ['apples', 'oranges'];

// Add to a list.
fruits.add('kiwis');

// Add multiple items to a list.
fruits.addAll(['grapes', 'bananas']);

// Get the list length.
assert(fruits.length == 5);

// Remove a single item.
var appleIndex = fruits.indexOf('apples');
fruits.removeRange(appleIndex, 1);
assert(fruits.length == 4);

// Remove all elements from a list.
fruits.clear();
assert(fruits.length == 0);
{% endpc %}

##### Getting and setting items

Lists use zero-based indexing, where 0
is the index of the first element, and
`list.length-1` is the index of the last
element. Use `indexOf()` to find
the index of an object in a list.

{% pc dart 0 %}
var fruits = ['apples', 'oranges'];

// Access a list item by index.
assert(fruits[0] == 'apples');

// Find an item in a list.
assert(fruits.indexOf('apples') == 0);
{% endpc %}

##### Sorting

Sort a list using the `sort()` method, and you must provide
a sorting function that compares two objects.
The sorting function must
return &lt; 0 for _smaller_,
0 for the _same_, and &gt; 0 for _bigger_.

{% pc dart 0 %}
var fruits = ['bananas', 'apples', 'oranges'];

// Sort a list.
fruits.sort((a, b) => a.compareTo(b));
assert(fruits[1] == 'bananas');
{% endpc %}

##### Generics

Lists are parameterized types, so you can specify the type that a list
should contain.

{% pc dart 0 %}
// This list should contain only strings.
var fruits = new List&lt;String>();

fruits.add('apples');
var fruit = fruits[0];
assert(fruit is String);

// Generates static analysis warning; num is not a string.
fruits.add(5);  // BAD: Throws exception in checked mode.
{% endpc %}

##### More information

Refer to the full
[List API docs](http://api.dartlang.org/dart_core/List.html)
for a full list of methods.

[Back to contents.](#toc)
{:.up-to-toc}

#### Sets

A [set](http://api.dartlang.org/dart_core/Set.html)
in Dart
is an unordered collection of unique items.
Because a set is unordered,
you can't get a set's items by index (position).

##### Adding and removing

{% pc dart 0 %}
var ingredients = new Set();
ingredients.addAll(['gold', 'titanium', 'xenon']);
assert(ingredients.length == 3);

// Adding a duplicate item has no effect.
ingredients.add('gold');
assert(ingredients.length == 3);

// Remove an item from a set.
ingredients.remove('gold');
assert(ingredients.length == 2);
{% endpc %}

##### Checking membership

Use `contains()` and `containsAll()` to check whether
one or more objects are in a set.

{% pc dart 0 %}
var ingredients = new Set();
ingredients.addAll(['gold', 'titanium', 'xenon']);

// Check whether an item is in the set.
assert(ingredients.contains('titanium') == true);

// Check whether all the items are in the set.
assert(ingredients.containsAll(['titanium', 'xenon']) == true);
{% endpc %}

##### Intersection and subset

An intersection is a set whose items are in two other sets.
A subset has all of its items included
in another, potentially larger, collection.

{% pc dart 0 %}
var ingredients = new Set();
ingredients.addAll(['gold', 'titanium', 'xenon']);

// Create the intersection of two sets.
var nobleGases = new Set.from(['xenon', 'argon']);
var intersection = ingredients.intersection(nobleGases);
assert(intersection.length == 1);
assert(intersection[0] == 'xenon');

// Check whether this set is a subset of another collection.
// That is, does another collection contains all the items of this set?
var allElements = ['hydrogen', 'helium', 'lithium', 'beryllium',
                   'gold', 'titanium', 'xenon' /* all the rest */];
assert(ingredients.isSubsetOf(allElements) == true);
{% endpc %}

##### More information

Refer to the full
[Set API docs](http://api.dartlang.org/dart_core/Set.html)
for a full list of methods.

[Back to contents.](#toc)
{:.up-to-toc}

#### Common collection methods

Both List and Set extend the
[Collection](http://api.dartlang.org/dart_core/Collection.html) interface.
As such, they share common functionality found in all collections.

The following examples work with any object that implements Collection.

##### Checking whether a collection has items

{% pc dart 0 %}
var teas = ['green', 'black', 'chamomile', 'earl grey'];

// Use isEmpty() to check whether a collection has no items.
assert(teas.isEmpty() == false);
{% endpc %}

##### Applying a function to each item

{% pc dart 0 %}
var teas = ['green', 'black', 'chamomile', 'earl grey'];

// Use forEach() to apply a function to every item in a collection.
teas.forEach((tea) => print('I drink $tea'));

// Use map() to create a new collection by applying a function to each
// item and collecting the results.
var loudTeas = teas.map((tea) => tea.toUpperCase());
assert(loudTeas[0] == 'GREEN');
{% endpc %}

##### Filtering and checking items

Use `forEach()` and `map()` to apply a function to each
element of the collection. Use `some()` and `every()`
to check whether some or all items in a collection
match a condition.

{% pc dart 0 %}
var teas = ['green', 'black', 'chamomile', 'earl grey'];

// Chamomile is not caffeinated.
isDecaffeinated(String teaName) => teaName == 'chamomile';

// Use filter() to create a new collection with only the items
// that return true from the provided function.
var decaffeinatedTeas = teas.filter((tea) => isDecaffeinated(tea));
// Or teas.filter(isDecaffeinated)

// Use some() to check whether at least one item in the collection
// satisfies a condition.
assert(teas.some(isDecaffeinated) == true);

// Use every() to check whether all the items in a collection
// satisfy a condition.
assert(teas.every(isDecaffeinated) == false);
{% endpc %}

##### More information

Refer to the full
[Collection API docs](http://api.dartlang.org/dart_core/Collection.html)
for a full list of methods.

[Back to contents.](#toc)
{:.up-to-toc}

#### Maps (aka dictionaries or hashes)

The [Map](http://api.dartlang.org/dart_core/Map.html)
interface, commonly known as a _dictionary_ or _hash_,
is an unordered collection of key-value pairs.
Maps associate a key to some value for easy retrieval.
Unlike in JavaScript, Dart objects are not maps.

The language tour has more
[information about maps](/docs/language-tour/#maps).

<aside class="note">
  <b>Note:</b> The Map
  interface does not extend Collection.
</aside>

##### Creating maps

You can declare a map using a terse literal syntax,
or you can use a traditional constructor.

{% pc dart 0 %}
// Map literals use strings as keys.
var hawaiianBeaches = {
  "oahu" : ['waikiki', 'kailua', 'waimanalo'],
  "big island" : ['wailea bay', 'pololu beach'],
  "kauai" : ['hanalei', 'poipu']
};

// Maps can be built from a constructor.
var searchTerms = new Map();

// Maps are parameterized types; you can specify what types
// the key and value should be.
var nobleGases = new Map&lt;int, String>();
{% endpc %}

##### Adding, retrieving, and removing items

You add, get, and set map items using the bracket syntax.
Use `remove()` to remove a key and its value from a map.

{% pc dart 0 %}
var nobleGases = new Map&lt;int, String>();

// Maps from constructors can use any Hashable object as a key;
// for example, int implements Hashable.
nobleGases[54] = 'xenon';

// Associate a key with a value.
nobleGases[54] = 'xenon';

// Retrieve a value with a key.
assert(nobleGases[54] == 'xenon');

// Check whether a map contains a key.
assert(nobleGases.containsKey(54) == true);

// Add a key-value pair only if the key doesn't yet exist in the map.
var value = nobleGases.putIfAbsent(36, () => 'krypton');
assert(value == 'krypton');

// Remove a key and its value.
nobleGases.remove(54);
assert(nobleGases.containsKey(54) == false);
{% endpc %}

##### Iterating through a map

You can retrieve all the values or all the keys from
a map. You can also iterate through the key-value
pairs.

{% pc dart 0 %}
var hawaiianBeaches = {
  "oahu" : ['waikiki', 'kailua', 'waimanalo'],
  "big island" : ['wailea bay', 'pololu beach'],
  "kauai" : ['hanalei', 'poipu']
};

// Get all the keys as an unordered collection.
var keys = hawaiianBeaches.getKeys();

assert(keys.length == 3);
assert(new Set.from(keys).contains('oahu') == true);

// Get all the values as an unordered collection.
var values = hawaiianBeaches.getValues();
assert(values.length == 3);
assert(values.some((v) => v.indexOf('waikiki') != -1) == true);

// Iterate through the key-value pairs.
// NOTE: Do not depend on iteration order.
hawaiianBeaches.forEach((k,v) {
  print("I want to visit $k and swim at $v");
  // I want to visit oahu and swim at [waikiki, kailua, waimanalo]
});
{% endpc %}

##### More information

Refer to the full
[Map API docs](http://api.dartlang.org/dart_core/Map.html)
for a full list of methods.

[Back to contents.](#toc)
{:.up-to-toc}

### Dates and times

A [Date](http://api.dartlang.org/dart_core/Date.html) object is a point in time.
The time is either UTC or the local time zone.

#### Constructing dates

{% pc dart 0 %}
// Get the current date and time.
var now = new Date.now();

// Create a new Date with the local time zone.
var y2k = new Date(2000, 1, 1, 0, 0, 0, 0);

// You can also use named parameters.
y2k = new Date(2000, month: 1, day: 1, hours: 0, minutes: 0, seconds: 0,
               milliseconds: 0);

// Specify all the parts of a date as a UTC time.
y2k = new Date(2000, 1, 1, 0, 0, 0, 0, isUtc: true);

// Specify a UTC date and time in milliseconds since the Unix epoch.
y2k = const Date.fromEpoch(1336017592000, isUtc: true);

// Parse an ISO 8601 date.
y2k = new Date.fromString('2000-01-01T00:00:00Z');
{% endpc %}

#### The epoch

The `value` getter on a date returns the number of milliseconds since
the epoch.

{% pc dart 0 %}
var y2k = new Date.fromString('2000-01-01T00:00:00Z');
var millisecondsSinceEpoch = y2k.value;
assert(millisecondsSinceEpoch == 946684800000);
{% endpc %}

#### Calculations

Use the [Duration](http://api.dartlang.org/dart_core/Duration.html) class to
calculate the difference between two dates
and to shift a date's time forward or backwards.

{% pc dart 0 %}
var y2k = new Date.fromString('2000-01-01T00:00:00Z');

// Add one year.
var y2001 = y2k.add(const Duration(366, 0, 0, 0, 0));
assert(y2001.year == 2001);

// Subtract 30 days.
var december2000 = y2001.subtract(const Duration(30, 0 ,0, 0, 0));
assert(december2000.year == 2000);
assert(december2000.month == 12);

// Calculate the difference between two dates.
// Returns a Duration object.
var duration = y2001.difference(y2k);
assert(duration.inDays == 366); // y2k was a leap year.
{% endpc %}

#### More information

Refer to the full
[Date API docs](http://api.dartlang.org/dart_core/Date.html) and
[Duration API docs](http://api.dartlang.org/dart_core/Duration.html)
for a full list of methods.

[Back to contents.](#toc)
{:.up-to-toc}

### Utility interfaces

The core library contains various utility interfaces, useful for
sorting, mapping values, and iterating.

#### Comparing objects

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

[Back to contents.](#toc)
{:.up-to-toc}

#### Implementing map keys

The default implementation of Map requires map keys to implement Hashable.
The [Hashable](http://api.dartlang.org/dart_core/Hashable.html) interface
indicates that an object can provide an integer
hash code.

Objects that are equal (via ==) must have identical hash codes.
A hash code doesn't have to be unique, but it should
be well distributed.

{% pc dart 0 %}
class Person implements Hashable {
  String firstName, lastName;

  Person(this.firstName, this.lastName);

  // Strategy from Effective Java, Chapter 11.
  int hashCode() {
    int result = 17;
    result = 37 * result + firstName.hashCode();
    result = 37 * result + lastName.hashCode();
    return result;
  }

  // Always implement operator== if class implements Hashable.
  bool operator==(other) {
    if (other == null) return false;
    if (other === this) return true;
    return (other.firstName == firstName && other.lastName == lastName);
  }
}

main() {
  var p1 = new Person('bob', 'smith');
  var p2 = new Person('bob', 'smith');
  assert(p1.hashCode() == p2.hashCode());
}
{% endpc %}

##### More information

Refer to the full
[Hashable API docs](http://api.dartlang.org/dart_core/Hashable.html)
for a full list of methods.

[Back to contents.](#toc)
{:.up-to-toc}

#### Iteration

Two interfaces contribute to iteration abilities in Dart, allowing objects
to work in for-in loops. Implementing the
[Iterable](http://api.dartlang.org/dart_core/Iterable.html)
interface signals that an object can provide an Iterator.
The [Iterator](http://api.dartlang.org/dart_core/Iterator.html) interface
defines the actual iteration ability.

{% pc dart 0 %}
class Process {
  // Represents a process...
}

class ProcessIterator implements Iterator&lt;Process> {
  Process next() {
    // Return the next process if possible; but if not:
    throw new NoMoreElementsException();
  }
  bool hasNext() {
    // True if calling next() would return a process.
    return false;
  }
}

// A mythical class that lets you iterate through all processes.
class Processes implements Iterable&lt;Process> {
  Iterator&lt;Process> iterator() {
    return new ProcessIterator();
  }
}

main() {
  // Objects that implement Iterable can be used with for-in.
  for (var process in new Processes()) {
    // Do something with the process.
  }
}
{% endpc %}

##### More information

Refer to the full
[Iterable API docs](http://api.dartlang.org/dart_core/Iterable.html)
and
[Iterator API docs](http://api.dartlang.org/dart_core/Iterator.html)
for a full list of methods.

[Back to contents.](#toc)
{:.up-to-toc}

### Math and numbers

The [Math](http://api.dartlang.org/dart_core/Math.html) class
provides common functionality such as sine and cosine,
maximum and minimum,
string-to-number conversion,
and constants such as _pi_ and _e_.

#### Converting strings to numbers

You can convert a string into either an integer or double with the Math class.

{% pc dart 0 %}
assert(Math.parseInt('42') == 42);
assert(Math.parseDouble("0.50") == 0.5);
{% endpc %}

#### Converting numbers to strings

Use the toString() method (defined by
[Object](http://api.dartlang.org/dart_core/Object.html))
to convert an int or double to a string.

To specify the number of digits to the right of the decimal,
use toStringAsFixed()
(defined by [num](http://api.dartlang.org/dart_core/num.html)).
To specify the number of significant digits in the string,
use toStringAsPrecision().

{% pc dart 0 %}
// Convert an int to a string.
assert(42.toString() == '42');

// Convert a double to a string.
assert(123.456.toString() == '123.456');

// Specify the number of digits after the decimal.
assert(123.456.toStringAsFixed(2) == '123.46');

// Specify the number of sig figs.
assert(123.456.toStringAsPrecision(2) == '1.2e+2');
assert(Math.parseDouble('1.2e+2') == 120.0);
{% endpc %}

#### Trigonometry

Use the Math class for the basic trigonometric functions.

<aside class="note">
<b>Note:</b> These methods use radians, not degrees!
</aside>

{% pc dart 0 %}
// Cosine
assert(Math.cos(Math.PI) == -1.0);

// Sine
var degrees = 30;
var radians = degrees * (Math.PI / 180);
// radians is now 0.52359.
var sinOf30degrees = Math.sin(radians);

// Truncate the decimal places to 2.
assert(Math.parseDouble(sinOf30degrees.toStringAsPrecision(2)) == 0.5);
{% endpc %}

#### Maximum and mininum

Math provides optimized max and min methods.

{% pc dart 0 %}
assert(Math.max(1, 1000) == 1000);
assert(Math.min(1, -1000) == -1000);
{% endpc %}

#### Math constants

Find your favorite constants&mdash;_pi_, _e_, and more&mdash;in Math.

{% pc dart 0 %}
// See the Math class for additional constants.

print(Math.E);     // 2.718281828459045
print(Math.PI);    // 3.141592653589793
print(Math.SQRT2); // 1.4142135623730951
{% endpc %}

#### Random numbers

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

#### More information

Refer to the full
[Math API docs](http://api.dartlang.org/dart_core/Math.html)
for a full list of methods.
Also see the API docs for
[num](http://api.dartlang.org/dart_core/num.html),
[int](http://api.dartlang.org/dart_core/int.html),
and
[double](http://api.dartlang.org/dart_core/double.html).

[Back to contents.](#toc)
{:.up-to-toc}

### Strings and regular expressions

A [String](http://api.dartlang.org/dart_core/String.html) is
an immutable, ordered list of 32-bit Unicode character codes.
You can use regular expressions to
search within strings and to replace parts of strings.

The [Pattern](http://api.dartlang.org/dart_core/Pattern.html)
interface is implemented by both String and
[RegExp](http://api.dartlang.org/dart_core/RegExp.html),
and is used for methods like
[split](http://api.dartlang.org/dart_core/String.html#split) and
[contains](http://api.dartlang.org/dart_core/String.html#contains).

The language tour has
[more information about strings](/docs/language-tour/#strings).

#### Searching inside a string

You can find particular locations within a string, as well as check
whether a string begins with or ends with a particular pattern.

{% pc dart 0 %}
// Check whether a string contains another string.
assert("Never odd or even".contains("odd") == true);

// Does a string start with another string?
assert("Never odd or even".startsWith("Never") == true);

// Does a string end with another string?
assert("Never odd or even".endsWith("even") == true);

// Find the location of a string inside a string.
assert("Never odd or even".indexOf("odd") == 6);
{% endpc %}

#### Extracting data from a string

You can get the individual characters (as Strings)
or individual character codes (as ints) from a string.

You can also extract a substring or split a string
into a list of substrings.

{% pc dart 0 %}
// Grab a substring.
assert("Never odd or even".substring(6, 9) == 'odd');

// Split a string using a string pattern.
var parts = "structured web apps".split(" ");
assert(parts.length == 3);
assert(parts[0] == 'structured');

// Get the character (as a string) by index.
assert("Never odd or even"[0] == "N");

// Use splitChars() to get a list of all characters (as Strings);
// good for iterating.
for (var char in "hello".splitChars()) {
  print(char);
}

// Get the char code at an index.
assert("Never odd or even".charCodeAt(0) == 78);

// Get all the char codes as a list of integers.
var charCodes = "Never odd or even".charCodes();
assert(charCodes.length == 17);
assert(charCodes[0] == 78);
{% endpc %}

#### Converting to uppercase or lowercase

Easily convert strings to their uppercase and lowercase variants.

{% pc dart 0 %}
// Convert to uppercase.
assert("structured web apps".toUpperCase() == 'STRUCTURED WEB APPS');

// Convert to lowercase.
assert("STRUCTURED WEB APPS".toLowerCase() == 'structured web apps');
{% endpc %}

#### Trimming and empty strings

Remove all leading and trailing white space with trim().
To check whether a string is empty (length is zero), use isEmpty().

{% pc dart 0 %}
// Trim a string.
assert('  hello  '.trim() == 'hello');

// Check whether a string is empty.
assert(''.isEmpty() == true);

// Strings with only white space are not empty.
assert('  '.isEmpty() == false);
{% endpc %}

#### Regular expressions

The [RegExp](http://api.dartlang.org/dart_core/RegExp.html)
interface provides the same capabilities as JavaScript
regular expressions. Use regular expressions for efficient searching
and pattern matching of strings.

{% pc dart 0 %}
// A regular expression for one or more digits.
var numbers = const RegExp(@'\d+');

var allCharacters = "llamas live fifteen to twenty years";
var someDigits = "llamas live 15 to 20 years";

// contains() can use a regular expression.
assert(allCharacters.contains(numbers) == false);
assert(someDigits.contains(numbers) == true);

// Replace every match with another string.
var exedOut = someDigits.replaceAll(numbers, "XX");
assert(exedOut == 'llamas live XX to XX years');
{% endpc %}

You can work directly with the RegExp class, too.
The [Match](http://api.dartlang.org/dart_core/Match.html) interface
provides access to a regular expression match.

{% pc dart 0 %}
var numbers = const RegExp(@'\d+');
var someDigits = "llamas live 15 to 20 years";

// Check whether the reg exp has a match in a string.
assert(numbers.hasMatch(someDigits) == true);

// Loop through all matches.
for (Match match in numbers.allMatches(someDigits)) {
  print(match.group(0)); // 15, then 20.
}
{% endpc %}

#### More information

Refer to the full
[String API docs](http://api.dartlang.org/dart_core/String.html)
for a full list of methods.
Also see the API docs for
[RegExp](http://api.dartlang.org/dart_core/RegExp.html) and
[Match](http://api.dartlang.org/dart_core/Match.html).

[Back to contents.](#toc)
{:.up-to-toc}

### Asynchronous programming

Async programming often uses callback functions,
but Dart provides an alternative:
the [Future](http://api.dartlang.org/dart_core/Future.html) interface.
A Future is
like a promise for a result to be provided "sometime in the future."

You have the option of using a
[Completer](http://api.dartlang.org/dart_core/Completer.html)
to produce a Future
and, later, to supply a value to the Future.

{% pc dart 0 %}
Future&lt;bool> longExpensiveSearch() {
  var completer = new Completer();
  database.search(() {
    // Perform exhaustive search.
    // ...
    // Sometime later,
    // found it!!
    completer.complete(true);
  });
  return completer.future;
}

Future&lt;bool> result = longExpensiveSearch(); //returns immediately

// result.then() returns immediately.
result.then((success) {
  // The following code executes when the operation is complete.
  print("The item was found: $success");
});
{% endpc %}

#### Chaining multiple asynchronous methods

The Future interface specifies a chain() method, which is a useful way
to specify that multiple async methods run in a certain order.
The chain() method takes a single function as a parameter, which
receives the value from the previous Future in the chain.
The function passed to chain() must itself return a Future.

{% pc dart 0 %}
Future expensiveWork() {
  // ...
}

Future lengthyComputation() {
  // ...
}

Future costlyQuery() {
  // ...
}

Future result = costlyQuery();
result.handleException((exception) => print("DOH!"));

result.chain((value) => expensiveWork())
      .chain((value) => lengthyComputation())
      .then((value)  => print("done!"));
{% endpc %}

In the above example, the methods run in the following order:

1. costlyQuery()
1. expensiveWork()
1. lengthyComputation()

In addition to the chain() method, the Future interface also defines a
transform() method. Use transform() when you only need to manipulate the
returned value, returning a new value immediately.
Use chain() when you need to start
another asynchronous operation, returning a Future.

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

#### More information

Refer to the API docs for
[Future](http://api.dartlang.org/dart_core/Future.html),
[Futures](http://api.dartlang.org/dart_core/Futures.html), and
[Completer](http://api.dartlang.org/dart_core/Completer.html)
for a full list of methods.

[Back to contents.](#toc)
{:.up-to-toc}

### Exceptions

The Dart core library defines many common exceptions,
all extending the base
[Exception](http://api.dartlang.org/dart_core/Exception.html)
interface.

Learn more about throwing and catching exceptions
in the [Exceptions section](/docs/language-tour/#exceptions)
of the language tour.

#### Common exceptions

Some of the most common exceptions include:

[NoSuchMethodException](http://api.dartlang.org/dart_core/NoSuchMethodException.html)
: Thrown when a receiving object does not implement a method.

[NullPointerException](http://api.dartlang.org/dart_core/NullPointerException.html)
: Thrown when the program tries to call a method or access a field of a
null object.

[IllegalArgumentException](http://api.dartlang.org/dart_core/IllegalArgumentException.html)
: Can be thrown by a method that encounters an unexpected argument.


#### Defining your own exception

Throwing an application-specific exception is a common way to indicate
that an error has occurred. You can define a custom exception
by implementing the Exception interface.

{% pc dart 0 %}
class FooException implements Exception {
  final String msg;
  const FooException([this.msg]);
  String toString() => msg == null ? 'FooException' : msg;
}
{% endpc %}

#### More information

See the
[Exception API docs](http://api.dartlang.org/dart_core/Exception.html).

[Back to contents.](#toc)
{:.up-to-toc}

## dart:isolate - Concurrency with isolates

{% render library-tour/isolates.markdown %}

#### More information

Refer to the API docs for
[isolates](http://api.dartlang.org/dart_isolate.html).

[Back to contents.](#toc)
{:.up-to-toc}

## dart:io - File and socket I/O for command-line apps

The [dart:io library](http://api.dartlang.org/io.html) provides
file and socket capabilities
for the Dart VM when running from the command line. These libraries
are not yet available to Dart programs that target the web browser.

In general, the dart:io library implements and promotes an
asynchronous API. Synchronous
methods can easily block the main loop, making
it difficult to scale server applications. Therefore, most operations
return results via callbacks or Future objects, a pattern common
with modern server platforms such as Node.js.

The few synchronous methods
in the dart:io library
are clearly marked with a Sync suffix on the method name.
We don't cover them here.

### Importing the I/O library

I/O functionality is in the `dart:io` library.

{% pc dart 0 %}
#import('dart:io');

main() {
  // The app
}
{% endpc %}

### Files and directories

Command-line Dart applications can read and write files and browse directories.
You have two choices for reading the contents of a file:
all at once, or streaming.
Reading a file all at once requires enough memory
to store all the contents of the file.
If the file is very large or you want to process it while reading it,
you should use a [stream](#streaming-file-contents).

#### Reading a file as text

When reading a text file, you can read the entire file
contents with `readAsText()`. When the individual lines are
important, you can use `readAsLines()`. In both cases,
a Future object is returned that provides the
the contents of the file as one or more strings.

{% pc dart 0 %}
#import('dart:io');

main() {
  var config = new File('config.txt');

  // Put the whole file in a single string.
  config.readAsText(Encoding.UTF_8).then((String contents) {
    print("The entire file is ${contents.length} characters long");
  });

  // Put each line of the file into its own string.
  config.readAsLines(Encoding.UTF_8).then((List&lt;String> lines) {
    print("The entire file is ${lines.length} lines long");
  });
}
{% endpc %}

#### Reading a file as binary

The following code reads an entire file into a list of bytes (as ints).

{% pc dart 0 %}
#import('dart:io');

main() {
  var config = new File('config.txt');

  config.readAsBytes().then((List&lt;int> contents) {
    print("The entire file is ${contents.length} bytes long");
  });
}
{% endpc %}

In the examples above, the API uses Future objects to signal completion.
This asynchronous technique is preferred for performance reasons.
However, you have the option to use synchronous and blocking
methods: `readAsTextSync()`, `readAsLinesSync()`, and `readAsBytesSync()`.

#### Handling errors

Errors are thrown as exceptions if you do not
register an explicit handler. If you want to
capture an error, you can register a handleException handler
with the Future object.

{% pc dart 0 %}
#import('dart:io');

main() {
  var config = new File('config.txt');
  Future&lt;String> readFile = config.readAsText();
  readFile.handleExceptione((e) => print("Error: $e"));
  readFile.then((text) => print(text));
}
{% endpc %}

#### Streaming file contents

Use an [InputStream](http://api.dartlang.org/io/InputStream.html)
to read a file, a little at a time. The `onData`
callback runs when data
is ready to be read. When the InputStream
is finished reading the file, the `onClosed` callback executes.

{% pc dart 0 %}
#import('dart:io');

main() {
  var config = new File('config.txt');
  var inputStream = config.openInputStream();

  inputStream.onError = (e) => print(e);
  inputStream.onClosed = () => print("file is now closed");
  inputStream.onData = () {
    List&lt;int> bytes = inputStream.read();
    print("Read ${bytes.length} bytes from stream");
  };
}
{% endpc %}

#### Writing file contents

Use an [OutputStream](http://api.dartlang.org/io/OutputStream.html)
to write data to a file. Open a file
for writing with `openOutputStream()` and declare a
mode. Use `FileMode.WRITE` to completely overwrite existing data in the file,
and `FileMode.APPEND`
to add to the end.

{% pc dart 0 %}
#import('dart:io');

main() {
  var logFile = new File('log.txt');
  var out = logFile.openOutputStream(FileMode.WRITE);
  out.writeString('FILE ACCESSED ${new Date.now()}');
  out.close();
}
{% endpc %}

To write binary data, use `write(List<int> buffer)`.

#### Listing files in a directory

Finding all files and subdirectories for a directory is an asynchronous
operation. The `list()` method returns a
[DirectoryLister](http://api.dartlang.org/io/DirectoryLister.html),
on which you can register callback handlers to be notified when
a file is encountered (using `onFile`) or when a directory is
encountered (using `onDir`).

{% pc dart 0 %}
#import('dart:io');

main() {
  var dir = new Directory('/tmp');

  DirectoryLister lister = dir.list(recursive:true); //returns immediately
  lister.onError = (e) => print(e);
  lister.onFile = (name) => print("Found file $name");
  lister.onDir = (name) => print("Found dir $name");
}
{% endpc %}

No equivalent synchronous API exists for walking a directory
tree.


#### Other common functionality

The File and Directory interfaces contain other functionality,
including but not limited to:

* [creating a file](http://api.dartlang.org/io/File.html#create)
* [creating a directory](http://api.dartlang.org/io/Directory.html#create)
* [deleting a file](http://api.dartlang.org/io/File.html#delete)
* [deleting a directory](http://api.dartlang.org/io/Directory.html#delete)
* [getting the length of a file](http://api.dartlang.org/io/File.html#length)
* [random access to a file](http://api.dartlang.org/io/File.html#open)

#### More information

Refer to the full API docs for
[File](http://api.dartlang.org/io/File.html),
[Directory](http://api.dartlang.org/io/Directory.html),
and [DirectoryLister](http://api.dartlang.org/io/DirectoryLister.html)
for a full list of methods. For more information,
read [An introduction to the dart:io library](/articles/io/).

[Back to contents.](#toc)
{:.up-to-toc}


{% comment %}
### Sockets

Coming soon.

### HTTP server and client

Coming soon.

### Web socket server

Coming soon.

{% endcomment %}

## dart:json - Encoding and decoding objects {#json}

[JSON](http://www.json.org/) is a simple text
format for representing structured objects and collections.
The [JSON library](http://api.dartlang.org/json.html)
decodes JSON-formatted strings into Dart objects,
and encodes objects into JSON-formatted strings.

The Dart JSON library works in both web apps and command-line apps.

### Importing the JSON library

To use the JSON library, import dart:json.

{% pc dart 0 %}
#import('dart:json');

main() {
  // The app
}
{% endpc %}

### Decoding JSON

Decode a JSON-encoded string into a Dart object with `JSON.parse()`.

{% pc dart 0 %}
#import('dart:json');

main() {
  var jsonString = """
  [
    {"score": 40},
    {"score": 80}
  ]
  """;

  var scores = JSON.parse(jsonString);
  assert(scores is List);

  var firstScore = scores[0];
  assert(firstScore is Map);
  assert(firstScore['score'] == 40);
}
{% endpc %}

### Encoding JSON

Encode a supported Dart object into a JSON-formatted string
with `JSON.stringify()`.

Only objects of type list, map, string, int, double, bool, or null can
be encoded into JSON.

{% pc dart 0 %}
#import('dart:json');

main() {
  var scores = [
    {'score': 40},
    {'score': 80},
    {'score': 100, 'overtime': true, 'special_guest': null}
  ];

  var jsonText = JSON.stringify(scores);
  assert(jsonText == '[{"score":40},{"score":80},'
                     '{"score":100,"overtime":true,'
                     '"special_guest":null}]');
}
{% endpc %}

[Back to contents.](#toc)
{:.up-to-toc}

## dart:uri - Manipulating URLs {#uri}

The [URI library](http://api.dartlang.org/uri.html) provides functions
to encode and decode strings for use in URIs. These functions
handle characters that are special for URIs, such as `&` and `=`.

The URI library also contains the
[Uri class](http://api.dartlang.org/uri/Uri.html),
which parses and exposes
the components of a URI, such as domain, port, and scheme.

The URI library works in both web apps and command-line apps.

### Importing the URI library

To use the URI library, import dart:uri.

{% pc dart 0 %}
#import('dart:uri');

main() {
  // The app
}
{% endpc %}

### Encoding and decoding fully qualified URIs

To encode and decode characters *except* those with special meaning in a URI
(such as `/`, `:`, `&`, `#`), use
[encodeUri()](http://api.dartlang.org/uri.html#encodeUri)
and [decodeUri()](http://api.dartlang.org/uri.html#decodeUri). Use these
functions when you need to encode or decode a fully qualified URI,
leaving intact special URI characters.

{% pc dart 0 %}
#import('dart:uri');

main() {
  var uri = 'http://example.org/api?foo=some message';
  var encoded = encodeUri(uri);
  assert(encoded == 'http://example.org/api?foo=some%20message');

  var decoded = decodeUri(encoded);
  assert(uri == decoded);
}
{% endpc %}

Notice how only the space between `some` and `message` was encoded.

### Encoding and decoding URI components

To encode and decode all characters in a string that have special meaning
in a URI, including (but not limited to)
`/`, `&`, and `:`, use
[encodeUriComponent()](http://api.dartlang.org/uri.html#encodeUriComponent) and
[decodeUriComponent()](http://api.dartlang.org/uri.html#decodeUriComponent).

{% pc dart 0 %}
#import('dart:uri');

main() {
  var uri = 'http://example.org/api?foo=some message';
  var encoded = encodeUriComponent(uri);
  assert(encoded == 'http%3A%2F%2Fexample.org%2Fapi%3Ffoo%3Dsome%20message');

  var decoded = decodeUriComponent(encoded);
  assert(uri == decoded);
}
{% endpc %}

Notice how every special character was encoded. For example, `/` was encoded
to `%2F`.

### Parsing URIs

You can parse a URI into its parts with the
[Uri.fromString() constructor](http://api.dartlang.org/uri/Uri.html#Uri).

{% pc dart 0 %}
#import('dart:uri');

main() {
  var uri = new Uri.fromString('http://example.org/foo/bar#frag');

  assert(uri.scheme == 'http');
  assert(uri.domain == 'example.org');
  assert(uri.path == '/foo/bar');
  assert(uri.fragment == 'frag');
}
{% endpc %}

The Uri class exposes more URI components. Learn more by
reading the [Uri API docs](http://api.dartlang.org/uri/Uri.html).

### Building URIs

You can build up a URI from individual parts using the
[Uri() constructor](http://api.dartlang.org/uri/Uri.html#Uri).

{% pc dart 0 %}
#import('dart:uri');

main() {
  var uri = new Uri(scheme: 'http', domain: 'example.org', path: '/foo/bar',
                    fragment: 'frag');
  assert(uri.toString() == 'http://example.org/foo/bar#frag');
}
{% endpc %}

[Back to contents.](#toc)
{:.up-to-toc}


## dart:utf - Strings and Unicode {#utf}

The [UTF library](http://api.dartlang.org/utf.html) helps bridge the gap
between strings and UTF8/UTF16/UTF32 encodings.

### Importing the UTF library

To use the UTF library, import dart:utf.

{% pc dart 0 %}
#import('dart:utf');

main() {
  // The app
}
{% endpc %}

### Decoding UTF8 characters

Use `decodeUtf8()` to decode UTF8-encoded bytes to a Dart string.

{% pc dart 0 %}
#import('dart:utf');

main() {
  var string = decodeUtf8([0xc3, 0x8e, 0xc3, 0xb1, 0xc5, 0xa3, 0xc3, 0xa9,
                           0x72, 0xc3, 0xb1, 0xc3, 0xa5, 0xc5, 0xa3, 0xc3,
                           0xae, 0xc3, 0xb6, 0xc3, 0xb1, 0xc3, 0xa5, 0xc4,
                           0xbc, 0xc3, 0xae, 0xc5, 0xbe, 0xc3, 0xa5, 0xc5,
                           0xa3, 0xc3, 0xae, 0xe1, 0xbb, 0x9d, 0xc3, 0xb1]);
  assert(string == "Îñţérñåţîöñåļîžåţîờñ");
}
{% endpc %}

### Encoding strings to UTF8 bytes

Use `encodeUtf8()` to encode a Dart string as a list of UTF8-encoded bytes.

{% pc dart 0 %}
#import('dart:utf');

main() {
  List&lt;int> expected = [0xc3, 0x8e, 0xc3, 0xb1, 0xc5, 0xa3, 0xc3, 0xa9, 0x72,
                        0xc3, 0xb1, 0xc3, 0xa5, 0xc5, 0xa3, 0xc3, 0xae, 0xc3,
                        0xb6, 0xc3, 0xb1, 0xc3, 0xa5, 0xc4, 0xbc, 0xc3, 0xae,
                        0xc5, 0xbe, 0xc3, 0xa5, 0xc5, 0xa3, 0xc3, 0xae, 0xe1,
                        0xbb, 0x9d, 0xc3, 0xb1];

  List&lt;int> encoded = encodeUtf8("Îñţérñåţîöñåļîžåţîờñ");

  assert(encoded.length == expected.length);
  for (var i = 0; i < encoded.length; i++) {
    assert(encoded[i] == expected[i]);
  }
}
{% endpc %}

### Other functionality

The UTF library can decode and encode UTF16 and UTF32 bytes.
The library can also convert directly to and from Unicode codepoints
and UTF8-encoded bytes. Learn more about the
[UTF library](http://api.dartlang.org/utf.html).

[Back to contents.](#toc)
{:.up-to-toc}


## dart:crypto - Hash codes and more {#crypto}

The [Dart crypto library](http://api.dartlang.org/crypto.html)
contains functions useful for cryptographic applications,
such as creating cryptographic hashes and generating
has-based message authentication codes.

### Importing the crypto library

To use the crypto library, import dart:crypto.

{% pc dart 0 %}
#import('dart:crypto');

main() {
  // The app
}
{% endpc %}

### Generating cryptographic hashes

You can generate [SHA256](http://api.dartlang.org/crypto/SHA256.html),
[SHA1](http://api.dartlang.org/crypto/SHA1.html), and
[MD5](http://api.dartlang.org/crypto/MD5.html) hashes
(also known as *digests* or *message digests*)
with dart:crypto. We
recommend using SHA256, but we have included SHA1 and MD5 for
compatibility with older systems.

Learn more about
[cryptographic hash functions](http://en.wikipedia.org/wiki/Cryptographic_hash_function).

{% pc dart 0 %}
#import('dart:crypto');

main() {
  var sha256 = new SHA256();
  var digest = sha256.update("message".charCodes()).digest();
  var hexString = CryptoUtils.bytesToHex(digest);
  assert(hexString ==
      'ab530a13e45914982b79f9b7e3fba994cfd1f3fb22f71cea1afbf02b460c6d1d');
}
{% endpc %}

If the message content changes, the digest value also changes
(with a very high probability).

### Generating message authentication codes

Use a hash-based message authentication code (HMAC) to combine a
cryptographic hash function with a secret key.
Learn more about [HMACs](http://en.wikipedia.org/wiki/HMAC).

{% pc dart 0 %}
#import('dart:crypto');
main() {
  var hmac = new HMAC(new SHA256(), "secretkey".charCodes());
  var hmacDigest = hmac.update("message".charCodes()).digest();
  var hmacHex = CryptoUtils.bytesToHex(hmacDigest);
  assert(hmacHex ==
      '5c3e2f56de9411068f675ef32ffa12735210b9cbfee2ba521367a3955334a343');
}
{% endpc %}

If either the message contents or key changes,
the digest value also changes (with a very high probability).

### Generating Base64 strings

You can represent binary data as a character string by using the
[Base64](http://en.wikipedia.org/wiki/Base_64) encoding scheme. Use the
`CryptoUtils.bytesToBase64()` utility method to convert a list
of bytes into a base64-encoded string.

{% pc dart 0 %}
#import('dart:crypto');
#import('dart:io');

main() {
  var file = new File('icon.ico');
  var bytes = file.readAsBytesSync();
  var base64 = CryptoUtils.bytesToBase64(bytes);
  assert(base64 ==
    "iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38G"
    "IAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==");
}
{% endpc %}

[Back to contents.](#toc)
{:.up-to-toc}

{% include syntax-highlighting.html %}
