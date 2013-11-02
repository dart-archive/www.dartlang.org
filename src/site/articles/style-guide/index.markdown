---
layout: article
title: "Dart Style Guide"
rel:
  author: bob-nystrom
description: "Follow these guidelines for consistent, readable Dart code."
has-permalinks: true
article:
  written_on: 2011-10-01
  updated_on: 2013-10-04
  collection: everyday-dart
---

{% include toc.html %}

# {{ page.title }}

<em>Written by Bob Nystrom<br />
<time pubdate date="2011-10-27">October 2011</time>
(updated October 2013)
</em>

As we build up an ecosystem of Dart code, it's helpful if it follows a
consistent coding style. A dedicated style guide for Dart helps us make
the most of the features unique to the language and makes it easier for
users to collaborate.

There will likely be things you disagree with in this guide. As the author,
there are things even I disagree with. I hope you'll agree that consistency is
often worth more than our individual preferences.

Keep in mind that, like many things with Dart, this guide isn't carved in
stone. As the language evolves and we gain experience with it, our style
will evolve too. This means that there will inevitably be code that doesn't
follow the latest style, or places where the style guide is ambiguous or
open-ended. Bear with us and it will get better as the language and its
libraries settle down.

## How to read this

This guide is broken into a couple of sections roughly working from the macro
scale down to the micro. Sections contain a list of guidelines. Each one starts
with one of four words:

* **DO** guidelines describe practices that should always be followed. There
will almost never be a valid reason to stray from them.

* **DON'T** guidelines are the converse: things that are almost never a good
idea. You'll note there are few of these here. Guidelines like these in
other languages help to avoid the pitfalls that appear over time. Dart is
new enough that we can just fix those pitfalls directly instead of putting
up ropes around them.

* **PREFER** guidelines are practices that you *should* follow. However, there
may be circumstances where it makes sense to do otherwise. Just make sure
you understand the full implications of ignoring the guideline when you
do.

* **AVOID** guidelines are the dual to "prefer": stuff you shouldn't do but
where there may be good reasons to on rare occasions.

This sounds like the style police are going to beat down your door if you don't
have your laces tied correctly. Things aren't that bad. Most of the guidelines
here are common sense and we're all reasonable people. The goal, as always, is
nice, readable and maintainable code.

## Types

#### AVOID creating classes that contain only static members.

In Java and C#, all members must be in a class. In those languages, you
occasionally encounter classes that are basically namespaces: just bags of
static members. Dart, like Python and JavaScript, doesn't have this limitation.
You are free to define variables and functions at the top level.

Name collisions, when they occur, can be avoided by importing a library using a
prefix. The advantage to this is that when collisions *don't* occur (which only
the *user* of a library knows, not the creator), the user doesn't have to fully
qualify the name at every callsite.

This doesn't mean you shouldn't have *any* static members, but it should be rare
to create classes that have *only* static members. Instead, those should be
libraries. Most classes should represent things you can construct.

<div class="good">
{% prettify dart %}
library utils;

num distance(num x1, num y1, num x2, num y2) {
  /* ... */
}
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
library utils;

class GeometryUtils {
  static num distance(num x1, num y1, num x2, num y2) {
    /* ... */
  }
}
{% endprettify %}
</div>

#### AVOID defining a one-member abstract class when a simple function will do.

Unlike Java, Dart has first-class functions, closures, and a nice light syntax
for using them. If all you need is something like a callback, just use a
function. If you're defining an class and it only has a single abstract member
with a meaningless name like `call` or `invoke`, there is a good chance you
just want a function.

<div class="good">
{% prettify dart %}
typedef bool Predicate(item);
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
abstract class Predicate {
  bool test(item);
}
{% endprettify %}
</div>

## Members

#### DO use constructors instead of static methods to create instances.


