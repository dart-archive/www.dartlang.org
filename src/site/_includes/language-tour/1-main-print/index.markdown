<p>
Here's some code
that uses some of Dart's most basic features.
</p>

{% highlight dart %}
// Define a function.
printNumber(num smallNumber) {
  assert(smallNumber < 100);            // Check our assumptions.
  print("The number is $smallNumber."); // Print to the console.
}

// This is where the app starts executing.
main() {
  var number = 42;           // Declare and initialize a variable.
  printNumber(number);       // Call a function.
}
{% endhighlight %}

<p>
Here's what this program uses
that applies to all (or almost all) Dart apps:
</p>

<dl>
  <dt> // </dt>
  <dd>
    How you indicate that the rest of the line is a
    <a href="#comments">comment</a>.
    Alternatively:
    {% highlight dart %}/* This comment might span many lines. */{% endhighlight %}
  </dd>

  <dt> num </dt>
  <dd>
    A type. Some of the other <a href="#built-in-types">built-in types</a>
    are String, int, and bool.
  </dd>

  <dt> assert() </dt>
  <dd>
    A way of <a href="#assert">checking assumptions</a>
    while you're testing your code.
  </dd>

  <dt> 100 </dt>
  <dd>
    A <a href="#numbers">number</a> literal.
  </dd>

  <dt> print() </dt>
  <dd>
    A handy way to display output.
  </dd>

  <dt> "..." (or '...')</dt>
  <dd>
    A <a href="#strings">string</a> literal.
  </dd>

  <dt> $text </dt>
  <dd>
    String interpolation: including a variable's toString() value inside of a string literal.
  </dd>

  <dt> main() </dt>
  <dd>
    The special, <b>required</b>,
    top-level function where app execution starts.
  </dd>

  <dt> var </dt>
  <dd>
    Declares a variable without specifying its type.
  </dd>
</dl>

### Style

Our code follows the conventions in the
<a href="/articles/style-guide/">Dart Style Guide</a>.
For example,
we indent two spaces by convention.

### Runtime modes

Dart programs can run in either production mode or checked mode.

_Production mode_ is the default runtime mode of a Dart
program, optimized for speed.
In production mode, the optional static types are ignored.

_Checked mode_ is a developer friendly mode
that helps you catch some type errors during runtime.
For example, if you assign a non-string to a variable declared as a String,
an exception will be thrown.

We recommend that you develop and debug in checked mode,
and deploy to production mode.