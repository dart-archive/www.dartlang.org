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
January 2012
(updated November 2012)</em>
</p>

This document describes how to define Dart classes
that behave like functions.
This functionality will be supported in Dart
starting with the M2 release.

#### Contents

1. [The call() method](#the-call-method)
1. [Function types](#function-types)
1. [The apply() method](#the-apply-method)
1. [Interactions with noSuchMethod()](#interactions-with-nosuchmethod)
1. [Summary](#summary)
{: .toc}

## The call() method

In the following example, we have an ordinary class `WannabeFunction` that
happens to define a method named `call()`.

{% highlight dart %}
class WannabeFunction {
  call(int a, int b) => a + b;
}
{% endhighlight %}

The call() method is special, in that anyone who defines a call() method is
presumed to dynamically emulate a function. This allows us to use instances of
WannabeFunction as if they were functions that take two integer arguments:

{% highlight dart %}
var wf = new WannabeFunction();
wf(3, 4); // 7
{% endhighlight %}

The example above is rather trivial, and we would be better off writing a
function directly. However, there are cases where this ability can be quite
useful.  It is also core to the design philosophy of the Dart language:

* What matters about an object is its behavior. If object _a_ has a procedural
interface that is compatible with that of another object _b_, _a_ may
substitute for _b_.
* The interface of any kind of object can always be emulated by another
suitably defined object.

### How does it work?

When x(a<sub>1</sub>, .., a<sub>n</sub>) is evaluated, if it is a normal
function, it gets called in the normal way. If it isn't we just invoke call()
on it. If x supports a call() method with suitable arguments it gets called.

Otherwise, `noSuchMethod()` gets invoked. The default implementation of
noSuchMethod() checks to see whether it was invoked due to an attempt to use call(),
and if so issues a helpful error message suggesting you might have wanted to use
a closure.


## The apply() method

The class Function defines the static method `apply()`
with the following signature:

{% highlight dart %}
external static apply(Function function,
                      List positionalArguments,
                      [Map<String, dynamic> namedArguments]);
{% endhighlight %}

The apply() function allows functions to be called in generic fashion.


## Function types

An additional issue is how user-defined function classes relate to the type
system.  To simulate functions properly, we want them to be members of the
appropriate function type:

{% highlight dart %}
typedef BinaryFunction(a,b);
...
new WannabeFunction() is BinaryFunction; // true
{% endhighlight %}

Therefore, we decree that an object is a member of a function type if the
object’s class has a call() method and that method is a member of the function
type.

## Interactions with noSuchMethod()

In Dart, you can customize how objects react to methods that are not explicitly
defined in their class chain by overriding noSuchMethod(). Here's an example
showing how you could use function emulation inside noSuchMethod():

{% highlight dart %}
noSuchMethod(InvocationMirror msg) =>
    msg.memberName == 'foo' ? msg.invokeOn(bar())
                            : Function.apply(baz,
                                msg.positionalArguments,
                                msg.namedArguments);
{% endhighlight %}

In the second line, `invokeOn()` handles the common case where you want to
forward the call to a particular object (in this case, the result of `bar()`).
The remaining lines handle the case where you want to forward just the parameters to
another function. If you know `baz` doesn't take any named arguments,
then that code can instead be
`Function.apply(baz, msg.positionalArguments)`.

The only argument to noSuchMethod() is an `InvocationMirror`, which is
currently defined as follows:

{% highlight dart %}
abstract class InvocationMirror {
  String get memberName;
  List get positionalArguments;
  Map<String, dynamic> get namedArguments;
  bool get isMethod;
  bool get isGetter;
  bool get isSetter;
  bool get isAccessor => isGetter || isSetter;

  invokeOn(Object receiver);
}
{% endhighlight %}

The boolean properties of InvocationMirror identify the syntactic form of the
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
</tr>
  <th align="left">isMethod</th>
  <td class="false"> false </td> <!-- x.y -->
  <td class="false"> false </td> <!-- x.y = e -->
  <td class="true"> true </td>   <!-- x.y(...) -->
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
</table>

It is important not to assume that `isMethod` means that a non-accessor was
being looked up, since in fact, Dart semantics mean that we would have called
noSuchMethod() only if neither a normal method nor a getter were found.
Likewise, `isGetter` does not imply a getter was being looked up; if a method
was present, it would be closurized and returned.

## Summary

This document describes how to define Dart classes that behave like functions.
This functionality will be supported in Dart starting with the M2 release.

Here is what you'll need to know in order to
implement your own function type in Dart once the feature is implemented:

1.  Define a class with a method named **call**.
1.  Implement the call() method to define
    what instances of your class do
    when invoked as functions via the **()** syntax.
1.  As a matter of good style,
    have the class implement the **Function** interface.
