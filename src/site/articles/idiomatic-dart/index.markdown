---
layout: article
title: "Idiomatic Dart"
rel:
  author: bob-nystrom
description: 'Learn how to write code that looks and feels like Dart.'
has-permalinks: true
article:
  written_on: 2011-10-01
  updated_on: 2013-03-12
  collection: everyday-dart
---

{% include toc.html %}

# {{ page.title }}

_Written by Bob Nystrom<br>
October 2011
(updated March 2013)_

Dart was designed to look and feel familiar if you're coming from other
languages, in particular Java and JavaScript. If you try hard enough, you can
use Dart just like it was one of those languages. If you try _really_ hard, you
may even be able to turn it into Fortran, but you'll be missing out on what's
unique and fun about Dart.

This article will help teach you to write code that's uniquely suited for Dart.
Since the language is still evolving, many of the idioms here are changing too.
There are places in the language where we still aren't sure what the best
practice is yet. (Maybe you can help us.) But here are some pointers that will
hopefully kick your brain out of Java or JavaScript mode, and into Dart.

<aside class="alert alert-info" markdown="1">
  **Note**:
  This article is not intended to teach you the basics of programming with Dart.
  If you are new to Dart, we recommend that you first explore the
  [Language Tour](/docs/dart-up-and-running/).
</aside>

## Constructors

We'll start this article the way every object starts its life: with
constructors. Every object will be constructed at some point, and defining
constructors is an important part of making a usable class. Dart has a few
interesting ideas here.

### Automatic field initialization

First up is getting rid of some tedium. Many constructors simply take their
arguments and assign them to fields, like:

{% prettify dart %}
class Point {
  num x, y;
  Point(num x, num y) {
    this.x = x;
    this.y = y;
  }
}
{% endprettify %}

So we've got to type `x` _four_ times here just to initialize a field. Lame. We
can do better:

{% prettify dart %}
class Point {
  num x, y;
  Point(this.x, this.y);
}
{% endprettify %}

If an argument has `this.` before it in a constructor argument list, the field
with that name will automatically be initialized with that argument's value.
This example shows another little feature too: if a constructor body is
completely empty, you can just use a semicolon (`;`) instead of `{}`.

### Named constructors

Like most dynamically-typed languages, Dart doesn't support overloading. With
methods, this isn't much of a limitation because you can always use a different
name, but constructors aren't so lucky. To alleviate that, Dart lets you define
_named constructors_:

{% prettify dart %}
import 'dart:math';

class Point {
  num x, y;
  Point(this.x, this.y);
  Point.zero() : x = 0, y = 0;
  Point.polar(num theta, num radius) {
    x = cos(theta) * radius;
    y = sin(theta) * radius;
  }
}
{% endprettify %}

Here our Point class has three constructors, a normal one and two named ones.
You can use them like so:

{% prettify dart %}
import 'dart:math';

main() {
  var a = new Point(1, 2);
  var b = new Point.zero();
  var c = new Point.polar(PI, 4.0);
}
{% endprettify %}

Note that we're still using `new` here when we invoke the named constructor. It
isn't just a static method.

### Factory constructors

There are a couple of design patterns floating around related to _factories._
They come into play when you need an instance of some class, but you want to be
a little more flexible than just hard-coding a call to a constructor for some
concrete type. Maybe you want to return a previously cached instance if you have
one, or maybe you want to return an object of a different type.

Dart supports that without requiring you to change what it looks like when you
create the object. Instead, you can define a _factory constructor_. When you
_call_ it, it looks like a regular constructor. But the implementation is free
to do anything it wants. For example:

{% prettify dart %}
class Symbol {
  final String name;
  static Map<String, Symbol> _cache;

  factory Symbol(String name) {
    if (_cache == null) {
      _cache = {};
    }

    if (_cache.containsKey(name)) {
      return _cache[name];
    } else {
      final symbol = new Symbol._internal(name);
      _cache[name] = symbol;
      return symbol;
    }
  }

  Symbol._internal(this.name);
}
{% endprettify %}

Here we have a class that defines symbols. A symbol is like a string but we
guarantee that there will only be one symbol with a given name in existence at
any point in time. This lets you safely compare two symbols for equality just by
testing that they're the same object.

The default (unnamed) constructor here is prefixed with `factory`. That tells
Dart that this is a factory constructor. When it's invoked, it will _not_ create
a new object. (There is no `this` inside a factory constructor.) Instead, you
are expected to create an instance and explicitly return it. Here, we look for a
previously cached symbol with the given name and reuse it if we found it.

