---
layout: default
title: "Dart Style Guide"
rel:
  author: bob-nystrom
description: "Follow these guidelines for consistent, readable Dart code."
---

<h1>Dart Style Guide</h1>
<em>Written by Bob Nystrom<br />
<time pubdate date="2011-10-27">October 2011</time><br />
Updated: March 2012
</em>

As we build up an ecosystem of Dart code, it's helpful if it follows a consistent coding style. A dedicated style guide for Dart helps us make the most of the features unique to the language and makes it easier for users to collaborate.

There will likely be things you disagree with in this guide. As the author, there are things *I* disagree with. I hope you'll agree that consistency is often worth more than our individual preferences.

Keep in mind that, like many things with Dart, this guide isn't carved in stone. As the language evolves and we gain experience with it, our style will evolve too. This means that there will inevitably be code that doesn't follow the latest style, or places where the style guide is ambiguous or open-ended. Bear with us and it will get better as the language and its libraries settle down.

#### Contents

<ol class="toc">
  <li> <a href="#how-to-read">How to read this</a> </li>
  <li> <a href="#types">Types</a> </li>
  <li> <a href="#members">Members</a> </li>
  <li> <a href="#annotations">Type annotations</a> </li>
  <li> <a href="#names">Names</a> </li>
  <li> <a href="#comments">Comments</a> </li>
  <li> <a href="#whitespace">Whitespace</a> </li>
</ol>

<h2 id="how-to-read">How to read this</h2>

This guide is broken into a couple of sections roughly working from the macro scale down to the micro. Sections contain a list of guidelines. Each one starts with one of four words:

  * **DO** guidelines describe practices that should always be followed. There will almost never be a valid reason to stray from them.

  * **DON'T** guidelines are the converse: things that are almost never a good idea. You'll note there are few of these here. Guidelines like these in other languages help to avoid the pitfalls that appear over time. Dart is new enough that we can just fix those pitfalls directly instead of putting up ropes around them.

  * **PREFER** guidelines are practices that you *should* follow. However, there may be circumstances where it makes sense to do otherwise. Just make sure you understand the full implications of ignoring the guideline when you do.

  * **AVOID** guidelines are the dual to "prefer": stuff you shouldn't do but where there may be good reasons to on rare occasions.

This sounds like the style police are going to beat down your door if you don't have your laces tied correctly. Things aren't that bad. Most of the guidelines here are common sense and we're all reasonable people. The goal, as always, is nice, readable and maintainable code.

<h2 id="types">Types</h2>

#### AVOID creating classes that contain only static members.

In Java and C#, all members must be in a class. In those languages, you occasionally encounter classes that are basically namespaces: just bags of static members. Dart, like Python and JavaScript, doesn't have this limitation. You are free to define variables and functions at the top level.

Name collisions, when they occur, can be avoided by importing a library using a prefix. The advantage to this is that when collisions *don't* occur (which only the *user* of a library knows, not the creator), the user doesn't have to fully qualify the name at every callsite.

This doesn't mean you shouldn't have *any* static members, but it should be rare to create classes that have *only* static members. Instead, those should be libraries. Most classes should represent things you can construct.

{% pretty_code dart 0 good %}
num distance(num x1, num y1, num x2, num y2) =&gt; ...
{% endpretty_code %}
{% pretty_code dart 0 bad %}
class GeometryUtils {
  num distance(num x1, num y1, num x2, num y2) =&gt; ...
}
{% endpretty_code %}

#### AVOID defining a one-member interface when a simple function will do.

Unlike Java, Dart has first-class functions, closures, and a nice light syntax for using them. If all you need is something like a callback, just use a function. If you're defining an interface and it only has a single member with a meaningless name like `call` or `invoke`, there is a good chance you just want a function.

{% pretty_code dart 0 good %}
typedef bool Predicate(item);
{% endpretty_code %}
{% pretty_code dart 0 bad %}
interface Predicate {
  bool test(item);
}
{% endpretty_code %}

<h2 id="members">Members</h2>

#### DO use constructors instead of static methods to create instances.

Constructors are invoked using `new` or `const` which communicates clearly at the callsite that an object is being created. Named constructors and factory constructors in Dart give you all of the flexibility of static methods in other languages, while still allowing the callsite to appear like a regular constructor invocation.

{% pretty_code dart 0 good %}
new Point.zero();
new DateTime.now();
new Address.parse('123 Main St.');
{% endpretty_code %}
{% pretty_code dart 0 bad %}
Point.zero();
DateTime.now();
Address.parse('123 Main St.');
{% endpretty_code %}

