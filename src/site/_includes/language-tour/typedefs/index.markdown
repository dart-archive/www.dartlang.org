In Dart, functions are objects, just as strings and numbers.
A _typedef_, or _function-type alias_, gives a function type a
name that you can use when declaring fields and return
types. A typedef retains type information
when a function type is assigned to a variable.

Consider the following code, which does not use a typedef.

{% pc dart 0 %}
class SortedCollection {
  Function compare;

  SortedCollection(int f(Object a, Object b)) {
    compare = f;
  }
}

int sort(Object a, Object b) => ... ;

main() {
  SortedCollection collection = new SortedCollection(sort);

  // all we know is that compare is a function, but what type of function?
  print(collection.compare is Function);  // true
}
{% endpc %}

Type information is lost when assigning `f` to `compare`.
The type of `f` is `(Object, Object) → int`, yet
the type of `compare` is Function.
If we change the code to use explicit names and retain type information,
both developers and tools can use that information.

Adding a typedef lets Dart retain the type information.

{% pc dart 0 %}
<b>typedef int Compare(Object a, Object b);</b>

class SortedCollection {
  Compare compare;

  SortedCollection(this.compare);
}

int sort(Object a, Object b) => ... ;

main() {
  SortedCollection collection = new SortedCollection(sort);
  print(collection.compare is Function);  // true
  print(collection.compare is Compare);   // true
}
{% endpc %}

<aside class="note" markdown="1">
**Note:** Currently, typedefs are restricted to function types.
This may change in a future version of the language specification.
</aside>

As typedefs are simply aliases, they offer a way to check the
type of any function. For example:

{% pc dart 0 %}
typedef int Compare(int a, int b);

int sort(int a, int b) => a - b;

main() {
  print(sort is Compare);  // true!
}
{% endpc %}

Typedefs can be parameterized.

{% pc dart 0 %}
typedef int Compare&lt;T>(T a, T b);

class SortedCollection&lt;T> {
  Compare&lt;T> compare;
  SortedCollection(this.compare);
}

main() {
  SortedCollection&lt;int> s = new SortedCollection&lt;int>((a,b) => a - b);
  print(s.compare is Compare&lt;int>);  // true
  print(s.compare('a','b'));  // checked mode throws exception
}
{% endpc %}