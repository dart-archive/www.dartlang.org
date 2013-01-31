---
layout: default
title: "Milestone 1 Language Changes"
rel:
  author: bob-nystrom
description: "A brief introduction to some of the language changes planned
             for the M1 milestone."
has-permalinks: true
article:
  written_on: 2012-07-01
  updated_on: 2012-12-01
  collection: language-details
---

# {{ page.title }}
_Written by Bob Nystrom <br />
July 2012
(updated December 2012)_

Right now as we near our "Milestone 1" release, we are making a slew of fun
language changes. There are tracking bugs in the repo for all of them, but I
wanted to run through them here and try to provide some context and rationale
where I can.

## Contents

1. [First-class types](#first-class-types)
1. [No explicit interfaces](#no-explicit-interfaces)
1. [No "+" on String](#no--on-string)
1. [No throwing `null`](#no-throwing-null)
1. [The "as" cast operator](#the-as-cast-operator)
1. [Cascades](#cascades)
1. [Lazy static initialization](#lazy-static-initialization)
1. [Field initialization with non-const objects](#field-initialization-with-non-const-objects)
1. [Support "const" modifier for variables](#support-const-modifier-for-variables)
1. [Syntax for defining operators](#syntax-for-defining-operators)
1. [Split library scope and import scope](#split-library-scope-and-import-scope)
1. [Revised switch](#revised-switch)
1. [Selective imports](#selective-imports)
1. [Re-export](#re-export)
1. [Static methods are constants](#static-methods-are-constants)
1. [New catch syntax](#new-catch-syntax)
1. [Getter definition syntax](#getter-definition-syntax)
1. [All objects hashable](#all-objects-hashable)
1. [One-line dartdoc comments](#one-line-dartdoc-comments)
1. [Raw strings marked with r](#raw-strings-marked-with-r)
1. [Throw is an expression](#throw-is-an-expression)
1. [Named optional params and positional optional params are specified differently](#named-optional-params-and-positional-optional-params-are-specified-differently)
1. [Test optional argument with "?"](#test-optional-argument)
1. [Constructor names are now unique names in a class](#constructor-names-unique)
1. [Simpler equality](#simpler-equality)
1. [Metadata](#metadata)
1. [Import and library syntax changes](#import-and-library-syntax-changes)
1. [Strings are UTF-16](#strings-are-utf-16)
1. [Conclusion](#conclusion)
{:.toc}

{::comment}
1. [Callable objects](#callable-objects)
{:/comment}

## First-class types

As we get ready for mirrors to come online with Dart, one minor step along the
way is adding support for first-class types. With this change, you can refer to
a class by name in an expression:

{% prettify dart %}
class SomeType {}

main() {
  print(SomeType); // <- Refer to the class.
}
{% endprettify %}

When you refer to a class by name, you're given a reference to an instance of
type `Type`. Until mirrors are here, you won't be able to do much with it, but
you can get its name, and compare instances with each other for equality.

In addition, you can get the type of an object by accessing its `runtimeType`
property:

{% prettify dart %}
print('a string'.runtimeType == String); // true
{% endprettify %}

## No explicit interfaces

One of the two biggest changes to Dart is a simplification: we are getting rid
of an explicit interface syntax. Dart has always had *implicit* interfaces:
every time you define a class, you also implicitly define an interface that
describes the public signatures of the methods that class exposes. For example:

{% prettify dart %}
class Person {
  final _name;
  Person(this._name);
  void greet(who) => 'Hello $who, I am $_name.';
}
{% endprettify %}

Here we have a concrete Person class. It has a method and some state. We’ll use
it in a function:

{% prettify dart %}
greetBob(Person person) => person.greet('bob');
{% endprettify %}

Now let’s say we want to make a new class, Imposter, that we can also pass to
`greetBob()`. But we don’t want to actually inherit from Person: we don’t want
its state or its methods. Implicit interfaces let us do that:

{% prettify dart %}
class Imposter implements Person {
  void greet(who) => 'Hello $who, it is a pleasure to meet you.';
}
{% endprettify %}

Note that it says *implements*, not *extends*. We are not subclassing Person, we
are just saying that Imposter supports all of the public methods Person defines
and that we can pass it to anything that expects a Person.

Dart also supports abstract methods in classes. Given abstract methods and
implicit interfaces, there’s no actual need for an explicit interface construct:
just make a class where all of its methods are abstract, and then implement its
implicit interface.

Getting rid of interfaces simplifies the language while also removing some of
the limitations that interfaces had: unlike classes, they couldn’t define static
members for example. It also simplifies designing an API: you no longer have
think about whether you should define something as an interface or an abstract
class.

## No "+" on String

Dart no longer allows using the "+" operator on
strings. So no more:

{% prettify dart %}
print("Hi, " + yourName);
{% endprettify %}

There seem to be as many reasons for (and against) this change as there are Dart
team members, but the two motivators I see repeatedly are:

1. It’s a source of bugs and surprising behavior because it’s not symmetric and
is sensitive to operator precedence. `print("1 + 2 = " + 1 + 2)` doesn’t do what
some people might expect and `"a" + 1` and `1 + "a"` have unpleasantly different
behavior.

2. Naïve code that uses it heavily can have poor performance with simple
internal string implementations. If you do something like use `+=` in a loop to
build up a long string, and you’re running on an implementation that doesn’t
have sophisticated code for handling strings you can end up doing a lot of
wasted allocations.

So, without `+`, what should you do when you need to staple a couple of strings
to each other? Fortunately, [Seth has your back
here](http://news.dartlang.org/2012/06/vm-to-remove-support-for-string.html).

([Tracking issue #3707](http://dartbug.com/3707))

## No throwing `null`

Dart now considers it a dynamic error to throw `null`. In almost every case
where `null` is thrown, it’s a programmer error: they meant to throw some
exception object but accidentally got a `null` instead. By disallowing this, we
can detect that error earlier and help the user fix their code.

*Allowing `null` to be thrown, on the other hand, forces programmers to think
*about what kinds of `catch` clauses will match it. Will a `catch` clause of any
*type select `null`? None of them? Just `var ex`? There isn’t an obvious
*intuitive correct behavior here, so users are likely to be confused.

([Tracking issue #2940](http://dartbug.com/2940))

## The "as" cast operator

Dart now has an infix operator `as` that lets you cast an expression to a given
type without having to declare a type annotated local variable. Where before, if
you wanted to indicate some extra knowledge about the types of objects in your
code, you had to do:

{% prettify dart %}
ButtonElement button = query('button');
button.value = 1234;
{% endprettify %}

Now you can do:

{% prettify dart %}
(query('button') as ButtonElement).value = 1234;
{% endprettify %}

At runtime, an `as` expression validates that the expression is of the expected
type (much like `is`) and then returns the same value. But in static contexts
like the editor, this lets a programmer state their type expectations in the
middle of an expression.

Like most of Dart’s type system, this is as much for documentation purposes as
it is anything else: a well-placed `as` expression makes it clear to other
readers of your code that you know something more precise about the type of an
expression than would otherwise be obvious from looking at the code.

([Tracking issue #3399](http://dartbug.com/3399))

## Cascades

Many times, you find yourself calling a series of methods on the same object. If
that object happens to be the result of some complex expression, that can lead
to either a lot of redundancy:

{% prettify dart %}
query('#my-form').query('button').classes.add('toggle');
query('#my-form').query('button').text = 'Click Me!';
query('#my-form').query('button').labels.add(toggleLabel);
{% endprettify %}

or the tedium of having to define a local variable:

{% prettify dart %}
var toggleButton = query('#my-form').query('button');
toggleButton.classes.add('toggle');
toggleButton.text = 'Click Me!';
toggleButton.labels.add(toggleLabel);
{% endprettify %}

Some APIs, like jQuery in JavaScript or StringBuffer in Java get around this by
using "fluent interfaces": their methods return `this` so you can chain calls
directly. But that forces API designers to choose between returning a useful
value or allowing chaining: they can’t support both. It also forces all APIs to
be designed up front to support this technique.

To remedy that, Smalltalk pioneered something called "message cascades", which
Dart has adopted. These let you sequence a series of method calls that all apply
to the same receiver, like so:

{% prettify dart %}
query('#my-form').query('button')
    ..classes.add('toggle')
    ..text = 'Click Me!'
    ..labels.add(toggleLabel);
{% endprettify %}

Here, everything after `..` is called on the result of the expression before the
first `..`. What’s nice is that cascades work with every API, not just ones
explicitly implemented using a fluent pattern.

([Tracking issue #2501](http://dartbug.com/2501))

## Lazy static initialization

Formerly, Dart required that all `static final` fields (or `final` top-level
variables) be initialized with constant expressions. In other words, they could
only be used to define compile-time constants. That significantly limits their
use, preventing, for example, this field:

{% prettify dart %}
class Stopwatch {
  static final startTime = new DateTime.now();
}
{% endprettify %}

We’ve decided to loosen that so that `static final` fields and `final` top-level
variables can be initialized using *any* expression. These will then be lazily
initialized the first time the variable is accessed. This is closer to behavior
users coming from Java or C# expect given Dart’s similar syntax.

([Tracking issue #3557](http://dartbug.com/3557))

## Field initialization with non-const objects

Formerly, Dart required that all fields initialized at their
declaration had to be compile-time constants. In M1, fields can now be
initialized by non-const values.

For example:

{% prettify dart %}
class DeckOfCards {
  List<Card> cards = <Card>[];
}
{% endprettify %}

The field `cards` is initialized when the object is created. Specifically,
the field is initialized before the constructor and its initializer list are
run.

Note that you may not refer to `this` in field initializers.

## Support "const" modifier for variables

The above change is more flexible, but it leaves an open issue: how do you
define a `static final` field or `final` top-level variable that *is* constant,
and that can be used in constant expressions? With this looser behavior, you
lose the ability to do:

{% prettify dart %}
class SomeClass {
  static final someConstant = 123;
  static final aConstList = const [someConstant];
}
{% endprettify %}

Since `someConstant` doesn’t *have* to be constant now, it may not be, which
means it can’t be used in a constant expression like `const [someConstant]`. To
fix that, Dart will also allow `const` as a modifier for variables. This way you
can indicate which top-level `final` variables and `static final` fields are
constant and which are lazily-initialized non-constant:

{% prettify dart %}
class SomeClass {
  static const someConstant = 123; // OK
  static final startTime = new DateTime.now(); // OK too
  static const aConstList = const [someConstant]; // also OK
}
{% endprettify %}

([Tracking issue #3549](http://dartbug.com/3549))

## Syntax for defining operators

This is a pretty minor change. The previous spec used `equals` and `negate` as
special identifiers for defining equality and unary negation operators,
respectively. That raises some confusing questions like "Can you also call those
methods by name?" To simplify that, we will just use `==` and `-` to define
those operators. We’ll disambiguate unary and binary minus by their arity
(number of parameters).

{% prettify dart %}
class MagicNumber {
  bool operator ==(other) => ...
  MagicNumber operator -() => ... // unary negate
  MagicNumber operator -(other) => ... // infix minus
}
{% endprettify %}

([Tracking issue #3765](http://dartbug.com/3765))

## Split library scope and import scope

Stephen [explains the rationale for this
change](http://code.google.com/p/dart/issues/detail?id=1285) better than I can:

> There is a problem that a name may be defined by `import` or by a definition
> in the current library. A change to the imported library can break a program
> by introducing a clashing name.

What he means here is consider you have this program:

{% prettify dart %}
import 'somelib.dart';

foo() => print('foo!');
main() => foo();
{% endprettify %}

Later, you upgrade to the latest greatest version of "somelib" and discover to
your dismay that they’ve added a `foo()` function to it. Currently, this breaks
your code since those names are in the same namespace and collide. Stephen’s
proposal is:

> I suggest that imports happen into a scope surrounding the current library.
> This would reduce a clash in an imported library to an override warning and at
> the same time ensure the current library's behaviour did not change.

In other words, with this change, your local `foo()` will *shadow* the new one
in "somelib" instead of colliding, and your code does the right thing.

In addition, we’ve removed another annoying restriction. Previously, if you
imported the same name from two different libraries
(say, Node from dart:html and dartdoc)
then you would get a name collision error *even if you didn’t use that
name anywhere in your code.* Now, Dart will only worry about name collisions for
names that you actually use. You get an error only if there is an ambiguous
*use* of a name in your code.

([Tracking issue #1285](http://dartbug.com/1285))

## Revised switch

In its original incarnation, Dart’s `switch` statement worked like JavaScript’s
and not Java’s. It was essentially syntactic sugar for a series of chained `if-
else` statments. For example, this:

{% prettify dart %}
switch (zzTop) {
case billy:
case dusty:
  hasBeard = true;
  break;
default:
  hasBeard = false;
}
{% endprettify %}

was exactly semantically equivalent to:

{% prettify dart %}
if ((zzTop == billy) || (zzTop == dusty)) {
  hasBeard = true;
} else {
  hasBeard = false;
}
{% endprettify %}

Note that in the desugared `if-else` form, it ends up calling the equality
(`==`) operator. This operator can be overloaded for your own types, so this has
an important consequence. With these semantics, a `switch` statement *must* be
handled exactly like a series of chained `if-else` statements.

This has unpleasant optimization implications. In languages like C and Java, a
`switch` statement can only be used with numeric values. Compilers can and do
compile down a `switch` statement to either a jump table that directly selects a
case based on the value, or to a binary search of the cases, or some mixed
heuristic of the two. In other words, in those languages selecting the right
`case` for a `switch` can have `O(1)` or `O(log n)` performance (where `n` is
the number of cases). In Dart, it’s always `O(n)`.

So we’ve decided to restrict `switch` in Dart. Instead of calling a user-defined
equality operator, we only allow you to switch on numbers, strings, and constant
objects. This gives compilers enough flexibility to compile them more
efficiently. Since constant objects are canonicalized, they can be reliably
compared purely based on *identity*, so they don’t have the problem of allowing
user-defined equality operators. This lets you still switch on user-defined
"enum-like" objects.

## Selective imports

Library imports were a blunt instrument in Dart: you either imported every
single name from a library or none of them. If a single name in that library
collides with another one you’re importing, your only recourse is to import that
entire library with a prefix.

Now, you’ll be given finer grained control. If you do:

{% prettify dart %}
import 'somelib.dart' show foo, bar;
{% endprettify %}

Then you will *only* import the names "foo" and "bar" from "somelib". This is
good if you are only using a small part of a library and want to make that
clear. Conversely:

{% prettify dart %}
import 'somelib.dart' hide foo, bar;
{% endprettify %}

Here, you import every name except "foo" and "bar". This is good for excluding
the one name that happens to cause a collision.

([Tracking issue #817](http://dartbug.com/817))

## Re-export

Let’s say you’re doing some refactoring and you decide to move a class from one
library to another. But, you don’t want to break all of the code that assumes
that class is still in the old library. Ideally, you’d like code that imports
*either* of those to be able to get to your class: you want it to appear to be
in both places.

Or, let’s say you have a giant library with hundreds of names in it (we’ll call
it "dart:html"). You want to split that up into a few smaller libraries. But
you’d also like users that want the whole kit and caboodle to just be able to
import "dart:html" and get everything.

To fix this, Dart has "re-exports". When you import a library, you can choose to
also re-export the names you import from it. That will make it appear to code
using *your* library that those names are coming directly from it. This lets you
decouple the library where users get something from the library where it’s
physically defined. For example:

{% prettify dart %}
// bar.dart
someMethod() => print('hi!');
anotherMethod() => print('hello!');

// foo.dart
import 'bar.dart';
export 'bar.dart';
{% endprettify %}

Thanks to the `export 'bar.dart'` part here, any code that imports "foo.dart"
will be able to access `someMethod()` and `anotherMethod()` as if they had been
defined directly in "foo.dart".

You can use this in combination with `show` and `hide`
to only re-export a subset of the names that an imported library
defines. If we add an export in "foo.dart":

{% prettify dart %}
import 'bar.dart';
export 'bar.dart' show someMethod;
{% endprettify %}

Then only `someMethod` will be re-exported.

([Tracking issue #760](http://dartbug.com/760))

## Static methods are constants

Right now, you can’t use a reference to a function (i.e. a closure) in a
constant expression. This makes sense for some closures because they truly
aren’t constant: they may close over non-constant state.

Top level functions and static methods don’t have that problem. So, moving
forward, Dart lets you treat references to those as constants and lets you use
them in constant expressions.

{% prettify dart %}
display(arg) => print(arg);

class Logger {
  // Use display in a const expression:
  static const defaultLogger = const Logger(display);

  final logCallback;
  const Logger(this.logCallback(arg));
}
{% endprettify %}

([Tracking issue #1652](http://dartbug.com/1652))

## New catch syntax

One strange consequence of marrying Dart’s optional type semantics with a Java-
like syntax is that you end up with a syntax for `catch` clauses that *looks*
like a type annotation, but is very much not like a type annotation in Dart:
Dart type annotations have no runtime effects, but the type in a `catch` clause
is used at runtime to test against the thrown exception.

This causes some confusion and some nasty syntactic corner cases. For example,
if you just have `catch(foo)` does that mean "catch an exception of any type and
bind it to `foo`" (which lines up with other parameters in Dart where the type
annotation is optional), or does it mean "catch an exception of type `foo` and
don’t bind it to a variable" (which is what it would mean in Java)?

To avoid that, we decided that that syntax is invalid and you *must* do either
`catch(var foo)` or `catch(foo someVar)` to be clear about your intent. But
that’s definitely *not* the syntax for a parameter in Dart, so now users trip
over *that.*

Our fix is to not try to follow Java-style syntax for this at all. Instead,
Dart does:

{% prettify dart %}
try {
  ...
} on SomeException catch(ex) { ... }
{% endprettify %}

The `on SomeException` part defines the type of exception you want to catch.
It can be omitted to catch all exceptions. The `catch(ex)` part defines the
variable you want to bind it to. It can be omitted if you don’t care to bind
the exception to a variable.

([Tracking issue #2948](http://dartbug.com/2948))

## Getter definition syntax

We’ve slightly changed the syntax for defining getters. For getters, they no
longer have an empty parameter list after the name (i.e. `()`):

{% prettify dart %}
int get theAnswer => 42;
{% endprettify %}

This makes the syntax for defining them closer to how they are invoked.
(You can of course have a curly block body too in addition to the simple
lambda body shown above.)

([Tracking issue #3602](http://dartbug.com/3602))

## All objects hashable

The Object class now implements Hashable.
This means that every object now responds to the `hashCode()`
method by default. This change lets you use any object as a
key in a map. (Note, map literals still only use strings as keys.)

Now you can do this:

{% prettify dart %}
class Person {
  String firstName, lastName;
  Person(this.firstName, this.lastName);
}

class Puppy {
  final bool cuddly = true;
}

main() {
  var spot = new Puppy();
  var alice = new Person("Alice", "Smith");
  var petOwners = new Map();
  petOwners[alice] = spot;
}
{% endprettify %}

([Tracking issue #3369](http://dartbug.com/3369))

## One-line dartdoc comments

Sometimes you'd like to write a small dartdoc comment. Previously, even a one-
line statement required three comment lines:

{% prettify dart %}
/**
 * Don't forget to feed the [Llama].
 */
feed() {
  // ...
}
{% endprettify %}

Three comment lines for a single statement? We can do better.

Now, there's even less excuse to not comment your code, thanks to the
introduction of the line-style dartdoc comment. It's for those times when a single
comment line captures everything you need to say.

{% prettify dart %}
/// Don't forget to feed the [Llama].
feed() {
  // ...
}
{% endprettify %}

The `///` style of comments works just fine with multi-line comments, if you
prefer this style over `/** ... */`. For example:

{% prettify dart %}
/// Returns a random number between 0.0 and 1.0.
///
/// The seed for the random number is...
num generateRandom();
{% endprettify %}

## Raw strings marked with `r`

With
[metadata](http://news.dartlang.org/2012/06/proposal-to-add-metadata-to-dart.html)
coming to Dart (not part of M1, though), and claiming the use of `@`,
we need a new way to mark a raw string.

Before M1, a raw string looked like:

{% prettify dart %}
// Pre M1.
var raw = @'This is a\nraw string';
{% endprettify %}

However, the metadata proposal wants to use this:

{% prettify dart %}
@42
class MeaningOfLife {
  
}
{% endprettify %}

We decided to use `@` for metadata, as it's more familiar
to developers, and use `r` to mark a raw string.

Once implemented, a raw string will look like:

{% prettify dart %}
var raw = r'steak\ntartare';
{% endprettify %}

([Tracking issue #931](http://dartbug.com/931))

## Throw is an expression

Previously, `throw` was a statement, and thus couldn't be used in a few useful
places. In M1, `throw` has been converted to an expression. 

For example, now in M1, you can throw exceptions from one-line functions.

{% prettify dart %}
String get prettyVersion => throw const NotImplementedException();
{% endprettify %}

([Tracking issue #587](http://dartbug.com/587))

## Named optional params and positional optional params are specified differently

In pre-M1 Dart there was one syntax for defining named parameters and optional
parameters. This prevented you from expressing one without the other.

In pre-M1 Dart:

{% prettify dart %}
enableFlags([bool bold, bool hidden]) {
  // ...
}

// Can pass arguments by name.
enableFlags(bold: true, hidden: false);

// But they are also optional and positional, too.
enableFlags();
enableFlags(false);
{% endprettify %}

As an API designer, I want to express that `bold` and `hidden` are named
parameters, and make the name part of the exposed API.

In M1, named parameters and optional parameters are given different syntax.
A method or function can make its optional parameters named or positional,
but not both.

To express named optional parameters, use the new `{ }` syntax. Note that
a default value is set with `:`.

{% prettify dart %}
enableFlags({bool bold, bool hidden: true}) {
  // ...
}

enableFlags(bold: true, hidden: false);
enableFlags(hidden: true);
{% endprettify %}

In the above example, `bold` defaults to `null` and
`hidden` defaults to true.

To express optional *positional* parameters, use the `[ ]` syntax:

{% prettify dart %}
connectToServer(String authKey, [ip = '127.0.0.1', port = 8080]) {
  // ...
}

// The following are all valid.
connectToServer('secret');
connectToServer('secret', '1.2.3.4');
connectToServer('secret', '1.2.3.4', 9999);
{% endprettify %}

To sum up, named and optional parameters were separated from each other in M1.
You can use either optional named parameters or optional positional parameters,
but not both, in a method or function.

## Test optional argument with "?"
{: #test-optional-argument}

Optional arguments are great, but before M1 it was hard to tell if the caller
explicitly passed `null` or simply omitted the parameter.

To illustrate, let's use an example:

{% prettify dart %}
authenticate(String username, [SignedKey key]) {
  if (key == null) {
    // Did the caller omit the parameter, or did they pass null?
  }
}
{% endprettify %}

In M1, you can use the ? operator to test whether an argument was explicitly
provided.

{% prettify dart %}
authenticate(String username, [SignedKey key]) {
  if (?key) {
    // The key was provided.
  } else {
    // The key was not provided.
  }
}
{% endprettify %}

You might be wondering why, with the existence of default values for optional
parameters, this new syntax is required. For example, why not provide
a default value for `key`?

The answer lies in the semantic difference of "passing null as a parameter" and
omitting the parameter. Sometimes an API treats those two conditions
differently, often when `null` is a valid value. For example, in the dart:html
library, we try to fake overloading using optional parameters in some places and
this makes that easier.

Also, only compile-time constants can be used as default values. Sometimes,
an object can't be a compile-time constant, and therefore can't be set as a
default parameter value.

([Tracking bug #4288](http://dartbug.com/4288))

## Constructor names are now unique names in a class
{: #constructor-names-unique}

Before M1, you could have a constructor and a method with the same name inside
a class. For example:

{% prettify dart %}
// Before M1, this worked.

class Ball {
  // Constructor with the name 'move'.
  Ball.move(num x, num y) {
    // ...
  }

  // Method with the name 'move'.
  move(num x, num y) {
    // ...
  }
}
{% endprettify %}

In M1, we don't allow constructor names to collide with method names in a class.
The fix is to rename either the method or the named constructor.

{% prettify dart %}
// Now in M1...

class Ball {
  Ball.at(num x, num y) {
    // ...
  }

  move(num x, num y) {
    // ...
  }
}
{% endprettify %}

## Simpler equality

In M1, equality got a makeover. The biggest change is `===` is now replaced
by the top-level function `identical(a, b)`. Also, to define your own equality
semantics in your class, implement the `==` operator instead of `equals`.
The semantics of `==` also changed.

To determine if two variables point to the same _instance_,
use `identical(a, b)`. The old `===` no longer exists.

For example:

{% prettify dart %}
class Person {
  String firstName, lastName;
  Person(this.firstName, this.lastName);
}

main() {
  var bob = new Person("Bob", "Smith");
  var robert = bob;
  var roberto = new Person("Bob", "Smith");

  print(identical(bob, robert));              // true
  print(identical(bob, roberto));             // false
}
{% endprettify %}

To define your own equality semantics for a class, implement the `==` operator.

Here's an example:

{% prettify dart %}
class Person {
  String firstName, lastName;
  Person(this.firstName, this.lastName);
  
  bool operator ==(Person other) {
    return (other.firstName == firstName && other.lastName == lastName);
  }
}

main() {
  var bob = new Person("Bob", "Smith");
  var robert = bob;
  var roberto = new Person("Bob", "Smith");

  print(identical(bob, robert));              // true
  print(identical(bob, roberto));             // false
  
  print(bob == robert);                       // true
  print(bob == roberto);                      // true
}
{% endprettify %}

Astute readers might wonder why the implementation of `operator ==` doesn't
first check for null. Luckily, the new semantics of `==` take care of the null
check.

For `a == b`, the following happens:

1. If either a or b is null, return identical(a, b)
1. Otherwise, return a.==(b)

## Metadata

You can now add metadata to classes, libraries, fields, parameters, and more.
For example, you can mark a function as _deprecated_ with a metadata annotation.
An editor (such as Dart Editor) can recognize the method as deprecated and
provide visual clues.

A metadata annotation begins with `@` followed by a reference to a compile-time
constant variable, or a call to a constant constructor. In other words,
there is no specific metadata type and developers can easily define
their own metadata annotations. The Dart project provides the meta package,
which contains `override` and `deprecated`.

Here is a usage example of a metadata annotation. Specifically,
`superOldMethod` is marked with `@deprecated`.

{% prettify dart %}
import 'package:meta/meta.dart';

@deprecated
superOldMethod() {
  print("don't call me, I'm old!");
}

main() {
  superOldMethod();
}
{% endprettify %}

Dart Editor applies a visual style to deprecated methods:

<img src="imgs/deprecated-metadata.png"
     alt="Dart Editor applies a visual style when @deprecated is used">

## Import and library syntax changes

We received a lot of feedback regarding the syntax and behavior of libraries
and imports. Significant changes were made in M1 on both fronts.

The change that affects the most code is that
imports and library directives are now more succinct and look less like
C. Instead of:

{% prettify dart %}
#library('trading_cards');  // OLD SYNTAX; no longer works.
#import('dart:html');       // OLD SYNTAX; no longer works.
{% endprettify %}

You now use library and import like this:

{% prettify dart %}
library trading_cards;
import 'dart:html';
{% endprettify %}

Notice how, in the above code, the `#` and parentheses are gone. Also, the
library name is now an identifier (not a string literal).

The syntax for importing a library with a namespace has also changed. Here
is an example of the new format:

{% prettify dart %}
import 'dart:svg' as svg;
{% endprettify %}

### Control the names imported by a library

New with M1 is the ability to selectively _show_ or _hide_ names when
a library is imported. This is useful, for example, when collisions would
otherwise occur.

For example, consider the case of an app importing two libraries that implement
a function with the same name.

{% prettify dart %}
library computer;

run(Program program) {
  // ...
}
{% endprettify %}

{% prettify dart %}
library exercise;

run(Marathon marathon) {
  // ...
}
{% endprettify %}

Here is the main app that uses both libraries. This app does not compile
because `run` is defined in both computer and exercise.

{% prettify dart %}
library app;

import 'computer.dart';
import 'exercise.dart';

main() {
  run(thing);  // compile-time error, run is defined in two libraries!
}
{% endprettify %}

Luckily, you can now import libraries and control the names that are added to
your namespace. Use `show` to pull in *only* the names specified, or `hide` to
pull in names *except* those specified.

For example, you can hide the `run` identifier from the app and no
collision will occur.

{% prettify dart %}
import 'computer.dart' hide run;
import 'exercise.dart';
{% endprettify %}

### Re-export

Also new with M1 is the ability for a library to expose
names from imported libraries as its own. This functionality is handy for
library authors to create a single developer-facing library while still
using sub-libraries for better code organization and privacy.

To illustrate, consider a typical UI framework. It's not uncommon to split
up the framework into separate libraries, such as models, views, and
controllers. However, it would be a burden on the consumer of this framework to
have to manually import each sub-library (models, views, and controllers).

With M1 and re-export, the framework author can create a single holistic library
called ui_framework, import all implementation libraries, and re-export their
names. Framework authors get the benefit of splitting code into individual
libraries, while consumers of the framework need only import a single library.

Here is an example:

{% prettify dart %}
library ui_framework;
import 'models.dart';
import 'views.dart';
import 'controllers.dart';

export 'models.dart';
export 'views.dart';
export 'controllers.dart';
{% endprettify %}

{% prettify dart %}
library my_app;
import 'ui_framework.dart';

main() {
  var model = new Model();
  var view = new View();
  var controller = new Controller();
}
{% endprettify %}




### Parts

Libraries can still be split into multiple files (what used to be `#source`).
However, the relationship between a library and its parts is now more
declarative.

Instead of:

{% prettify dart %}
#library('trading_cards');   // OLD SYNTAX; no longer works.
#source('game_rules.dart');  // OLD SYNTAX; no longer works.
{% endprettify %}

You now declare _parts_ of a library like:

{% prettify dart %}
library trading_cards;
part 'game_rules.dart';
{% endprettify %}

And the part must declare that it is a _part of_ a library. Over in
game_rules.dart:

{% prettify dart %}
// Inside game_rules.dart

part of trading_cards;
{% endprettify %}



{::comment}

## Callable objects

Coming soon.

{:/comment}

## Strings are UTF-16

Before M1, a string was a sequence of Unicode character codes.
Now, a string is a sequence of valid UTF-16 code units.
This is mostly an internal change to improve performance,
but you might care about it
if your code compares or stores strings.


## Conclusion

There are a few other minor changes and clean-ups, but that's the big noticeable
stuff. As always, your feedback, questions and comments are welcome on the
[mailing list](http://dartlang.org/mailing-list) and our [issue
tracker](http://dartbug.com).
