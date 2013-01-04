--- 
layout: default
title: "Mixins in Dart"
description: "Mixins will let you implement functionality once and use it in multiple classes."
rel:
    author: gilad-bracha
has-permalinks: true
article:
  written_on: 2012-12-18
  collection: language-details
---

# {{ page.title }}
_Written by Gilad Bracha <br>
December 2012_

This document describes mixins in Dart.
The semantics are deliberately restricted in several ways,
so as to reduce disruption to our existing implementations,
while allowing future evolution toward a full-fledged mixin implementation.
This restricted version already provides considerable value.

The intent is to incorporate mixins into Dart in M3.

#### Contents

1. [Basic concepts](#basic-concepts)
1. [Syntax and semantics](#syntax-and-semantics)
1. [Possible issues](#possible-issues)
   1. [Privacy](#privacy)
   1. [Statics](#statics)
   1. [Types](#types)
1. [Extensions](#extensions)
1. [Spec changes](#spec-changes)
{:.toc}

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

{% highlight dart %}
abstract class Collection<E> {
    Collection<E> newInstance();
    Collection<E> map(f) {
     var result = newInstance();
     forEach((E e){result.add(f(e));})
     return result;
  }
}

typedef DOMElementList<E> = abstract DOMList with Collection<E>;

typedef DOMElementSet<E> = abstract DOMSet with Collection<E>;

// ... 28 more variants
{% endhighlight %}

Here, Collection\<E> is a normal class that is used to declare a mixin.
Both the classes DOMElementList and DOMElementSet are mixin applications.
They are defined by the typedef declaration that gives them a name
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

{% highlight dart %}
class DOMElementList<E> extends DOMList with Collection<E> {
   DOMElementList<E> newInstance() => new DOMElementList<E>();
}

class DOMElementSet<E> extends DOMSet with Collection<E> {
   DOMElementSet<E> newInstance() => new DOMElementSet<E>();
}
{% endhighlight %}

Here, DOMElementList is not the application _Collection mixin |> DOMList._ 
Instead, it is a new class whose superclass is such an application.
The situation with respect to DOMElementSet is analogous.
Note that in each case,
the abstract method newInstance() is overridden with an implementation,
so these classes can be instantiated directly.

Consider what happens if DOMList has a non-trivial constructor:

{% highlight dart %}
class DOMElementList<E> extends DOMList with Collection<E> {
   DOMElementList<E> newInstance() => new DOMElementList<E>(0);
   DOMElementList(size): super(size);
}
{% endhighlight %}

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

{% highlight dart %}
class Person {
  String name;
  Person(this.name);
}

class Maestro extends Person with Musical, Aggressive, Demented {
  Maestro(name):super(name);
}
{% endhighlight %}

Here, the superclass is the mixin application:

<em>Demented mixin \|> Aggressive mixin \|> Musical mixin \|> Person</em>

We assume that only Person has a constructor with arguments.
Hence _Musical mixin |> Person_ inherits Person's constructors,
and so on until the actual superclass of Maestro,
which is formed by a series of mixin applications.

In reality in this example we'd expect that
Demented, Aggressive, and Musical 
actually have interesting properties that are likely to require state. 


## Possible issues

Having illustrated the proposal,
we now discuss several areas where we can anticipate issues:

* Privacy
* Statics
* Types


### Privacy

A mixin application may well be declared outside the library
that declared the original class.
This should not have any effect on
who can access members of a mixin application instance.
Access to members is determined based on
the library where they were originally declared,
exactly as with ordinary inheritance. 
Strictly speaking, I need not even bring this up,
as it follows from the semantics of mixin application,
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

**We may safely ignore this issue for the time being.**
Because of restriction (2),
the type of a mixin does not include
additional members beyond those
declared by the mixin or shared by all objects.
Even if the mixin implements interfaces,
the mixin itself must implement
the methods of the interfaces,
and so it is safe to assume that anyone mixing in the mixin
is a subtype of the full type denoted by the mixin's name.

However, when restriction (2) is lifted, the problem will arise.

This would argue for defining mixins as distinct constructs,
so that the mixin name would denote a stable type.
However, this requires pre-planning.
Instead, we might choose to denote
the type of the mixin of a class C
by a special type expression.

Generics are also an issue.
If a class has type parameters,
its mixin necessarily has identical type parameters. 

## Extensions

A key question is whether this proposal can be
cleanly extended when we relax its restrictions.
The implications of lifting restriction (2) have already been discussed.
Restriction (3) requires more sophistication in the implementation: 
`super` calls must appear to bind dynamically to the actual superclass.
This can be achieved either by copying methods that use `super`,
or by making `super` calls late bound.
See section 6 of the paper
[Mixins in Strongtalk](http://www.bracha.org/mixins-paper.pdf)
for a discussion of relevant implementation techniques. 

Restriction (1) is more complex.
Because of Dart syntax,
there is no way to pass the constructor arguments
up the inheritance chain as part of the `with` clause
(as there is in, say, Scala).

A comprehensive approach to addressing the issue
is illustrated below via a variation on our mad maestro example.

{% highlight dart %}
class Musical {
   final Instrument instrument;
   Musical(this.instrument);
}

class Aggressive {
  final String aggressionLevel;
  Aggressive(this.aggressionLevel);
}

class Demented {
 final disorder;
 Demented(this.disorder);
}

class Maestro extends Person with Musical, Aggressive, Demented {
  Maestro(name, disorder, degree, instrument) :
     Demented(disorder), Aggressive(degree), Musical(instrument), super(name);
}
{% endhighlight %}

The constructor for Maestro explicitly channels the various parameters
to the various mixins that are used to define its superclasses.  

The rules given in the restricted proposal still apply:
each mixin has its constructor called independently,
as does the superclass.
Only the part of the constructor
that operates on the mixin itself is called.
If the mixin had a superclass,
that superconstructor is not run.

If calls to mixin constructors are absent,
a default call of the form M(),
where M is the name of the mixin,
should be inserted by the implementation.
This will ensure calling of its default constructor if it exists.
Of course, these calls may be optimized away
if the mixin has no fields or constructors.
Hence, both the behavior and performance
of the restricted proposal are preserved.

## Spec changes

The rest of this document describes and shows
how mixins change the language specification.
Changes to existing sections are
<span class="spec-change">highlighted in yellow</span>.

### 7. Classes

<aside>
  <div class="alert alert-info">
    <strong>Summary of changes:</strong>
    Add the mixin clause,
    explain its implications on the superclass chain,
    its effects on superconstructor call, and so on.
    Basically, sugar for series of anonymous mixin applications.
  </div>
</aside>

<em><b>classDefinition:</b><br>
&nbsp;&nbsp;&nbsp;&nbsp; metadata <b>abstract</b>? <b>class</b> identifier typeParameters? (superclass<span class="spec-change"> mixins?)?</span> interfaces?<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '{' (metadata classMemberDefinition)* '}'<br>
&nbsp;&nbsp;&nbsp; ;<br>
<br>
<span class="spec-change"><b>mixins:</b><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>with</b> typeList<br>
&nbsp;&nbsp;&nbsp; ;<br></span>
...</em>

An _abstract class_ is a class that is explicitly declared with the
**abstract** modifier<span class="spec-change">,
either by means of a class declaration or via a
type alias for a mixin application</span>.

...

### 7.9 Superclasses

<span class="spec-change">The superclass of a class _C_
that has a **with** clause **with** <em>M<sub>1</sub>, …, 
M<sub>k</sub></em> and an extends clause **extends** S
is the application of <em>M<sub>k</sub> * .. * 
M<sub>1</sub></em> to _S_.
If no **with** clause is specified then </span>
the **extends** clause 
of a class _C_ specifies its superclass.
If no **extends** clause is specified, then either:

* _C_ is Object, which has no superclass. OR
* <span class="spec-change">Class _C_ is deemed to have
  an **extends** clause of the form **extends** Object,
  and the rules above apply.</span>

It is a compile-time error to specify an **extends** clause for class Object.<br/>

<em><b>superclass:</b><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>extends</b> type<br>
&nbsp;&nbsp;&nbsp; ; </em>

It is a compile-time error if the **extends** clause of a class _C_
includes a type expression that does not denote a class available
in the lexical scope of _C._

<div class='spec-commentary'>

<p>
The type parameters of a generic class are available in the lexical scope of the 
superclass clause, potentially shadowing classes in the surrounding scope. The 
following code is therefore illegal and should cause a compile-time error:
</p>

{% highlight dart %}
class T{}
class G<T> extends T {} // Compilation error: Attempt to subclass a type parameter
{% endhighlight %}
</div>

A class _S_ is _a superclass of_ a class _C_ iff either:

* _S_ is the superclass of _C,_ or
* _S_ is a superclass of a class _S'_ and _S'_ is a superclass of _C._

It is a compile-time error if a class _C_ is a superclass of itself.


### 9. Mixins

<aside>
  <div class="alert alert-info">
    <strong>Summary of changes:</strong>
    This section is completely new.
  </div>
</aside>

<div class="spec-rationale">
<p>
Caveat 1: Mixins are not implemented at this time.
</p>

<p>
Caveat 2: This section of the spec is work in progress.
</p>
</div>

A mixin describes the difference between a class and its superclass. A mixin may 
be declared directly or derived from an existing class declaration.

It is a compile-time error if a declared or derived mixin refers to **super**. 
It is a compile-time error if a declared or derived mixin explicitly declares a 
constructor. It is a compile-time error if a mixin is derived from a class whose 
superclass is not Object.

<div class="spec-rationale">
<p>
These restrictions are temporary.
We expect to remove them in later versions of Dart.
</p>

<p>
The restriction on the use of <strong>super</strong>
avoids the problem of rebinding 
<strong>super</strong> when the mixin is bound to difference superclasses.
</p>

<p>
The restriction on constructors simplifies the construction of mixin 
applications because the process of creating instances is simpler.
</p>

<p>
The restriction on the superclass means that the type of a class
from which a mixin is derived is always implemented
by any class that mixes it in.
This allows us to defer the question of whether and how
to express the type of the mixin
independently of its superclass and superinterface types.
</p>

<p>
Reasonable answers exist for all these issues,
but their implementation is non-trivial.
</p>
</div>

#### 9.1 Mixin Application

A mixin may be applied to a superclass,
yielding a new class.
Mixin application may occur when a mixin is
mixed into a class declaration via its **with** clause,
or it may occur in the context of a type alias.

<em>
<b>mixinApplication:</b> <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qualified_mixins interfaces?';' <br>
;
</em>

A mixin application of the form _S **with** M_
defines a class _C_ with superclass _S._

A mixin application of the form
<em>S <b>with</b> M<sub>1</sub>, …, M<sub>k</sub></em>
defines a class _C_ whose superclass is
the application of the mixin composition
_M<sub>k</sub> * … * M<sub>1</sub>_ to _S._

In both cases above, _C_ declares the same instance members as _M_.
If any of the instance fields of _M_ have initializers,
they are executed in the scope of _M_
to initialize the corresponding fields of _C_.
The class _C_ has an implicitly declared nullary generative constructor
with no initializer list and no body.

It is a compile-time error if _S_ does not denote a class
available in the immediately enclosing scope.
It is a compile-time error if _M_
(respectively, any of <em>M<sub>1</sub>, ..., M<sub>k</sub></em>)
does (respectively, do) not denote
a class or mixin available in the immediately enclosing scope.
It is a compile-time error if a well-formed mixin
cannot be derived from _M_
(respectively, from each of <em>M<sub>1</sub>, ..., M<sub>k</sub></em>).

Let _K_ be a class declaration with the same superclass and interfaces as _C_,
and the instance members declared by _M_
(respectively <em>M<sub>1</sub>, ..., M<sub>k</sub></em>).
It is a static warning if the declaration of _K_
would cause a static warning.
It is a compile-time error if the declaration of _K_
would cause a compile-time error.

<p class="spec-commentary">
If, for example, _M_ declares an instance member _im_
whose type is at odds with the type of a member of the same name in _S_,
this will result in a static warning
just as if we had defined _K _by means of an ordinary class declaration 
extending _S _with a body that included _im_.
</p>


#### 9.2 Mixin Composition

<p class="spec-rationale">
Dart does not directly support mixin composition, but the concept is useful 
when defining how the superclass of a class with a mixin clause is created.
</p>

The _composition of two mixins_,
<em>M<sub>1</sub>&lt;T<sub>1</sub> … T<sub>kM1</sub></em>> and
<em>M<sub>2</sub>&lt;U<sub>1</sub> … U<sub>kM2</sub>></em>,
written <em>M<sub>1</sub>&lt;T<sub>1</sub> … T<sub>kM1</sub>>
* M<sub>2</sub>&lt;U<sub>1</sub> … U<sub>kM2</sub>></em>,
defines an anonymous mixin such that for any class
<em>S&lt;V<sub>1</sub> … V<sub>kS</sub>></em>,
the application of
<em>M<sub>1</sub>&lt;T<sub>1</sub> … T<sub>kM1</sub>></em> to
<em>S&lt;V<sub>1</sub> … V<sub>kS</sub>></em>
is equivalent to 

<em>**typedef** Id<sub>1</sub><T<sub>1</sub> …
T<sub>kM1</sub>, U<sub>1</sub> … U<sub>kM2</sub>, V<sub>1</sub> … V<sub>kS</sub>> = 
**abstract** Id<sub>2</sub><U<sub>1</sub> … U<sub>kM2</sub>, V<sub>1</sub> … V<sub>kS</sub>> **with** 
M<sub>1</sub> <T<sub>1</sub> … T<sub>kM1</sub>>;</em>

where _Id<sub>2</sub>_ denotes

<em>**typedef** Id<sub>2</sub><U<sub>1</sub> … U<sub>kM2</sub>,
V<sub>1</sub> … V<sub>kS</sub>> =
**abstract** S<V<sub>1</sub> … V<sub>kS</sub>> **with**
<em>M<sub>2</sub><U<sub>1</sub> … U<sub>kM2</sub>>; </em>

and _Id<sub>1</sub>_ and _Id<sub>2</sub>_ are unique identifiers
that do not exist anywhere in the program. 

<p class="spec-rationale">
The classes produced by mixin composition are regarded as abstract
because they cannot be instantiated independently.
They are only introduced as anonymous superclasses
of ordinary class declarations and mixin applications. 
Consequently, no warning is given if a mixin composition
includes abstract members, or incompletely implements an interface.
</p>

Mixin composition is associative.

<p class="spec-commentary" markdown="1">
Note that any subset of _M<sub>1</sub>_,
_M<sub>2</sub>_, and _S_ may or may not be generic.
For any non-generic declaration,
the corresponding type parameters may be elided, 
and if no type parameters remain
in the derived declarations _Id<sub>1</sub>_ and/or _Id<sub>2</sub>_
then those declarations need not be generic either.  
</p>


### 14. Libraries and Scripts

A Dart program consists of one or more libraries,
and may be built out of one or more _compilation units_.
A compilation unit may be a library or a part.

A _library_ consists of (a possibly empty) set of imports, and a set of top 
level declarations. A _top level declaration_ is either a class,
a type alias declaration,
a function,
or a variable declaration.

<em><b>topLevelDefinition:</b><br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; classDefinition<br>
<span class="spec-change">&nbsp;&nbsp;&nbsp;&nbsp;| typeAlias<br/></span></em>
&nbsp;&nbsp;&nbsp;&nbsp;| **external** _functionSignature_<br/>
&nbsp;&nbsp;&nbsp;&nbsp;| **external** _getterSignature_<br/>
&nbsp;&nbsp;&nbsp;&nbsp;| **external** <em>setterSignature<br/>
&nbsp;&nbsp;&nbsp;&nbsp;| functionSignature functionBody<br/>
&nbsp;&nbsp;&nbsp;&nbsp;| returnType? getOrSet identifier formalParameterList functionBody<br/>
&nbsp;&nbsp;&nbsp;&nbsp;| (**final** | **const**) type? staticFinalDeclarationList ';'<br/>
&nbsp;&nbsp;&nbsp;&nbsp;| variableDeclaration ';'<br/>
&nbsp;&nbsp;&nbsp;&nbsp;| ;

### 15.3.1 Typedef

<aside>
  <div class="alert alert-info">
    <strong>Summary of changes:</strong>
    Generalize to support mixin applications.
  </div>
</aside>

A _type alias_ declares a name for a type expression<span class="spec-change">
or mixin application</span>.

<div class="spec-change" markdown="1">
<em>**typeAlias:**<br/>
&nbsp;&nbsp;&nbsp;&nbsp; metadata</em> <b>typedef</b> <em>typeAliasBody<br/>
&nbsp;&nbsp;&nbsp;&nbsp; ; </em>
</div>

<div class="spec-change" markdown="1">
<em>**typeAliasBody:**<br/>
&nbsp;&nbsp;&nbsp;&nbsp; identifier typeParameters? `='</em> **abstract**? <em>mixinApplication<br/>
&nbsp;&nbsp;&nbsp;&nbsp; | _functionTypeAlias_<br/>
&nbsp;&nbsp;&nbsp;&nbsp; ; </em>
</div>

<div class="spec-change" markdown="1">
<em>**functionTypeAlias:**<br/>
&nbsp;&nbsp;&nbsp;&nbsp; functionPrefix typeParameters? formalParameterList ';'<br/>
&nbsp;&nbsp;&nbsp;&nbsp; ;<br/></em>
</div>

<em>**functionPrefix:**<br/>
&nbsp;&nbsp;&nbsp;&nbsp; returnType? identifier<br/>
&nbsp;&nbsp;&nbsp;&nbsp; ;

The effect of a type alias of the form
**typedef** _T id (T<sub>1</sub> p<sub>1</sub>, …, 
T<sub>n</sub> p<sub>n</sub>,
[T<sub>n+1</sub> p<sub>n+1</sub>, …, T<sub>n+k</sub> p<sub>n+k</sub>])_
declared in a library _L_
is to introduce the name _id_ into the scope of _L,_
bound to the function type _(T<sub>1</sub>, …, T<sub>n</sub>,
[T<sub>n+1</sub> p<sub>n+1</sub>, …,  T<sub>n+k</sub> p<sub>n+k</sub>]) → T._
The effect of a type alias of the form
**typedef** _T id (T<sub>1</sub> p<sub>1</sub>, …, 
T<sub>n</sub> p<sub>n</sub>,
{T<sub>n+1</sub> p<sub>n+1</sub>,
…, T<sub>n+k</sub> p<sub>n+k</sub>})_
declared in a library _L_ is to introduce the name _id_
into the scope of _L,_
bound to the function type <em>(T<sub>1</sub>, …, T<sub>n</sub>,
{T<sub>n+1 </sub>p<sub>n+1</sub>, …, T<sub>n+k</sub> p<sub>n+k</sub>]}) → T.</em>
In either case, if no return type is specified,
it is taken to be **dynamic.**
Likewise, if a type annotation is omitted on a formal parameter,
it is taken to be **dynamic.**

<p class="spec-change" markdown="1">
The effect of a type alias of the form **typedef** _C = M_; or the form 
**typedef** _C<T<sub>1</sub>, …, T<sub>n</sub>> = M_;  is to introduce the name _C_ into the 
scope of _L,_ bound to the class defined by the mixin application _M_. The name 
of the class is also set to _C_. Iff the type alias body includes the built-in 
identifier **abstract**, the class being defined is an abstract class.
</p>

It is a compile-time error if any default values are specified in the signature 
of a function type alias. It is a compile-time error if a typedef refers to 
itself via a chain of references that does not include a class type. 

### 15.4 Interface Types

<aside>
  <div class="alert alert-info">
    <strong>Summary of changes:</strong>
    Add the effects of mixin clause on subtyping.
  </div>
</aside>


The implicit interface of class _I_ is a _direct supertype_ of the implicit 
interface of class _J_ iff:

* _I_ is Object, and _J_ has no **extends** clause_._
* _I_ is listed in the **extends** clause of _J._
* _I_ is listed in the **implements** clause of _J._
* <span class="spec-change">_I_ is listed in the **with** clause of _J._</span>
* <span class="spec-change">_J_ is a mixin application of the mixin of _I._</span>

### 16.1.1 Reserved Words

<aside>
  <div class="alert alert-info">
    <strong>Summary of changes:</strong>
    Add the reserved word <b>with</b>
    (turning an evil keyword into a good one!).
  </div>
</aside>

A _reserved word_ may not be used as an identifier; it is a compile-time error 
if a reserved word is used where an identifier is expected.

<strong>assert, break, case, catch, class, const, continue, default, do, else, 
extends, false, final, finally, for, if, in, is, new, null, return, super, 
switch, this, throw, true, try, var, void, while<span class='spec-change'>,
with</span>.</strong>
