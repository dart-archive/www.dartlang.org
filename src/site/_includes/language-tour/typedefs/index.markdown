In Dart, functions are objects, just as strings and numbers.
A _typedef_, or _function-type alias_, gives a function type a
name that you can use when declaring fields and return
types. A typedef retains type information
when a function type is assigned to a variable.

Consider the following code, which does not use a typedef.

{% highlight dart %}
class SortedCollection {
  Function compare;

  SortedCollection(int f(Object a, Object b)) {
    compare = f;
  }
}

int sort(Object a, Object b) => 0; // Initial, broken implementation.

main() {
  SortedCollection collection = new SortedCollection(sort);

  // All we know is that compare is a function, but what type of function?
  assert(collection.compare is Function);
}
{% endhighlight %}

Type information is lost when assigning `f` to `compare`.
The type of `f` is `(Object, Object) → int`, yet
the type of `compare` is Function.
If we change the code to use explicit names and retain type information,
both developers and tools can use that information.

Adding a typedef lets Dart retain the type information.

{% highlight dart %}
typedef int Compare(Object a, Object b);

class SortedCollection {
  Compare compare;

  SortedCollection(this.compare);
}

int sort(Object a, Object b) => 0; // Initial, broken implementation.

main() {
  SortedCollection collection = new SortedCollection(sort);
  assert(collection.compare is Function);
  assert(collection.compare is Compare);
}
{% endhighlight %}

<aside class="note" markdown="1">
**Note:** Currently, typedefs are restricted to function types.
This may change in a future version of the language specification.
</aside>

As typedefs are simply aliases, they offer a way to check the
type of any function. For example:

{% highlight dart %}
typedef int Compare(int a, int b);

int sort(int a, int b) => a - b;

main() {
  assert(sort is Compare);  // True!
}
{% endhighlight %}

Typedefs can be parameterized.

{% highlight dart %}
typedef int Compare<T>(T a, T b);

class SortedCollection<T> {
  Compare<T> compare;
  SortedCollection(this.compare);
}

main() {
  SortedCollection<int> s = new SortedCollection<int>((a,b) => a - b);
  assert(s.compare is Compare<int>);
}
{% endhighlight %}