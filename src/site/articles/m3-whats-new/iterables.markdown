---
layout: default
title: "Iterables"
description: "The Iterable API has changed, affecting all collections, such as lists and sets. Learn about the new API and how to update your code."
has-permalinks: true
rel:
  author: florian-loitsch
article:
  written_on: 2013-01-30
  collection: libraries-and-apis
---

# Iterables

<p>
<em>Written by Florian Loitsch <br>
January 2013</em>
</p>

With our recent big merge from experimental to the bleeding edge branch,
we added a lot of functionality to Iterable.
Given that all Collection classes (such as List and Set)
implement the Iterable interface,
this change had a big impact on many core classes.

This article summarizes the functions and getters
that are now available in Iterable.
You might also want to refer to the
[Iterable API documentation](http://api.dartlang.org/dart_core/Iterable.html).

#### Contents
1. [Methods that return new Iterables](#methods-that-return-new-iterables)
1. [Getters](#getters)
1. [Convenience methods](#convenience-methods)
1. [Iterator](#iterator)
1. [Porting your code](#porting-your-code)
{: .toc}


## Methods that return new Iterables

Iterable was extended with many Iterable-returning methods.
These are lazy methods in that they only wrap the original instance.
They do not immediately perform any work.
Instead, it is the iterators of the wrapping objects that do the actual work.
As a consequence it is possible to modify the original Iterable
(adding new elements, or deleting them)
and the wrapping iterable will see the changes.
(Of course, it is still not allowed to change an iterable
while an iteration is in progress.)

New methods include methods to skip the first elements
(`skip()` and `skipWhile()`),
or to ignore remaining elements
(`take()` and `takeWhile()`).
We furthermore moved the Collection methods `map()` and `filter()` to Iterable
and renamed `filter()` to `where()`.

<aside class="alert alert-info" markdown="1">
  <strong>Note:</strong>
  We initially renamed `map()` to `mappedBy()`.
  In response to feedback,
  we're undoing that name change.
</aside>

Both `map()` and `where()` are lazy now
and don’t allocate a new list or set.
Similar to the other Iterable-returning methods,
they just wrap the original Iterable.
The iterators of the wrapping iterable
perform the actual mapping and filtering.

<aside class="alert alert-info" markdown="1">
  <strong>Note:</strong>
  Wrapping iterables
  can change the complexity of seemingly constant operations.
  For example, `iterable.isEmpty` with `iterable = foo.where(predicate)`
  can be in O(n) if the predicate rejects all elements.
  Wrapping iterables are furthermore not allowed to cache their results,
  since the underlying iterable may change.
</aside>

## Getters

We have added some getters: `first`, `last`, and `single`.
(`single` is similar to `first`,
except that it verifies that there is no other element.)

The `length` getter has been pushed up from List and Set to Iterable.
(This move makes sense because
computing the length with an iterator is trivial.)
Similarly to `last`, `length` is a getter,
although it can have complexity O(n)
(and not even terminate if the Iterable is infinite).

<aside class="alert alert-info" markdown="1">
  <strong>Tip:</strong>
  To check whether an iterable is empty,
  **use `isEmpty` instead of `length == 0`.**
  However, although `isEmpty` is likely to be cheaper than `length`,
  even `isEmpty` can be expensive,
  as described in the previous section.
</aside>

### Implementing getters

The default implementation of the getters uses the iterator,
but subclasses are encouraged to shortcut the use of the iterator.
The List class, for instance,
has direct access to all of these elements
and thus doesn’t instantiate any iterator.

Implementations should shortcut even if
iterating over the elements has a side effect.
For example, `list.map(...).last` does not iterate over all elements,
but just maps the last element.
In general we shortcut as much as possible
and advise other implementers of Iterable to do the same.


## Convenience methods

We added some other convenience methods.
Most of them have a complexity linear in
the number of elements in the iterable.
Subclasses are however encouraged to improve the complexity wherever they can.

Since iterables are mostly lazy now,
it can be convenient to force the evaluation,
storing the result in a list or set.
The `toList()` and `toSet()` methods are intended for exactly this purpose.
They allocate a new list or set and store the iterable’s elements in it.
In the following example this forces the evaluation of the filtering,
but keeps the mapping lazy:

{% prettify dart %}
return myList
  .where(someExpensivePredicate)
  .toList()
  .map(someCheapTransformation);  
{% endprettify %}

<aside class="alert alert-info" markdown="1">
  <strong>Note:</strong>
  `toList()` and `toSet()` are guaranteed to return a new list or set.
  Thus, `myList.toList()` is an easy way to make a copy of `myList`.
</aside>

The `firstMatching()`, `lastMatching()`, and `singleMatching()` methods
are filtering counterparts to `first`, `last`, and `single`.
With the exception of the optional `orElse` parameter,
they could be implemented on top of `where` and, respectively,
`first`, `last`, and `single`.

The `elementAt()` method provides an easy way
to get to an element at a specific index.
By default it allocates an iterator
and simply moves to the next element until it reaches the given index.
The `contains()` method in Iterable, too,
is implemented by iterating over all elements,
and by checking whether an element is equal to the given key.

The methods `any()` (renamed from `some()`) and `every()`
have been moved from Collection to Iterable.
They check if any or all, respectively,
elements of the iterable satisfy a given predicate.

The `reduce()` method is a very flexible way
to combine all elements into a single value.
The method starts with a given initial value
and then combines sequentially each element with the previous value.

The methods `min()` and `max()`
(taking an optional comparator method)
find the smallest or largest element in the iterable.

Finally, `join()` calls `toString()` on all elements
and combines them into a string,
separated by an (optional) separator.

## Iterator

The interface of iterators has changed to the following:

{% prettify dart %}
abstract class Iterator<E> {
  bool moveNext();  // Moves to the next (potentially first) element.
  E get current;    // Returns the element of the last successful
                    // moveNext(); null otherwise.
}
{% endprettify %}

An iterator starts by pointing to a position before the first element.
Trying to get the current element simply returns null.
Invoking `moveNext()` then moves the iterator to the first element,
if there is one, and sets current to that value,
or moves to a position after the end,
if the iterable is empty,
and sets current to null.

### Implementing an iterator

Frequently Iterators are implemented as follows:

{% prettify dart %}
class MyIterator<E> implements Iterator<E> {
  E _current;
  var _position = -1;  // Before the first element.
  var _elementContainer;
  MyIterator(this._elementContainer);

  bool moveNext() {
    var newPosition = _position + 1;
    if (newPosition < _elementContainer.length) {
      _current = _elementContainer.getElementAt(newPosition);
      _position = newPosition;
      return true;
    }
    _position = _elementContainer.length;
    _current = null;
    return false;
  }

  E get current => _current;
}
{% endprettify %}

<aside class="alert alert-info" markdown="1">
  <strong>Note:</strong>
  The `current` getter cannot throw an exception;
  it just returns the element that has been set in `moveNext()`.
  All checking and important work is done in `moveNext()`.
  Also don’t forget to set your position
  to the position before the first element
  (a common mistake when porting iterators).
</aside>


## Porting your code

From our experience it should be relatively easy
to port pre-M3 code to the new Iterable API.
Most of the time it simply consists of
search/replacing the old names with their new ones.
There is however a small trap:
since iterable functions are now lazy,
you must verify that the result of filtering and mapping
can be used as an iterable.
If not, you must insert `toList()` or `toSet()`
after these transforming calls
to make sure that the iterable is evaluated eagerly.

As usual, [Dart Editor](http://www.dartlang.org/editor)
can help with the migration.
Select your project or file in Dart Editor,
choose **Clean Up Source** from the context menu,
and make sure **Migrate to 1.0 M3 library** is checked.
You can click **Next** to see the changes that will be made.
For example:

<img style="border:solid 1px black"
     alt="Clean Up dialog showing old and new code, side by side"
     src="imgs/cleanup.png" />

<aside class="alert alert-info" markdown="1">
  <strong>Note:</strong>
  This screenshot is from the brief period when
  `map()` was named `mappedBy()`.
  Dart Editor no longer suggests that change.
</aside>

We are excited about these improvements to Iterable
and believe that they are a big step forward for the core library.
We hope you feel the same way, and we’d like to hear your
[feedback](https://groups.google.com/a/dartlang.org/group/misc).
