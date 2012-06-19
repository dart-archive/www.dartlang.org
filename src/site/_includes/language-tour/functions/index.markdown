Here's a simple function:

{% highlight dart %}
String say(String from, String msg) => "$from says $msg";
{% endhighlight %}

And here's an example of calling it:

{% highlight dart %}
assert(say("Bob", "Hello") == "Bob says Hello");
{% endhighlight %}

Omitting the types, you could write the above as:

{% highlight dart %}
say(from, msg) => "$from says $msg";
{% endhighlight %}

However, we recommend using types for function signatures.

The `=> e;` syntax is a shorthand for `{ return e; }`.
For example, `say(from, msg) => "$from says $msg";`
is the same as:

{% highlight dart %}
say(from, msg) {
  return "$from says $msg";
}
{% endhighlight %}

#### Optional parameters

Wrapping a function parameter in `[]` marks it as an optional parameter.

{% highlight dart %}
String say(String from, String msg, [String device]) {
  var result = "$from says $msg";
  if (device != null) {
    result = "$result with a $device";
  }
  return result;
}
{% endhighlight %}

Here's an example of calling this function without the optional parameter:

{% highlight dart %}
assert(say("Bob", "Howdy") == "Bob says Howdy");
{% endhighlight %}

Here's an example of calling this function with the third parameter:

{% highlight dart %}
assert(say("Bob", "Howdy", "smoke signal") ==
    "Bob says Howdy with a smoke signal");
{% endhighlight %}

#### Default values for optional parameters

Optional parameters may have default values. The default values
must be compile time constants. If no default value is
provided, the value is `null` (as we saw above).

{% highlight dart %}
String say(String from, String msg,
    [String device='carrier pigeon', String mood]) {
  var result = "$from says $msg";
  if (device != null) {
  	result = "$result with a $device";
  }
  if (mood != null) {
    result = "$result (in a $mood mood)";
  }
  return result;
}
{% endhighlight %}

Omitting the optional parameters, you can see how the default values are used:

{% highlight dart %}
assert(say("Bob", "Howdy") == 'Bob says Howdy with a carrier pigeon');
{% endhighlight %}

You can pass null to an optional parameter, overriding its default
value.

{% highlight dart %}
assert(say('Bob', 'Howdy', null) == 'Bob says Howdy');
{% endhighlight %}

#### Named parameters

Optional parameters are also named parameters.

{% highlight dart %}
assert(say("Bob", "Howdy", device: "tin can and string") ==
    "Bob says Howdy with a tin can and string");

assert(say("Bob", "Howdy", mood: "fresh") ==
    "Bob says Howdy with a carrier pigeon (in a fresh mood)");
{% endhighlight %}

#### First class functions

You can pass a function as a parameter to another function. For example:

{% highlight dart %}
var ages = [1,4,5,7,10,14,21];
var oddAges = ages.filter((i) => i % 2 == 1);
{% endhighlight %}

Which is the same as:

{% highlight dart %}
bool isOdd(num i) => i % 2 == 1;
var ages = [1,4,5,7,10,14,21];
var oddAges = ages.filter(isOdd);
{% endhighlight %}

You can also assign a function to a variable, such as:

{% highlight dart %}
var loudify = (msg) => '!!! ${msg.toUpperCase()} !!!';
assert(loudify('hello') ==
    '!!! HELLO !!!');
{% endhighlight %}

#### Lexical closures

Functions can close over variables defined in surrounding scopes.
The following example shows how `makeAdder` captures the variable `n`
and makes it available to the function that `makeAdder` returns.
Wherever the returned function goes, it remembers `n`.

{% highlight dart %}
Function makeAdder(num n) {
  return (num i) => n + i;
}

main() {
  var add2 = makeAdder(2);
  assert(add2(3) == 5);
}
{% endhighlight %}

(Special thanks to Bob Nystrom for this example.)

#### Return values

All functions return a value. If no return value is specified, the statement `return null;`
is implicitly appended to the function body.

### Summary of functions

Dart supports first class functions, with optional parameters, named parameters,
and default values for parameters. Functions may be assigned to variables and
passed as parameters to other functions. Functions also support lexical
closures, which allows access to variables outside its immediate lexical scope.
