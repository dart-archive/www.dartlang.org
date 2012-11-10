---
layout: default
title: "Unit Testing with Dart"
rel:
  author: graham-wheeler
description: "Using Dart's unit test library for synchronous and asynchronous tests."
has-permalinks: true
---

# {{ page.title }}
_Written by Graham Wheeler <br />
June 2012 (updated November 2012)_


Dart includes a unit test library that is easy to use, adaptable, and supports both synchronous and asynchronous tests. This article describes how to write and run tests, and how testing fits into the overall Dart ecosystem.

## Contents

1. [Differences from the earlier library](#differences-from-the-earlier-library)
1. [A simple unit test example](#a-simple-unit-test-example)
1. [Basic synchronous tests](#basic-synchronous-tests)
1. [Grouping tests](#grouping-tests)
1. [Setup and teardown](#setup-and-teardown)
1. [Running a limited set of tests](#running-a-limited-set-of-tests)
1. [Asynchronous tests](#asynchronous-tests)
1. [Matchers](#matchers)
1. [Configuring the test environment](#configuring-the-test-environment)
1. [Using expect() in other contexts](#using-expect-in-other-contexts)
{:.toc}

## Differences from the earlier library

The unit test library is not new, but has undergone some changes. If you have been using the library or the Expect class in dart:core, here are the main changes to bear in mind:

* `asyncTest` is deprecated and will soon go away; instead write your async tests with `test()` and use `expectAsync` and/or guardAsync for callbacks
* the syntax of `expect()` has changed, and a large set of matchers is now available for use with `expect()`
* `expectThrows` is deprecated and will soon go away, instead use the `throws` or `throwsA()` matchers with `expect()`
* the `Expect` class in dart:core is deprecated except for internal use, and `expect()` should be used instead

The new `expect()` is modelled on 3rd generation assert libraries like
[Hamcrest](http://http//code.google.com/p/hamcrest/), and borrows some ideas
from Ladislav Thon's [dart-matcher](https://github.com/Ladicek/dart-matchers)
library.

## A simple unit test example

For those who want to jump right to it, let's start with an example. Let's say we are writing a quicksort algorithm in Dart and want to test it. Open the Dart editor, create a new application "quicksort", then change the "quicksort.dart" file to look as follows:

{% highlight dart %}
import 'package:/unittest/unittest.dart';

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
{% endhighlight %}

There are a couple of problems with this code that we will use unit tests to discover. To begin, we have just one test in `main()` which asserts that a 5-element array is properly sorted after calling `quickSort`. Note how the test is written: we wrap it in a call to `test()` with this form:

{% highlight dart %}
test(String testName, functionToTest);
{% endhighlight %}

Within the function we are testing, we write assertions, using `expect()`:

{% highlight dart %}
expect(actualValue, expectedValueMatcher);
{% endhighlight %}

The second argument to expect is what we call a "matcher". It can be a scalar value, or a special matcher function, of which the library provides many; in our case we are using `orderedEquals()` which matches against an Iterable object in index order.

When we run this application in checked mode, we see output similar to this:

    FAIL: QuickSort
      Caught type 'double' is not a subtype of type 'int' of 'pivotIndex'.
      #0      _quickSort (file:///home/gram/quicksort.dart:25:27)
      #1      quickSort (file:///home/gram/quicksort.dart:33:13)
      #2      main.<anonymous closure> (file:///home/gram/quicksort.dart:39:21)

    0 PASSED, 1 FAILED, 0 ERRORS
    Exception: Exception: Some tests failed.

The remainder of the stack trace is in the unit test library and not relevant, 
and has been omitted above.

The problem here was this line:

{% highlight dart %}
int pivotIndex = left + ((right-left) / 2);
{% endhighlight %}

The right hand side is a double, which we can't assign to int. We can fix this by changing the line to this:

{% highlight dart %}
int pivotIndex = left + ((right-left) / 2).toInt();
{% endhighlight %}

Running the test again, we see:

    FAIL: QuickSort
      Expected: equals <[1, 2, 3, 4, 5]> ordered
           but: was <3> mismatch at position 0.
  
(We are omitting the stack traces and summary details here for brevity).

This tells us that we have a bug, but doesn't help us find it. We need to dig deeper. 

The partition part of quicksort is given a pivot index (which in turn maps to a pivot value), and is meant to move all values less than the pivot value to the left of the pivot, and all values greater to the right of the pivot, and then return the final position of the pivot value. So if we passed [3,2,1] and pivot index 1 (i.e. pivot value 2), after partitioning we should have [1,2,3] and the returned pivot index should still be 1. Let's test that, by adding a second test. Change `main()` by adding the code in bold below:

{% highlight dart %}
void main() {
  test('QuickSort', () =>
    expect(quickSort([5, 4, 3, 2, 1]),
      orderedEquals([1, 2, 3, 4, 5]))
  );
  test('Partition', () {
    List array = [3, 2, 1];
    int index = _partition(array, 0, array.length-1, 1);
    expect(index, equals(1));
    expect(array, orderedEquals([1, 2, 3]));
  });
}
{% endhighlight %}

If we run this again, we still see the first test fail, but now we also see:

    FAIL: Partition
      Expected: <1>
           but: was <0>

So there is a problem with partition. We did not get to the second `expect()`; the first one failed. If we look carefully at the code, we can see that `_partition` returns the final value of `storeIndex`, which is initialized to the value of `left`. Look more carefully, and we can see that `storeIndex` doesn't have its value changed after initialization - which explains why we got a returned index of 0 after passing in 0 for left. Clearly we missed something here. The hazards of writing algorithms from memory! Off to Wikipedia...

A bit of research shows the problem. The loop in `_partition` is meant to increment `storeIndex`:

{% highlight dart %}
for (var i = left; i < right; i++) {
  if (array[i] < pivotValue) {
    var tmp = array[i];
    array[i] = array[storeIndex];
    array[storeIndex++] = tmp;
  }
}
{% endhighlight %}

After making that change and running the app again, we see happiness:

    PASS: QuickSort
    PASS: Partition

    All 2 tests passed.

We can easily run this from the command line using the
[standalone Dart virtual machine](http://www.dartlang.org/docs/standalone-dart-vm/).
If you want to test the exit code from the standalone VM, add this import:

{% highlight dart %}
import 'package:unittest/vm_config.dart';
{% endhighlight %}

and add a line before the tests:

{% highlight dart %}
useVmConfiguration();
{% endhighlight %}

This will result in a zero exit code if all tests pass or a 1 exit code upon test failure. See [Configuring the test environment](#configuring-the-test-environment) later for more details. You can run the test with the command:

    dart Quicksort.dart

If you prefer the Dart editor environment and want to run your tests in the browser, add this import:

{% highlight dart %}
import 'package:unittest/html_config.dart';
{% endhighlight %}

and add a line before the tests:

{% highlight dart %}
useHtmlConfiguration();
{% endhighlight %}

Test results will be displayed in the Dartium window and exit codes are shown in the editor's Debugger tab.

The rest of this article dives deeper into the unit test library.

## Basic synchronous tests

Tests are created using the top level function `test()`. This function takes a name for the test and a function to execute. Typically the calls to `test()` would be in a `main()` function or in a function called from `main()`. In contrast to some languages where reflection is used to determine unit test functions, in Dart they must be explicitly called.

Here is a trivial example to illustrate the syntax of `test()`:

{% highlight dart %}
import 'package:unittest/unittest.dart';
main() {
 test('An empty test', () {
   // a test with expectations and matchers
 });
}
{% endhighlight %}

This test doesn't do anything useful and will always pass. Note that test functions takes no arguments and return no value; if a value is returned it is ignored.

Of course, a real test will have some content in the body of the test function, and that body will usually be making assertions about the state of the system under test. To express such assertions we use `expect()`. `expect()` is typically called with two arguments: an actual value and a "matcher" that tests if the value satisfies some constraint. For example:

{% highlight dart %}
test('Addition test', () {
  expect(2 + 2, equals(4));
});
{% endhighlight %}

If the matcher fails then an ExpectException is thrown, which will be caught and handled by the unit test framework as a test failure. Later we will see how this behavior of `expect()` can be customized to use it in other contexts.

If you want to simply pass a predicate to `expect()`, you can use the `isTrue` matcher, as in:

{% highlight dart %}
test('Addition test', () {
  expect(2 + 2 == 5, isTrue);
});
{% endhighlight %}

However, if you use matchers with more granularity, `expect()` generates a useful descriptive message upon failure, which is passed as an argument to the ExpectException constructor. When using a predicate form like the above, `expect()` has no useful information to do this with. So in the second case, the description will simply be:

    Expected: true
         But: was <false>

while in the first case it is the more descriptive:

    Expected: a value equal to 5
         But: was <4>

It is possible to pass an additional string argument to `expect()` (using either form) which will be appended to the output, and doing so is strongly encouraged if using the predicate form to improve the resulting output. The additional argument is a named argument called `reason`. For example:

{% highlight dart %}
test('Addition test', () => expect(2 + 2 == 5, isTrue, reason:'Two twos are not five'));
{% endhighlight %}

which results in:

   Assertion failed
   Two twos are not five

There are circumstances when the simple predicate form is sufficient. For example, if you have code that should be unreachable, then you can use:

{% highlight dart %}
expect(false, isTrue, reason:'Unreachable');
{% endhighlight %}

Another case might be where you have a complex predicate that would be too tedious to write using composite matchers, or where the predicate is implemented by a function, and where a simpler text description is useful. For example:

{% highlight dart %}
expect(isPrime(x), isTrue, reason:'${x} is not prime');
{% endhighlight %}

There are a large set of possible matchers that can be used with `expect()`, and it is possible to create custom ones. In fact, matchers can be composed to create more complex matchers. Matchers will be discussed in more detail later in this article.

Note that `test()` calls cannot be nested; each call to `test()` defines one and only one test. 

`expect` can take two other optional named arguments: `failureHandler` and `verbose`. The latter is a boolean flag that if set will result in more verbose error messages in some cases (for example, some container matchers will output the full contents of the actual container if a mismatch occurs and `verbose` is set). The `failureHandler` argument will be discussed later in the section on custom failure handlers.

## Grouping tests


It can be helpful to group similar tests together, which can be done with `group()`. The `group()` function has a similar form to `test()`, taking a name and a function as arguments, with the function containing the tests in the group. For example:

{% highlight dart %}
group('My test group', () {
  test('Test 1', () => expect(0, equals(1));
  test('Test 2', () => expect(1, equals(0));
});
{% endhighlight %}

Test names have their group names prepended; in this case, the first test has the name 'My test group Test 1' and the second test has the name 'My test group Test 2'. Test groups can be nested (with multiple group names prepended).

Groups are not themselves tests, and so should not include assertions or calls to expect() outside of the contained tests.

## Setup and teardown

Inside a group body, in addition to calling test() you can call setUp() and/or tearDown() with function arguments. The function passed as an argument to setUp() will be called before each test, and that passed to tearDown() will be called after each test.

Usually you would set these up at the start of the group:

{% highlight dart %}
group('foo', () {
  setUp(() {...});
  tearDown(() {...});
  test(description, () {...});
  ...
});
{% endhighlight %}

However you can interlace them differently; each test() will use the most recently set values. 

Whenever a new group is started these functions are reset. This applies for nested groups too. Nested groups do not inherit these functions or augment them; they get their own. This is the most flexible approach as chaining can always be done explicitly.

## Running a limited set of tests

The Dart unittest library provides a mechanism to quickly run just one unit test. This is useful if you have a failing test that you want to explore in the debugger, and you want to remove the distraction of other tests. To isolate a test, change the name of the call for that test from `test()` to `solo_test()`. If there is one `solo_test()` call then only that test will be run (if you mistakenly have more than one `solo_test()` then an exception will be thrown).

Another way of reducing the set of tests which are run is to call the `filterTests` function. This function can take a `RegExp` argument, or a `String` argument that is used to create a `RegExp`, which in turn is matched against each test description; only those tests that match will be run. To filter, you must disable the automatic execution of tests before any calls to `group()` or `test()` iby setting `config.autorun` to false.  If you have not imported a unittest config library like `html_config.dart`, you will need to create a default configuration first; in this case use:

{% highlight dart %}
ensureInitialized();
config.autorun = false;
{% endhighlight %}

Then, after setting up all your tests with `test()` and `group()`, call `filterTests()` with an appropriate filter, and finally start running the tests with:

{% highlight dart %}
runTests();
{% endhighlight %}

A third way of limiting the tests is to set or clear the `enabled` flag on a test case. Each call to `test()` creates a new test case in an array, which can be accessed with `testCases`. Look at the `html_interactive_config.dart` library for an example of how this is used; this library will run tests in the browser and allow you to select a subset of tests to rerun (and the tests can be edited in between executions, allowing for a quick edit/test cycle).


## Asynchronous tests


So far all of the tests shown have been synchronous; that is, the test function body runs to completion and when it returns the test is done. What about testing asynchronous code? We need a way to tell the test framework that it should not consider a test complete until one or more callbacks have been run a certain number of times.

Say we have this code in our application:

{% highlight dart %}
window.setTimeout(checkProgress, 100);
{% endhighlight %}

and we want to test whether window.setTimeout calls the checkProgress function. If we just write:

{% highlight dart %}
test('Window timeout test', () {
  window.setTimeout(checkProgress, 100); 
});
{% endhighlight %}

the test will pass, but in fact is not doing what we want. There is no assertion or other check to tell that checkProgress was ever fired. We need to have the test understand that it is testing asynchronous code, and then either succeed if the callback is executed or fail after some time has elapsed and nothing has happened.

The unit test library provides expectAsyncN (where N is the number of arguments) for asynchronous tests.

Here is an example of expectAsync0:

{% highlight dart %}
test('Window timeout test', () {
  window.setTimeout(expectAsync0(checkProgress), 100); 
});
{% endhighlight %}

When this test starts to run, it calls `window.setTimeout` and passes a closure, created by `expectAsync0`, as the event handler. This closure will in turn call `checkProgress()`. If `checkProgress()` throws an exception the closure catches it and mark the test as failed. The test is not considered complete until either the closure is executed or the test framework times out and fails the test.

`expectAsyncN()` can take an additional count argument to specify how many times the callback must be called before the test is considered complete. For example:

{% highlight dart %}
test('Double callback', () {
  var callback = expectAsync0(foo, count: 2);
  window.setTimeout(callback, 0);
  window.setTimeout(callback, 0);
});
{% endhighlight %}

There are times when we have callbacks that we don't expect to be called. For example, consider a function that takes two callback arguments, and only one of them will be called (a common example would be onSuccess and onFailure handlers). Even though we don't expect some callback to be called, we still need to guard the code so that the test harness handles the failure case where it is called. We can do this with `expectAsyncN()` with a count parameter of zero. For example:

{% highlight dart %}
test('getDirectory', () {
  fs.root.getDirectory('nonexistent', flags:{},
    successCallback:
        expectAsync1((e) => 
            expect(false, 'Should not be reached'), count:0),
    errorCallback:
        expectAsync1((e) =>
            expect(e.code, equals(FileError.NOT_FOUND_ERR)));
});
{% endhighlight %}

An alternative is to use `guardAsync(fn)`, which executes the function `fn` within a try/catch block so that any exceptions are reported to the test library. For example we could have used:

{% highlight dart %}
successCallback:
    (e) => guardAsync(() { expect(false, 'Should not be reached'); }),
{% endhighlight %}

We might have a callback that's called an undetermined number of times, where
only a test can tell us when it's the last time. For these cases we can use `expectAsyncUntilN()` (where N is 0, 1 or 2). These functions take a second function argument which should return false if more callbacks are expected or true if all callbacks are done.


## Matchers


So far we have only looked at the `equals(v)` matcher. The Dart unittest library contains a large set of predefined matchers, which we will look at briefly now. The Dart SDK documentation contains details for each matcher. Note that a number of matchers can in turn take matchers as their arguments; in these cases simple values can be used too, and they will automatically be wrapped in `equals(v)` matchers. For example:

{% highlight dart %}
expect(foo, hasLength(6));
{% endhighlight %}

is turned into:

{% highlight dart %}
expect(foo, hasLength(equals(6));
{% endhighlight %}

The following simple matchers take no arguments, and have mostly self-evident meanings:

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

Be careful with `isTrue` and `isFalse`. These test for equality with the corresponding Boolean values. That means these would both fail:

{% highlight dart %}
expect(10, isTrue)
expect(10, isFalse)
{% endhighlight %}

To test if something is not true, use:

{% highlight dart %}
isNot(isTrue)
{% endhighlight %}

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

`equalsIgnoringWhitespace(v)` normalizes whitespace runs to single spaces first and trims off leading and trailing whitespace. 

For objects that have a length property, we have this matcher:

    hasLength(m)

m here can be a value or a matcher; e.g `hasLength(6)` or `hasLength(greaterThan(5))`.

For testing whether functions throw exceptions, we have:

    throws
    throwsA(m)
    returnsNormally

`throwsA` takes a matcher argument which will be matched against the exception; an example is shown in the next paragraph. `returnsNormally` will swallow any thrown exception and throw an `ExpectException` instead with details of the inner exception including the stack trace.

For type checking, we have:

    new isInstanceOf<T>()

For example:

{% highlight dart %}
test('Exception type',
    expect(()=> throw 'X',
        throwsA(new isInstanceOf<String>()));
{% endhighlight %}

<aside>
  <div class="alert alert-info">
    <strong>Note:</strong>
    `isInstance` and `throwsA` currently
    work in the Dart VM only; they do not work in Dart compiled to Javascript.
    In that case the best bet for now is to use predicate matchers which will be
    described later.
  </div>
</aside>

As the usual case is to throw an exception, there are predefined matchers for a number of the core exception types (these do work with dart2js):

    throwsException
    throwsFormatException
    throwsArgumentError
    throwsIllegalJSRegExpException
    throwsRangeError
    throwsIndexOutOfRangeException
    throwsNoSuchMethodError
    throwsUnimplementedError
    throwsNullPointerException
    throwsUnsupportedError

So for example we can write:

{% highlight dart %}
test('Null Exception',
    expect(()=> throw new NullPointerException(),
        throwsNullPointerException));
{% endhighlight %}

For matching the inner content of compound objects, we have a number of matchers, starting with the ubiquitous `equals()`:

    equals(object, [depth])

This works with scalars, Maps and iterables (which should match in order). The depth parameter is to deal with cyclic structures; after [depth] comparisons the match will fail if it has not already terminated. The default depth is 100. 

Here is an example, taken from the JSON parse tests:

{% highlight dart %}
expect(JSON.parse('{"x": {"a":3, "b": -4.5}, "y":[{}], '
               '"z":"hi","w":{"c":null,"d":true}, "v":null}'),
  equals({"x": {"a":3, "b": -4.5}, "y":[{}],
               "z":"hi","w":{"c":null,"d":true}, "v":null}));
{% endhighlight %}

For testing just a subpart of an object, we can use:

    contains(m)

This works with Strings (matches substrings), Maps (matches if the Map has that key) or Collections (matches if some element in the collection is a match). In the latter case m can be a matcher, e.g.:

{% highlight dart %}
expect([1, 2, 3, 4], contains(isNonZero));
{% endhighlight %}

The converse matcher to `contains()` is `isIn()`.

    everyElement(m)
    someElement(m)

These work on collections. m can be a value or a matcher. E.g.:

{% highlight dart %}
expect(foo, someElement(greaterThan(10)));
{% endhighlight %}

For any Iterable:

    orderedEquals(Iterable expected)
    unorderedEquals(Iterable expected)

Note that `unorderedEquals` is O(n^2) and should be used with care on larger objects.

For Maps:

    containsValue(v)
    containsPair(key, valueOrMatcher)

There are some operators for combining or inverting matchers:

    isNot(matcher)
    allOf(List<Matcher> matchers)
    anyOf(List<Matcher> matchers)

The `allOf()` and `anyOf()` represent AND/OR operations. They can take a list of matchers or several individual matcher or scalar arguments (limited to 7 in the latter case).

Finally, there is a `predicate` matcher, which allows you to use arbitrary functions:

    predicate(fn, reason)

This can be used to solve the problems with isInstance/throwsA in dart2js. For example:


{% highlight dart %}
expect(() => throw 'X',
    throwsA(predicate((e) => e is String, 'is a String')));
{% endhighlight %}


### Creating custom matchers

Should the set of matchers provided by default be insufficient, it is possible to create your own. A matcher implements the `Matcher` interface:

{% highlight dart %}
abstract class Matcher {
  /** This does the matching of the actual vs expected values. */
  bool matches(item, MatchState matchState);
  /** This builds a textual description of the matcher. */
  Description describe(Description description);
  /**This builds a textual description of a specific mismatch. */
  Description describeMismatch(item, Description mismatchDescription,
      MatchState matchState, bool verbose);
}
{% endhighlight %}

In most cases rather than extending this interface you would implement a subclass of `BaseMatcher`, to reduce the number of necessary methods that must be implemented from 3 to 2:

{% highlight dart %}
abstract class BaseMatcher implements Matcher {
  const BaseMatcher();
  bool matches(item, MatchState matchState);
  Description describe(Description mismatchDescription);
  Description describeMismatch(item, Description mismatchDescription,
      MatchState matchState, bool verbose) =>
    mismatchDescription.add('was ').addDescriptionOf(item);
}
{% endhighlight %}

Here is an example of a custom matcher that matches string prefixes while ignoring whitespace runs:

{% highlight dart %}
class PrefixMatcher extends BaseMatcher {
  final String _prefix;
  PrefixMatcher(prefix) {
    this._prefix = collapseWhitespace(_prefix);
  }
  bool matches(item, MatchState matchState) {
    return item is String &&
        collapseWhitespace(item)).startsWith(_prefix);
  }
  Description describe(Description description) =>
    description.add('a string starting with ').
        addDescriptionOf(collapseWhitespace(_prefix)).
        add(' ignoring whitespace');
}
{% endhighlight %}

There are three important parts to this:

* the constructor which needs to take in any expected value information or a matcher that is used to test the expected value;
* the `matches(item, MatchState matchState)` method which matches an actual value, and returns true if the match is good and false otherwise;
* the `describe()` method, which generates a textual description of the matcher.

Recall a typical error message from `expect()` looks like:

    Expected: a value equal to 5
         But: was <4>

The `describe()` method of the matcher is used to build the “Expected:" part of the error message, while the "But:" part is generated by the `describeMismatch()` method, for which BaseMatcher has a default implementation that is good enough for most cases.

Both `describe()` and `describeMismatch()` use the Description class, which has the following useful methods:

* `add(text)` which appends the text to the description;
* `addDescriptionOf(value)` which describes a value, possibly recursively calling `describe()` if the value is a matcher;
* `addAll(start, separator, end, list)` which appends the contents of list (an `Iterable`), formatting it with the provided start, end and separator characters.

MatchStates are used to pass match failure information that is costly to compute back from `matches` to `describeMismatch`. In most cases it is not used. Take a look at the
library source to see some examples of how it is used; for example see `everyElement`.

In many cases you can quickly make a new Matcher by creating a derived class of
`CustomMatcher`; see the API documentation for details and an example.

## Configuring the test environment

Depending on whether you are running tests from the command line, within the editor, or from a browser, you may want to change how the output is generated (print versus HTML markup, for example). To do this you need to configure the test environment, which you do by calling `configure()`. `configure()` takes a Configuration object argument; a Configuration has several functions that get called at different times during the test process:

* `onInit()` which is called when the test framework is initialized, before any tests are added;
* `onStart()` which is called before the first test is run;
* `onTestResult(TestCase)` which is called upon completion of each test;
* `onDone(passed, failed, errors, List<TestCase> results, String uncaughtError)` which is called when all tests are done; in the default configuration this prints the test summary.

You don't need to create your own `Configuration` classes; the library has several built-in which should be adequate for most purposes. These are:

* the default `Configuration`, which prints test results to standard output;
* `VmConfiguration`, which exits the process with a return value of 1 upon failure; useful in particular for driving tests from other programs or scripts where the return code of the process is useful to detect success or failure; call `useVmConfiguration()` to use this, and import `vm_config.dart`;
* `HtmlConfiguration`, which puts test results in an HTML table and sets the browser document body to be this table; call `useHtmlConfiguration()` to use this, and import `html_config.dart`;
* `HtmlEnhancedConfiguration`, which is similar to `HtmlConfiguration` but provides a richer layout; call `useHtmlEnhancedConfiguration()` to use this, and import `html_enhanced_config.dart`.
* `HtmlInteractiveConfiguration`, which provides a rich in-browser layout with the ability to enable/disable tests and rerun tests; call `useHtmlInteractiveConfiguration()` to use this, and import `html_enhanced_config.dart`.

For running tests in a continuous integration environment, the default or VmConfigurations are most useful. 

## Using `expect()` in other contexts

While `expect()` has been used here in the context of unit tests, it is possible to use it in other contexts as a general assertion mechanism. The default behavior is to throw an `ExpectException` upon failure with the failure reason as the message property, but that can be customized. In fact, expect has its own unit tests that do just this.

There are two functions that can be used to customize the behavior of expect:

* `configureExpectHandler` - this is used to change the object which handles `expect()` failures. The default object simply throws ExpectExceptions. It may be desirable to do something different; for example to log the error and swallow the exception instead.
* `configureExpectFormatter` - this is used to change the function which is used to format error messages by `expect()`. It is rare that this would need to change and it will not be considered further here; see the SDK documentation for details.

The easiest way to customize the error handler is to create a class that inherits from `DefaultFailureHandler` and overrides this method:

{% highlight dart %}
void fail(String reason) {
  throw new ExpectException(reason);
    }
{% endhighlight %}

For example, this failure handler just keeps a count of the number of failures:

{% highlight dart %}
class MyFailureHandler extends DefaultFailureHandler {
  int errorCount;
  MyFailureHandler() {
    errorCount = 0;
    // set this to be the expect() failure handler
    configureExpectHandler(this);
  }
  void fail(String reason) {
    ++errorCount;
  }
}
{% endhighlight %}

Apart from the default failure handler, a reference to a failure handler can be explictly passed to an `expect()` call using the `failureHandler` named argument.

