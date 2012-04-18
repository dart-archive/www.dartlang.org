Your Dart code can throw and catch exceptions. Exceptions are errors that
signal something happened that was not anticipated. If not caught,
exceptions bubble up to the top of the program.

In contrast to Java, all of Dart's exceptions are unchecked exceptions.
Methods do not declare which exceptions they might throw, and
you are not required to catch any exceptions.

Dart provides
an [Exception](http://api.dartlang.org/dart_core/Exception.html) interface and numerous predefined exception types.
You can, of course, define your own exceptions by extending the Exception interface.
Some examples of common exceptions include:

* [IndexOutOfRangeException](http://api.dartlang.org/dart_core/IndexOutOfRangeException.html)
* [NoSuchMethodException](http://api.dartlang.org/dart_core/NoSuchMethodException.html)
* [NullPointerException](http://api.dartlang.org/dart_core/NullPointerException.html)
* [IllegalArgumentException](http://api.dartlang.org/dart_core/IllegalArgumentException.html)

However, Dart programs can throw any object as an exception. 

#### Throw

Here's how you throw, or _raise_, an exception.

{% pretty_code dart 0 %}
throw new IllegalArgumentException('Value must be greater than zero');
{% endpretty_code %}

You can also throw arbitrary objects.

{% pretty_code dart 0 %}
throw "Out of llamas!";
{% endpretty_code %}

#### Catch

Catching, or capturing, an exception stops the exception from propagated.
Catching an exception gives you a chance to handle it.

{% pretty_code dart 0 %}
try {
  breedMoreLlamas();
} catch (final OutOfLlamasException e) {
  buyMoreLlamas();
}
{% endpretty_code %}

To handle code that can throw more than one type of exception, you can specify
multiple catch clauses.
The first catch clause that matches the thrown object's
type handles the exception. If the catch
clause does not specify a type, that clause can handle any type of thrown object.

{% pretty_code dart 0 %}
try {
  breedMoreLlamas();
} catch (final OutOfLlamasException e) {  // a specific exception
  buyMoreLlamas();
} catch (final Exception e) {             // anything that is an exception
  print("Unknown exception: $e");
} catch (final e) {                       // no specified type, handles all
  print("Something really unknown: $e");
}
{% endpretty_code %}


#### Finally

To ensure that some code runs whether or not an exception is thrown,
use the finally clause.

If no catch clause matches the exception,
the finally clause runs and then the exception is propagated.

{% pretty_code dart 0 %}
try {
  breedMoreLlamas();
} finally {
  cleanLlamaStalls();  // always run, even if exception is thrown
}
{% endpretty_code %}

The finally clause runs after any matching catch clauses.

{% pretty_code dart 0 %}
try {
  breedMoreLlamas();
} catch (final e) {
  print("Error: $e");  // handle exception first
} finally {
  cleanLlamaStalls();  // then run finally
}
{% endpretty_code %}
