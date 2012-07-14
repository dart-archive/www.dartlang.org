If you look at the API documentation for the basic array type,
[List](http://api.dartlang.org/dart_core/List.html),
you'll see that the type is actually **List\<E>**.
The \<...> notation marks List as a _generic_
(or _parameterized_) type&mdash;a
type that can declare formal type parameters.


### Why use generics?

Because types are optional in Dart,
you never _have_ to use generics.
You might _want_ to, though,
for the same reason you might want to use other types in your code:
Types (generic or not) let you document and annotate your code,
making it easier to express your intent.

For example,
if you intend for a list to contain only strings,
you can declare it as **`List<String>`**
(read that as "List of String").
That way you, your fellow programmers, and your tools
(such as Dart Editor and the Dart VM in checked mode)
can detect that assigning a non-string to the list
is probably a mistake.

{% highlight dart %}
var names = new List<String>();
names.addAll(['Seth', 'Kathy', 'Lars']);
...
names.add(42); // Fails in checked mode (succeeds in production mode).
{% endhighlight %}

Another reason for using generics
is to reduce code duplication.
Generics let you share a single interface
and implementation between many types,
while still taking advantage of checked mode
and static analysis early warnings.
For example,
say you create an interface for caching an object:

{% highlight dart %}
interface ObjectCache {
  Object getByKey(String key);
  setByKey(String key, Object value);
}
{% endhighlight %}

You discover that you want a string-specific version of this interface,
so you create another interface:

{% highlight dart %}
interface StringCache {
  String getByKey(String key);
  setByKey(String key, String value);
}
{% endhighlight %}

Later, you decide you want a number-specific version of this interface...
You get the idea.

Generic types can save you the trouble of creating all these interfaces.
Instead, you can create a single interface that takes a type parameter:

{% highlight dart %}
interface Cache<T> {
  T getByKey(String key);
  setByKey(String key, T value);
}
{% endhighlight %}

In this code, T is the stand-in type.
It's a placeholder that you can think of as
a type that a developer will define later.


<section id="generics-literals" markdown="1">
### Using collection literals

Both built-in collection types are parameterized:
[lists](#lists) and
[maps](#maps).
Parameterized literals are just like the literals you've already seen,
except that you add **`<type>`**
before the opening bracket.
For example:

{% highlight dart %}
var names = <String>['Seth', 'Kathy', 'Lars'];
var pages = <String>{        // Specify value type: String
    'index.html':'Homepage', // (the key type is implicitly String).
    'robots.txt':'Hints for web robots',
    'humans.txt':'We are people, not machines' };
{% endhighlight %}

<aside>
  <div class="alert alert-info">
    <strong>Tip:</strong>
    Map literals always have string _keys_.
    The type before the brace specifies the type of the map's _values_.
  </div>
</aside>

</section>


<section id="generics-constructors" markdown="1">
### Using constructors

To specify one or more types when using a constructor,
put the types in angle brackets
(`<...>`)
just after the class or interface name.
For example:

{% highlight dart %}
var names = new List<String>();
names.addAll(['Seth', 'Kathy', 'Lars']);
var nameSet = new Set<String>.from(names);
{% endhighlight %}

The following code creates a map
that has integer keys and values of type View:

{% highlight dart %}
var views = new Map<int, View>();
{% endhighlight %}
</section>

<section id="generics-collections" markdown="1">
### Generic collections and the types they contain

Dart generic types are _reified_,
which is a fancy way of saying that
they carry their type information around at runtime.
For example, you can test the type of a collection,
even in production mode:

{% highlight dart %}
var names = new List<String>();
names.addAll(['Seth', 'Kathy', 'Lars']);
print(names is List<String>); // true
{% endhighlight %}

However, the **is** expression
checks the type of the _collection_ only&mdash;not
of the objects inside it.
In production mode,
a `List<String>` might have some non-string items in it.
The solution is to either
check each item's type or
wrap item-manipulation code in an [exception handler](#exceptions).

<aside>
  <div class="alert alert-info">
    <strong>Note:</strong>
    In contrast,
    generics in Java use _erasure_,
    which means that generic type parameters are removed at runtime.
    In Java, you can test whether an object is a List,
    but you can't test whether it's a <code>List&lt;String&gt;</code>.
  </div>
</aside>
</section>

<section id="generics-summary" markdown="1">
### Summary of generics

For more information about generics, see
[Optional Types in Dart](http://www.dartlang.org/articles/optional-types/).
</section>