#### DO use `;` instead of `{}` for empty constructor bodies.

In Dart, a constructor with an empty body can be terminated with just a semicolon. This is *required* for const constructors. For consistency and brevity, other constructors should also do this.

{% pretty_code dart 0 good %}
class Point {
  int x, y;
  Point(this.x, this.y);
}
{% endpretty_code %}
{% pretty_code dart 0 bad %}
class Point {
  int x, y;
  Point(this.x, this.y) {}
}
{% endpretty_code %}

#### DO place the `super()` call last in a constructor initialization list.

The `super()` call always happens last to guarantee that all initializers are run before the subclass constructor has access to `this`, so putting the `super()` call visually last reinforces this.

{% pretty_code dart 0 good %}
View(Style style, List children)
    : _children = children,
      super(style) {
{% endpretty_code %}
{% pretty_code dart 0 bad %}
View(Style style, List children)
    : super(style),
      _children = children {
{% endpretty_code %}

#### DO use a getter for operations that conceptually access a property.

If the name of the method starts with `get` or is an adjective like `visible` or `empty` that's a sign you're better off using a getter. More specifically, a getter should:

  * **Not take any arguments.**
  * **Return a value.**
  * **Be side-effect free.** Invoking a getter shouldn't change any externally-visible state (caching internally or lazy initialization is OK). Invoking the same getter repeatedly should return the same value unless the object is explicitly changed between calls.
  * **Be fast.** Users expect expressions like `foo.bar` to execute quickly.

{% pretty_code dart 0 good %}
rect.width
collection.isEmpty
button.visible
{% endpretty_code %}
{% pretty_code dart 0 bad %}
collection.sum // may be slow to calculate
DateTime.now   // returns different value each call
window.refresh // doesn't return a value
{% endpretty_code %}

#### DO use a setter for operations that conceptually change a property.

If the name of the method starts with `set` that's often a sign that it could be a setter. More specifically, a setter should:

  * **Take a single argument.**
  * **Change some state in the object.**
  * **Usually have a corresponding getter.** It feels weird for users to have state that they can modify but not see. (The converse is not true; it's fine to have getters that don't have setters.)
  * **Be idempotent.** Calling the same setter twice with the same value should do nothing the second time.
  * **Be fast.** Users expect expressions like `foo.bar = value` to execute quickly.

{% pretty_code dart 0 good %}
rect.width = 3;
button.visible = false;
{% endpretty_code %}

#### AVOID wrapping fields in getters and setters just to be "safe".

In Java and C#, it's common to hide all fields behind getters and setters (or properties in C#), even if the implementation just forwards to the field. That way, if you ever need to do more work in those members, you can without needing to touch the callsites. This is because calling a getter method is different than accessing a field in Java, and accessing a property isn't binary-compatible with accessing a raw field in C#.

Dart doesn't have this limitation. Fields and getters/setters are completely indistinguishable. You can expose a field in a class and later wrap it in a getter and setter without having to touch any code that uses that field.

{% pretty_code dart 0 good %}
class Box {
  var contents;
}
{% endpretty_code %}
{% pretty_code dart 0 bad %}
class Box {
  var _contents;
  get contents() =&gt; _contents;
  set contents(value) {
    _contents = value;
  }
}
{% endpretty_code %}

#### PREFER using a public final field instead of a private field with a public getter.

If you have a field that outside code should be able to see but not assign to (and you don't need to set it outside of the constructor), a simple solution that works in many cases is to just mark it `final`.

{% pretty_code dart 0 good %}
class Box {
  final contents;
}
{% endpretty_code %}
{% pretty_code dart 0 bad %}
class Box {
  var _contents;
  get contents() =&gt; _contents;
}
{% endpretty_code %}

#### DO use `=>` to define members whose body is a single expression that fits on one line.

In addition to using `=>` for function expressions, Dart also lets you define members with them. They are a good fit for simple members that just calculate and return a value.

{% pretty_code dart 0 good %}
get width() =&gt; right - left;
bool ready(num time) =&gt; minTime === null || minTime &lt;= time;
containsValue(String value) =&gt; getValues().some((v) =&gt; v == value);
{% endpretty_code %}

#### AVOID boolean arguments unless their meaning is completely obvious.

Unlike other types, booleans are usually used in literal form. Things like numbers are usually wrapped in named constants, but we usually just pass around `true` and `false` directly. That can make callsites unreadable if it isn't clear what the boolean represents:

{% pretty_code dart 0 bad %}
new Timer(true);
new Timer(false);
new ListBox(false, true, true);
{% endpretty_code %}

Instead, consider using named arguments, named constructors, or named constants to clarify what the call is doing.

{% pretty_code dart 0 good %}
new Timer.oneShot();
new Timer.repeating();
new ListBox(scroll: scrollBoth, showScrollbars: true);
{% endpretty_code %}

<h2 id="annotations">Type annotations</h2>

#### PREFER providing type annotations on public APIs.

Type annotations are important documentation for how a library should be used. Annotating the parameter and return types of public methods and functions helps users understand what the API expects and what it provides.

If, however, a public API does accept any type, or accepts a range of values that Dart's type system cannot express, then it is acceptable to leave that untyped.

For code internal to a library (either private, or things like nested functions) annotate where you feel it helps, but don't feel that you *must* provide them.

{% pretty_code dart 0 bad %}
install(id, destPath) {
  ...
}
{% endpretty_code %}

Here, it's unclear what `id` is. A string? And what is `destPath`? A string or a `File` object? Is this method synchronous or asynchronous?

{% pretty_code dart 0 good %}
Future&lt;bool&gt; install(PackageId id, String destPath) {
  ...
}
{% endpretty_code %}

With types, all of this is clarified.

#### PREFER using `var` without a type annotation for local variables.

Method bodies in modern code tend to be short, and the types of local variables are almost always trivially inferrable from the initializing expression, so explicit type annotations are usually just visual noise. Decent editors can infer the type of local variables and still provide the auto-complete and tooling support you expect.

{% pretty_code dart 0 good %}
Map&lt;int, List&lt;Person&gt;&gt; groupByZip(Iterable&lt;Person&gt; people) {
  var peopleByZip = new Map&lt;int, List&lt;Person&gt;&gt;();
  for (var person in people) {
    peopleByZip.putIfAbsent(person.zip, () =&gt; &lt;Person&gt;[]);
    peopleByZip[person.zip].add(person);
  }
  return peopleByZip;
}
{% endpretty_code %}

{% pretty_code dart 0 bad %}

    Map&lt;int, List&lt;Person&gt;&gt; groupByZip(Iterable&lt;Person&gt; people) {
      Map&lt;int, List&lt;Person&gt;&gt; peopleByZip = new Map&lt;int, List&lt;Person&gt;&gt;();
      for (Person person in people) {
        peopleByZip.putIfAbsent(person.zip, () =&gt; &lt;Person&gt;[]);
        peopleByZip[person.zip].add(person);
      }
      return peopleByZip;
    }

{% endpretty_code %}

#### DON'T use `double` as a type annotation.

Annotating that a parameter is type `double` means not only that it *may* be a floating-point value, but that it *must*. It's a type error to pass an `int` to it. There should never be cases where code can handle floating-point values but not integers. The type annotation you want is `num`, which allows *both* integer and floating-point values.

The `double` type exists in Dart only because of the desire to report static type warnings in places like this:

{% pretty_code dart 0 bad %}
int three = 3.14159; // Not an int.
{% endpretty_code %}

If floating-point literals had static type `num`, that would not be a static warning due to bidirectional assignment compatibility.

#### DON'T type annotate initializing formals.

If a constructor parameter is using `this.` to initialize a field, then the type of the parameter is understood to be the same type as the field.

{% pretty_code dart 0 good %}
class Point {
  int x, y;
  Point(this.x, this.y);
}
{% endpretty_code %}
{% pretty_code dart 0 bad %}
class Point {
  int x, y;
  Point(int this.x, int this.y);
}
{% endpretty_code %}

#### AVOID annotating types on function expressions.

The value of function expressions is their brevity. If a function is complex enough that types are needed to understand it, it should probably be a function statement or a method. Conversely, if it is short enough to be an expression, it likely doesn't need types.

{% pretty_code dart 0 good %}
var names = people.map((person) => person.name);
{% endpretty_code %}
{% pretty_code dart 0 bad %}
var names = people.map(String _(Person person) {
  return person.name;
});
{% endpretty_code %}

<h2 id="names">Names</h2>

#### DO name types using `UpperCamelCase`.

Classes, interfaces, and typedefs should capitalize the first letter of each word (including the first word), and use no separators. Abbreviations should be capitalized like words.

{% pretty_code dart 0 good %}
SliderMenu
XmlHttpRequest
{% endpretty_code %}

#### DO name other identifiers using `lowerCamelCase`.

Class members, top level definitions, variables, parameters, and named parameters, should capitalize the first letter of each word *except* the first word, and use no separators. Abbreviations should be capitalized like words.

{% pretty_code dart 0 good %}
item
xmlHttpRequest
clearItems
{% endpretty_code %}

#### DO name libraries and sourcefiles using `lowercase_with_underscores`.

Some file systems are not case-sensitive, so many projects require filenames to be all lowercase. Using a separate character allows names to still be readable in that form. Using underscores as the separator ensures that the name is still a valid Dart identifier, which may be helpful if the language later supports symbolic imports.

{% pretty_code dart 0 good %}
slider_menu
file_system
peg_parser
{% endpretty_code %}
{% pretty_code dart 0 bad %}
SliderMenu
filesystem
peg-parser
{% endpretty_code %}

<h2 id="comments">Comments</h2>

#### DO comment members and types using doc-style comments.

These start with `/**` and end with `*/`. Within a doc comment, you can use [markdown][] for formatting.

[markdown]: http://daringfireball.net/projects/markdown/

{% pretty_code dart 0 good %}
/**
 * Parses a set of option strings. For each option:
 *
 * * If it is `null`, then it is ignored.
 * * If it is a string, then [validate] is called on it.
 * * If it is any other type, it is *not* validated.
 */
void parse(List options) {
  ...
}
{% endpretty_code %}

#### PREFER using a single-line Dart-doc comment if the comment is short enough.

{% pretty_code dart 0 good %}
/** Returns the greater of the two arguments. */
max(a, b) =&gt; a &gt; b ? a : b;
{% endpretty_code %}

#### DO use line comments for everything else.

{% pretty_code dart 0 good %}
greet(name) {
  // Assume we have a valid name.
  print('Hi, $name!');
}
{% endpretty_code %}
{% pretty_code dart 0 bad %}
greet(name) {
  /* Assume we have a valid name. */
  print('Hi, $name!');
}
{% endpretty_code %}

#### DO capitalize and punctuate comments like sentences.

This doesn't mean that the comment must always be a complete sentence, though it usually should. "Returns the number of items." is an acceptable comment.

{% pretty_code dart 0 good %}
// Remove the last item from the collection.
{% endpretty_code %}
{% pretty_code dart 0 bad %}
// remove the last item from the collection
{% endpretty_code %}

#### DO use square brackets in doc comments for identifiers that are in scope.

If you surround things like variable, method or type names in square brackets, then documentation generators can look up the name and cross-link the two together.

{% pretty_code dart 0 good %}
/* Rolls both [Dice] and returns the highest rolled value. */
num greatestRoll(Dice a, Dice b) =&gt; Math.max(a.roll(), b.roll());
{% endpretty_code %}

#### DO describe method signatures in the prose of the documentation comment.

Other languages use verbose tags and sections to describe what the parameters and returns of a method are.

{% pretty_code dart 0 bad %}
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
  ...
}
{% endpretty_code %}

The convention in Dart is to just integrate that into the description of the method and highlight parameters using square brackets.

{% pretty_code dart 0 good %}
/**
 * Defines a flag. Throws an [IllegalArgumentException] if there is
 * already an option named [name] or there is already an option using
 * abbreviation [abbr]. Returns the new flag.
 */
Flag addFlag(String name, String abbr) {
  ...
}
{% endpretty_code %}

<h2 id="whitespace">Whitespace</h2>

Like many languages, Dart ignores whitespace. However, *humans* don't. Having a consistent whitespace style helps ensure that human readers see code the same way the compiler does.

#### DON'T use tabs.

Using spaces for formatting ensures the code looks the same in everyone's editor. It also makes sure it looks the same when posted to blogs, or on code sites like [Google Code][] or [github][].

[google code]: http://code.google.com/projecthosting/
[github]: http://github.com

You may complain that spaces take more effort to type. If that's the case, I encourage you to pause your 8-track player, put on your parachute pants and go out and find a modern text editor that makes spaces as easy to work with as tabs.

#### AVOID lines longer than 80 characters.

Readability studies show that long lines of text are harder to read because your eye has to travel farther when moving to the beginning of the next line. This is why newspapers and magazines use multiple columns of text.

If you really find yourself wanting lines longer than 80 characters, our experience is that your code is likely too verbose and could be a little more compact. Do you really need to call that class `AbstractWidgetFactoryManagerBuilder`?

#### DO indent blocks with two spaces.

{% pretty_code dart 0 good %}
if (condition) {
  print('hi');
}
{% endpretty_code %}

#### DO indent continued lines with at least four spaces.

{% pretty_code dart 0 good %}
someLongObject.aReallyLongMethodName(longArg, anotherLongArg,
    wrappedToNextLine);
{% endpretty_code %}

You may indent more than four spaces to line things up if you like:

{% pretty_code dart 0 good %}
someLongObject.aReallyLongMethodName(longArg, anotherLongArg,
                                     wrappedToNextLine);
{% endpretty_code %}

#### DON'T indent lines that are continued with a function expression.

The one exception to the above rule is function expressions used within larger expressions, like being passed to methods. These are formatted like so:

{% pretty_code dart 0 good %}
window.setTimeout(() {
  print('I am a callback');
});
{% endpretty_code %}

Note that even though second and third lines are a continuation of the first, they are not indented four spaces. Instead, they line up with the first line. The second line is indented two spaces because it is a block.

#### DO place the opening curly brace (`{`) on the same line as what it follows.

{% pretty_code dart 0 good %}
class Foo {
  method() {
    if (true) {
      ...
    } else {
      ...
    }
  }
}
{% endpretty_code %}

#### DO use curly braces for all flow control structures.

Doing so avoids the [dangling else][] problem.

[dangling else]: http://en.wikipedia.org/wiki/Dangling_else

{% pretty_code dart 0 good %}
if (true) {
  print('sanity');
} else {
  print('opposite day!');
}
{% endpretty_code %}
{% pretty_code dart 0 bad %}
if (true) print('sanity');
else
  print('opposite day!');
{% endpretty_code %}

There is one exception to this: short `if` statements with no `else` clause that fit on one line may omit the braces.

{% pretty_code dart 0 good %}
if (arg == null) return defaultValue;
{% endpretty_code %}

#### DO use spaces around binary and ternary operators, after commas, and not around unary operators.

Note that `<` and `>` are considered binary operators when used as expressions, but not for specifying generic types. Also, `is` is considered a binary operator. However, the `.` used to access members is not and should *not* have spaces around it.

{% pretty_code dart 0 good %}
a = 1 + 2 / (3 * -b);
c = !condition == a &gt; b;
d = a ? b : object.method(a, b, c);
if (obj is !SomeType) print('not SomeType');
{% endpretty_code %}
{% pretty_code dart 0 bad %}
a=1+2/(3* - b);
c= ! condition==a&gt;b;
d= a?b:object.method(a,b,c);
if (obj is! SomeType) print('not SomeType');
{% endpretty_code %}

#### DO place spaces around `in`, and after each `;` in a loop.

{% pretty_code dart 0 good %}
for (var i = 0; i &lt; 100; i++)
for (final item in collection)
{% endpretty_code %}

#### DO use a space after flow-control keywords.

This is unlike function and method calls, which do *not* have a space between the name and the opening parenthesis.

{% pretty_code dart 0 good %}
while (foo) {
  ...
}

try {
  ...
}
{% endpretty_code %}

#### DON'T use a space after `(`, `[`, and `{`, or before `)`, `]`, and `}`.

Also, do not use a space when using `<` and `>` for generic types.

{% pretty_code dart 0 good %}
&lt;int&gt;[1, 2, (3 + 4)]
{% endpretty_code %}

#### DO use a space before `{` in function and method bodies.

This is an exception to the above rule. When a `{` is used after a parameter list in a function or method, there should be a space between it and the `)` ending the parameters.

{% pretty_code dart 0 good %}
getEmptyFn(a) {
  return () {};
}
{% endpretty_code %}
{% pretty_code dart 0 bad %}
getEmptyFn(a){
  return (){};
}
{% endpretty_code %}

#### DO format constructor initialization lists with each field on its own line.

{% pretty_code dart 0 good %}
MyClass()
    : firstField("some value"),
      secondField("another"),
      thirdField("last") {
  ...
}
{% endpretty_code %}

Note that the `:` should be wrapped to the next line and indented four spaces. Fields should all line up (so all but the first field end up indented six spaces).

#### DO use a space around `=` in named parameters and after `:` for a named argument.

{% pretty_code dart 0 good %}
new ListBox(showScrollbars: true);
ListBox([this.showScrollbars = true]);
{% endpretty_code %}

{% pretty_code dart 0 bad %}
new ListBox(showScrollbars:true);
new ListBox(showScrollbars : true);
ListBox([this.showScrollbars=true]);
{% endpretty_code %}

{% include syntax-highlighting.html %}