What's cool is that the _caller_ never sees this. They just do:

{% prettify dart %}
var a = new Symbol('something');
var b = new Symbol('something');

assert(identical(a, b)); // true!
{% endprettify %}

The second call to `new` will return the previously cached object. This is nice
because it means that if we don't need a factory constructor at first, but later
realize we do, we won't have to change all of our existing code that's calling
`new` to instead call some static method.

## Functions

Like most modern languages, Dart features first-class functions with full
closures and a lightweight syntax. Functions are objects just like any other,
and you shouldn't hesitate to use them freely.

Dart has three notations for creating functions:

* named functions
* anonymous functions with statement bodies
* expression bodies, also known as _arrow functions_

The named form looks like this:

{% prettify dart %}
bool isShouting(String message) {
  return (message.toUpperCase() == message);
}
{% endprettify %}

The above example looks similar to functions or methods
found in C or Java. You can call functions in the usual way:

{% prettify dart %}
print(isShouting("I'M JUST VERY EXCITED")); // true
{% endprettify %}

In Dart, functions are objects, so you can pass them as arguments:

{% prettify dart %}
var messages = ['hello', 'DART IS FUN'];
var shouts = messages.where(isShouting).toList();

print(shouts); // ['DART IS FUN']
{% endprettify %}

If you don't need to give a name to a function, there is an anonymous form, too.
It looks like a named function, but without a name or return type.
Here is an example:

{% prettify dart %}
var shouts2 = messages.where((m) {
  return (m.toUpperCase() == m);
}).toList();
{% endprettify %}

Finally, if you need a really lightweight function that just evaluates
and returns a single expression, there's `=>`:

{% prettify dart %}
var shouts3 = messages.where((m) => m.toUpperCase() == m).toList();
{% endprettify %}

A parenthesized argument list followed by `=>` and a single expression
creates a function that takes those arguments, and returns the result of the
expression.

In practice, we find ourselves preferring arrow functions whenever possible
since they're terse but still easy to spot thanks to `=>`. We use anonymous
functions frequently for event handlers and callbacks.

