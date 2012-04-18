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
you can declare it as **List&lt;String>**
(read that as "List of String").
That way you, your fellow programmers, and your tools
(such as Dart Editor and the Dart VM in checked mode)
can detect that assigning a non-string to the list
is probably a mistake.

{% pc dart 0 %}
List&lt;String> names = new List&lt;String>();
names.addAll(['Seth', 'Kathy', 'Lars']);
...
names.add(42); // fails in checked mode (succeeds in production mode)
{% endpc %}

Another reason for using generics
is to reduce code duplication.
Generics let you share a single interface
and implementation between many types,
while still taking advantage of checked mode
and static analysis early warnings.
For example,
say you create an interface for caching an object:

{% pc dart 0 %}
interface ObjectCache {
  Object getByKey(String key);
  setByKey(String key, Object value);
}
{% endpc %}

You discover that you want a string-specific version of this interface,
so you create another interface:

{% pc dart 0 %}
interface StringCache {
  String getByKey(String key);
  setByKey(String key, String value);
}
{% endpc %}

Later, you decide you want a number-specific version of this interface...
You get the idea.

Generic types can save you the trouble of creating all these interfaces.
Instead, you can create a single interface that takes a type parameter:

{% pc dart 0 %}
interface Cache&lt;T> {
  T getByKey(String key);
  setByKey(String key, T value);
}
{% endpc %}

In this code, T is the stand-in type.
It's a placeholder that you can think of as
a type that a developer will define later.


<section id="generics-literals">
### Using collection literals

Both built-in collection types are parameterized:
[lists](#lists) and
[maps](#maps).
Parameterized literals are just like the literals you've already seen,
except that you add **&lt;<em>type</em>>**
before the opening bracket.
For example:

{% pc dart 0 %}
List&lt;String> names = <b>&lt;String></b>['Seth', 'Kathy', 'Lars'];
Map&lt;String, String> pages = <b>&lt;String></b>{ // specify <b>value</b> type: String
    'index.html':'Homepage',  // (the <b>key</b> type is implicitly String)
    'robots.txt':'Hints for web robots',
    'humans.txt':'We are people, not machines' };
{% endpc %}

<aside class="note">
  **Note:**
  Map literals always have string _keys_.
  The type before the brace specifies the type of the map's _values_.
</aside>

</section>


<section id="generics-constructors">
### Using constructors

To specify one or more types when using a constructor,
put the types in angle brackets
(<code>&lt;...></code>)
just after the class or interface name.
For example:

{% pc dart 0 %}
List&lt;String> names = new List<b>&lt;String></b>();
names.addAll(['Seth', 'Kathy', 'Lars']);
Set&lt;String> nameSet = new Set<b>&lt;String></b>.from(names);
{% endpc %}

The following code creates a map
that has integer keys and values of type View:

{% pc dart 0 %}
Map&lt;int, View> views = new Map<b>&lt;int, View></b>();
{% endpc %}
</section>

<section id="generics-collections">
### Generic collections and the types they contain

Dart generic types are _reified_,
which is a fancy way of saying that
they carry their type information around at runtime.
For example, you can test the type of a collection,
even in production mode:

{% pc dart 0 %}
List&lt;String> names = new List&lt;String>();
names.addAll(['Seth', 'Kathy', 'Lars']);
print(names is List&lt;String>);           // true
{% endpc %}

However, the **is** expression
checks the type of the _collection_ only&mdash;not
of the objects inside it.
In production mode,
a List&lt;String> might have some non-string items in it.
The solution is to either
check each item's type or
wrap item-manipulation code in an [exception handler](#exceptions).

<aside class="note">
  **Note:**
  In contrast,
  generics in Java use _erasure_,
  which means that generic type parameters are removed at runtime.
  In Java, you can test whether an object is a List,
  but you can't test whether it's a List&lt;String>.
</aside>
</section>


<section id="generics-summary">
### Summary of generics

For more information about generics, see
[Optional Types in Dart](http://www.dartlang.org/articles/optional-types/).
</section>
