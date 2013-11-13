--- 
layout: article
title: "Using Future Based APIs"
description: "A first look at Futures and how to use them to make your
asynchronous code better."
rel:
    author: shailen-tuli
has-permalinks: true
article:
  written_on: 2013-02-07
  collection: libraries-and-apis
---

{% include toc.html %}

# {{ page.title }}

_Written by Shailen Tuli, February 2013_

## Introduction

Dart is a single-threaded programming language. If any code blocks the thread
of execution, the program effectively freezes. Let's look at some code where
this happens:

{% prettify dart %}
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

    <Contents of dailyNewsDigest.txt>
    Winning lotto numbers: [23, 63, 87, 26, 2]
    Tomorrow's forecast: 70F, sunny.
    Baseball score: Red Sox 10, Yankees 0

Our code is problematic: since `readAsStringSync()` blocks, the remaining code
runs only when `readAsStringSync()` returns with the contents of the file, 
_however long that takes_.  And if reading the file takes a long time, the
user waits passively, wondering if she won the lottery, what tomorrow's weather
will be like, and who won today's game. Not good.

To help keep the application responsive, Dart library authors use an
asynchronous model when defining functions that do potentially expensive work.
Such functions return their value using a Future.

## What is a Future?

A Future represents a means for getting a value sometime in the future. When a
function that returns a Future is invoked, two things happen:

1. The function queues up work to be done and returns an uncompleted Future
object immediately.
1. Later, when a value is available, the Future object completes with that
value (or with an error; we'll discuss that later).

To get the value that the Future represents, use the `then()` method to
register a callback. This callback fires when the Future completes.

## Using a Future

Let's rewrite `printDailyNewsDigest()` to get the file contents
asynchronously:

{% prettify dart %}
import 'dart:io';
import 'dart:async';

void printDailyNewsDigest() {
  File file = new File("dailyNewsDigest.txt");
  Future future = file.readAsString();
  future.then((content) {
    print(content);
  });
}
{% endprettify %}

The `printDailyNewsDigest()` function now uses `readAsString()`, which is
non-blocking. Calling `readAsString()` queues up the work to be done but
doesn't stop the rest of the code from executing. The program prints the
lottery numbers, the forecast, and the baseball score; when
`readAsString()` finishes reading the news file, the program prints its
contents. If `readAsString()` takes a little while to complete its work, no
great harm is done: the user gets to read other things before the daily news
digest is printed.

    Winning lotto numbers: [23, 63, 87, 26, 2]
    Tomorrow's forecast: 70F, sunny.
    Baseball score: Red Sox 10, Yankees 0
    <Contents of dailyNewsDigest.txt>

## Sequence of events during code execution

The preceding code executes in three steps:

1. The program enters `main()`, which calls `printDailyNewsDigest()`, which
queues up the file reading task.  After calling the remaining print functions,
`main()` exits, but the program continues.
1. The work scheduled by `readAsString()` is performed, and the contents of the
file are read into memory. When the entire file is read, the Future completes
with the file contents.
1. The callback registered within `then()` fires and prints the contents
of the news file.

Calling `then()` returns a new Future, which completes with the value
returned by `then()`'s callback. This means that calls to `then()` can be
chained (we'll see examples of this later). 

## Handling errors when dealing with Futures

If a Future-returning function completes with an error, the Future returned by
`then()` also completes with an error. We can capture that error using
`catchError()`:

{% prettify dart %}

void printDailyNewsDigest() {
  File file = new File("dailyNewsDigest.txt");
  Future future = file.readAsString();
  future.then((content) => doSomethingWith(content))
        .catchError((e) => handleError(e));
}
{% endprettify %}

If `dailyNewsDigest.txt` doesn't exist or isn't available for reading,
the code above executes as follows:

1. `readAsString()`'s Future completes with an error.
1. `then()`'s Future completes with an error.
1.  `catchError()`'s callback handles the error, `catchError()`'s Future
completes normally, and the error does not propagate.

<aside class="alert alert-info" markdown="1">
  Chaining catchError() to then() is a common pattern when working with
  functions that return Futures.
  <strong>
    Consider this pairing the asynchronous equivalent of try-catch blocks.
  </strong>
</aside>

Like `then()`, `catchError()` returns a new Future that completes with
the return value of its callback.

For more details and examples, read
[Futures and Error Handling](/articles/futures-and-error-handling/).


## Calling multiple functions that return Futures

Consider three functions,  `expensiveA()`, `expensiveB()`, and `expensiveC()`,
that return Futures.  You can invoke them sequentially (one function starts
when a previous one completes), or you can kick off all of them at the same
time and do something once all the values return. The Future interface
is fluid enough to deal with both use cases.

### Chaining function calls using then()

When Future-returning functions need to run in order, use
chained `then()` calls:

{% prettify dart %}
expensiveA().then((aValue) => expensiveB()) 
            .then((bValue) => expensiveC()) 
            .then((cValue) => doSomethingWith(cValue));
{% endprettify %}

Nested callbacks also work, but they're harder to read and not as Dart-y.

### Waiting on multiple Futures to complete using Future.wait()

If the order of execution of the functions is not important, 
you can use `Future.wait()` to handle multiple Future objects
without having to explicitly chain function calls.

The functions get triggered in quick succession; when all of them
complete with a value, `Future.wait()` returns a new Future.
This Future completes with a list containing the values produced by
each function.

{% prettify dart %}
Future.wait([expensiveA(), expensiveB(), expensiveC()])
      .then((List responses) => chooseBestResponse(responses))
      .catchError((e) => handleError(e));
{% endprettify %}

If any of the invoked functions completes with an error, the Future returned
by `Future.wait()` also completes with an error. Use `catchError()` to handle
the error.

## More information

Read the following documentation for more details on using Futures:

* [Futures and Error Handling](/articles/futures-and-error-handling/),
  an article that starts where this one ends
* [The Event Loop and Dart](/articles/event-loop/),
  an article that describes how to schedule tasks using Futures
* [Future API reference](http://api.dartlang.org/dart_async/Future.html)

