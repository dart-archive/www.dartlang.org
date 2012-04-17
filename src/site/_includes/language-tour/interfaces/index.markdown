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


<section id="interfaces-defining">
### Defining an interface

Use the `interface` keyword to define an interface.
For example, here's the code that defines the
[Hashable](http://api.dartlang.org/dart_core/Hashable.html) interface:

{% pretty_code dart 0 %}
interface Hashable {
  int hashCode();
}
{% endpretty_code %}

Notice how, instead of having a method body (`{...}`),
the interface just has a semicolon (`;`).
</section>


<section id="interfaces-implementing">
### Implementing an interface

A class can implement one or more interfaces
by declaring them in its **implements** clause
and then providing the APIs required by the interfaces.
For example:

{% pretty_code dart 0 %}
class Point <b>implements Hashable</b> {
  num x, y;
  ...
  // required by Hashable
  <b>int hashCode() {</b>
    int result = 17;
    result = 37 * result + x.hashCode();
    result = 37 * result + y.hashCode();
    return result;
  <b>}</b>
  ...
}
{% endpretty_code %}

Here's an example of
specifying that a class implements multiple interfaces:

{% pretty_code dart 0 %}
class Point <b>implements Comparable, Hashable</b> {
  ...
}
{% endpretty_code %}

<aside class="note">
  **Note:**
  Soon you'll be able to treat Dart classes as interfaces.
  This feature will be useful when creating mock objects for testing.
</aside>

</section>


<section id="interfaces-extending">
### Extending an interface

You can create an interface
that builds on one or more interfaces.
The new interface is called a _subinterface_,
and all the interfaces it inherits from are its _superinterfaces_.

Use the **extends** keyword
to specify which interface (or interfaces) you're adding to.
Here's an example of creating a subinterface of Hashable:

{% pretty_code dart 0 %}
interface HashablePoint extends Hashable {
  num x, y;
}
{% endpretty_code %}

<aside class="note">
  **Note:**
  Technically, interfaces don't have instance variables
  such as `x` and `y`.
  What looks like an instance variable is really a
  shortcut for declaring
  [getter and setter methods](#classes-getters-and-setters).
</aside>

Here's an example of implementing a subinterface
and checking types.

{% pc dart 0 %}
class Point implements HashablePoint {
  num x, y; // required by HashablePoint

  // required by Hashable
  int hashCode() {
    ...
  }
}

void main() {
  Point p = new Point();
  print(p is Point);          // true
  print(p is Hashable);       // true
  print(p is HashablePoint);  // true
}
{% endpc %}
</section>


<section id="interfaces-default-class">
### Defining constructors and a default class

An interface can define constructors,
as long as it specifies a _default class_.

<aside class="note">
  **Note:**
  Many of the Dart APIs are implemented as
  interfaces that have default classes.
  For example, all of the <a href="#built-in-types">built-in types</a>,
  including <a href="#numbers">num and int</a>, are interfaces.
</aside>

Use the `default` keyword to specify
the default class.
For example:

{% pretty_code dart 0 %}
interface ObjectCache default MemoryCache {
  ObjectCache();
  ...
}
{% endpretty_code %}

The code for the default class might look like this:

{% pretty_code dart 0 %}
class MemoryCache implements ObjectCache {
  ...
}
{% endpretty_code %}

Invoking a constructor via an interface
results in a call to the equivalent constructor
in the interface's default class.
For example:

{% pc dart 0 %}
var cache = new ObjectCache(); // same as: new MemoryCache()
{% endpc %}

</section>


<section id="interfaces-summary">
### Summary of interfaces
Interfaces are everywhere in Dart,
from built-in types to
many of the types defined in the standard Dart libraries.
Because Dart interfaces can have default classes,
you can use interface constructors.
</section>
