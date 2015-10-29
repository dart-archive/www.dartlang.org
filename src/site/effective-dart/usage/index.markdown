---
layout: article
title: "Effective Dart: Usage"
description: "Guidelines for using language features to write maintainable code."
has-permalinks: true
prev-guide: /effective-dart/documentation/
prev-guide-title: "Documentation"
next-guide: /effective-dart/design/
next-guide-title: "Design"
---

{% include toc.html %}
{% include effective-dart-nav.html %}

# {{ page.title }}

This is the most "blue-collar" guide in Effective Dart. You'll apply the
guidelines here every day in the bodies of your Dart code. *Users* of your
library may not be able to tell that you've internalized the ideas here, but
*maintainers* of it sure will.

## Strings

### DO use adjacent strings to concatenate string literals.
{:.no_toc}

If you have two string literals&mdash;not values, but the actual quoted literal
form&mdash;you do not need to use `+` to concatenate them. Just like in C and
C++, simply placing them next to each other does it. This is a good way to make
a single long string that doesn't fit on one line.

<div class="good">
{% prettify dart %}
raiseAlarm(
    "ERROR: Parts of the spaceship are on fire. Other "
    "parts are overrun by martians. Unclear which are which.");
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
raiseAlarm(
    "ERROR: Parts of the spaceship are on fire. Other " +
    "parts are overrun by martians. Unclear which are which.");
{% endprettify %}
</div>

### PREFER using interpolation to compose strings and values.
{:.no_toc}

If you're coming from other languages, you're used to using long chains of `+`
to build a string out of literals and other values. That does work in Dart, but
it's almost always cleaner and shorter to use interpolation:

<div class="good">
{% prettify dart %}
"Hello, $name! You are ${year - birth} years old.";
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
"Hello, " + name + "! You are " + (year - birth) + " years old.";
{% endprettify %}
</div>

### AVOID using curly braces in interpolation when not needed.
{:.no_toc}

If you're interpolating a simple identifier not immediately followed by more
alphanumeric text, the `{}` should be omitted.

<div class="good">
{% prettify dart %}
'Hi, $name!'
"Wear your wildest $decade's outfit."
'Wear your wildest ${decade}s outfit.'
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
'Hi, ${name}!'
"Wear your wildest ${decade}'s outfit."
{% endprettify %}
</div>

## Collections

### DO use collection literals when possible.
{:.no_toc}

There are two ways to make an empty growable list: `[]` and `new List()`.
Likewise, there are three ways to make an empty linked hash map: `{}`, `new
Map()`, and `new LinkedHashMap()`.

If you want to create a non-growable list, or some other custom collection type
then, by all means, use a constructor. Otherwise, use the nice literal syntax.
The core library exposes those constructors to ease adoption, but idiomatic Dart
code does not use them.

<div class="good">
{% prettify dart %}
var points = [];
var addresses = {};
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
var points = new List();
var addresses = new Map();
{% endprettify %}
</div>

You can even provide a type argument for them if that matters.

<div class="good">
{% prettify dart %}
var points = <Point>[];
var addresses = <String, Address>{};
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
var points = new List<Point>();
var addresses = new Map<String, Address>();
{% endprettify %}
</div>

Note that this doesn't apply to the *named* constructors for those classes.
`List.from()`, `Map.fromIterable()`, and friends all have their uses. Likewise,
if you're passing a size to `new List()` to create a non-growable one, then it
makes sense to use that.

### DON'T use `.length` to see if a collection is empty.
{:.no_toc}

The [Iterable][] contract does not require that a collection know its length or
be able to provide it in constant time. Calling `.length` just to see if the
collection contains *anything* can be painfully slow.

[iterable]: https://api.dartlang.org/1.12.1/dart-core/Iterable-class.html

Instead, there are faster and more readable getters: `.isEmpty` and
`.isNotEmpty`. Use the one that doesn't require you to negate the result.

<div class="good">
{% prettify dart %}
if (lunchBox.isEmpty) return "so hungry...";
if (words.isNotEmpty) return words.join(" ");
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
if (lunchBox.length == 0) return "so hungry...";
if (!words.isEmpty) return words.join(" ");
{% endprettify %}
</div>

### CONSIDER using higher-order methods to transform a sequence.
{:.no_toc}

If you have a collection and want to produce a new modified collection from it,
it's often shorter and more declarative to use `.map()`, `.where()`, and the
other handy methods on `Iterable`.

