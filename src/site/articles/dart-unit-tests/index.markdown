---
layout: default
title: "Unit Testing with Dart"
rel:
  author: graham-wheeler
description: "Using Dart's unit test library for synchronous and asynchronous tests."
---

# {{ page.title }}
_Written by Graham Wheeler <br />
June 2012_


Dart includes a unit test library that is easy to use, adaptable, and supports both synchronous and asynchronous tests. This article describes how to write and run tests, how testing fits into the overall Dart ecosystem, and what is coming next.

## Contents

1. [Differences from the earlier library](#differences-from-the-earlier-library)
1. [A simple unit test example](#a-simple-unit-test-example)
1. [Basic synchronous tests](#basic-synchronous-tests)
1. [Grouping tests](#grouping-tests)
1. [Running a single test](#running-a-single-test)
1. [Asynchronous tests](#asynchronous-tests)
1. [Matchers](#matchers)
1. [Configuring the test environment](#configuring-the-test-environment)
1. [Using expect() in other contexts](#using-expect-in-other-contexts)
1. [What's next](#whats-next)
{:.toc}

## Differences from the earlier library

The unit test library is not new, but has undergone some changes. If you have been using the library or the Expect class in dart:core, here are the main changes to bear in mind:

* asyncTest is deprecated and will soon go away; instead write your async tests with `test()` and use expectAsync and/or guardAsync for callbacks
* the syntax of `expect()` has changed, and a large set of matchers is now available for use with `expect()`
* expectThrows is deprecated and will soon go away, instead use the throws or `throwsA()` matchers with `expect()`
* the Expect class in dart:core is deprecated except for internal use, and `expect()` should be used instead

The new `expect()` is modelled on 3rd generation assert libraries like
[Hamcrest](http://http//code.google.com/p/hamcrest/), and borrows some ideas
from Ladislav Thon's [dart-matcher](https://github.com/Ladicek/dart-matchers)
library.

## A simple unit test example

For those who want to jump right to it, let's start with an example. Let's say we are writing a quicksort algorithm in Dart and want to test it. Open the Dart editor, create a new application "quicksort", then change the "quicksort.dart" file to look as follows
(you will need to set the appropriate path in the import at the start to point to the unit test library for your environment):

    #import('DART_SDK_PATH/lib/unittest/unittest.dart');

    int _Partition(List array, int left, int right, int pivotIndex) {
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

    void _QuickSort(List array, int left, int right) {
      if (left < right) {
        int pivotIndex = left + ((right-left) / 2);
        pivotIndex = _Partition(array, left, right, pivotIndex);
        _QuickSort(array, left, pivotIndex-1);
        _QuickSort(array, pivotIndex+1, right);
      }
    }

    List QuickSort(List array) {
      _QuickSort(array, 0, array.length-1);
      return array;
    }

    void main() {
      test('QuickSort', () =>
        expect(QuickSort([5, 4, 3, 2, 1]),
          orderedEquals([1, 2, 3, 4, 5]))
      );
    }

There are a couple of problems with this code that we will use unit tests to discover. To begin we have just one test in `main()` which asserts that a 5-element array is properly sorted after calling QuickSort. Note how the test is written: we wrap it in a call to `test()` with this form:

    test(String testName, functionToTest);

Within the function we are testing, we write assertions, using `expect()`:

    expect(actualValue, expectedValueMatcher);

The second argument to expect is what we call a "matcher". It can be a scalar value, or a special matcher function, of which the library provides many; in our case we are using `orderedEquals()` which matches against an Iterable object in index order.

When we run this application, we see output similar to this:

    FAIL: QuickSort
      Caught type 'Double' is not a subtype of type 'int' of 'pivotIndex'.
       0. Function: '::_QuickSort@3c1671e2' url: 'http://127.0.0.1:34677/usr/local/google/home/gram/dart/Quicksort/Quicksort.dart' line:23 col:27
       1. Function: '::QuickSort' url: 'http://127.0.0.1:34677/usr/local/google/home/gram/dart/Quicksort/Quicksort.dart' line:31 col:13
       2. Function: '::function' url: 'http://127.0.0.1:34677/usr/local/google/home/gram/dart/Quicksort/Quicksort.dart' line:37 col:21
       3. Function: '::function' url: 'http://127.0.0.1:34677/home/gram/svn/dart/lib/unittest/unittest.dart' line:545 col:20
       4. Function: '::guardAsync' url: 'http://127.0.0.1:34677/home/gram/svn/dart/lib/unittest/unittest.dart' line:509 col:19
  

    0 PASSED, 1 FAILED, 0 ERRORS
    Exception: Exception: Some tests failed.
    Stack Trace:  0. Function: 'Configuration.onDone' url: 'http://127.0.0.1:34677/home/gram/svn/dart/lib/unittest/config.dart' line:76 col:19
     1. Function: '::_completeTests@13cecf33' url: 'http://127.0.0.1:34677/home/gram/svn/dart/lib/unittest/unittest.dart' line:578 col:17
     2. Function: '::_nextBatch@13cecf33' url: 'http://127.0.0.1:34677/home/gram/svn/dart/lib/unittest/unittest.dart' line:559 col:17
     3. Function: '::function' url: 'http://127.0.0.1:34677/home/gram/svn/dart/lib/unittest/unittest.dart' line:499 col:16
     4. Function: '::function' url: 'http://127.0.0.1:34677/home/gram/svn/dart/lib/unittest/unittest.dart' line:482 col:13
     5. Function: '_ReceivePortImpl@6be832b._handleMessage@6be832b' url: 'dart:isolate' line:19 col:46

This has two parts - the first part prints the results for each test as it is run, and the second part is a summary of the whole test run, which repeats the information for the failed tests.

The problem here was this line:

    int pivotIndex = left + ((right-left) / 2);

The right hand side is a double, which we can't assign to int. We can fix this by changing the line to this:

    int pivotIndex = left + ((right-left) / 2).toInt();

Running the test again, we see:

    FAIL: QuickSort
      Expected: equals <[1, 2, 3, 4, 5]> ordered
           but: mismatch at position 0
  
(We are omitting the stack traces and summary details here for brevity).

This tells us that we have a bug, but doesn't help us find it. We need to dig deeper. 

The partition part of quicksort is given a pivot index (which in turn maps to a pivot value), and is meant to move all values less than the pivot value to the left of the pivot, and all values greater to the right of the pivot, and then return the final position of the pivot value. So if we passed [3,2,1] and pivot index 1 (i.e. pivot value 2), after partitioning we should have [1,2,3] and the returned pivot index should still be 1. Let's test that, by adding a second test. Change `main()` by adding the code in bold below:

    void main() {
      test('QuickSort', () =>
        expect(QuickSort([5, 4, 3, 2, 1]),
          orderedEquals([1, 2, 3, 4, 5]))
      );
      test('Partition', () {
        List array = [3, 2, 1];
        int index = _Partition(array, 0, array.length-1, 1);
        expect(index, equals(1));
        expect(array, orderedEquals([1, 2, 3]));
      });
    }

If we run this again, we still see the first test fail, but now we also see:

    FAIL: Partition
      Expected: <1>
           but: was <0>

So there is a problem with partition. We did not get to the second `expect()`; the first one failed. If we look carefully at the code, we can see that _Partition returns the final value of storeIndex, which is initialized to the value of left. Look more carefully, and we can see that storeIndex doesn't have its value changed after initialization - which explains why we got a returned index of 0 after passing in 0 for left. Clearly we missed something here. The hazards of writing algorithms from memory! Off to Wikipedia...

A bit of research shows the problem. The loop in _Partition is meant to increment storeIndex:

    for (var i = left; i < right; i++) {
      if (array[i] < pivotValue) {
        var tmp = array[i];
        array[i] = array[storeIndex];
        array[storeIndex++] = tmp;
      }
    }

After making that change and running the app again, we see happiness:

    PASS: QuickSort
    PASS: Partition

    All 2 tests passed.

We can easily run this from the command line using the
[standalone Dart virtual machine](http://www.dartlang.org/docs/standalone-dart-vm/).
If you want to test the exit code from the standalone VM, add this import (with the appropriate path):

    #import('dart/lib/unittest/vm_config.dart');

and add a line before the tests:

    useVmConfiguration();

This will result in a zero exit code if all tests pass or a 1 exit code upon test failure. See Configuring the Test Environment later for more details. You can run the test with the command:

    dart Quicksort.dart

The rest of this article dives deeper into the unit test library.

## Basic synchronous tests

Tests are created using the top level function `test()`. This function takes a name for the test and a function to execute. Typically the calls to `test()` would be in a `main()` function or in a function called from `main()`. In contrast to some languages where reflection is used to determine unit test functions, in Dart they must be explicitly called.

Here is a trivial example to illustrate the syntax of `test()`:

    #import('dart/lib/unittest/unittest.dart'); // Use an appropriate path
    main() {
     test('An empty test', () {
       // a test with expectations and matchers
     });
    }

This test doesn't do anything useful and will always pass. Note that test functions takes no arguments and return no value; if a value is returned it is ignored.

Of course, a real test will have some content in the body of the test function, and that body will usually be making assertions about the state of the system under test. To express such assertions we use `expect()`. `expect()` is typically called with two arguments: an actual value and a "matcher" that tests if the value satisfies some constraint. For example:

    test('Addition test', () {
      expect(2 + 2, equals(4));
    });

If the matcher fails then an ExpectException is thrown, which will be caught and handled by the unit test framework as a test failure. Later we will see how this behavior of `expect()` can be customized to use it in other contexts.

It is possible to simply pass a predicate to `expect()`, as in:

    test('Addition test', () {
      expect(2 + 2 == 5);
    });

However, if you use matchers, `expect()` generates a useful descriptive message upon failure, which is passed as an argument to the ExpectException constructor. When using the predicate form, `expect()` has no useful information to do this with. So in the second case, the description will simply be:

   Assertion failed

while in the first case it is the more descriptive:

    Expected: a value equal to 5
         But: was <4>

It is possible to pass an additional string argument to `expect()` (using either form) which will be appended to the output, and doing so is strongly encouraged if using the predicate form to improve the resulting output. When using the predicate form this argument must be named `reason`; when using matchers it can simply be the third positional argument. For example:

    test('Addition test', () => expect(2 + 2 == 5, reason:'Two twos are not five'));

which results in:

   Assertion failed
   Two twos are not five

There are circumstances when the predicate form is preferable to using matchers. If you have code that should be unreachable, then you can use:

    expect(false, reason:'Unreachable');

Another case might be where you have a complex predicate that would be too tedious to write using composite matchers, or where the predicate is implemented by a function, and where a simpler text description is useful. For example:

    expect(isPrime(x), reason:'${x} is not prime');

The latter example could be written as:

    expect(isPrime(x), isTrue, '${x} is not prime');

However in this case using the isTrue matcher is not adding any value. 

There are a large set of possible matchers that can be used with `expect()`, and it is possible to create custom ones. In fact, matchers can be composed to create more complex matchers. Matchers will be discussed in more detail later in this article.

Note that `test()` calls cannot be nested; each call to `test()` defines one and only one test. 

## Grouping tests


It can be helpful to group similar tests together, which can be done with `group()`. The `group()` function has a similar form to `test()`, taking a name and a function as arguments, with the function containing the tests in the group. For example:

    group('My test group', () {
      test('Test 1', () => expect(0, equals(1));
      test('Test 2', () => expect(1, equals(0));
    });

Test names have their group names prepended; in this case, the first test has the name 'My test group Test 1' and the second test has the name 'My test group Test 2'. Test groups can be nested (with multiple group names prepended).

Groups are not themselves tests, and so should not include assertions or calls to expect() outside of the contained tests.

## Setup and Teardown

Inside a group body, in addition to calling test() you can call setUp() and/or tearDown() with function arguments. The function passed as an argument to setUp() will be called before each test, and that passed to tearDown() will be called after each test.

Usually you would set these up at the start of the group:

    group('foo', () {
      setUp(() {...});
      tearDown(() {...});
      test(description, () {...});
      ...
    });

However you can interlace them differently; each test() will use the most recently set values. 

Whenever a new group is started these functions are reset. This applies for nested groups too. Nested groups do not inherit these functions or augment them; they get their own. This is the most flexible approach as chaining can always be done explicitly.

## Running a limited set of tests

The Dart unittest library provides a mechanism to quickly run just one unit test. This is useful if you have a failing test that you want to explore in the debugger, and you want to remove the distraction of other tests. To isolate a test, change the name of the call for that test from `test()` to `solo_test()`. If there is one `solo_test()` call then only that test will be run (if you mistakenly have more than one `solo_test()` then an exception will be thrown).

Another way of reducing the set of tests which are run is to use the `setFilter(pattern)` function. This function takes a `String` argument that is used to create a `RegExp`, which in turn is matched against each test description; only those tests that match will be run.

## Asynchronous tests


So far all of the tests shown have been synchronous; that is, the test function body runs to completion and when it returns the test is done. What about testing asynchronous code? We need a way to tell the test framework that it should not consider a test complete until one or more callbacks have been run a certain number of times.

Say we have this code in our application:

    window.setTimeout(checkProgress, 100);

and we want to test whether window.setTimeout calls the checkProgress function. If we just write:

    test('Window timeout test', () {
      window.setTimeout(checkProgress, 100); 
    });

the test will pass, but in fact is not doing what we want. There is no assertion or other check to tell that checkProgress was ever fired. We need to have the test understand that it is testing asynchronous code, and then either succeed if the callback is executed or fail after some time has elapsed and nothing has happened.

The unit test library provides expectAsyncN (where N is the number of arguments) for asynchronous tests.

Here is an example of expectAsync0:

    test('Window timeout test', () {
      window.setTimeout(expectAsync0(checkProgress), 100); 
    });

When this test starts to run, it calls `window.setTimeout` and passes a closure, created by `expectAsync0`, as the event handler. This closure will in turn call `checkProgress()`. If `checkProgress()` throws an exception the closure catches it and mark the test as failed. The test is not considered complete until either the closure is executed or the test framework times out and fails the test.

`expectAsyncN()` can take an additional count argument to specify how many times the callback must be called before the test is considered complete. For example:

    test('Double callback', () {
      var callback = expectAsync0(foo, count: 2);
      window.setTimeout(callback, 0);
      window.setTimeout(callback, 0);
    });

There are times when we have callbacks that we don't expect to be called. For example, consider a function that takes two callback arguments, and only one of them will be called (a common example would be onSuccess and onFailure handlers). Even though we don't expect some callback to be called, we still need to guard the code so that the test harness handles the failure case where it is called. We can do this with `expectAsyncN()` with a count parameter of zero. For example:

    test('getDirectory', () {
      fs.root.getDirectory('nonexistent', flags:{},
        successCallback:
            expectAsync1((e) => 
                expect(false, 'Should not be reached'), count:0),
        errorCallback:
            expectAsync1((e) =>
                expect(e.code, equals(FileError.NOT_FOUND_ERR)));
    });

We might have a callback that's called an undetermined number of times, where
only a test can tell us when it's the last time. For these cases we can use `expectAsyncUntilN()` (where N is 0, 1 or 2). These functions take a second function argument which should return false if more callbacks are expected or true if all callbacks are done.


## Matchers


So far we have only looked at the `equals(v)` matcher. The Dart unittest library contains a large set of predefined matchers, which we will look at briefly now. The Dart SDK documentation contains details for each matcher. Note that a number of matchers can in turn take matchers as their arguments; in these cases simple values can be used too, and they will automatically be wrapped in `equals(v)` matchers. For example:

    expect(foo, hasLength(6));

is turned into:

    expect(foo, hasLength(equals(6));

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

As types are not first class objects in Dart, this is a bit of a kludge but does the job. For example:

    test('Exception type',
        expect(()=> throw 'X',
            throwsA(new isInstanceOf<String>()));

As the usual case is to throw an exception, there are predefined matchers for a number of the core exception types:

    throwsBadNumberFormatException
    throwsException
    throwsIllegalArgumentException
    throwsIndexOutOfRangeException
    throwsNoSuchMethodException
    throwsNotImplementedException
    throwsNullPointerException
    throwsUnsupportedOperationException

So for example we can write:

    test('Null Exception',
        expect(()=> throw new NullPointerException(),
            throwsNullPointerException));

<aside>
  <div class="alert alert-info">
    <strong>Note:</strong>
    These type matchers (`isInstance` and `throwsA` plus its variants) currently
    work in the Dart VM only; they do not work in Dart compiled to Javascript.
  </div>
</aside>

For matching the inner content of compound objects, we have a number of matchers, starting with the ubiquitous `equals()`:

    equals(object, [depth])

This works with scalars, Maps and iterables (which should match in order). The depth parameter is to deal with cyclic structures; after [depth] comparisons the match will fail if it has not already terminated. The default depth is 100. 

Here is an example, taken from the JSON parse tests:

    expect(JSON.parse('{"x": {"a":3, "b": -4.5}, "y":[{}], '
                   '"z":"hi","w":{"c":null,"d":true}, "v":null}'),
      equals({"x": {"a":3, "b": -4.5}, "y":[{}],
                   "z":"hi","w":{"c":null,"d":true}, "v":null}));

For testing just a subpart of an object, we can use:

    contains(m)

This works with Strings (matches substrings), Maps (matches if the Map has that key) or Collections (matches if some element in the collection is a match). In the latter case m can be a matcher, e.g.:

    expect([1, 2, 3, 4], contains(isNonZero));

The converse matcher to `contains()` is `isIn()`.

    everyElement(m)
    someElement(m)

These work on collections. m can be a value or a matcher. E.g.:

    expect(foo, someElement(greaterThan(10)));

For any Iterable:

    orderedEquals(Iterable expected)
    unorderedEquals(Iterable expected)

Note that `unorderedEquals` is O(n^2) and should be used with care on larger objects.

For Maps:

    containsValue(v)
    containsPair(key, valueOrMatcher)

Finally, we have some operators for combining or inverting matchers:

    isNot(matcher)
    allOf(List<Matcher> matchers)
    anyOf(List<Matcher> matchers)

The `allOf()` and `anyOf()` represent AND/OR operations. They can take a list of matchers or several individual matcher or scalar arguments (limited to 7 in the latter case).

### Creating custom matchers

Should the set of matchers provided by default be insufficient, it is possible to create your own. A matcher implements the `Matcher` interface:

    interface Matcher {
      /** This does the matching of the actual vs expected values. */
      bool matches(item);
      /** This builds a textual description of the matcher. */
      Description describe(Description description);
      /**This builds a textual description of a specific mismatch. */
      Description describeMismatch(item, Description mismatchDescription);
    }

In most cases rather than extending this interface you would implement a subclass of `BaseMatcher`, to reduce the number of necessary methods that must be implemented from 3 to 2:

    class BaseMatcher implements Matcher {
      const BaseMatcher();
      abstract bool matches(item);
      abstract Description describe(Description mismatchDescription);
      Description describeMismatch(item, Description mismatchDescription) =>
        mismatchDescription.add('was ').addDescriptionOf(item);
    }

Here is an example of a custom matcher that matches string prefixes while ignoring whitespace runs:

    class PrefixMatcher extends BaseMatcher {
      final String _prefix;
      PrefixMatcher(prefix) {
        this._prefix = collapseWhitespace(_prefix);
      }
      bool matches(item) {
        return item is String &&
            collapseWhitespace(item)).startsWith(_prefix);
      }
      Description describe(Description description) =>
        description.add('a string starting with ').
            addDescriptionOf(collapseWhitespace(_prefix)).
            add(' ignoring whitespace');
    }

There are three important parts to this:

* the constructor which needs to take in any expected value information or a matcher that is used to test the expected value;
* the `matches(item)` method which matches an actual value, and returns true if the match is good and false otherwise;
* the `describe()` method, which generates a textual description of the matcher.

Recall a typical error message from `expect()` looks like:

    Expected: a value equal to 5
         But: was <4>

The `describe()` method of the matcher is used to build the “Expected:" part of the error message, while the "But:" part is generated by the `describeMismatch()` method, for which BaseMatcher has a default implementation that is good enough for most cases.

Both `describe()` and `describeMismatch()` use the Description class, which has the following useful methods:

* `add(text)` which appends the text to the description;
* `addDescriptionOf(value)` which describes a value, possibly recursively calling `describe()` if the value is a matcher;
* `addAll(start, separator, end, list)` which appends the contents of list (an `Iterable`), formatting it with the provided start, end and separator characters.

## Configuring the test environment

Depending on whether you are running tests from the command line, within the editor, or from a browser, you may want to change how the output is generated (print versus HTML markup, for example). To do this you need to configure the test environment, which you do by calling `configure()`. `configure()` takes a Configuration object argument; a Configuration has several functions that get called at different times during the test process:

* `onInit()` which is called when the test framework is initialized, before any tests are added;
* `onStart()` which is called before the first test is run;
* `onTestResult(TestCase)` which is called upon completion of each test;
* `onDone(passed, failed, errors, List<TestCase> results, String uncaughtError)` which is called when all tests are done; in the default configuration this prints the test summary.

You don't need to create your own `Configuration` classes; the library has several built-in which should be adequate for most purposes. These are:

* the default `Configuration`, which prints test results to standard output;
* `VmConfiguration`, which exits the process with a return value of 1 upon failure; useful in particular for driving tests from other programs or scripts where the return code of the process is useful to detect success or failure; call `useVmConfiguration()` to use this, and import vm_config.dart;
* `HtmlConfiguration`, which puts test results in an HTML table and sets the browser document body to be this table; call `useHtmlConfiguration()` to use this, and import html_config.dart;
* `HtmlEnhancedConfiguration`, which is similar to `HtmlConfiguration` but provides a richer layout; call `useHtmlEnhancedConfiguration()` to use this, and import html_enhanced_config.dart.

For running tests in a continuous integration environment, the default or VmConfigurations are most useful. 

## Using `expect()` in other contexts

While `expect()` has been used here in the context of unit tests, it is possible to use it in other contexts as a general assertion mechanism. The default behavior is to throw an `ExpectException` upon failure with the failure reason as the message property, but that can be customized. In fact, expect has its own unit tests that do just this.

There are two functions that can be used to customize the behavior of expect:

* `configureExpectHandler` - this is used to change the object which handles `expect()` failures. The default object simply throws ExpectExceptions. It may be desirable to do something different; for example to log the error and swallow the exception instead.
* `configureExpectFormatter` - this is used to change the function which is used to format error messages by `expect()`. It is rare that this would need to change and it will not be considered further here; see the SDK documentation for details.

The easiest way to customize the error handler is to create a class that inherits from `DefaultFailureHandler` and overrides this method:

    void fail(String reason) {
      throw new ExpectException(reason);
    }

For example, this failure handler just keeps a count of the number of failures:

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

