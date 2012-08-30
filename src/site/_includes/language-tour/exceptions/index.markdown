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

{% highlight dart %}
throw new IllegalArgumentException('Value must be greater than zero');
{% endhighlight %}

You can also throw arbitrary objects.

{% highlight dart %}
throw "Out of llamas!";
{% endhighlight %}

#### Catch

Catching, or capturing, an exception stops the exception from propagated.
Catching an exception gives you a chance to handle it.

{% highlight dart %}
try {
  breedMoreLlamas();
} on OutOfLlamasException catch (e) {
  buyMoreLlamas();
}
{% endhighlight %}

To handle code that can throw more than one type of exception, you can specify
multiple catch clauses.
The first catch clause that matches the thrown object's
type handles the exception. If the catch
clause does not specify a type, that clause can handle any type of thrown object.

{% highlight dart %}
try {
  breedMoreLlamas();
} on OutOfLlamasException catch (e) {  // A specific exception
  buyMoreLlamas();
} on Exception catch (e) {             // Anything that is an exception
  print("Unknown exception: $e");
} catch (e) {                       // No specified type, handles all
  print("Something really unknown: $e");
}
{% endhighlight %}


#### Finally

To ensure that some code runs whether or not an exception is thrown,
use the finally clause.

If no catch clause matches the exception,
the finally clause runs and then the exception is propagated.

{% highlight dart %}
try {
  breedMoreLlamas();
} finally {
  cleanLlamaStalls();  // Always clean up, even if exception is thrown.
}
{% endhighlight %}

The finally clause runs after any matching catch clauses.

{% highlight dart %}
try {
  breedMoreLlamas();
} catch (e) {
  print("Error: $e");  // Handle exception first.
} finally {
  cleanLlamaStalls();  // Then clean up.
}
{% endhighlight %}

Learn more about
<a href="/docs/library-tour/#exceptions">exceptions</a> in the library tour.
