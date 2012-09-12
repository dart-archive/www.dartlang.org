In many object oriented languages such as Java,
Interfaces are types that define how you can interact with an object.
An interface may specify methods,
constructors,
instance variables
(or, more precisely, getters and setters),
and superinterfaces.
It doesn't, however, specify the code _inside_ of
methods and constructors.

This definition may also sound similar to [Abstract Classes](#classes-abstract).
In Dart the decision was made to drop explicit interfaces. 

Dart does however, have implicit interfaces. Anytime you define a class, 
Dart implicitly defines an interface that matches the public signature
of that class.

<section id="interfaces-defining" markdown="1">
### Defining an interface with abstract classes

Since interfaces are only implicit, if you wanted to create an
interface to be used by other classes we need to use the `abstract`
keyword to define the class and methods.
For example, here's the code that defines the
[Hashable](http://api.dartlang.org/dart_core/Hashable.html) interface:

{% highlight dart %}
abstract class Hashable {
  abstract int hashCode();
}
{% endhighlight %}

Notice how, instead of having a method body (`{...}`),
the abstract method just has a semicolon (`;`).

<aside>
  <div class="alert alert-info">
    <strong>Note:</strong>
    Technically, any class, concrete or abstract creates an implicit interface.
    We only need to use an abstract class if we are only concerned about
    creating a class that will not be instantiated.
  </div>
</aside>

</section>


<section id="interfaces-implementing" markdown="1">
### Implementing an interface

A class can implement one or more implicit interfaces
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
specifying that a class implements multiple implicit interfaces:

{% highlight dart %}
class Point implements Comparable, Hashable {
  ...
}
{% endhighlight %}

</section>


<section id="interfaces-extending" markdown="1">
### Extending an interface

Using abstract classes, you can also create an interface
that builds on one or more implicit interfaces.
The new interface is called a _subinterface_,
and all the interfaces it inherits from are its _superinterfaces_.

Use the **extends** keyword
to specify which abstract class (or regular class) you're adding to.
Here's an example of creating an abstract subclass of Hashable:

{% highlight dart %}
abstract class HashablePoint extends Hashable {
  num x, y;
}
{% endhighlight %}

<aside>
  <div class="alert alert-info">
    <strong>Note:</strong>
    Technically, abstract classes don't have instance variables
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


<section id="interfaces-summary" markdown="1">
### Summary of interfaces
Interfaces are part of every class in Dart,
from built-in types to the standard Dart libraries.
Because Dart interfaces are implicit, we can use abstract classes
to build and define interfaces, otherwise they're provided automatically
by any class you create.
</section>
