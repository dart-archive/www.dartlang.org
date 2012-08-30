---
layout: default
title: "Milestone 1 Language Changes"
rel:
  author: bob-nystrom
description: "A brief introduction to some of the language changes planned
             for the M1 milestone."
has-permalinks: true
---

# {{ page.title }}
_Written by Bob Nystrom <br />
July 2012_

Right now as we near our "Milestone 1" release, we are making a slew of fun
language changes. There are tracking bugs in the repo for all of them, but I
wanted to run through them here and try to provide some context and rationale
where I can.

## Contents

1. [First class types](#first-class-types)
1. [No explicit interfaces](#no-explicit-interfaces)
1. [No "+" on String](#no--on-string)
1. [No throwing `null`](#no-throwing-null)
1. [The "as" cast operator](#the-as-cast-operator)
1. [Cascades](#cascades)
1. [Lazy static initialization](#lazy-static-initialization)
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
1. [Conclusion](#conclusion)
{:.toc}

## First class types

As we get ready for mirrors to come online with Dart, one minor step along the
way is adding support for first-class types. With this change, you can refer to
a class by name in an expression:

{% highlight dart %}
class SomeType {}

main() {
  print(SomeType); // <- Refer to the class.
}
{% endhighlight %}

When you refer to a class by name, you're given a reference to an instance of
type `Type`. Until mirrors are here, you won't be able to do much with it, but
you can get its name, and compare instances with each other for equality.

In addition, you can get the type of an object by accessing its `type` property:

{% highlight dart %}
print('a string'.type == String); // true
{% endhighlight %}

## No explicit interfaces

One of the two biggest changes to Dart is a simplification: we are getting rid
of an explicit interface syntax. Dart has always had *implicit* interfaces:
every time you define a class, you also implicitly define an interface that
describes the public signatures of the methods that class exposes. For example:

{% highlight dart %}
class Person {
  final _name;
  Person(this._name);
  void greet(who) => 'Hello $who, I am $_name.';
}
{% endhighlight %}

Here we have a concrete Person class. It has a method and some state. We’ll use
it in a function:

{% highlight dart %}
greetBob(Person person) => person.greet('bob');
{% endhighlight %}

Now let’s say we want to make a new class, Imposter, that we can also pass to
`greetBob()`. But we don’t want to actually inherit from Person: we don’t want
its state or its methods. Implicit interfaces let us do that:

{% highlight dart %}
class Imposter implements Person {
  void greet(who) => 'Hello $who, it is a pleasure to meet you.';
}
{% endhighlight %}

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

A deeply contentious issue, Dart no longer allows using the "+" operator on
strings. So no more:

{% highlight dart %}
print("Hi, " + yourName);
{% endhighlight %}

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

{% highlight dart %}
ButtonElement button = query('button');
button.value = 1234;
{% endhighlight %}

Now you can do:

{% highlight dart %}
(query('button') as ButtonElement).value = 1234;
{% endhighlight %}

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

{% highlight dart %}
query('#my-form').query('button').classes.add('toggle');
query('#my-form').query('button').text = 'Click Me!';
query('#my-form').query('button').labels.add(toggleLabel);
{% endhighlight %}

or the tedium of having to define a local variable:

{% highlight dart %}
var toggleButton = query('#my-form').query('button');
toggleButton.classes.add('toggle');
toggleButton.text = 'Click Me!';
toggleButton.labels.add(toggleLabel);
{% endhighlight %}

Some APIs, like jQuery in JavaScript or StringBuffer in Java get around this by
using "fluent interfaces": their methods return this so you can chain calls
directly. But that forces API designers to choose between returning a useful
value or allowing chaining: they can’t support both. It also forces all APIs to
be designed up front to support this.

To remedy that, Smalltalk pioneered something called "message cascades" which
Dart has adopted. These let you sequence a series of method calls that all apply
to the same receiver, like so:

{% highlight dart %}
query('#my-form').query('button')
    ..classes.add('toggle')
    ..text = 'Click Me!'
    ..labels.add(toggleLabel);
{% endhighlight %}

Here, everything after `..` is called on the result of the expression before the
first `..`. What’s nice is that this works with every API, not just ones
explicitly implemented using a fluent pattern.

([Tracking issue #2501](http://dartbug.com/2501))

## Lazy static initialization

Formerly, Dart required that all `static final` fields (or `final` top-level
variables) be initialized with constant expressions. In other words, they could
only be used to define compile-time constants. That significantly limits their
use, preventing, for example, this field:

{% highlight dart %}
class Stopwatch {
  static final startTime = new DateTime.now();
}
{% endhighlight %}

We’ve decided to loosen that so that `static final` fields and `final` top-level
variables can be initialized using *any* expression. These will then be lazy
initialized the first time the variable is accessed. This is closer to behavior
users coming from Java or C# expect given Dart’s similar syntax.

([Tracking issue #3557](http://dartbug.com/3557))

## Support "const" modifier for variables

The above change is more flexible, but it leaves an open issue: how do you
define a `static final` field or `final` top-level variable that *is* constant,
and that can be used in constant expressions? With this looser behavior, you
lose the ability to do:

{% highlight dart %}
class SomeClass {
  static final someConstant = 123;
  static final aConstList = const [someConstant];
}
{% endhighlight %}

Since `someConstant` doesn’t *have* to be constant now, it may not be, which
means it can’t be used in a constant expression like `const [someConstant]`. To
fix that, Dart will also allow `const` as a modifier for variables. This way you
can indicate which top-level `final` variables and `static final` fields are
constant and which are lazy-initialized non-constant:

{% highlight dart %}
class SomeClass {
  static const someConstant = 123; // OK
  static final startTime = new DateTime.now(); // OK too
  static const aConstList = const [someConstant]; // also OK
}
{% endhighlight %}

([Tracking issue #3549](http://dartbug.com/3549))

## Syntax for defining operators

This is a pretty minor change. The previous spec used `equals` and `negate` as
special identifiers for defining equality and unary negation operators,
respectively. That raises some confusing questions like "Can you also call those
methods by name?" To simplify that, we will just use `==` and `-` to define
those operators. We’ll disambiguate unary and binary minus by their arity
(number of parameters).

{% highlight dart %}
class MagicNumber {
  bool operator ==(other) => …
  MagicNumber operator -() => … // unary negate
  MagicNumber operator -(other) => … // infix minus
}
{% endhighlight %}

([Tracking issue #3765](http://dartbug.com/3765))

## Split library scope and import scope

Stephen [explains the rationale for this
change](http://code.google.com/p/dart/issues/detail?id=1285) better than I can:

> There is a problem that a name may be defined by `#import` or by a definition
> in the current library. A change to the imported library can break a program
> by introducing a clashing name.

What he means here is consider you have this program:

{% highlight dart %}
#import('somelib.dart');

foo() => print('foo!');
main() => foo();
{% endhighlight %}

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
imported the same name from two different libraries (say Node from dart:html and
dartdoc) then you would get a name collision error *even if you didn’t use that
name anywhere in your code.* Now, Dart will only worry about name collisions for
names that you actually use. You only get an error if there is an ambiguous
*use* of a name in your code.

([Tracking issue #1285](http://dartbug.com/1285))

## Revised switch

In its original incarnation, Dart’s `switch` statement worked like JavaScript’s
and not Java’s. It was essentially syntactic sugar for a series of chained `if-
else` statments. For example, this:

{% highlight dart %}
switch (zzTop) {
case billy:
case dusty:
  hasBeard = true;
  break;
default:
  hasBeard = false;
}
{% endhighlight %}

was exactly semantically equivalent to:

{% highlight dart %}
if ((zzTop == billy) || (zzTop == dusty)) {
  hasBeard = true;
} else {
  hasBeard = false;
}
{% endhighlight %}

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

{% highlight dart %}
#import('somelib.dart', show: ['foo', 'bar']);
{% endhighlight %}

Then you will *only* import the names "foo" and "bar" from "somelib". This is
good if you are only using a small part of a library and want to make that
clear. Conversely:

{% highlight dart %}
#import('somelib.dart', hide: ['foo', 'bar']);
{% endhighlight %}

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

{% highlight dart %}
// bar.dart
someMethod() => print('hi!');
anotherMethod() => print('hello!');

// foo.dart
#import('bar.dart', export: true);
{% endhighlight %}

Thanks to the `export: true` part here, any code that imports "foo.dart" will be
able to access `someMethod()` and `anotherMethod()` as if they had been defined
directly in "foo.dart". You can use this in combination with selective imports
to only re-export a subset of the names that an imported library defines. If we
change the import in "foo.dart" to:

{% highlight dart %}
#import('bar.dart', show: ['someMethod'], export: true);
{% endhighlight %}

Then only `someMethod` will be re-exported.

([Tracking issue #760](http://dartbug.com/760))

## Static methods are constants

Right now, you can’t use a reference to a function (i.e. a closure) in a
constant expression. This makes sense for some closures because they truly
aren’t constant: they may close over non-constant state.

Top level functions and static methods don’t have that problem. So, moving
forward, Dart lets you treats references to those as constants and lets you use
them in constant expressions.

{% highlight dart %}
display(arg) => print(arg);

class Logger {
  // Use display in a const expression:
  static const defaultLogger = const Logger(display);

  final logCallback;
  const Logger(this.logCallback(arg));
}
{% endhighlight %}

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

{% highlight dart %}
try {
  ...
} on SomeException catch(ex) { ... }
{% endhighlight %}

The `on SomeException` part defines the type of exception you want to catch.
It can be omitted to catch all exceptions. The `catch(ex)` part defines the
variable you want to bind it to. It can be omitted if you don’t care to bind
the exception to a variable.

([Tracking issue #2948](http://dartbug.com/2948))

## Getter definition syntax

We’ve slightly changed the syntax for defining getters. For getters, they no
longer have an empty parameter list after the name (i.e. `()`):

{% highlight dart %}
int get theAnswer => 42;
{% endhighlight %}

This makes the syntax for defining them closer to how they are invoked.
(You can of course have a curly block body too in addition to the simple
lambda body shown above.)

([Tracking issue #3602](http://dartbug.com/3602))

## All objects Hashable

The Object class now implements Hashable.
This means that every object now responds to the `hashCode()`
method by default. This change lets you use any object as a
key in a map. (Note, map literals still only use strings as keys.)

Now you can do this:

{% highlight dart %}
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
{% endhighlight %}

([Tracking issue #3369](http://dartbug.com/3369))

## Line-style doc comments

Sometimes you'd like to write a small dartdoc comment. Previously, even a one-
line statement required three comment lines:

{% highlight dart %}
/**
 * Don't forget to feed the [Llama].
 */
feed() {
  // ...
}
{% endhighlight %}

Three comment lines for a single statement? We can do better.

Now, there's even less excuse to not comment your code, thanks to the
introduction of the line-style dartdoc comment. For those times when a single
comment line captures everything you need to say.

{% highlight dart %}
/// Don't forget to feed the [Llama].
feed() {
  // ...
}
{% endhighlight %}

The `///` style of comments works just fine with multi-line comments, if you
prefer this style over `/** ... */`. For example:

{% highlight dart %}
/// Generate a random number.
/// Returns a number between 0.0 and 1.0.
num generateRandom();
{% endhighlight %}

## Raw strings marked with `r`

With
[metadata](http://news.dartlang.org/2012/06/proposal-to-add-metadata-to-dart.html)
coming to Dart (not part of M1, though), and claiming the use of `@`,
we need a new way to mark a raw string.

Before M1, a raw string looked like:

{% highlight dart %}
var raw = @'This is a\nraw string';
{% endhighlight %}

However, the metadata proposal wants to use this:

{% highlight dart %}
@42
class MeaningOfLife {
  
}
{% endhighlight %}

We decided to use `@` for metadata, as it's more familiar
to developers, and use `r` to mark a raw string.

Once implemented, a raw string will look like:

{% highlight dart %}
var raw = r'steak\ntartare';
{% endhighlight %}

([Tracking issue #931](http://dartbug.com/931))

## Conclusion

There are a few other minor changes and clean-ups, but that’s the big noticeable
stuff. As always, your feedback, questions and comments are welcome on the
[mailing list](http://dartlang.org/mailing-list) and our [issue
tracker](http://dartbug.com).