Constructors are invoked using `new` or `const` which communicates clearly at
the callsite that an object is being created. Named constructors and factory
constructors in Dart give you all of the flexibility of static methods in other
languages, while still allowing the callsite to appear like a regular
constructor invocation.

<div class="good">
{% prettify dart %}
class Point {
  num x, y;
  Point(this.x, this.y);
  Point.zero()
      : x = 0,
        y = 0;
}
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
class Point {
  num x, y;
  Point(this.x, this.y);
  static Point zero() => new Point(0, 0);
}
{% endprettify %}
</div>

#### DO use `;` instead of `{}` for empty constructor bodies.


In Dart, a constructor with an empty body can be terminated with just a
semicolon. This is *required* for const constructors. For consistency and
brevity, other constructors should also do this.

<div class="good">
{% prettify dart %}
class Point {
  int x, y;
  Point(this.x, this.y);
}
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
class Point {
  int x, y;
  Point(this.x, this.y) {}
}
{% endprettify %}
</div>

#### DO place the `super()` call last in a constructor initialization list.


Field initializers are evaluated in the order that they appear in the
constructor initialization list. If you place a `super()` call in the middle of
an initializer list, the superclass's initializers will be evaluated right then
before evaluating the rest of the subclass's initializers.

What it *doesn't* mean is that the superclass's *constructor body* will be
executed then. That always happens after all initializers are run regardless of
where `super()` appears. It's vanishingly rare that the order of initializers
matters, so the placement of `super()` in the list almost never matters either.

Getting in the habit of placing it last improves consistency, visually
reinforces when the superclass's constructor body is run, and may help
performance.

