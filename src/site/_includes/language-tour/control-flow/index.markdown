You can control the flow of your Dart code using any of the following:

* [If and else](#if-else)
* [For loops](#for-loops)
* [While and do while](#while)
* [Break and continue](#break)
* [Switch and case](#switch)
* [Assert statement](#assert)

<h4 id="if-else">If and else</h4>

{% pretty_code dart 0 %}
if (isRaining()) {
  you.bringRainCoat();
} else if (isSnowing()) {
  you.wearJacket();
} else {
  car.putTopDown();
}
{% endpretty_code %}

Remember, unlike JavaScript, Dart treats all values
that are not `true` as `false`.
See [Booleans](#booleans) for more info.

<h4 id="for-loops">For loops</h4>

You can iterate with the standard `for` loop.

{% pretty_code dart 0 %}
for (int i = 0; i < candidates.length; i++) {
  candidates[i].interview();
}
{% endpretty_code %}

Closures inside of Dart's `for` loops correctly capture the
value of the index, avoiding a common pitfall found in JavaScript.
For example, consider:

{% pretty_code dart 0 %}
main() {
  var callbacks = [];
  for (var i = 0; i < 2; i++) {
    callbacks.add(() => print(i));
  }
  callbacks.forEach((c) => c());
}
{% endpretty_code %}

The output is `0` and then `1`, as expected. In contrast,
the example would print `2` and then `2` in JavaScript.

If the object that you are iterating over is a `Collection`,
you can use the [forEach()](http://api.dartlang.org/dart_core/Collection.html#forEach)
method. Using forEach() is
a good option if you don't need to know the current iteration
counter.

{% pretty_code dart 0 %}
candidates.forEach((candidate) => candidate.interview());
{% endpretty_code %}

Collections also support the `for-in` form of iteration:

{% pretty_code dart 0 %}
var collection = [0, 1, 2];
for (var x in collection) {
  print(x);
}
// prints:
// 0
// 1
// 2
{% endpretty_code %}

<h4 id="while">While and do while</h4>

A `while` loop evaluates the conditional before the loop.

{% pretty_code dart 0 %}
while (!auctionItem.currentWinner(bidder) &&
       auctionItem.currentBid < bidder.maximumBid) {
  auctionItem.placeBid(bidder, auction.currentBid + 1);
}
{% endpretty_code %}

A do while loop evaluates the conditional *after* the loop.

{% pretty_code dart 0%}
do {
  printLine();
} while (!atEndOfPage());
{% endpretty_code %}

<h4 id="break">Break and continue</h4>

Use `break` to stop looping.

{% pretty_code dart 0 %}
while (true) {
  if (shutDownRequested()) break;
  processIncomingRequests();
}
{% endpretty_code %}

Use `continue` to skip to the next loop iteration.

{% pretty_code dart 0 %}
for (int i = 0; i < candidates.length; i++) {
  var candidate = candidates[i];
  if (candidate.yearsExperience < 5) {
    continue;
  }
  candidate.interview();
}
{% endpretty_code %}

You might write that example differently if you're
using a [Collection](http://api.dartlang.org/dart_core/Collection.html).

{% pretty_code dart 0 %}
candidates.filter((c) => c.yearsExperience >= 5)
          .forEach((c) => c.interview());
{% endpretty_code %}

<h4 id="switch">Switch and case</h4>

Switch statements in Dart compare objects using `==`. Remember to include a `break` statement
at the end of each non-empty `case` clause to avoid fall-through (which is an error, see below).
A `default` clause can be used to catch conditions that don't match.

{% pretty_code dart 0 %}
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
{% endpretty_code %}

The following example omits the `break` statement in the `case` clause,
thus generating an error:

{% pretty_code dart 0 %}
var command = 'OPEN';
switch (command) {

  case 'OPEN':
    executeOpen();
    // ERROR: missing break causes an exception to be thrown!!

  case 'CLOSED':
    executeClose();
    break;
}
{% endpretty_code %}

However, Dart does support empty `case` clauses, allowing a form
of fall-through.

{% pretty_code dart 0 %}
var command = 'CLOSED';
switch (command) {
  case 'CLOSED':     // empty case falls through
  case 'NOW_CLOSED':
    // runs for both CLOSED and NOW_CLOSED
    executeClose();
    break;
}
{% endpretty_code %}

<h4 id="assert">Assert</h4>

Use an assert statement to disrupt normal execution
if a boolean condition is false.
Here are some examples of assert statements:

{% pretty_code dart 0 %}
assert(text != null);  // Make sure the variable has a non-null value.
assert(number &lt; 100);  // Make sure the value is less than 100.
{% endpretty_code %}

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
