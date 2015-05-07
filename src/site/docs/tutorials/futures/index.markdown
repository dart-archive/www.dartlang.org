---
layout: tutorial
title: "Asynchronous Programming with Futures"
description: "A first look at Futures and how to use them to make your asynchronous code better."
has-permalinks: true
tutorial:
  id: futures
next: streams/
next-title: "Use Streams for Data"
prev: polymer-intro/
prev-title: "Define a Custom Element"
---

{% capture whats_the_point %}

* Dart is single-threaded.
* Synchronous code can make your program freeze.
* Use Futures to perform asynchronous operations.
* Use `await` in an async function to pause execution until a Future completes.
* Or use Future's `then()` method.
* Use try-catch expressions in async functions to catch errors.
* Or use Future's `catchError()` method.
* You can chain Futures to run asynchronous functions in order.

{% endcapture %}

{% capture sample_links %}


<p markdown="1"> This tutorial features these examples
in the `futures/bin` directory,
all variations of the same example:</p>

* futures1.dart
* futures2.dart
* futures3.dart
* futures4.dart
* futures5.dart

<p>
Don't have the source code?
<a href="https://github.com/dart-lang/dart-tutorials-samples/archive/master.zip">
  Download it.
</a>

{% endcapture %}

{% capture content %}

<div class="tute-target-title">
<h1>{{page.title}}</h1>
</div>

Dart is a single-threaded programming language.
If any code blocks the thread of execution
(for example, by waiting for a time-consuming operation
or blocking on I/O) the program effectively freezes.
Asynchronous operations let your program run without getting blocked.
Dart uses Future objects to represent asynchronous operations.