Read more about
[functions in Dart](/docs/dart-up-and-running/contents/ch02.html#functions).

### One-line methods

Dart has one more trick up its sleeve that is one of my favorite features of the
language: you can also use `=>` for defining members. Sure, you _could_ do
this:

{% prettify dart %}
class Rectangle {
  num width, height;

  bool contains(num x, num y) {
    return (x < width) && (y < height);
  }

  num area() {
    return width * height;
  }
}
{% endprettify %}

But why do that when you can just do:

{% prettify dart %}
class Rectangle {
  num width, height;
  bool contains(num x, num y) => (x < width) && (y < height);
  num area() => width * height;
}
{% endprettify %}

We find arrow functions are great for defining simple getters and other one-
liner methods that calculate or access some property of an object.

### Function types and aliases

As a reminder, Dart allows you to pass a function as an argument to another
function. Here is an example:

{% prettify dart %}
List<num> filterNumbers(List<num> numbers, bool filter(num x)) {
  return numbers.where(filter).toList();
}
{% endprettify %}

While the above code works, it would be nice to extract extra type information
about `filter`. As it is written, you can't ask what kind of function
filter is. That is, you can't say `if (filter is bool filter(num x))`.
Also, the syntax is a bit noisy in the signature for `filterNumbers`.

To help clean up function signatures, and to provide a bit more type
information about functions, you can use a _typedef_.
A typedef essentially provides an alias for a function signature.

{% prettify dart %}
typedef bool Filter(num x);

List<num> filterNumbers(List<num> numbers, Filter filter) {
  return numbers.where(filter).toList();
}
{% endprettify %}

Now you can easily ask `if (filter is Filter)`.

Whenever you create a field that's set to a function value, use a typedef to
specify that function's signature. The following example is from Dart's Web UI
library:

{% prettify dart %}
/** Function to set up the contents of a conditional template. */
typedef void ConditionalBodySetup(ConditionalTemplate template);

/**
 * A template conditional like `<template instantiate="if test">` or
 * `<td template instantiate="if test">`.
 */
class ConditionalTemplate extends PlaceholderTemplate {
  bool isVisible = false;
  final ConditionalBodySetup bodySetup;

  ConditionalTemplate(Node reference, exp, this.bodySetup)
      : super(reference, exp);

  ...
{% endprettify %}

## Type annotations

Why do this:

{% prettify javascript %}
// JavaScript w/ Closure compiler

/**
 * @param {String} name
 * @return {String}
 */
makeGreeting = function(name) {
  /** @type {String} */
  var greeting = 'hello ' + name;
  return greeting;
}
{% endprettify %}

When you can do this:

{% prettify dart %}
// Dart

String MakeGreeting(String name) {
  String greeting = 'hello $name';
  return greeting;
}
{% endprettify %}

Dart is an optionally typed language, which means developers don't need
to fight ceremonial type checkers just to get their code to run. Use type
annotations as "inline documentation" to help your fellow developers and
tools.

Generally speaking, **use type annotations on the "surface area" of your code**.
If another developer is going to see the interface, use type annotations.
Your friends will thank you.

Inside of methods, the rules are a bit more flexible. Use type annotations
when you want to, but feel free to use `var` if your team's style guide
permits it. A good editor or analyzer should perform useful type inference
even if var is used.

It's perfectly fine to omit a type annotation if you need to express something
the type system can't naturally express. For example, if your method takes
an integer or a Duration, you can simply use `var`.

{% prettify dart %}
/// This method used to only take an [int] but now it takes a [Duration] or
/// [int]. Use of [int] is deprecated, please use [Duration].
calculateTimePeriod(var duration) {
  if (duration is int) {
    // ...
  } else if (duration is Duration) {
    // ...
  } else {
    throw new ArgumentError('duration must be an int or Duration');
  }
}
{% endprettify %}

This is a common practice used while an API is evolving. Once the evolution is
complete, you can add a specific type annotation.

Learn more about [Dart's optional static typing](/articles/optional-types/).

## Fields, getters, and setters

Speaking of properties, Dart uses your standard `object.someProperty` syntax for
working with them. That's how most languages work when `someProperty` is an
actual field on the class, but Dart also allows you to define methods that look
like property access but execute whatever code you want. As in other languages,
these are called _getters_ and _setters_. Here's an example:

{% prettify dart %}
class Rectangle {
  num left, top, width, height;

  Rectangle(this.left, this.top, this.width, this.height);

  num get right             => left + width;
      set right(num value)  => left = value - width;
  num get bottom            => top + height;
      set bottom(num value) => top = value - height;
}
{% endprettify %}

Here we have a Rectangle class with four actual fields, `left`, `top`, `width`,
and `height`. It also has getters and setters to define two more logical
properties: `right` and `bottom`. If you're using the class, there is no visible
difference between a "real" field and getters and setters:

{% prettify dart %}
var rect = new Rectangle(3, 4, 20, 15);
print(rect.left);
print(rect.bottom);
rect.top = 6;
rect.right = 12;
{% endprettify %}

This blurring the line between fields and getters/setters is fundamental to the
language. The clearest way to think of it is that fields _are_ just getters and
setters with default implementations. This means that you can do fun stuff like
override an inherited getter with a field and vice versa. If an interface
defines a getter, you can implement it by simply having a field with the same
name and type. If the field is mutable (not `final`) it can implement a setter
that an interface requires.

In practice, what this means is that you don't have to insulate your fields by
defensively hiding them behind boilerplate getters and setters like you would in
Java or C#. If you have some exposed property, feel free to make it a public
field. If you don't want it to be modified, just make it `final`.

Later, if you need to do some validation or other work, you can always replace
that field with a getter and setter. If we wanted our Rectangle class to make
sure it always has a non-negative size, we could change it to:

{% prettify dart %}
class Rectangle {
  num left, top;
  num _width, _height;

  Rectangle(this.left, this.top, this._width, this._height);

  num get width => _width;
  set width(num value) {
    if (value < 0) throw 'Width cannot be negative.';
    _width = value;
  }

  num get height => _height;
  set height(num value) {
    if (value < 0) throw 'Height cannot be negative.';
    _height = value;
  }

  num get right             => left + width;
      set right(num value)  => left = value - width;
  num get bottom            => top + height;
      set bottom(num value) => top = value - height;

}
{% endprettify %}

And now we've modified the class to do some validation without having to touch
any of the existing code that was already using it.

## Top-level definitions

Dart is a "pure" object-oriented language in that everything you can place in a
variable is a real object (no mutant "primitives") and every object is an
instance of some class. It's not a _dogmatic_ OOP language though. You aren't
required to place everything you define inside some class. Instead, you are free
to define functions, variables, and even getters and setters at the top level if
you want.

{% prettify dart %}
import 'dart:math';

num abs(num value) => value < 0 ? -value : value;

final TWO_PI = PI * 2.0;

int get today {
  final date = new DateTime.now();
  return date.day;
}

main() {
  print(today);
}
{% endprettify %}

Even in languages that don't require you to place everything inside a class or
object, like JavaScript, it's still common to do so as a form of namespacing:
top-level definitions with the same name could inadvertently collide. To address
that, Dart has a library system that allows you to import definitions from other
libraries with a prefix applied to disambiguate it. That means you shouldn't
_need_ to defensively squirrel your definitions inside classes.

The most common example of a top-level function is `main()`. If you work with
the DOM, the familiar `document` and `window` "variables" are actually top-level
getters in Dart. The project used to have a Math class, but we moved all
functionality from that class to top-level methods inside the dart:math library.

## Dependency injection

You can combine ideas from typedefs, functions, and constructors to build a
simple _dependency injection_ system. Consider this example:

{% prettify dart %}
typedef Connection ConnectionFactory();

Connection _newDBConnection() => new DatabaseConnection();

class Person {
  String id;
  String name;
  ConnectionFactory connectionFactory;

  Person({this.connectionFactory: _newDBConnection});

  Future save() {
    var conn = connectionFactory();
    return conn.query('UPDATE PERSONS SET name = ? WHERE id = ?', [name, id]);
  }
}
{% endprettify %}

The above sample shows off a bunch of cool features from Dart:

Typedefs
: Used to create an alias for a function that returns a new database
  connection.

Optional named parameters
: Used to set a default database connection factory,
  or use a user-supplied factory function.

Top-level functions
: Used to define the default database connection factory method.

## Strings and interpolation

Dart has a few kinds of string literals. You can use single or double quotes,
and you can use triple-quoted multiline strings:

{% prettify dart %}
var s1 = 'I am a "string"'
"I'm one too";

var s2 = '''I'm
on multiple lines
''';

var s3 = """
As
am
I
""";
{% endprettify %}

While there is a plus (+) operator on String, it's often cleaner and faster to
use _string interpolation_:

{% prettify dart %}
var name = 'Fred';
var salutation = 'Hi';
var greeting = '$salutation, $name';
{% endprettify %}

A dollar sign (`$`) in a string literal followed by a variable will expand to
that variable's value. (If the variable isn't a string, it calls `toString()` on
it.) You can also interpolate expressions by placing them inside curly braces:

{% prettify dart %}
import 'dart:math';
main() {
  var r = 2;
  print('The area of a circle with radius $r is ${PI * r * r}');
}
{% endprettify %}

## Operators

Dart shares the same operators and precedences that you're familiar with from C,
Java, etc. They will do what you expect. Under the hood, though, they are a
little special. In Dart, an expression using an operator like `1 + 2` is really
just syntactic sugar for calling a method. The previous example looks more like
`1.+(2)` to the language.

This means that you can also override (most) operators for your own types. For
example, here's a `Vector` class:

{% prettify dart %}
class Vector {
  num x, y;
  Vector(this.x, this.y);
  operator +(Vector other) => new Vector(x + other.x, y + other.y);
}
{% endprettify %}

With that, we can add vectors using familiar syntax:

{% prettify dart %}
var position = new Vector(3, 4);
var velocity = new Vector(1, 2);
var newPosition = position + velocity;
{% endprettify %}

That being said, please don't go crazy with this. We're giving you the keys to
the car and trusting that you won't turn around and drive it through the living
room.

In practice, if the type you're defining often uses operators in the "real
world" (on a blackboard?) then it might be a good candidate for overridden
operators: things like complex numbers, vectors, matrices, etc. Otherwise,
probably not. Types with custom operators should generally be immutable too.

Note that because operator calls are really just method calls, they have an
inherent asymmetry. The method is always looked up on the left-hand argument. So
when you do `a + b`, it's the type of `a` that gets to decide what that means.

## Equality

Dart has two equality operators,
`==` and `!=`,
which work a little differently from the JavaScript equality operators.
Unlike JavaScript, Dart has no `===` operator.
Instead, it has a top-level function called `identical()`.

Use `==` and `!=` for testing equivalence. They are what you'll need 99% of the
time. Unlike in JavaScript, they don't do any implicit conversions, so they
will behave like you'd expect. Don't be afraid to use them. Unlike _Java_,
they work for any type that has an equivalence relation defined. No more
`someString.equals("something")`.

You can implement `==` for your own types if that makes sense for them. You don't
have to implement `!=`: Dart will automatically infer that from your definition
of `==`. If you do implement `==` be sure to also implement
[hashCode](http://api.dartlang.org/dart_core/Object.html#hashCode).

The `identical()` function is for testing whether two objects are the _exact
same object in memory_. In practice, you will rarely need to use it. The Object
class definition of `==` returns `identical(this, other)`, so the only time
you'll need to call `identical()` is if you overload `==` or specifically want
to sidestep an overloaded `==` operator.

## Numbers

Dart has a `num` class and two subclasses: `int` and `double`. Integers are of
arbitrary size in the VM, and double are 64-bit doubles as defined by IEEE 754
standard.

In typical Dart code, we find that we want two kinds of numbers:

1. Only integers with no floating points. For instance, using ints for list
   indices.
1. Any number, including floating points.

Using `int` handles the first set, and using `num` handles the second set. It's
very rare that we want a number that _must_ have a floating point and
_cannot_ be an integer, which is what double expresses.

Idiomatic Dart numbers are annotated with either `int` or `num`,
rarely `double`.

## Futures

A Future is a promise for a value to be returned, well, in the future.

Methods that work with a Future should always return the Future. This helps
consumers of the method to properly handle errors that might occur. It also
lets consumers know when the operation is complete.

{% prettify dart %}
Future doLengthyComputation() {
  return lengthyComp().then((value) => print(value))
                      .catchError((e) => print(e));
}
{% endprettify %}

Always chain the `catchError()` call off of the call to
`then()`, otherwise you will lose exceptions thrown from within `then()`.

Here is an example of what **not to do**:

{% prettify dart %}
// WARNING: This code contains an anti-pattern.
Future doLengthyComputation() {
  Future future = lengthyComp();
  future.then((value) => print(value));

  // BAD! You'll only get errors from future, not from then().
  // BAD! Your caller never sees any errors that occur.
  future.catchError((e) => print(e));
  return future;
}
{% endprettify %}

If you want to run a function "in the future", it's tempting to use
`Timer.run`. Unless you know what you're doing, **don't.**
Unfortunately, exceptions thrown
from within run's callback are more-or-less uncatchable.

Luckily, Future has a constructor that can help. Use
`Future.delayed` to run a function in a future event loop tick
without losing exceptions that might be thrown.

{% prettify dart %}
Future doLengthyComputation() {
  return new Future.delayed(const Duration(seconds: 0),
      () => doTheThingThatMightFail());
}
{% endprettify %}

## Comments

Dart supports structured comments that can be parsed by tools. However, Dart
eschews ceremonial API docs for more fluid and natural comments.

Compare and contrast Java and Dart comment styles:

<div class="row">
  <div class="col-md-6">
{% prettify java %}
/**
 * Returns an Llama object that can then be petted. 
 * The age argument must specify an non-zero integer. The amount
 * argument is the amount of {@link Money} paid for the llama.
 * <p>
 * This method throws {@link NoMoreLlamasException} is thrown
 * if there are no more llamas to purchase.
 * {@link IllegalArgumentException} is
 * thrown if age is less than zero.
 *
 * @param  age  a non-zero age
 * @param  amount the amount of money paid for the llama
 * @throws NoMoreLlamasException if there are no more llamas available
 * @throws IllegalArgumentException if age is less than zero
 * @return      the llama
 * @see         Farmer
 */
 public Llama buyLlama(Age age, Money amount) {
   // ...
 }
{% endprettify %}
  </div>
  <div class="col-md-6">
{% prettify dart %}
/**
 * Returns a Llama that can be petted.
 * An [ArgumentError] is thrown if age is less than zero, and
 * [NoMoreLlamasError] is thrown if they are all out of llamas.
 */
Llama buyLlama(int age, Money amount) {
  // ...
}
{% endprettify %}
  </div>
</div>

Less is more with Dart doc comments. No need to repeat yourself over and over,
just say what you need to say inline in the comments.
Also, no need to embed HTML tags in your doc comments; Dart's dartdoc tool can
understand a subset of markdown.

{% prettify dart %}
/**
 * ## Examples
 *
 * Getting the _value_:
 *
 *     Future<int> future = getFutureFromSomewhere();
 *     future.then((value) {
 *       print("I received the number $value");
 *     });
 * ...
 */ 
{% endprettify %}

Learn more about [Dart's comment styles](/articles/doc-comment-guidelines/).