Interfaces are types that define how you can interact with an object.
An interface can specify methods,
constructors,
instance variables
(or, more precisely, getters and setters),
and superinterfaces.
It doesn't, however, specify the code _inside_ of
methods and constructors.

Interfaces are handy for specifying APIs
without specifying exactly how the APIs are implemented.


<section id="interfaces-defining" markdown="1">
### Defining an interface

Use the `interface` keyword to define an interface.
For example, here's the code that defines the
[Hashable](http://api.dartlang.org/dart_core/Hashable.html) interface:

{% highlight dart %}
interface Hashable {
  int hashCode();
}
{% endhighlight %}

Notice how, instead of having a method body (`{...}`),
the interface just has a semicolon (`;`).
</section>


<section id="interfaces-implementing" markdown="1">
### Implementing an interface

A class can implement one or more interfaces
by declaring them in its **implements** clause
and then providing the APIs required by the interfaces.
For example:

{% highlight dart %}
class Point implements Hashable {
  num x, y;
  ...

  // Required by Hashable.
  int hashCode() {
    int result = 17;
    result = 37 * result + x.hashCode();
    result = 37 * result + y.hashCode();
    return result;
  }
  
  // Always implement operator== if the class implements Hashable.
  bool operator==(other) {
    if (other == null) return false;
    if (other === this) return true;
    return (other.x == x && other.y == y);
  }
}
{% endhighlight %}

Here's an example of
specifying that a class implements multiple interfaces:

{% highlight dart %}
class Point implements Comparable, Hashable {
  ...
}
{% endhighlight %}

<aside>
  <div class="alert alert-info">
    <strong>Tip:</strong>
    Dart classes have implicit interfaces.
    This feature is useful when creating mock objects for testing.
  </div>
</aside>

</section>


<section id="interfaces-extending" markdown="1">
### Extending an interface

You can create an interface
that builds on one or more interfaces.
The new interface is called a _subinterface_,
and all the interfaces it inherits from are its _superinterfaces_.

Use the **extends** keyword
to specify which interface (or interfaces) you're adding to.
Here's an example of creating a subinterface of Hashable:

{% highlight dart %}
interface HashablePoint extends Hashable {
  num x, y;
}
{% endhighlight %}

<aside>
  <div class="alert alert-info">
    <strong>Note:</strong>
    Technically, interfaces don't have instance variables
    such as `x` and `y`.
    What looks like an instance variable is really a
    shortcut for declaring
    [getter and setter methods](#classes-getters-and-setters).
  </div>
</aside>

Here's an example of implementing a subinterface
and checking types.

{% highlight dart %}
class Point implements HashablePoint {
  num x, y; // Required by HashablePoint

  // Required by Hashable
  int hashCode() {
    // ...
  }

  // Always implement operator== if class implements Hashable.
  bool operator==(other) {
    // ...
  }
}

main() {
  var p = new Point();
  assert(p is Point);
  assert(p is Hashable);
  assert(p is HashablePoint);
}
{% endhighlight %}
</section>


<section id="interfaces-default-class" markdown="1">
### Defining constructors and a default class

An interface can define constructors,
as long as it specifies a _default class_.

<aside>
  <div class="alert alert-info">
    <strong>Note:</strong>
    Many of the Dart APIs are implemented as
    interfaces that have default classes.
    For example, all of the <a href="#built-in-types">built-in types</a>,
    including <a href="#numbers">num and int</a>, are interfaces.
  </div>
</aside>

Use the `default` keyword to specify
the default class.
For example:

{% highlight dart %}
interface ObjectCache default MemoryCache {
  ObjectCache();
  // ...
}
{% endhighlight %}

The code for the default class might look like this:

{% highlight dart %}
class MemoryCache implements ObjectCache {
  // ...
}
{% endhighlight %}

Invoking a constructor via an interface
results in a call to the equivalent constructor
in the interface's default class.
For example:

{% highlight dart %}
var cache = new ObjectCache(); // Same as: new MemoryCache()
assert(cache is ObjectCache);
assert(cache is MemoryCache);
{% endhighlight %}

</section>


<section id="interfaces-summary" markdown="1">
### Summary of interfaces
Interfaces are everywhere in Dart,
from built-in types to
many of the types defined in the standard Dart libraries.
Because Dart interfaces can have default classes,
you can use interface constructors.
</section>