<div class="good">
{% prettify dart %}
View(Style style, List children)
    : _children = children,
      super(style) {
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
View(Style style, List children)
    : super(style),
      _children = children {
{% endprettify %}
</div>

#### DO use a getter for operations that conceptually access a property.


If the name of the method starts with `get` or is an adjective like `visible` or
`empty` that's a sign you're better off using a getter. More specifically, you
should use a getter instead of a method when it:

  * **Does not take any arguments.**
  * **Returns a value.**
  * **Is side-effect free.** Invoking a getter shouldn't change any
  externally-visible state (caching internally or lazy initialization is
  OK). Invoking the same getter repeatedly should return the same value
  unless the object is explicitly changed between calls.
  * **Is fast.** Users expect expressions like `foo.bar` to execute quickly.

<div class="good">
{% prettify dart %}
num width = rect.width;
bool allGone = collection.isEmpty;
bool canSee = button.visible;
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
num amount = accounts.sum;           // may be slow to calculate
DateTime timeStamp = DateTime.now;   // returns different value each call
window.refresh;                      // doesn't return a value
{% endprettify %}
</div>

#### DO use a setter for operations that conceptually change a property.


If the name of the method starts with `set` that's often a sign that it could be
a setter. More specifically, use a setter instead of a method when it:

  * **Takes a single argument.**
  * **Changes some state in the object.**
  * **Has a corresponding getter.** It feels weird for users to have state that
  they can modify but not see. (The converse is not true; it's fine to have
  getters that don't have setters.)
  * **Is idempotent.** Calling the same setter twice with the same value
  should do nothing the second time.
  * **Is fast.** Users expect expressions like `foo.bar = value` to execute quickly.

<div class="good">
{% prettify dart %}
rect.width = 3;
button.visible = false;
{% endprettify %}
</div>

#### AVOID wrapping fields in getters and setters just to be "safe".


In Java and C#, it's common to hide all fields behind getters and setters (or
properties in C#), even if the implementation just forwards to the field. That
way, if you ever need to do more work in those members, you can without needing
to touch the callsites. This is because calling a getter method is different
than accessing a field in Java, and accessing a property isn't binary-compatible
with accessing a raw field in C#.

Dart doesn't have this limitation. Fields and getters/setters are completely
indistinguishable. You can expose a field in a class and later wrap it in a
getter and setter without having to touch any code that uses that field.

<div class="good">
{% prettify dart %}
class Box {
  var contents;
}
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
class Box {
  var _contents;
  get contents => _contents;
  set contents(value) {
    _contents = value;
  }
}
{% endprettify %}
</div>

#### PREFER using a public final field instead of a private field with a public getter.


If you have a field that outside code should be able to see but not assign to
(and you don't need to set it outside of the constructor), a simple solution
that works in many cases is to just mark it `final`.

<div class="good">
{% prettify dart %}
class Box {
  final contents = [];
}
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
class Box {
  var _contents;
  get contents => _contents;
}
{% endprettify %}
</div>

#### CONSIDER using `=>` to define members whose body returns the result of a single expression.


In addition to using `=>` for function expressions, Dart also lets you define
members with them. They are a good fit for simple members that just calculate
and return a value.

<div class="good">
{% prettify dart %}
get width => right - left;
bool ready(num time) => minTime == null || minTime <= time;
containsValue(String value) => getValues().contains(value);
{% endprettify %}
</div>

Members that don't fit on one line can still use `=>`, but if you find yourself
cramming a single expression into several continued lines, it is probably
cleaner to just use a curly body with an explicit `return`.

#### AVOID boolean arguments unless their meaning is completely obvious.


Unlike other types, booleans are usually used in literal form. Things like
numbers are usually wrapped in named constants, but we usually just pass around
`true` and `false` directly. That can make callsites unreadable if it isn't
clear what the boolean represents:

<div class="bad">
{% prettify dart %}
new Task(true);
new Task(false);
new ListBox(false, true, true);
{% endprettify %}
</div>

Instead, consider using named arguments, named constructors, or named constants
to clarify what the call is doing.

<div class="good">
{% prettify dart %}
new Task.oneShot();
new Task.repeating();
new ListBox(scroll: true, showScrollbars: true);
{% endprettify %}
</div>

## Type annotations

#### PREFER providing type annotations on public APIs.


Type annotations are important documentation for how a library should be used.
Annotating the parameter and return types of public methods and functions helps
users understand what the API expects and what it provides.

If, however, a public API does accept any type, or accepts a range of values
that Dart's type system cannot express, then it is acceptable to leave that
untyped.

For code internal to a library (either private, or things like nested functions)
annotate where you feel it helps, but don't feel that you *must* provide them.

<div class="bad">
{% prettify dart %}
install(id, destPath) {
  /* ... */
}
{% endprettify %}
</div>

Here, it's unclear what `id` is. A string? And what is `destPath`? A string or a
`File` object? Is this method synchronous or asynchronous?

<div class="good">
{% prettify dart %}
Future<bool> install(PackageId id, String destPath) {
  /* ... */
}
{% endprettify %}
</div>

With types, all of this is clarified.

#### PREFER using `var` without a type annotation for local variables.


Method bodies in modern code tend to be short, and the types of local variables
are almost always trivially inferrable from the initializing expression, so
explicit type annotations are usually just visual noise. Decent editors can
infer the type of local variables and still provide the auto-complete and
tooling support you expect.

<div class="good">
{% prettify dart %}
Map<int, List<Person>> groupByZip(Iterable<Person> people) {
  var peopleByZip = new Map<int, List<Person>>();
  for (var person in people) {
    peopleByZip.putIfAbsent(person.zip, () => <Person>[]);
    peopleByZip[person.zip].add(person);
  }
  return peopleByZip;
}
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
Map<int, List<Person>> groupByZip(Iterable<Person> people) {
  Map<int, List<Person>> peopleByZip = new Map<int, List<Person>>();
  for (Person person in people) {
    peopleByZip.putIfAbsent(person.zip, () => <Person>[]);
    peopleByZip[person.zip].add(person);
  }
  return peopleByZip;
}
{% endprettify %}
</div>

#### PREFER using `double` or `int` instead of `num` for parameter type
annotations in performance sensitive code.

Monomorphic call sites (sites that have stable input types)
can be optimized much easier than polymorphic call sites (sites that have
varying input types).

Whenever you can, pick a specific number type for your type annotation.
Explicitly say `double` or `int` to help your users pass in a consistent type
to your function or method.

When you use `num` as a type annotation, you are saying "either an int or
a double can go here." This ambiguity it harder for Dart runtimes to optimize.

#### DON'T type annotate initializing formals.


If a constructor parameter is using `this.` to initialize a field, then the type
of the parameter is understood to be the same type as the field.

<div class="good">
{% prettify dart %}
class Point {
  int x, y;
  Point(this.x, this.y);
}
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
class Point {
  int x, y;
  Point(int this.x, int this.y);
}
{% endprettify %}
</div>

#### AVOID annotating types on function expressions.


The value of function expressions is their brevity. If a function is complex
enough that types are needed to understand it, it should probably be a function
statement or a method. Conversely, if it is short enough to be an expression, it
likely doesn't need types.

<div class="good">
{% prettify dart %}
var names = people.map((person) => person.name);
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
var names = people.map((Person person) {
  return person.name;
});
{% endprettify %}
</div>

#### AVOID annotating with `dynamic` when not required.


In most places in Dart, a type annotation can be omitted, in which case the type
will automatically be `dynamic`. Thus, omitting the type annotation entirely is
semantically equivalent but more terse.

<div class="good">
{% prettify dart %}
lookUpOrDefault(String name, Map map, defaultValue) {
  var value = map[name];
  if (value != null) return value;
  return defaultValue;
}
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
dynamic lookUpOrDefault(String name, Map map, dynamic defaultValue) {
  var value = map[name];
  if (value != null) return value;
  return defaultValue;
}
{% endprettify %}
</div>

#### DO annotate with `Object` instead of `dynamic` to indicate any object is accepted.


Some operations will work with any possible object. For example, a log method
could take any object and call `toString()` on it. Two types in Dart permit all
objects: `Object` and `dynamic`. However, they convey two different things.

The `Object` annotation says "I accept any object, and I only require it to have
the methods that `Object` itself defines."

A `dynamic` type annotation means that no type annotation can express what
objects you actually allow. (Or maybe one could, but you don't care to write
it.)

<div class="good">
{% prettify dart %}
// Accepts any object.
void log(Object object) {
  print(object.toString());
}

// Only accepts bool or String, which can't be expressed in a type annotation.
bool convertToBool(arg) {
  if (arg is bool) return arg;
  if (arg is String) return arg == 'true';
  throw new ArgumentError('Cannot convert $arg to a bool.');
}
{% endprettify %}
</div>

## Names

#### DO name types using `UpperCamelCase`.


Classes and typedefs should capitalize the first letter of each word (including
the first word), and use no separators.

<div class="good" markdown="1">
{% prettify dart %}
class SliderMenu {
  // ...
}

class HttpRequest {
  // ...
}

typedef num Adder(num x, num y);
{% endprettify %}
</div>

#### DO name constants using `ALL_CAPS_WITH_UNDERSCORES`.


Constants&mdash;variables declared using `const`&mdash;are special in Dart
because they can be used in constant expressions, unlike `final` variables. To
clarify this, they are given their own naming style.

<div class="good">
{% prettify dart %}
const PI = 3.14;
const DEFAULT_TIMEOUT = 1000;
final urlScheme = new RegExp('^([a-z]+):');

class Dice {
  static final numberGenerator = new Random();
}
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
const pi = 3.14;
const kDefaultTimeout = 1000;
final URL_SCHEME = new RegExp('^([a-z]+):');

class Dice {
  static final NUMBER_GENERATOR = new Random();
}
{% endprettify %}
</div>

#### DO name other identifiers using `lowerCamelCase`.


Class members, top-level definitions, variables, parameters, and named
parameters should capitalize the first letter of each word *except* the first
word, and use no separators.

<div class="good">
{% prettify dart %}
var item;

HttpRequest httpRequest;

align(clearItems) {
  // ...
}
{% endprettify %}
</div>

#### DO name libraries and source files using `lowercase_with_underscores`.


Some file systems are not case-sensitive, so many projects require filenames to
be all lowercase. Using a separate character allows names to still be readable
in that form. Using underscores as the separator ensures that the name is still
a valid Dart identifier, which may be helpful if the language later supports
symbolic imports.

<div class="good" markdown="1">
Good:

* `slider_menu.dart`
* `file_system.dart`
* `library peg_parser;`
</div>

<div class="bad" markdown="1">
Bad:

* `SliderMenu.dart`
* `filesystem.dart`
* `library peg-parser;`
</div>

#### DO capitalize acronyms and abbreviations longer than two letters like words.


Capitalized acronyms can be harder to read, and are ambiguous when you have
multiple adjacent acronyms. Given the name `HTTPSFTPConnection`, there's no way
to tell if that's an HTTPS FTP connection or an HTTP SFTP one.

To avoid this, acronyms are capitalized like regular words, except for
two-letter ones.

<div class="good">
{% prettify dart %}
HttpConnection
uiHandler
IOStream
HttpRequest
ID
id
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
HTTPConnection
UiHandler
IoStream
HTTPRequest
Id
{% endprettify %}
</div>

## Comments

#### DO comment members and types using doc-style comments.


Dart supports two syntaxes of doc comments. Line doc comments start each line
with `///`:

<div class="good">
{% prettify dart %}
/// Parses a set of option strings. For each option:
///
/// * If it is `null`, then it is ignored.
/// * If it is a string, then [validate] is called on it.
/// * If it is any other type, it is *not* validated.
void parse(List options) {
  // ...
}
{% endprettify %}
</div>

Block doc comments start with `/**`, end with `*/` and can span multiple lines:

<div class="good">
{% prettify dart %}
/**
 * Parses a set of option strings.
 */
void parse(List options) {
  // ...
}
{% endprettify %}
</div>

Within a doc comment, you can use [markdown][] for formatting.

[markdown]: http://daringfireball.net/projects/markdown/

#### DO use line comments for everything else.


<div class="good">
{% prettify dart %}
greet(name) {
  // Assume we have a valid name.
  print('Hi, $name!');
}
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
greet(name) {
  /* Assume we have a valid name. */
  print('Hi, $name!');
}
{% endprettify %}
</div>

#### DO capitalize and punctuate comments like sentences.


This doesn't mean that the comment must always be a complete sentence, though it
usually should. "Returns the number of items." is an acceptable comment.

<div class="good">
{% prettify dart %}
// Remove the last item from the collection.
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
// remove the last item from the collection
{% endprettify %}
</div>

#### DO use square brackets in doc comments for identifiers that are in scope.


If you surround things like variable, method or type names in square brackets,
then documentation generators can look up the name and cross-link the two
together.

<div class="good">
{% prettify dart %}
import 'dart:math';

/// Rolls both [Dice] and returns the highest rolled value.
num greatestRoll(Dice a, Dice b) => max(a.roll(), b.roll());
{% endprettify %}
</div>

#### DO describe method signatures in the prose of the documentation comment.



Other languages use verbose tags and sections to describe what the parameters
and returns of a method are.

<div class="bad">
{% prettify dart %}
/**
 * Defines a flag with the given name and abbreviation.
 *
 * @param name The name of the flag.
 * @param abbr The abbreviation for the flag.
 * @returns The new flag.
 * @throws IllegalArgumentException If there is already an option with
 *     the given name or abbreviation.
 */
Flag addFlag(String name, String abbr) {
  // ...
}
{% endprettify %}
</div>

The convention in Dart is to just integrate that into the description of the
method and highlight parameters using square brackets.

<div class="good">
{% prettify dart %}
/**
 * Defines a flag. Throws an [IllegalArgumentException] if there is
 * already an option named [name] or there is already an option using
 * abbreviation [abbr]. Returns the new flag.
 */
Flag addFlag(String name, String abbr) {
  // ...
}
{% endprettify %}
</div>

## Whitespace

Like many languages, Dart ignores whitespace. However, *humans* don't. Having a
consistent whitespace style helps ensure that human readers see code the same
way the compiler does.

#### DON'T use tabs.


Using spaces for formatting ensures the code looks the same in everyone's
editor. It also makes sure it looks the same when posted to blogs, or on code
sites like [Google Code][] or [GitHub][].

[google code]: http://code.google.com/projecthosting/
[github]: http://github.com

Modern editors emulate the behavior of tabs while inserting spaces, giving you
the easy editing of tabs and the consistency of spaces.

#### AVOID lines longer than 80 characters.


Readability studies show that long lines of text are harder to read because your
eye has to travel farther when moving to the beginning of the next line. This is
why newspapers and magazines use multiple columns of text.

If you really find yourself wanting lines longer than 80 characters, our
experience is that your code is likely too verbose and could be a little more
compact. Do you really need to call that class
`AbstractWidgetFactoryManagerBuilder`?

#### DO place the operator on the preceding line in a multi-line expression.


There are valid arguments for both styles but most of our code seems to go this
way, and consistency matters most.

<div class="good">
{% prettify dart %}
if (isDeepFried ||
    (hasPieCrust && !vegan) ||
    containsBacon) {
  print('Bob likes it.');
}
{% endprettify %}
</div>

Note that this includes `=>` as well:

<div class="good">
{% prettify dart %}
bobLikes() =>
    isDeepFried || (hasPieCrust && !vegan) || containsBacon;
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
bobLikes()
    => isDeepFried || (hasPieCrust && !vegan) || containsBacon;
{% endprettify %}
</div>

#### DO place the `.` on the next line in a multi-line expression.


This supercedes the previous rule. Unlike other operators, if you split an
expression on a `.`, then put that at the beginning of the second line.

<div class="good">
{% prettify dart %}
someVeryLongVariable.withAVeryLongProperty
    .aMethodOnThatObject();
{% endprettify %}
</div>

#### DO indent block bodies two spaces.


<div class="good">
{% prettify dart %}
if (condition) {
  print('hi');
}
{% endprettify %}
</div>

#### DO indent continued lines with at least four spaces.


<div class="good">
{% prettify dart %}
someLongObject.aReallyLongMethodName(longArg, anotherLongArg,
    wrappedToNextLine);
{% endprettify %}
</div>

You may indent more than four spaces to line things up if you like:

<div class="good">
{% prettify dart %}
someLongObject.aReallyLongMethodName(longArg, anotherLongArg,
                                     wrappedToNextLine);
{% endprettify %}
</div>

#### DON'T indent lines that are continued with a function expression.


The one exception to the above rule is function expressions used within larger
expressions, like being passed to methods. These are formatted like so:

<div class="good">
{% prettify dart %}
new Future.delayed(const Duration(seconds:1), () {
  print('I am a callback');
});
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
new Future.delayed(const Duration(seconds:1), () {
      print('I am a callback');
    });
{% endprettify %}
</div>

#### DO place the opening curly brace (`{`) on the same line as what it follows.


<div class="good">
{% prettify dart %}
class Foo {
  method() {
    if (true) {
      // ...
    } else {
      // ...
    }
  }
}
{% endprettify %}
</div>

#### DO use curly braces for all flow control structures.


Doing so avoids the [dangling else][] problem.

[dangling else]: http://en.wikipedia.org/wiki/Dangling_else

<div class="good">
{% prettify dart %}
if (true) {
  print('sanity');
} else {
  print('opposite day!');
}
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
if (true) print('sanity');
else
  print('opposite day!');
{% endprettify %}
</div>

There is one exception to this: short `if` statements with no `else` clause that
fit on one line may omit the braces.

<div class="good">
{% prettify dart %}
if (arg == null) return defaultValue;
{% endprettify %}
</div>

#### DO indent switch cases two spaces and case bodies four spaces.


<div class="good">
{% prettify dart %}
switch (fruit) {
  case 'apple':
    print('delish');
    break;

  case 'durian':
    print('stinky');
    break;
}
{% endprettify %}
</div>

#### DO use spaces around binary and ternary operators, after commas, and not around unary operators.



Note that `<` and `>` are considered binary operators when used as expressions,
but not for specifying generic types. Both `is` and `is!` are considered single
binary operators. However, the `.` used to access members is not and should
*not* have spaces around it.

<div class="good">
{% prettify dart %}
a = 1 + 2 / (3 * -b);
c = !condition == a > b;
d = condition ? b : object.method(a, b, c);
if (obj is! SomeType) print('not SomeType');
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
a=1+2/(3* - b);
c= ! condition==a>b;
d= condition?b:object.method(a,b,c);
if (obj is !SomeType) print('not SomeType');
{% endprettify %}
</div>

#### DO place spaces around `in`, and after each `;` in a loop.


<div class="good">
{% prettify dart %}
for (var i = 0; i < 100; i++) {
  // ...
}

for (final item in collection) {
  // ...
}
{% endprettify %}
</div>

#### DO use a space after flow-control keywords.


This is unlike function and method calls, which do *not* have a space between
the name and the opening parenthesis.

<div class="good">
{% prettify dart %}
while (foo) {
  // ...
}

try {
  // ...
} catch (e) {
  // ...
}
{% endprettify %}
</div>

#### DON'T use a space after `(`, `[`, and `{`, or before `)`, `]`, and `}`.


Also, do not use a space when using `<` and `>` for generic types.

<div class="good">
{% prettify dart %}
var numbers = <int>[1, 2, (3 + 4)];
{% endprettify %}
</div>

#### DO use a space before `{` in function and method bodies.


This is an exception to the above rule. When a `{` is used after a parameter
list in a function or method, there should be a space between it and the `)`
ending the parameters.

<div class="good">
{% prettify dart %}
getEmptyFn(a) {
  return () {};
}
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
getEmptyFn(a){
  return (){};
}
{% endprettify %}
</div>

#### DO format constructor initialization lists with each field on its own line.


<div class="good">
{% prettify dart %}
MyClass()
    : firstField = "some value",
      secondField = "another",
      thirdField = "last" {
  // ...
}
{% endprettify %}
</div>

Note that the `:` should be wrapped to the next line and indented four spaces.
Fields should all line up (so all but the first field end up indented six
spaces).

#### DO use a space around `:` in named parameters and after `:`  for a named argument.


<div class="good">
{% prettify dart %}
class ListBox {
  bool showScrollbars;

  ListBox({this.showScrollbars: false});
}

main() {
  new ListBox(showScrollbars: true);
}
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
new ListBox(showScrollbars:true);
new ListBox(showScrollbars : true);
{% endprettify %}
</div>

#### DO use a spaces around `=` in optional positional parameters.


<div class="good">
{% prettify dart %}
class HttpServer {
  static Future<HttpServer> listen([int port = 80]) {
    // ...
  }
}
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
import 'dart:async';

class HttpServer {
  static Future<HttpServer> listen([int port=80]) {
    // ...
  }
}
{% endprettify %}
</div>

#### DO use four spaces for method cascades


<div class="good">
{% prettify dart %}
var list = new List()
    ..addAll([1,2,3])
    ..addAll([4,5,6]);
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
var list = new List()
  ..addAll([1,2,3])
  ..addAll([4,5,6]);
{% endprettify %}
</div>
