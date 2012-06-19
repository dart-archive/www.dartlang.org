You can control the flow of your Dart code using any of the following:

* [If and else](#if-else)
* [For loops](#for-loops)
* [While and do while](#while)
* [Break and continue](#break)
* [Switch and case](#switch)
* [Assert](#assert)

<h4 id="if-else">If and else</h4>

{% highlight dart %}
if (isRaining()) {
  you.bringRainCoat();
} else if (isSnowing()) {
  you.wearJacket();
} else {
  car.putTopDown();
}
{% endhighlight %}

Remember, unlike JavaScript, Dart treats all values
that are not `true` as `false`.
See [Booleans](#booleans) for more info.

<h4 id="for-loops">For loops</h4>

You can iterate with the standard `for` loop.

{% highlight dart %}
for (var i = 0; i < candidates.length; i++) {
  candidates[i].interview();
}
{% endhighlight %}

Closures inside of Dart's `for` loops correctly capture the
value of the index, avoiding a common pitfall found in JavaScript.
For example, consider:

{% highlight dart %}
main() {
  var callbacks = [];
  for (var i = 0; i < 2; i++) {
    callbacks.add(() => print(i));
  }
  callbacks.forEach((c) => c());
}
{% endhighlight %}

The output is `0` and then `1`, as expected. In contrast,
the example would print `2` and then `2` in JavaScript.

If the object that you are iterating over is a `Collection`,
you can use the [forEach()](http://api.dartlang.org/dart_core/Collection.html#forEach)
method. Using forEach() is
a good option if you don't need to know the current iteration
counter.

{% highlight dart %}
candidates.forEach((candidate) => candidate.interview());
{% endhighlight %}

Collections also support the `for-in` form of iteration:

{% highlight dart %}
var collection = [0, 1, 2];
for (var x in collection) {
  print(x);
}
{% endhighlight %}

<h4 id="while">While and do while</h4>

A `while` loop evaluates the conditional before the loop.

{% highlight dart %}
while (!auctionItem.currentWinner(bidder) &&
       auctionItem.currentBid < bidder.maximumBid) {
  auctionItem.placeBid(bidder, auction.currentBid + 1);
}
{% endhighlight %}

A do while loop evaluates the conditional *after* the loop.

{% highlight dart%}
do {
  printLine();
} while (!atEndOfPage());
{% endhighlight %}

<h4 id="break">Break and continue</h4>

Use `break` to stop looping.

{% highlight dart %}
while (true) {
  if (shutDownRequested()) break;
  processIncomingRequests();
}
{% endhighlight %}

Use `continue` to skip to the next loop iteration.

{% highlight dart %}
for (var i = 0; i < candidates.length; i++) {
  var candidate = candidates[i];
  if (candidate.yearsExperience < 5) {
    continue;
  }
  candidate.interview();
}
{% endhighlight %}

You might write that example differently if you're
using a [Collection](http://api.dartlang.org/dart_core/Collection.html).

{% highlight dart %}
candidates.filter((c) => c.yearsExperience >= 5)
          .forEach((c) => c.interview());
{% endhighlight %}

<h4 id="switch">Switch and case</h4>

Switch statements in Dart compare int or const String objects using `==`.
Remember to include a `break` statement
at the end of each non-empty `case` clause to avoid fall-through (which is an error, see below).
A `default` clause can be used to catch conditions that don't match.

{% highlight dart %}
var command = 'OPEN';
switch (command) {
  case 'CLOSED':
    executeClose();
    break;
  case 'PENDING':
    executePending();
    break;
  case 'APPROVED':
    executeApproved();
    break;
  case 'DENIED':
    executeDenied();
    break;
  case 'OPEN':
    executeOpen();
    break;
  default:
    executeUnknown();
}
{% endhighlight %}

The following example omits the `break` statement in the `case` clause,
thus generating an error:

{% highlight dart %}
var command = 'OPEN';
switch (command) {

  case 'OPEN':
    executeOpen();
    // ERROR: Missing break causes an exception to be thrown!!

  case 'CLOSED':
    executeClose();
    break;
}
{% endhighlight %}

However, Dart does support empty `case` clauses, allowing a form
of fall-through.

{% highlight dart %}
var command = 'CLOSED';
switch (command) {
  case 'CLOSED':     // Empty case falls through.
  case 'NOW_CLOSED':
    // Runs for both CLOSED and NOW_CLOSED.
    executeClose();
    break;
}
{% endhighlight %}

<h4 id="assert">Assert</h4>

Use an assert statement to disrupt normal execution
if a [boolean](#booleans) condition is false.
You can find examples of assert statements throughout this tour.
Here are some more:

{% highlight dart %}
assert(text != null);  // Make sure the variable has a non-null value.
assert(number < 100);  // Make sure the value is less than 100.
assert(urlString.startsWith('https')); // Make sure this is an HTTPS URL.
{% endhighlight %}

<aside class="note" markdown="1">
  **Important:** Assert statements work only in checked mode.
  They have no effect in production mode.
</aside>

Inside the parentheses, you can put any expression
that resolves to a boolean value.
If the expression's value is true,
the assertion succeeds and execution continues.
Otherwise,
the assertion fails and an exception (an
[AssertionError](http://api.dartlang.org/dart_core/AssertionError.html))
is thrown.
