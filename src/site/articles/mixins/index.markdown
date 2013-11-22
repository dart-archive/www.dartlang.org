--- 
layout: article
title: "Mixins in Dart"
description: "Mixins let you implement functionality once and use it in multiple classes."
rel:
    author: gilad-bracha
has-permalinks: true
article:
  written_on: 2012-12-18
  updated_on: 2013-11-01
  collection: language-details
---

{% include toc.html %}

# {{ page.title }}

_Written by Gilad Bracha <br>
December 2012 (updated November 2013)_

This document describes mixins in Dart.
The semantics are deliberately restricted in several ways,
so as to reduce disruption to our existing implementations,
while allowing future evolution toward a full-fledged mixin implementation.
This restricted version already provides considerable value.

## Basic concepts

If you are familiar with the academic literature on mixins
you can probably skip this section.
Otherwise, please do read it,
as it defines important concepts and notation.
Those wishing to delve deeply into the topic can start with this paper:
[Mixins in Strongtalk](http://www.bracha.org/mixins-paper.pdf).

In a language supporting classes and inheritance,
a class implicitly defines a _mixin_.
The mixin is usually implicit—it is defined by the class body,
and constitutes the delta between the class and its superclass.
The class is in fact a _mixin application_—the
result of applying its implicitly defined mixin to its superclass. 

The term _mixin application_ comes from
a close analogy with _function application_.
Mathematically, a mixin _M_ can be seen as a function
from superclass to subclass:
feed _M_ a superclass _S_, and a new subclass of _S_ is returned.
This is often written as _M |> S_ in the research literature.

Based on the notion of function application,
one can define function composition.
The concept carries through to mixin composition;
we define the composition of mixins
<em>M<sub>1</sub></em> and <em>M<sub>2</sub></em>,
written <em>M<sub>1</sub></em> * <em>M<sub>2</sub></em>, as:
<em>(M<sub>1</sub> * M<sub>2</sub>) |> S =
M<sub>1</sub> |> (M<sub>2</sub> |> S)</em>.

Functions are useful because
they can be applied to different arguments. 
Likewise mixins.
The mixin implicitly defined by a class
is usually applied only once,
to the superclass given in the class declaration.
To allow mixins to be applied to different superclasses,
we need to be able to either
declare mixins independently of any particular superclass,
or alternately,
to extricate the implicit mixin of a class
and reuse it outside its original declaration.
That is what we propose to do below.

## Syntax and semantics

Mixins are implicitly defined via ordinary class declarations.
In principle, every class defines a mixin that can be extracted from it.
However, in this proposal,
a mixin may only be extracted from a class
that obeys the following restrictions:

1. The class has no declared constructors.
2. The class' superclass is Object.
3. The class contains no `super` calls.

Restriction (1) avoids complications that arise
due to the need to pass constructor parameters up the inheritance chain.
Under those circumstances, 
restriction (2) encourages mixins to be declared explicitly.
Restriction (3) means that implementations can continue
to statically bind `super` calls rather than either
rebinding them upon mixin application,
or binding them dynamically.

Example 1:

{% prettify dart %}
abstract class Collection<E> {
  Collection<E> newInstance();
  Collection<E> map((f) {
    var result = newInstance();
    forEach((E e) { result.add(f(e)); });
    return result;
  }
}

abstract class DOMElementList<E> = DOMList with Collection<E>;

abstract class DOMElementSet<E> = DOMSet with Collection<E>;

// ... 28 more variants
{% endprettify %}

Here, Collection\<E> is a normal class that is used to declare a mixin.
Both the classes DOMElementList and DOMElementSet are mixin applications.
They are defined by a special form of class declaration that gives them a name
and declares them equal to an application of
a mixin to a superclass, given via a `with` clause.
The class is abstract
because it does not implement the abstract method 
newInstance() declared in Collection. 

In the above, DOMElementList is effectively
<em>Collection mixin |> DOMList</em>,
while DOMElementSet is <em>Collection mixin |> DOMSet</em>.

The benefit here is that the code in class Collection
can be shared in multiple class hierarchies.
We list two such hierarchies above—one rooted in DOMList 
and one rooted in DOMSet.
One need not repeat/copy the code in Collection,
and every change made to Collection will propagate to both hierarchies,
greatly easing maintenance of the code.
This particular example is loosely based on a 
real and very acute case in the Dart libraries.

The above examples illustrate one form of mixin application,
where the mixin application specifies a mixin and a superclass
to which it applies,
and provides the application with a name.

In an alternative form, mixin applications appear in
the `with` clause of a class declaration
as a comma-separated list of identifiers.
All the identifiers must denote classes.
In this form, multiple mixins are composed and applied
to the superclass named in the extends clause,
producing an anonymous superclass. 
Taking the same examples again, we would have:

{% prettify dart %}
class DOMElementList<E> extends DOMList with Collection<E> {
   DOMElementList<E> newInstance() => new DOMElementList<E>();
}

class DOMElementSet<E> extends DOMSet with Collection<E> {
  DOMElementSet<E> newInstance() => new DOMElementSet<E>();
}
{% endprettify %}

Here, DOMElementList is not the application _Collection mixin |> DOMList._ 
Instead, it is a new class whose superclass is such an application.
The situation with respect to DOMElementSet is analogous.
Note that in each case,
the abstract method newInstance() is overridden with an implementation,
so these classes can be instantiated directly.

Consider what happens if DOMList has a non-trivial constructor:

{% prettify dart %}
class DOMElementList<E> extends DOMList with Collection<E> {
  DOMElementList<E> newInstance() => new DOMElementList<E>(0);
  DOMElementList(size): super(size);
}
{% endprettify %}

Each mixin has its own constructor called independently,
and so does the superclass.
Since a mixin constructor cannot be declared,
the call to it can be elided in the syntax;
in the underlying implementation,
the call can always be placed at the start of the initialization list.

The constructor would set the values for any fields
and for the generic type parameters.

This rule ensures that these examples run smoothly
and also generalize cleanly once one lifts restriction (1).

The second form is a convenient sugar
that allows multiple mixins to be mixed into a class
without the need to introduce multiple intermediate declarations. 
For example:

{% prettify dart %}
class Person {
  String name;
  Person(this.name);
}

class Maestro extends Person with Musical, Aggressive, Demented {
  Maestro(name):super(name);
}
{% endprettify %}

Here, the superclass is the mixin application:

<em>Demented mixin \|> Aggressive mixin \|> Musical mixin \|> Person</em>

We assume that only Person has a constructor with arguments.
Hence _Musical mixin |> Person_ inherits Person's constructors,
and so on until the actual superclass of Maestro,
which is formed by a series of mixin applications.

In reality in this example we'd expect that
Demented, Aggressive, and Musical 
actually have interesting properties that are likely to require state. 


## Details

We now discuss a few issues in more detail:

* Privacy
* Statics
* Types


### Privacy

A mixin application may well be declared outside the library
that declared the original class.
This does not have any effect on
who can access members of a mixin application instance.
Access to members is determined based on
the library where they were originally declared,
exactly as with ordinary inheritance. 
This follows from the semantics of mixin application,
which are determined by the semantics of inheritance
in the underlying language.

### Statics

Can one use the statics of the original class
via the mixin application or not?  
Again, the answer (No) follows from the semantics of inheritance.
Statics are not inherited in Dart. 

### Types

What is the type of a mixin application instance?
In general, it is a subtype of its superclass,
and also supports the methods defined on the mixin.
The mixin name itself, however,
denotes the type of the original class,
which has its own superclass
and may not be compatible with a particular mixin application.

What about the interfaces a class supports?
Does its mixin support them?
In general, no, since interface support
may rely on inherited functionality.
This implies that a mixin application must declare
what interfaces it implements explicitly.

### Generics

If a class has type parameters,
its mixin necessarily has identical type parameters. 


