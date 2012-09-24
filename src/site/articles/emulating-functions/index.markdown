---
layout: default
title: "Emulating Functions in Dart"
rel:
  author: gilad-bracha
has-permalinks: true
---

# {{ page.title }}

<p>
<em>Written by Gilad Bracha <br>
January 2012<br>
Updated: September 2012</em>
</p>

This document describes a refinement of the Dart programming language
that allows user-defined classes that are substitutable for functions.

<aside>
  <div class="alert alert-info">
    <strong>Note:</strong>
    This functionality is expected to be implemented for the Dart M1 release.
  </div>
</aside>

## Contents

1. [The call() method](#the-call-method)
1. [Function types](#function-types)
1. [The apply() method](#the-apply-method)
1. [Interactions with noSuchMethod()](#interactions-with-nosuchmethod)
1. [Summary](#summary)

## The call() method

In the following example, we have an ordinary class `WannabeFunction` that
happens to define a method named `call()`.

{% highlight dart %}
class WannabeFunction implements Function {
  call (int a, int b) => a + b;
  apply(ArgumentDescriptor args) => this.call.apply(args);
}
{% endhighlight %}

The `call()` method is special, in that anyone who defines a `call()` method is
presumed to dynamically emulate a function. This allows us to use instances of
WannabeFunction as if they were functions which take two integer arguments:

{% highlight dart %}
var wf = new WannabeFunction();
wf(3, 4); // 7
{% endhighlight %}

The example above is rather trivial, and we would be better off writing a
function directly. However, there are cases where this ability can be quite
useful.  It is also core to the design philosophy of the Dart language:

* What matters about an object is its behavior. If object a has a procedural
interface that is compatible with that of another object b, a may
substitute for b.
* The interface of any kind of object can always be emulated by another
suitably defined object.

### How does it work?

When x(a<sub>1</sub>, .., a<sub>n</sub>) is evaluated, if it is a normal
function, it gets called in the normal way. If it isn't we just invoke `call()`
on it. If x supports a call() method with suitable arguments it gets called.

Otherwise, `noSuchMethod()` gets invoked. The default implementation of
noSuchMethod checks to see it it was invoked due to an attempt  to use call(),
and if so issues a helpful error message suggesting you might have wanted to use
a closure.

<section class="spec-commentary" markdown="1">
Why do we insist on `call()`? It looks like

    int operator () (int a) => a *2;

would work instead of

    int call (int a) => a * 2;

However, as shown below, we need to be able to closurize the operator (e.g.,
`f.call`) which doesn’t work for `()`. We don’t allow `f.()`.  Perhaps we could, but it is clearly too error prone.
</section>

## The apply() method

Actual function objects have an `apply()` method whose signature is defined in the
Function class defined as:

{% highlight dart %}
abstract class Function {
  apply(ArgumentDescriptor args);
}
{% endhighlight %}

where

{% highlight dart %}
class ArgumentDescriptor {
  final List positionalArguments;
  final Map<String, dynamic> namedArguments;

  ArgumentDescriptor(List this.positionalArguments,
                     Map<String, dynamic> this.namedArguments);
}
{% endhighlight %}

The ArgumentDescriptor class turns out to be useful in the mirror API as well
(see below). The apply method allows functions to be called in generic fashion.
Best practice for classes emulating functions is to implement Function and
define their own apply method.

{% highlight dart %}
class Int2Int implements Function {
  int call (int a) => a * 2; 

  // Another way to implement apply().
  apply(ArgumentDescriptor args) => this(args.positionalArguments[0]);
}
{% endhighlight %}

However, this is not essential. It is always possible to invoke such an object f
as a function using an ArgumentDescriptor by closurizing its call method and
calling apply on it:

    f.call.apply(args);

<section class="spec-commentary" markdown="1">
We could say that if you declare call(), apply() gets created for you. However,
this entails an undesirable degree of magic.  One has to deal with interactions
with user-defined apply() methods, whether locally declared or (worse)
inherited. Debuggers need to know how to display these synthetic apply()
methods, etc.
</section>

## Function types

An additional issue is how user-defined function classes relate to the type
system.  To simulate functions properly, we want them to be members of the
appropriate function type:

{% highlight dart %}
typedef UnaryFunction();
...
new WannabeFunction() is UnaryFunction; // true
{% endhighlight %}

Therefore, we decree that an object is a member of a function type if the
object’s class has a call() method and that operator is a member of the function
type.

## Interactions with noSuchMethod()

In Dart, you can customize how objects react to methods that are not explicitly
defined in their class chain by overriding `noSuchMethod()`. Here's an example
showing how you could use function emulation inside `noSuchMethod()`:

{% highlight dart %}
noSuchMethod(InvocationMirror msg) =>
      msg.memberName == 'foo' ? msg.invokeOn(bar())
                              : baz.apply(msg.arguments);
{% endhighlight %}

In the second line, `invokeOn()` handles the common case where you want to
forward the call to a particular object (in this case, the result of `bar()`).
The third line handles the case where you want to forward just the parameters to
another function. If `baz` doesn't implement Function and `apply()` as we
recommended above, then that code should instead be
`baz.call.apply(msg.arguments)`.

The only argument to `noSuchMethod()` is an `InvocationMirror`, which is
currently defined as follows:

{% highlight dart %}
abstract class InvocationMirror {

  final String memberName;
  final ArgumentDescriptor arguments;
  final bool isGetter;
  final bool isSetter;
  final bool isMethod;
  final bool isAccessor;

  invokeOn(Object o);
}
{% endhighlight %}

The boolean properties of `InvocationMirror` identify the syntactic form of the
method invocation, as the following table shows.

<!-- TODO: move this to stylesheet -->
<style type="text/css">
  .property-table { margin-bottom: 20px;}
  .property-table td {border: 1px solid #bbb; text-align: center;}
  .property-table td.true {background: #d9f2db;}
  .property-table td.false {background: #ffbfbf;}
</style>

<table class="property-table">
<tr>
  <th>&nbsp;</th>
  <th colspan="3">Form of method invocation</th>
</tr>
<tr>
  <th>&nbsp;</th><th>x.y</th><th>x.y = e</th><th>x.y(...)</th>
</tr>
<tr>
  <th align="left">isGetter</th>
  <td class="true"> true </td>   <!-- x.y -->
  <td class="false"> false </td> <!-- x.y = e -->
  <td class="false"> false </td> <!-- x.y(...) -->
</tr>
<tr>
  <th align="left">isSetter</th>
  <td class="false"> false </td> <!-- x.y -->
  <td class="true"> true </td>   <!-- x.y = e -->
  <td class="false"> false </td> <!-- x.y(...) -->
</tr>
<tr>
  <th align="left">isAccessor</th>
  <td class="true"> true </td>   <!-- x.y -->
  <td class="true"> true </td>   <!-- x.y = e -->
  <td class="false"> false </td> <!-- x.y(...) -->
</tr>
</tr>
  <th align="left">isMethod</th>
  <td class="false"> false </td> <!-- x.y -->
  <td class="false"> false </td> <!-- x.y = e -->
  <td class="true"> true </td>   <!-- x.y(...) -->
</tr>
</table>

It is important not to assume that `isMethod` means that a non-accessor was
being looked up, since in fact, Dart semantics mean that we would have called
`noSuchMethod()` only if neither a normal method nor a getter were found.
Likewise, `isGetter` does not imply a getter was being looked up; if a method
was present, it would be closurized and returned.

## Summary

This document describes how to define Dart classes that behave like functions.
This functionality is supported in Dart starting with the M1 release.

Here is what you'll need to know in order to
implement your own function type in Dart once the feature is implemented:

1.  Define a class with an operator named **call**. <br>
    The implementation of that operator defines
    what instances of your class will do
    when invoked as functions via the **()** syntax.
1.  As a matter of good style,
    have the class implement the **Function** interface,
    and define an **apply()** method.
    The easiest way to define `apply()` is:

{% highlight dart %}
apply(ArgumentDescriptor args) => this.call.apply(args);
{% endhighlight %}
