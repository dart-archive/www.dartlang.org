---
layout: article
title: "Unit Testing with Dart"
rel:
  author: graham-wheeler
description: "Using Dart's unit test library for synchronous and
asynchronous tests."
has-permalinks: true
article:
  written_on: 2012-06-01
  updated_on: 2013-07-23
  collection: libraries-and-apis
---

{% include toc.html %}

# {{ page.title }}

_Written by Graham Wheeler <br />
June 2012 (updated July 2013)_


Dart includes a unit test library that is easy to use, adaptable, and
supports both synchronous and asynchronous tests.
This article describes
how to write and run tests, and how testing fits into the overall Dart
ecosystem.

For more information, see the
[unit test library API documentation](http://api.dartlang.org/unittest.html).

## Differences from the earlier library

The unit test library is not new, but has undergone some changes.
If you
have been using the library or the Expect class in dart:core, here are the
main changes to bear in mind:

* `setUp` and `tearDown` functions are now chained in nested groups
* the format of test failure messages has changed to have 'Expected' and 'Actual' lines,
  with an optional 'Which' line containing additional info;
  this latter line corresponds to the old 'But' line that was not previously optional



## A simple unit test example

For those who want to jump right to it, let's start with an example.
Let's say we are writing a quicksort algorithm in Dart and want to test it.
Open the Dart editor, create a new application "quicksort",
then change the "quicksort.dart" file to look as follows:

{% prettify dart %}
import 'package:unittest/unittest.dart';

// NOTE: This code purposely has errors to illustrate unittest further below.

int _partition(List array, int left, int right, int pivotIndex) {
  var pivotValue = array[pivotIndex];
  array[pivotIndex] = array[right];
  array[right] = pivotValue;
  var storeIndex = left;
  for (var i = left; i < right; i++) {
    if (array[i] < pivotValue) {
      var tmp = array[i];
      array[i] = array[storeIndex];
      array[storeIndex] = tmp;
    }
  }
  var tmp = array[storeIndex];
  array[storeIndex] = array[right];
  array[right] = tmp;
  return storeIndex;
}

void _quickSort(List array, int left, int right) {
  if (left < right) {
    int pivotIndex = left + ((right-left) / 2);
    pivotIndex = _partition(array, left, right, pivotIndex);
    _quickSort(array, left, pivotIndex-1);
    _quickSort(array, pivotIndex+1, right);
  }
}

List quickSort(List array) {
  _quickSort(array, 0, array.length-1);
  return array;
}

void main() {
  test('QuickSort', () =>
    expect(quickSort([5, 4, 3, 2, 1]),
      orderedEquals([1, 2, 3, 4, 5]))
  );
}
{% endprettify %}

There are a couple of problems with this code
that we will use unit tests to discover.
To begin, we have just one test in `main()`,
which asserts that a 5-element array is
properly sorted after calling `quickSort`.
Note how the test is written:
we wrap it in a call to `test()` with this form:

{% prettify dart %}
test(String testName, functionToTest);
{% endprettify %}

Within the function we are testing, we write assertions, using `expect()`:

{% prettify dart %}
expect(actualValue, expectedValueMatcher);
{% endprettify %}

`expect()` is modelled on third-generation assert libraries like
[Hamcrest](http://http//code.google.com/p/hamcrest/).
It also borrows some ideas
from Ladislav Thon's early Dart matcher library, darmatch.

The second argument to expect is what we call a "matcher".
It can be a scalar value, or a special matcher function,
of which the library provides many;
in our case we are using `orderedEquals()`,
which matches against an Iterable object in index order.

When we run this application in checked mode,
we see output similar to this:

    unittest-suite-wait-for-done
    ERROR: QuickSort
      Test failed: Caught type 'double' is not a subtype of type 'int' of 'pivotIndex'.
      quicksort.dart 24:27  _quickSort
      quicksort.dart 32:13  quickSort
      quicksort.dart 38:21  main.<fn>
      dart:async             _createTimer.<fn>

    0 PASSED, 0 FAILED, 1 ERRORS

Following this is a line:

    Uncaught Error: Exception: Some tests failed.

followed by a stack trace.
We can ignore this for now;
the default behavior of the unittest library is
to throw an exception at the end if any tests did not succeed,
and the stack trace relates to that.

The 'unittest-suite-wait-for-done' line is used by the library
to communicate with test harnesses that host it
and can be ignored for now.

Notice that the test wasn't reported as failing;
it was reported as having an error.
The unittest library distinguishes between
a test that is 'well-behaved' but fails its expectations
and those that throw due to unexpected runtime errors.
Our quicksort currently is of the second type.

The problem here was this line:

{% prettify dart %}
int pivotIndex = left + ((right-left) / 2);
{% endprettify %}

The right hand side is a double, which we can't assign to int.
We can fix this by changing the line to this:

{% prettify dart %}
int pivotIndex = left + ((right-left) ~/ 2);
{% endprettify %}

Running the test again, we see:

    FAIL: QuickSort
      Expected: equals [1, 2, 3, 4, 5] ordered
        Actual: [3, 5, 2, 4, 1]
         Which: was <3> instead of <1> at location [0]

(We are omitting the initial line, stack dump,
and summary details here for brevity).

This tells us that we have a bug (in this case a failed expectation),
but doesn't help us find it.
We need to dig deeper.

The partition part of quicksort is given a pivot index
(which in turn maps to a pivot value),
and is meant to move all values less than
the pivot value to the left of the pivot,
and all values greater to the right of the pivot,
and then return the final position of the pivot value.
So if we passed [3, 2, 1] and pivot index 1 (i.e. pivot value 2),
after partitioning we should have [1, 2, 3]
and the returned pivot index should still be 1.
Let's test that, by adding a second test.
Change `main()` by adding the highlighted code below:

{% prettify dart %}
void main() {
  test('QuickSort', () =>
    expect(quickSort([5, 4, 3, 2, 1]),
      orderedEquals([1, 2, 3, 4, 5]))
  );
[[highlight]]  test('Partition', () {
    List array = [3, 2, 1];
    int index = _partition(array, 0, array.length-1, 1);
    expect(index, equals(1));
    expect(array, orderedEquals([1, 2, 3]));
  });[[/highlight]]
}
{% endprettify %}

If we run this again, we still see the first test fail, but now we also see:

    FAIL: Partition
      Expected: <1>
        Actual: <0>

So there is a problem with `_partition`.
We did not get to the second `expect()`; the first one failed.
If we look carefully at the code,
we can see that `_partition` returns the final value of `storeIndex`,
which is initialized to the value of `left`.
Look more carefully,
and we can see that `storeIndex`
doesn't have its value changed after initialization -
which explains why we got a returned index of 0 after passing in 0 for left.
Clearly we missed something here.
The hazards of writing algorithms from memory! Off to Wikipedia...

A bit of research shows the problem.
The loop in `_partition` is meant to increment `storeIndex`:

{% prettify dart %}
for (var i = left; i < right; i++) {
  if (array[i] < pivotValue) {
    var tmp = array[i];
    array[i] = array[storeIndex];
    array[storeIndex++] = tmp;
  }
}
{% endprettify %}

After making that change and running the app again, we see happiness:

    PASS: QuickSort
    PASS: Partition

    All 2 tests passed.

We can easily run this from the command line using the
[standalone Dart virtual machine](/docs/dart-up-and-running/contents/ch04-tools-dart-vm.html).
If you want to test the exit code from the standalone VM, add this import:

{% prettify dart %}
import 'package:unittest/vm_config.dart';
{% endprettify %}

and add a line in `main()` before the tests:

{% prettify dart %}
useVMConfiguration();
{% endprettify %}

This will result in a zero exit code if all tests pass
or a 1 exit code upon test failure.
See [Configuring the test environment](#configuring-the-test-environment)
later for more details.
You can run the test with the command:

    dart Quicksort.dart

If you prefer the Dart editor environment
and want to run your tests in the browser, add this import:

{% prettify dart %}
import 'package:unittest/html_config.dart';
{% endprettify %}

and add a line before the tests:

{% prettify dart %}
useHtmlConfiguration();
{% endprettify %}

<aside class="alert alert-warning" markdown="1">
**Important:**
Import and use **only one configuration.**
If you import multiple configuration files,
your tests won't run.
</aside>

Test results will be displayed in the Dartium window,
and exit codes are shown in the editor's Debugger tab.

The rest of this article dives deeper into the unit test library.

## Basic synchronous tests

Tests are created using the top level function `test()`.
This function takes a name for the test and a function to execute.
Typically the calls to `test()` would be in a `main()` function
or in a function called from `main()`.
In contrast to some libraries
where reflection is used to determine unit test functions,
in `unittest` they must be explicitly created by calling `test()`.

Here is a trivial example to illustrate the syntax of `test()`:

{% prettify dart %}
import 'package:unittest/unittest.dart';
main() {
 test('An empty test', () {
   // a test with expectations and matchers
 });
}
{% endprettify %}

This test doesn't do anything useful and will always pass.
Note that test functions take no arguments and might not return any value;
if a value is returned it is ignored unless it is a Future;
more on that later.

Of course, a real test will have some content
in the body of the test function,
and that body will usually be making assertions
about the state of the system under test.
To express such assertions we use `expect()`.
`expect()` is typically called with two arguments:
an actual value and a "matcher"
that tests if the value satisfies some constraint.
For example:

{% prettify dart %}
test('Addition test', () {
  expect(2 + 2, equals(5));
});
{% endprettify %}

If the matcher fails then a `TestFailure` object is thrown,
which will be caught and handled by the unit test framework as a test failure.
Later we will see how this behavior of `expect()` can be customized
to use it in other contexts.

If you want to simply pass a predicate to `expect()`,
you can use the `isTrue` matcher, as in:

{% prettify dart %}
test('Addition test', () {
  expect(2 + 2 == 5, isTrue);
});
{% endprettify %}

However, if you use matchers with more granularity,
`expect()` generates a useful descriptive message upon failure,
which is passed as an argument to the TestFailure constructor.
When using a predicate form like the above,
`expect()` has no useful information to do this with.
So in the second case, the description will simply be:

      Expected: true
        Actual: <false>

while in the first case it is the more descriptive:

      Expected: <5>
        Actual: <4>

It is possible to pass an additional string argument to `expect()`
(using either form) which will be appended to the output,
and doing so is strongly encouraged
if using the predicate form to improve the resulting output.
The additional argument is a named argument called `reason`.
For example:

{% prettify dart %}
test('Addition test', () => expect(2 + 2 == 5, isTrue, reason:'Two twos are not five'));
{% endprettify %}

which results in:

      Expected: true
        Actual: <false>
      Two twos are not five

There are circumstances when the simple predicate form is sufficient.
For example, if you have code that should be unreachable, then you can use:

{% prettify dart %}
expect(false, isTrue, reason:'Unreachable');
{% endprettify %}

Another case might be where you have a complex predicate
that would be too tedious to write using composite matchers,
or where the predicate is implemented by a function,
and where a simpler text description is useful.
For example:

{% prettify dart %}
expect(isPrime(x), isTrue, reason:'${x} is not prime');
{% endprettify %}

There are a large set of possible matchers that can be used with `expect()`,
and it is possible to create custom ones.
In fact, matchers can be composed to create more complex matchers.
Matchers will be discussed in more detail later in this article.

Note that `test()` calls cannot be nested;
each call to `test()` defines one and only one test.

`expect` can take two other optional named arguments:
`failureHandler` and `verbose`.
The latter is a boolean flag that if set
can result in more verbose error messages in some cases
(for example, some container matchers will output the full contents
of the actual container if a mismatch occurs and `verbose` is set).
The `failureHandler` argument will be discussed later
in the section on custom failure handlers.

## Grouping tests

It can be helpful to group similar tests together,
which can be done with `group()`.
The `group()` function has a similar form to `test()`,
taking a name and a function as arguments,
with the function containing the tests in the group.
For example:

{% prettify dart %}
group('My test group', () {
  test('Test 1', () => expect(0, equals(1));
  test('Test 2', () => expect(1, equals(0));
});
{% endprettify %}

Test names have their group names prepended;
in this case, the first test has the name 'My test group Test 1'
and the second test has the name 'My test group Test 2'.
Test groups can be nested (with multiple group names prepended).
The default separator used
to concatenate group names and test names is a space,
but you can change this by
setting the `groupSep` top-level String variable in unittest.

Groups are not themselves tests,
and so should not include assertions or calls to expect()
outside of the contained tests.

## Setup and teardown

Inside a group body, or at the top level in `main()`,
you can call setUp() and/or tearDown() with function arguments.
The function passed as an argument to setUp() will be called before each test,
and that passed to tearDown() will be called after each test.

Usually you would set these up at the start of the group:

{% prettify dart %}
group('foo', () {
  setUp(() {/*...*/});
  tearDown(() {/*...*/});
  test(description, () {/*...*/});
  /*...*/
});
{% endprettify %}

However you can interlace them differently;
each test function will use the most recently set values.

Whenever a new group is started, these functions are reset.
This applies for nested groups too.
Nested groups inherit these functions
but can augment them by in turn calling `setUp()` or `tearDown()`;
parent setUp functions will be called before child ones,
and parent tearDown functions will be called after child ones.
The code below shows examples of nested setUp/tearDown functions and
how by calling setUp more than once
the setUp function used by a test can be altered:

{% prettify dart %}
group('outer', () {
  test('outer test 1', () => print('outer test 1'));
  setUp(() => print('outer setup 1'));
  tearDown(() => print('outer teardown 1'));
  test('outer test 2', () => print('outer test 2'));
  setUp(() => print('outer setup 2'));
  tearDown(() => print('outer teardown 2'));
  test('outer test 3', () => print('outer test 3'));
  group('inner', () {
    test('inner test 1', () => print('inner test 1'));
    setUp(() => print('inner setup 1'));
    tearDown(() => print('inner teardown'));
    test('inner test 2', () => print('inner test 2'));
    setUp(() => print('inner setup 2'));
    test('inner test 3', () => print('inner test 3'));
    setUp(() => print('inner setup 3'));
  });
});
{% endprettify %}

The output is:

    outer test 1
    outer setup 1, outer test 2, outer teardown 1
    outer setup 2, outer test 3, outer teardown 2
    outer setup 2, inner test 1, outer teardown 2
    outer setup 2, inner setup 1, inner test 2, inner teardown, outer teardown 2
    outer setup 2, inner setup 2, inner test 3, inner teardown, outer teardown 2

In the output above,
all lines relating to a single test have been coalesced for brevity.

If your setUp/tearDown functions need to perform asynchronous operations,
you can do that by having them return a Future.
Execution of tests will be paused until the Future is complete.
If a setUp or tearDown fails, that will be considered a test error.
Note that if a setUp or test function fails,
any corresponding tearDown function will still be called.
Tests that have failed setUp or tearDown functions
will report an ERROR rather than a FAIL.

## Running a limited set of tests

The Dart unittest library provides a mechanism
to quickly run just one unit test.
This is useful if you have a failing test
that you want to explore in the debugger,
and you want to remove the distraction of other tests.
To isolate a test,
change the name of the call for that test from `test()` to `solo_test()`.
If there is one `solo_test()` call
then only that test will be run
(if you mistakenly have more than one `solo_test()`
then an exception will be thrown).
Similarly, you can rename a call to `group()` to `solo_group()`
to isolate execution to just that single group.
To exclude tests, you can rename calls to `test()` or `group()`
to `skip_test()` or `skip_group()`, respectively.

Another way of reducing the set of tests which are run
is to call the `filterTests` function.
This function can take a `RegExp` argument,
or a `String` argument that is used to create a `RegExp`,
which in turn is matched against each test description;
only those tests that match will be run.

A third way of limiting the tests is
to set or clear the `enabled` flag on a test case.
Each call to `test()` creates a new TestCase object
in the top-level `testCases` list.

## Asynchronous tests

So far all of the tests shown have been synchronous;
that is, the test function body runs to completion
and when it returns the test is done.
To test asynchronous code,
we need a way to tell the test framework
that it should not consider a test complete until some condition has been met;
typically this would be either the completion of a Future
or one or more callbacks being called a certain number of times.

Say we have this code in our application:

{% prettify dart %}
new Timer(new Duration(milliseconds:100), checkProgress);
{% endprettify %}

Also say that we want to test whether Timer calls the checkProgress function.
The following test would pass, but it wouldn't do what we want:

{% prettify dart %}
// BAD TEST
test('Timer test', () {
  new Timer(new Duration(milliseconds:100), checkProgress);
});
{% endprettify %}

The test has no assertion or other check to tell
that checkProgress was ever fired.
We need to have the test understand that
it is testing asynchronous code,
and then either succeed if the callback is executed
or fail after some time has elapsed and nothing has happened.

Here is an example of expectAsync0:

{% prettify dart %}
test('Window timeout test', () {
  new Timer(new Duration(milliseconds:100), expectAsync0(checkProgress));
});
{% endprettify %}

When this test starts to run, it calls `new Timer` and passes a closure,
created by `expectAsync0`, as the event handler.
This closure will in turn call `checkProgress()`.
If `checkProgress()` throws an exception
the closure catches it and marks the test as failed.
The test is not considered complete until either
the closure is executed or the test framework times out and fails the test.
Note that the timing out of the test is not something
that is handled by the unittest library itself at this time;
it is normally implemented by test harnesses
that manage the execution of tests.

`expectAsyncN()` can take an additional count argument
to specify how many times the callback must be called
before the test is considered complete.
For example:

{% prettify dart %}
test('Double callback', () {
  var callback = expectAsync0(foo, count: 2);
  new Timer(new Duration(milliseconds:100), callback);
  new Timer(new Duration(milliseconds:100), callback);
});
{% endprettify %}

There are times when we have callbacks that we don't expect to be called.
For example, consider a function that takes two callback arguments,
and only one of them will be called
(for example, onSuccess and onFailure handlers).
Even though we don't expect one of the callbacks to be called,
we still need to guard the code
so that the test library handles exceptions that may be thrown in that code.
We can do this by wrapping the callback we don't expect to be called
with `protectAsyncN()`.
Note that in this case, if that callback was called,
it would not terminate the test unless an exception was thrown,
so it is a good idea in such cases
to add a failing expectation in the callback:

{% prettify dart %}
test('two callbacks', () {
  my_function(/* ... */,
    successCallback:
        expectAsync1(() {}),
    errorCallback:
        protectAsync1((e) =>
            expect(true, isFalse, reason: 'Should not be reached')));
});
{% endprettify %}

A call to the error callback would signify the end of this test,
while a call to the success callback would not,
unless an exception was thrown in that code.
This is why it is a good idea to have a failing expectation in that code
if the test will otherwise not terminate.

An alternative is to use `guardAsync(fn)`,
which executes the function `fn` within a try/catch block
so that any exceptions are reported to the test library.
For example we could have used:

{% prettify dart %}
errorCallback:
    (e) => guardAsync(() {
      expect(true, isFalse, reason: 'Should not be reached');
    }));
{% endprettify %}

We might have a callback that's called an undetermined number of times, where
only a test can tell us when it's the last time.
For these cases we can use `expectAsyncUntilN()` (where N is 0, 1 or 2).
These functions take a second predicate function argument
that should return false if more callbacks are expected
or true if all callbacks are done.

These functions can all take a named 'id' argument
that will be used in error messages to identify the callback.
This is particularly useful for anonymous closures or in minified code;
for named functions or methods
the framework will use the function or method name as the default id.

In addition to the use of guarded callbacks,
you can make a test asynchronous by returning a Future.
The test will only be considered complete after the Future is complete.
You can combine returning a Future with calls to expectAsyncN, if necessary.


## Matchers

So far we have only looked at the `equals(v)` matcher.
The Dart unittest library contains a large set of predefined matchers,
which we will look at briefly now.
The Dart SDK documentation contains details for each matcher.
Note that a number of matchers can in turn take matchers as their arguments;
in these cases simple values can be used too,
and they will automatically be wrapped in `equals(v)` matchers.
For example:

{% prettify dart %}
expect(foo, hasLength(6));
{% endprettify %}

is turned into:

{% prettify dart %}
expect(foo, hasLength(equals(6));
{% endprettify %}

The following simple matchers take no arguments,
and have mostly self-evident meanings:

    isNull
    isNotNull
    isTrue
    isFalse
    isAnything
    isEmpty
    isZero
    isNonZero
    isPositive
    isNonPositive
    isNegative
    isNonNegative

Be careful with `isTrue` and `isFalse`.
These test for equality with the corresponding Boolean values.
That means these would both fail:

{% prettify dart %}
expect(10, isTrue)
expect(10, isFalse)
{% endprettify %}

To test if something is not true, use:

{% prettify dart %}
isNot(isTrue)
{% endprettify %}

`isEmpty` works with Strings, Maps or Collections.

To test equality or identity, respectively, we have these matchers:

    equals(expected)
    same(expected)

For numeric inequality, we have:

    greaterThan(v)
    greaterThanOrEqualTo(v)
    lessThan(v)
    lessThanOrEqualTo(v)
    closeTo(value, delta)
    inInclusiveRange(low, high) // low <= actual <= high
    inExclusiveRange(low, high) // low < actual < high
    inOpenClosedRange(low, high) // low < actual <= high
    inClosedOpenRange(low, high) // low <= actual < high

For string matching, we have:

    equalsIgnoringCase(v)
    equalsIgnoringWhitespace(v)
    startsWith(prefix)
    endsWith(suffix)
    stringContainsInOrder(List<String> substrings)
    matches(regexp)

`equalsIgnoringWhitespace(v)` normalizes whitespace runs to single spaces
first and trims off leading and trailing whitespace.


For objects that have a length property, we have this matcher:

    hasLength(m)

m here can be a value or a matcher;
e.g `hasLength(6)` or `hasLength(greaterThan(5))`.

For testing whether functions throw exceptions, we have:

    throws
    throwsA(m)
    returnsNormally

`throwsA` takes a matcher argument which will be matched against the exception;
an example is shown in the next paragraph.
`returnsNormally` will swallow any thrown exception
and throw a `TestFailure` instead
with details of the inner exception including the stack trace.

For type checking, we have:

    new isInstanceOf<T>()

For example:

{% prettify dart %}
test('Exception type', () {
    expect(()=> throw 'X',
    throwsA(new isInstanceOf<String>()));
});
{% endprettify %}

Note that the error messages produced by isInstanceOf
will not include the name of the type T,
so it is a good idea to include a reason in the call to `expect()`.
If you match against a particular type more than once,
you may want to create a custom matcher for it, as follows:

{% prettify dart %}
class _IsFoo extends TypeMatcher {
  const _IsFoo() : super('Foo');
  bool matches(item, Map matchState) => item is Foo;
}
const isFoo = const _IsFoo();

expect(x, isFoo);
{% endprettify %}

Custom matchers will be discussed in more detail later.

As the usual case is to throw an exception,
there are predefined matchers for a number of the core exception types and for functions that may throw them:

    isException
    throwsException
    isFormatException
    throwsFormatException
    isArgumentError
    throwsArgumentError
    isRangeError
    throwsRangeError
    isNoSuchMethodError
    throwsNoSuchMethodError
    isUnimplementedError
    throwsUnimplementedError
    isStateError
    throwsStateError
    isUnsupportedError
    throwsUnsupportedError

So for example we can write:

{% prettify dart %}
test('Range Error', () {
    expect(()=> throw new RangeError("out of range"),
        throwsRangeError);
});

{% endprettify %}

For matching the inner content of compound objects,
we have a number of matchers, starting with the ubiquitous `equals()`:

    equals(object, [depth])

This works with scalars, Maps, and iterables
(which should match in order).
The depth parameter is to deal with cyclic structures;
after [depth] comparisons the match will fail if it has not already terminated.
The default depth is 100.


Here is an example, taken from the JSON parse tests:

{% prettify dart %}
expect(JSON.parse('{"x": {"a":3, "b": -4.5}, "y":[{}], '
               '"z":"hi","w":{"c":null,"d":true}, "v":null}'),
  equals({"x": {"a":3, "b": -4.5}, "y":[{}],
               "z":"hi","w":{"c":null,"d":true}, "v":null}));
{% endprettify %}

For testing just a subpart of an object, we can use:

    contains(m)

This works with Strings (matches substrings),
Maps (matches if the Map has that key),
or Collections (matches if some element in the collection is a match).
In the latter case m can be a matcher, e.g.:

{% prettify dart %}
expect([1, 2, 3, 4], contains(isNonZero));
{% endprettify %}

The converse matcher to `contains()` is `isIn()`.

    everyElement(m)
    someElement(m)

These work on collections.
m can be a value or a matcher.
E.g.:

{% prettify dart %}
expect(foo, someElement(greaterThan(10)));
{% endprettify %}

For any Iterable:

    orderedEquals(Iterable expected)
    unorderedEquals(Iterable expected)

Note that `unorderedEquals` is O(n^2)
and should be used with care on larger objects.

For Maps:

    containsValue(v)
    containsPair(key, valueOrMatcher)

There are some operators for combining or inverting matchers:

    isNot(matcher)
    allOf(List<Matcher> matchers)
    anyOf(List<Matcher> matchers)

The `allOf()` and `anyOf()` represent AND/OR operations.
They can take a list of matchers or several individual matcher or scalar arguments (limited to 7 in the latter case).

Finally, there is a `predicate` matcher,
which allows you to use arbitrary functions:

    predicate(fn, reason)

For example, an alternative way to create a type matcher is:

{% prettify dart %}
var isString = predicate((e) => e is String, 'is a String');

expect(() => throw 'X', throwsA(isString));
{% endprettify %}


### Creating custom matchers

Should the set of matchers provided by default be insufficient,
it is possible to create your own.
A matcher implements or extends the `Matcher` class:

{% prettify dart %}
abstract class Matcher {
  /** This does the matching of the actual vs expected values. */
  bool matches(item, Map matchState);
  /** This builds a textual description of the matcher. */
  Description describe(Description description);
  /**This builds a textual description of a specific mismatch. */
  Description describeMismatch(item, Description mismatchDescription,
      MatchState matchState, bool verbose) => mismatchDescription;
}
{% endprettify %}

Here is an example of a custom matcher
that matches string prefixes while ignoring whitespace runs:

{% prettify dart %}
class PrefixMatcher extends Matcher {
  final String _prefix;
  PrefixMatcher(prefix) : this._prefix = collapseWhitespace(prefix);
  bool matches(item, Map matchState) {
    return item is String &&
        collapseWhitespace(item).startsWith(_prefix);
  }
  Description describe(Description description) =>
    description.add('a string starting with ').
        addDescriptionOf(collapseWhitespace(_prefix)).
        add(' ignoring whitespace');
}
{% endprettify %}

There are three important parts to this:

* the constructor, which needs to take in any expected value information
  or a matcher that is used to test the expected value
* the `matches(item, Map matchState)` method, which matches an actual value
  and returns true if the match is good and false otherwise
* the `describe()` method, which generates a textual description of the matcher

Recall a typical error message from `expect()` looks like:

    Expected: <matcher description>
      Actual: <value>
       Which: <mismatch description>

The `describe()` method of the matcher is used
to build the “Expected:" part of the error message,
while the "Which:" part is generated by the `describeMismatch()` method,
for which Matcher has a default implementation that produces no "Which:" part.

Both `describe()` and `describeMismatch()` use the Description class,
which has the following useful methods:

* `add(text)`, which appends the text to the description
* `addDescriptionOf(value)`, which describes a value,
  possibly recursively calling `describe()` if the value is a matcher
* `addAll(start, separator, end, list)`, which appends the contents of list
  (an `Iterable`),
  formatting it with the provided start, end, and separator characters

The matchState Map can be used to pass match failure information
that is costly to compute back from `matches` to `describeMismatch`.
In most cases it is not needed.
Take a look at the library source to see some examples of how it is used;
for example see `everyElement`.

In many cases you can quickly make a new Matcher by creating a derived class of
`CustomMatcher`.
This class lets you provide
a feature name and description, a Matcher, and a function
to get the value of the feature from some object,
and will have instances that can match that feature against the Matcher.
This is best illustrated by example.
Say we have a class `Widget`, where each `Widget` has a `price`,
and we want to make assertions about widget prices.
We can create a custom matcher for widget prices as follows:

{% prettify dart %}
class _Price extends CustomMatcher {
  _Price(matcher) : super('Widget with price that is', 'price', matcher);
  featureValueOf(actual) => actual.price;
}
Matcher price(m) => new _Price(wrapMatcher(m));
{% endprettify %}

`wrapMatcher` is a function that will
return the value it is passed if it is a `Matcher`,
or create an `equals()` `Matcher` from that value otherwise.

You could then use this like in the following examples:

{% prettify dart %}
expect(widget, price(greaterThan(0)));

var isFree = price(0);
expect(special, isFree);
{% endprettify %}

Other simple ways of making custom matchers are by using
the TypeMatcher class as described earlier for type matchers,
or the predicate function.
For example, if we had a Rectangle class
that had `length`, `width` and `area` properties,
and wanted to be able to assert that the area was computed correctly,
we could use:

{% prettify dart %}
var hasCorrectArea = predicate((rect) => rect.area == rect.length * rect.width,
    "has correct area");

expect(myRect, hasCorrectArea);
{% endprettify %}

## Configuring the test environment

Depending on whether you are running tests from the command line,
within the editor, or from a browser,
you may want to change how the output is generated
(print versus HTML markup, for example).
To do this you need to configure the test environment,
which you do by setting `unittestConfiguration` to
an appropriate instance of a `Configuration` class.
A Configuration has several functions
that get called at different times during the test process:

* `onInit()` is called when the test framework is initialized,
  before any tests are added
* `onStart()` is called before the first test is run
* `onTestResult(TestCase)` is called upon completion of each test
* `onDone(passed, failed, errors, List<TestCase> results, String uncaughtError)`
  is called when all tests are done;
  in the default configuration this prints the test summary

You don't need to create your own `Configuration` classes;
the library has several built-in which should be adequate for most purposes.
These are:

* the default `Configuration`,
  which prints test results to standard output
* `VMConfiguration`,
  which exits the process with a return value of 1 upon failure;
  useful in particular for driving tests from other programs or scripts
  where the return code of the process is useful to detect success or failure;
  call `useVMConfiguration()` to use this, and import `vm_config.dart`
* `HtmlConfiguration`,
  which puts test results in an HTML table
  and sets the browser document body to be this table;
  call `useHtmlConfiguration()` to use this, and import `html_config.dart`
* `HtmlEnhancedConfiguration`,
  which is similar to `HtmlConfiguration`
  but provides a richer layout;
  call `useHtmlEnhancedConfiguration()` to use this,
  and import `html_enhanced_config.dart`
* `HtmlInteractiveConfiguration`,
  which provides a rich in-browser layout
  with the ability to enable/disable tests and rerun tests;
  call `useHtmlInteractiveConfiguration()` to use this,
  and import `html_enhanced_config.dart`

For running tests in a continuous integration environment,
the default or VM configurations are most useful.

The base configuration class has some flags
that can be modified before the first call to `test()` to modify its behavior:

* `autoStart` controls whether tests should be started automatically
  (default true).
  If this is set to false no tests will be run until you call `runtests()`.
* `throwOnTestFailures` controls whether an exception is
  thrown at the end of all the tests if any tests did not succeed
  (default true).
* `stopTestOnExpectFailure` controls whether an expectation failure
  will cause a test to be terminated and the next test to be run
  (default true).
  If set to false,
  the test will keep running after an expectation failure
  (any other exception will still stop the test).
  The expectation failure messages are buffered
  and all output at the end of the test.


## Using expect() in other contexts

While `expect()` has been used here in the context of unit tests,
it is possible to use it in other contexts as a general assertion mechanism.
The default behavior is to throw a `TestFailure` object upon failure
with the failure reason as the message property,
but that can be customized.
In fact, expect has its own unit tests that do just this.

There are two functions that can be used to customize the behavior of expect:

* `configureExpectFailureHandler` is used to change the object
  that handles `expect()` failures.
  The default object simply throws TestFailures.
  It may be desirable to do something different;
  for example to log the error and swallow the exception instead.
* `configureExpectFormatter` is used to change the function
  that `expect()` uses to format error messages.
  It is rare that this would need to change
  and it will not be considered further here;
  see the SDK documentation for details.

The easiest way to customize the error handler is
to create a class that inherits from `DefaultFailureHandler`
and overrides this method:

{% prettify dart %}
void fail(String reason) {
  throw new TestFailure(reason);
}
{% endprettify %}

For example, this failure handler just keeps a count of the number of failures:

{% prettify dart %}
class MyFailureHandler extends DefaultFailureHandler {
  int errorCount;
  MyFailureHandler() {
    errorCount = 0;
    // set this to be the expect() failure handler
    configureExpectFailureHandler(this);
  }
  void fail(String reason) {
    ++errorCount;
  }
}
{% endprettify %}

Apart from the default failure handler,
a reference to a failure handler can be explictly passed to an `expect()` call
using the `failureHandler` named argument.