Using those instead of an imperative `for` loop makes it clear that your intent
is to produce a new sequence and not to produce side effects.

<div class="good">
{% prettify dart %}
var aquaticNames = animals
    .where((animal) => animal.isAquatic)
    .map((animal) => animal.name);
{% endprettify %}
</div>

At the same time, this can be taken too far. If you are chaining or nesting
many higher-order methods, it may be clearer to write a chunk of imperative
code.

### AVOID using `Iterable.forEach()` with a function literal.
{:.no_toc}

`forEach()` functions are widely used in JavaScript because the built in
`for-in` loop doesn't do what you usually want. In Dart, if you want to iterate
over a sequence, the idiomatic way to do that is using a loop.

<div class="good">
{% prettify dart %}
for (var person in people) {
  ...
}
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
people.forEach((person) {
  ...
});
{% endprettify %}
</div>

The exception is if all you want to do is invoke some already existing function
on each element. In that case, `forEach()` is handy.

<div class="good">
{% prettify dart %}
people.forEach(print);
{% endprettify %}
</div>

## Functions

### DO use a function declaration to bind a function to a name.
{:.no_toc}

Modern languages have realized how useful local nested functions and closures
are. It's common to have a function defined inside another one. In many cases,
this function is used as a callback immediately and doesn't need a name. A
function expression is great for that.

But, if you do need to give it a name, use a function declaration statement
instead of binding a lambda to a variable.

<div class="good">
{% prettify dart %}
void main() {
  localFunction() {
    ...
  }
}
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
void main() {
  var localFunction = () {
    ...
  };
}
{% endprettify %}
</div>

### DON'T create a lambda when a tear-off will do.
{:.no_toc}

If you refer to a method on an object but omit the parentheses, Dart gives you
a "tear-off"&mdash;a closure that takes the same parameters as the method and
invokes it when you call it.

If you have a function that invokes a method with the same arguments as are
passed to it, you don't need to manually wrap the call in a lambda.

<div class="good">
{% prettify dart %}
names.forEach(print);
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
names.forEach((name) {
  print(name);
});
{% endprettify %}
</div>

## Variables

### DON'T explicitly initialize variables to `null`.
{:.no_toc}

In Dart, a variable or field that is not explicitly initialized automatically
gets initialized to `null`. This is reliably specified by the language. There's
no concept of "uninitialized memory" in Dart. Adding `= null` is redundant and
unneeded.

<div class="good">
{% prettify dart %}
int _nextId;

class LazyId {
  int _id;

  int get id {
    if (_nextId == null) _nextId = 0;
    if (_id == null) _id = _nextId++;

    return _id;
  }
}
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
int _nextId = null;

class LazyId {
  int _id = null;

  int get id {
    if (_nextId == null) _nextId = 0;
    if (_id == null) _id = _nextId++;

    return _id;
  }
}
{% endprettify %}
</div>


### CONSIDER omitting the types for local variables.
{:.no_toc}

Method bodies in modern code tend to be short, and the types of local variables
are almost always trivially inferrable from the initializing expression, so
explicit type annotations are usually just visual noise.

Dart comes with powerful static analysis tools that will infer the type of local
variables and still provide the auto-complete and tooling support you expect.

<div class="good">
{% prettify dart %}
Map<int, List<Person>> groupByZip(Iterable<Person> people) {
  var peopleByZip = <int, List<Person>>{};
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
  Map<int, List<Person>> peopleByZip = <int, List<Person>>{};
  for (Person person in people) {
    peopleByZip.putIfAbsent(person.zip, () => <Person>[]);
    peopleByZip[person.zip].add(person);
  }
  return peopleByZip;
}
{% endprettify %}
</div>


## Members

### DON'T wrap a field in a getter and setter unnecessarily.
{:.no_toc}

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


### PREFER using a `final` field to make a read-only property.
{:.no_toc}

If you have a field that outside code should be able to see but not assign to, a
simple solution that works in many cases is to simply mark it `final`.

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

Of course, if you need to internally assign to the field outside of the
constructor, you may need to do the "private field, public getter" pattern, but
don't reach for that until you need to.


### CONSIDER using `=>` for short members whose body is a single expression.
{:.no_toc}

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