* [Introduction](#introduction)
* [What is a Future?](#what-is-a-future)
* [Async and await](#async-await)
  * [Handling errors](#handling-errors-async)
  * [Sequential processing](#sequential-processing-async)
* [The Future API](#the-future-api)
  * [Handling errors](#handling-errors-future-api)
  * [Calling multiple functions that return Futures](#calling-multiple-funcs)
* [Other resources](#other-resources)
* [What next?](#what-next)

## Introduction {#introduction}

Let's look at some code that could possibly cause a program to freeze:

{% prettify dart %}
// Synchronous code
import 'dart:io';

void printDailyNewsDigest() {
  File file = new File("dailyNewsDigest.txt");
  print(file.readAsStringSync());
}

void main() {
  printDailyNewsDigest();
  printWinningLotteryNumbers();
  printWeatherForecast();
  printBaseballScore();
}
{% endprettify %}

Our program reads the news of the day from a file, `dailyNewsDigest.txt`,
prints it, and then prints a bunch of other items of interest to the user:

{% prettify none %}
<Contents of dailyNewsDigest.txt>
Winning lotto numbers: [23, 63, 87, 26, 2]
Tomorrow's forecast: 70F, sunny.
Baseball score: Red Sox 10, Yankees 0
{% endprettify %}

Our code is problematic: since `readAsStringSync()` blocks, the remaining code
runs only when `readAsStringSync()` returns with the contents of the file, 
_however long that takes_.  And if reading the file takes a long time, the
user waits passively, wondering if she won the lottery, what tomorrow's weather
will be like, and who won today's game. Not good.

To help keep the application responsive, Dart library authors use an
asynchronous model when defining functions that do potentially expensive work.
Such functions return their value using a
<a href="https://api.dartlang.org/dart_async/Future.html"
   target="_blank">Future</a>.

## What is a Future? {#what-is-a-future}

A Future represents a means for getting a value sometime in the future. When a
function that returns a Future is invoked, two things happen:

1. The function queues up work to be done and returns an uncompleted Future
   object immediately.
1. Later, when a value is available, the Future object completes with that
   value (or with an error; we'll discuss that later).

To get the value that the Future represents, you have two options:

* Use `async` and `await` 
* Use the Future API

## Async and await {#async-await}

The `async` and `await` keywords are part of the Dart language's
[asynchrony support](/docs/dart-up-and-running/ch02.html#asynchrony).
They allow you to write asynchronous code that looks like synchronous
code and doesn't use the Future API.

Let's rewrite `printDailyNewsDigest()` to get the file contents
asynchronously using `async` and `await`:

<!-- BEGIN(futures2.dart) -->{% prettify dart %}
import 'dart:io';
import 'dart:async';

[[highlight]]Future[[/highlight]] printDailyNewsDigest() [[highlight]]async[[/highlight]] {
  File file = new File("dailyNewsDigest.txt");
  var content = [[highlight]]await[[/highlight]] file.readAsString();
  print(content);
}
{% endprettify %}<!-- END(futures2.dart) -->

The `printDailyNewsDigest()` function now uses `readAsString()`, which is
non-blocking. Calling `readAsString()` queues up the work to be done but
doesn't stop the rest of the code from executing. The program prints the
lottery numbers, the forecast, and the baseball score; when
`readAsString()` finishes reading the news file, the program prints its
contents. If `readAsString()` takes a little while to complete its work, no
great harm is done: the user gets to read other things before the daily news
digest is printed.

This code executes as follows:

1. The `printDailyNewsDigest()`, marked with the `async` keyword,
   immediately returns a Future.
1. Later, it starts executing the function body.
1. When it reaches the `await` expression, it pauses after calling
   `readAsString()`.
1. After `readAsString()`'s Future completes, the function starts
   executing again, calling `print()`.
1. When the function runs out of code, the Future that it returned
   completes. Note that if an async function doesn't explicitly
   return a value, it returns a Future wrapped around a null value.

### Handling errors {#handling-errors-async}

If a Future-returning function completes with an error,
you probably want to capture that error.
Async functions can use try-catch to capture the error.

{% prettify dart %}
// Handling errors with async and await.
Future printDailyNewsDigest() async {
  File file = new File("dailyNewsDigest.txt");
  [[highlight]]try[[/highlight]] {
    var content = await file.readAsString();
    print(content);
  } [[highlight]]catch[[/highlight]] (e) {
    handleError(e);
  }
}
{% endprettify %}

The try-catch code behaves in the same way with asynchronous code that
it does for synchronous code: If the `readAsString()` method encounters
an error, the code inside the `catch` clause
is executed; in this example, `handleError()` is called.

### Sequential processing {#sequential-processing-async}

You can use multiple `await` expressions to ensure that each statement
completes before executing the next statement:

{% prettify dart %}
// Sequential processing using async and await.
main() async {
  await expensiveA();
  await expensiveB();
  doSomethingWith(await expensiveC());
}   
{% endprettify %}

The `expensiveB()` function will not execute until `expensiveA()` has
finished, and so on.

---

## The Future API {#the-future-api}

Before async and await were added in Dart 1.9,
you had to use the Future API.
You might still see the Future API used in older code
and in code that needs more functionality than async-await offer.

To write asynchronous code using the Future API,
you use the `then()` method to register a callback.
This callback fires when the Future completes.

Let's rewrite `printDailyNewsDigest()` to get the file contents
asynchronously using the Future API:

{% prettify dart %}
import 'dart:io';
import 'dart:async';

void printDailyNewsDigest() {
  File file = new File("dailyNewsDigest.txt");
  Future future = file.readAsString();
  future.[[highlight]]then[[/highlight]]((content) {
    print(content);
  });
}
{% endprettify %}

This code executes as follows:

1. The `printDailyNewsDigest()` function does not return immediately.
1. The work scheduled by `readAsString()` is performed,
   and the contents of the file are read into memory.
   When the entire file is read, the Future completes with the file contents.
1. The callback registered within `then()` fires and prints the
   contents of the news file.  Calling `then()` returns a new Future,
   which completes with the value returned by `then()`'s callback.
   This means that calls to `then()` can be
   chained (we'll see examples of this later). 
   Note that no Future is returned unless you explicitly return one.

### Handling errors {#handling-errors-future-api}

With the Future API, you can capture an error using `catchError()`:

{% prettify dart %}
// Handling errors with the Future API.
void printDailyNewsDigest() {
  File file = new File("dailyNewsDigest.txt");
  Future future = file.readAsString();
  future.then((content) => doSomethingWith(content))
        .[[highlight]]catchError[[/highlight]]((e) => handleError(e));
}
{% endprettify %}

If `dailyNewsDigest.txt` doesn't exist or isn't available for reading,
the code above executes as follows:

1. `readAsString()`'s Future completes with an error.
1. `then()`'s Future completes with an error.
1.  `catchError()`'s callback handles the error, `catchError()`'s Future
completes normally, and the error does not propagate.

<aside class="alert alert-info" markdown="1">
  Chaining catchError() to then() is a common pattern when using
  the Future API.
  <strong>
    Consider this pairing the Future API's equivalent of try-catch blocks.
  </strong>
</aside>

Like `then()`, `catchError()` returns a new Future that completes with
the return value of its callback.

For more details and examples, read
[Futures and Error Handling](/articles/futures-and-error-handling/).

### Calling multiple functions that return Futures {#calling-multiple-funcs}

Consider three functions,  `expensiveA()`, `expensiveB()`, and `expensiveC()`,
that return Futures.  You can invoke them sequentially (one function starts
when a previous one completes), or you can kick off all of them at the same
time and do something once all the values return. The Future interface
is fluid enough to deal with both use cases.

#### Chaining function calls using then()

When Future-returning functions need to run in order, use chained
`then()` calls:

{% prettify dart %}
expensiveA().then((aValue) => expensiveB())
            .then((bValue) => expensiveC())
            .then((cValue) => doSomethingWith(cValue));
{% endprettify %}

Nested callbacks also work, but they're harder to read and not as Dart-y.

#### Waiting on multiple Futures to complete using Future.wait()

If the order of execution of the functions is not important, 
you can use `Future.wait()`.

The functions get triggered in quick succession; when all of them
complete with a value, `Future.wait()` returns a new Future.
This Future completes with a list containing the values produced by
each function.

{% prettify dart %}
// Parallel processing using the Future API
Future.wait([expensiveA(), expensiveB(), expensiveC()])
      .then((List responses) => chooseBestResponse(responses))
      .catchError((e) => handleError(e));
{% endprettify %}

If any of the invoked functions completes with an error, the Future returned
by `Future.wait()` also completes with an error. Use `catchError()` to handle
the error.

## Other resources {#other-resources}

Read the following documentation for more details on using Futures
and asynchronous programming in Dart:

* [Futures and Error Handling](/articles/futures-and-error-handling/),
  an article that starts where this tutorial ends
* [The Event Loop and Dart](/articles/event-loop/),
  an article that describes how to schedule tasks using Futures
* [Asynchrony support](/docs/dart-up-and-running/ch02.html#asynchrony),
  a section in the [language tour](/docs/dart-up-and-running/)
* [Future API reference](http://api.dartlang.org/dart_async/Future.html)

## What next? {#what-next}

* The next tutorial,
[Fetch Data Dynamically](/docs/tutorials/fetchdata/),
uses a Future when doing an HTTP request.

* The example featured in
[Use IndexedDB](/docs/tutorials/indexeddb/)
uses many Futures when interacting with the database.

{% endcapture %}

{% include tutorial.html %}

