Here's a simple function:

{% pretty_code dart 0 %}
String say(String from, String msg) => "$from says $msg";
{% endpretty_code %}

And here's an example of calling it:

{% pretty_code dart 0 %}
assert(say("Bob", "Hello") == "Bob says Hello");
{% endpretty_code %}

Omitting the types, you could write the above as:

{% pretty_code dart 0 %}
say(from, msg) => "$from says $msg";
{% endpretty_code %}

However, we recommend using types for function signatures.

The `=> e;` syntax is a shorthand for `{ return e; }`.
For example, `say(from, msg) => "$from says $msg";`
is the same as:

{% pretty_code dart 0 %}
say(from, msg) {
  return "$from says $msg";
}
{% endpretty_code %}

#### Optional parameters

Wrapping a function parameter in `[]` marks it as an optional parameter.

{% pretty_code dart 0 %}
String say(String from, String msg, [String device]) {
  var result = "$from says $msg";
  if (device != null) {
    result = "$result with a $device";
  }
  return result;
}
{% endpretty_code %}

Here's an example of calling this function without the optional parameter:

{% pretty_code dart 0 %}
assert(say("Bob", "Howdy") == "Bob says Howdy");
{% endpretty_code %}

Here's an example of calling this function with the third parameter:

{% pretty_code dart 0 %}
assert(say("Bob", "Howdy", "smoke signal") ==
    "Bob says Howdy with a smoke signal");
{% endpretty_code %}

#### Default values for optional parameters

Optional parameters may have default values. The default values
must be compile time constants. If no default value is
provided, the value is `null` (as we saw above).

{% pretty_code dart 0 %}
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
{% endpretty_code %}

Omitting the optional parameters, you can see how the default values are used:

{% pretty_code dart 0 %}
assert(say("Bob", "Howdy") == 'Bob says Howdy with a carrier pigeon');
{% endpretty_code %}

You can pass null to an optional parameter, overriding its default
value.

{% pc dart 0 %}
assert(say('Bob', 'Howdy', null) == 'Bob says Howdy');
{% endpc %}

#### Named parameters

Optional parameters are also named parameters.

{% pretty_code dart 0 %}
assert(say("Bob", "Howdy", device: "tin can and string") ==
    "Bob says Howdy with a tin can and string");

assert(say("Bob", "Howdy", mood: "fresh") ==
    "Bob says Howdy with a carrier pigeon (in a fresh mood)");
{% endpretty_code %}

#### First class functions

You can pass a function as a parameter to another function. For example:

{% pretty_code dart 0 %}
var ages = [1,4,5,7,10,14,21];
var oddAges = ages.filter((i) => i % 2 == 1);
{% endpretty_code %}

Which is the same as:

{% pretty_code dart 0 %}
bool isOdd(num i) => i % 2 == 1;
var ages = [1,4,5,7,10,14,21];
var oddAges = ages.filter(isOdd);
{% endpretty_code %}

You can also assign a function to a variable, such as:

{% pretty_code dart 0 %}
var loudify = (msg) => '!!! ${msg.toUpperCase()} !!!';
assert(loudify('hello') ==
    '!!! HELLO !!!');
{% endpretty_code %}

#### Lexical closures

Functions can close over variables defined in surrounding scopes.
The following example shows how `makeAdder` captures the variable `n`
and makes it available to the function that `makeAdder` returns.
Wherever the returned function goes, it remembers `n`.

{% pretty_code dart 0 %}
Function makeAdder(num n) {
  return (num i) => n + i;
}

main() {
  var add2 = makeAdder(2);
  assert(add2(3) == 5);
}
{% endpretty_code %}

(Special thanks to Bob Nystrom for this example.)

#### Return values

All functions return a value. If no return value is specified, the statement `return null;`
is implicitly appended to the function body.

### Summary of functions

Dart supports first class functions, with optional parameters, named parameters,
and default values for parameters. Functions may be assigned to variables and
passed as parameters to other functions. Functions also support lexical
closures, which allows access to variables outside its immediate lexical scope.