It's *not* a good idea to use this for `void` members. Readers expect `=>` to
mean "returns a useful value", so even though it can be terse to use `=>` for
a member that doesn't return anything, it's clearer to use `{ ... }`.


## Constructors

### DO use initializing formals when possible.
{:.no_toc}

Many fields are initialized directly from a constructor parameter, like:

<div class="bad">
{% prettify dart %}
class Point {
  num x, y;
  Point(num x, num y) {
    this.x = x;
    this.y = y;
  }
}
{% endprettify %}
</div>

We've got to type `x` _four_ times here define a field. Lame. We can do better:

<div class="good">
{% prettify dart %}
class Point {
  num x, y;
  Point(this.x, this.y);
}
{% endprettify %}
</div>

This `this.` syntax before a constructor parameter is called an "initializing
formal". You can't always take advantage of it. In particular, using it means
the parameter is not visible in the initialization list. But, when you can, you
should.


### DON'T type annotate initializing formals.
{:.no_toc}

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


### DO use `;` instead of `{}` for empty constructor bodies.
{:.no_toc}

In Dart, a constructor with an empty body can be terminated with just a
semicolon. (In fact, it's required for const constructors.)

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


### DO place the `super()` call last in a constructor initialization list.
{:.no_toc}

Field initializers are evaluated in the order that they appear in the
constructor initialization list. If you place a `super()` call in the middle of
an initializer list, the superclass's initializers will be evaluated right then
before evaluating the rest of the subclass's initializers.

What it *doesn't* mean is that the superclass's *constructor body* is executed
then. That always happens after all initializers are run regardless of where
`super()` appears. Placing the `super()` elsewhere is confusing and almost never
useful. In fact, [DDC][] *requires* that it appear last.

[ddc]: https://github.com/dart-lang/dev_compiler

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


## Async

### PREFER async/await over using raw futures.
{:.no_toc}

Explicit asynchronous code is notoriously hard to read and debug, even when
using a nice abstraction like futures. This is why we added `async`/`await` to
the language. They make a huge improvement in readability code and let you use
all of the built-in control flow structures of the language within your
asynchronous code.

<div class="good">
{% prettify dart %}
Future<bool> doAsyncComputation() async {
  try {
    var result = await longRunningCalculation();
    return await verifyResult(result);
  } catch(e) {
    log.error(e);
    return false;
  }
}
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
Future<bool> doAsyncComputation() {
  return longRunningCalculation().then((result) {
    return verifyResult(result);
  }).catchError((e) {
    log.error(e);
    return new Future.value(false);
  });
}
{% endprettify %}
</div>

### DON'T use `return await`.
{:.no_toc}

Awaiting a future and then returning from an async function, which then wraps
that result back in a future, is redundant. Omit the `await`.

<div class="good">
{% prettify dart %}
Future intersperse(Future before, String message, Future after) async {
  await before;
  print(message);
  return after;
}
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
Future intersperse(Future before, String message, Future after) async {
  await before;
  print(message);
  return await after;
}
{% endprettify %}
</div>

### DON'T use `async` when it has no useful effect.
{:.no_toc}

It's easy to get in the habit of using `async` on any function that does
anything related to asynchrony. But in some cases, it's extraneous. If you can
omit the `async` without changing the behavior of the function, do so.

<div class="good">
{% prettify dart %}
Future afterTwoThings(Future first, second) {
  return Future.wait([first, second]);
}
{% endprettify %}
</div>

<div class="bad">
{% prettify dart %}
Future afterTwoThings(Future first, second) async {
  return Future.wait([first, second]);
}
{% endprettify %}
</div>

Cases where `async` *is* useful include:

* You are using `await`. (This is the obvious one.)

* You are returning an error asynchronously. `async` and then `throw` is shorter
  than `return new Future.error(...)`.

* You are returning a value and you want it implicitly wrapped in a future.
  `async` is shorter than `new Future.value(...)`.

* You don't want any of the code to execute until after the event loop has taken
  a turn.

<div class="good">
{% prettify dart %}
Future usesAwait(Future later) async {
  print(await later);
}

Future asyncError() async {
  throw "Error!";
}

Future asyncValue() async {
  return "value";
}
{% endprettify %}
</div>

### CONSIDER using higher-order methods to transform a stream.
{:.no_toc}

This parallels the above suggestion on iterables. Streams support many of the
same methods and also handle things like transmitting errors, closing, etc.
correctly.
