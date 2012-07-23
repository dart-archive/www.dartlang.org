Dart is an object-oriented language with classes
and single inheritance. The root class is
[Object](http://api.dartlang.org/dart_core/Object.html).

### Instance variables

Here's how you declare
a class with instance variables
(also known as member variables):

{% highlight dart %}
class Point {
  num x, y;
}
{% endhighlight %}

All uninitialized instance variables have the value `null`.

Both final and non-final instance variables generate
an implicit getter method. Non-final instance variables
generate an implicit setter method.
([Getters and setters](#classes-getters-and-setters) are discussed more later.)

{% highlight dart %}
class Point {
  num x, y;
}

main() {
  var point = new Point();
  point.x = 4;             // Use the setter method for x.
  assert(point.x == 4);    // Use the getter method for x.
  assert(point.y == null); // Values default to null.
}
{% endhighlight %}

#### Instance variable initialization

If you initialize an instance variable
where it is declared
(instead of in a constructor or method),
the initial value must be a compile-time constant.

<aside>
  <div class="alert alert-info">
    <strong>Note:</strong>
    This restriction is currently under review.
  </div>
</aside>

An example of a compile-time constant is a number literal:

{% highlight dart %}
class Point {
  num x = 0,
      y = 0;
}
{% endhighlight %}

Use the constructor body, demonstrated in the next section,
to assign non-constant values to instance variables.

### Constructors

Declare a constructor by creating a method with the
same name as its class. The most common form of constructor,
the generative constructor,
creates a new instance of a class.

{% highlight dart %}
class Point {
  num x, y;

  Point(num x, num y) {
    // There's a better way to do this, stay tuned.
    this.x = x;
    this.y = y;
  }
}
{% endhighlight %}

The `this` keyword references the current instance.

<aside>
  <div class="alert alert-info">
    <strong>Tip:</strong>
    Use <code>this</code> only when there is a name
    conflict. Otherwise, Dart style omits the <code>this</code>.
  </div>
</aside>

The pattern of assigning a constructor argument to
a member variable is so common, Dart has syntactic sugar
to make it easy.

{% highlight dart %}
class Point {
  num x, y;

  // Syntactic sugar for this.x = x and this.y = y
  Point(this.x, this.y);
}
{% endhighlight %}

#### Default constructors

If you don't declare a constructor,
a default constructor is provided for you.
The default constructor has no arguments and invokes
the no-argument constructor in the superclass.

#### Constructors aren't inherited

Subclasses don't inherit constructors from their superclass.
A subclass that declares no constructors will have
only the default (no-argument, no name) constructor.

#### Initializer list

Final variables must be initialized before the object is assigned to `this`.
Use the initializer list, which runs before the constructor body,
to initialize any final variables.

{% highlight dart %}
#import('dart:html');

class Button {
  final Collection<ButtonHandler> handlers;
  final String domId;
  final Element elem;

                // What follows the : is the initializer list.
  Button(domId) : domId = domId,
                  handlers = [],
                  elem = document.query(domId) {
    bindHandlers();
  }

  bindHandlers() {
    // ...
  }
}
{% endhighlight %}

The right-hand side of an initializer does not have access
to `this`.

#### Named constructors

Use a named constructor to implement multiple
constructors for a class or to provide extra clarity.

{% highlight dart %}
class Point {
  num x, y;

  // Named constructor
  Point.fromJson(Map json) : x = json['x'], y = json['y'];

  Point(this.x, this.y);
}
{% endhighlight %}

Create new instances from a named constructor with `new`:

{% highlight dart %}
var jsonData = JSON.parse('{"x":1, "y":2}');
var point = new Point.fromJson(jsonData);
{% endhighlight %}

Remember that constructors are not inherited, which means
that a superclass's named constructor is not
inherited by a subclass. If you want a subclass to be created
with a named constructor defined in the superclass, you
must implement that constructor in the subclass.

By default, a constructor in a subclass will call the superclass's
default constructor. If no default (zero-argument) constructor
is defined in the superclass, you must manually call
a constructor in the superclass.

For example:

{% highlight dart %}
class Person {
  Person.fromJson(Map data) {
    print('in Person');
  }
}

class Employee extends Person {
  // Person does not have a default constructor;
  // you must call super.fromJson(data).
  Employee.fromJson(Map data) : super.fromJson(data) {
    print('in Employee');
  }
}

main() {
  var emp = new Employee.fromJson({});

  // Prints:
  // in Person
  // in Employee
}
{% endhighlight %}


#### Constant constructors

Dart has deterministic object creation,
thus avoiding tricky situations found in other languages.
To achieve this, only immutable
compile-time expressions are allowed
for the initial values of instance variable declarations.

An immutable compile-time constant object is known as a `const` object.
Creating a `const` object requires defining a `const`
constructor and ensuring all instance fields are `final`.

{% highlight dart %}
class Point {
  final num x, y;
  const Point(this.x, this.y);
  static final Point origin = const Point(0, 0);
}
{% endhighlight %}

Because compile-time constants are constant and immutable,
constructing two identical `const` objects results in
a single, canonical instance.

{% highlight dart %}
void main() {
  var a = const Point(1, 1);
  var b = const Point(1, 1);

  assert(a === b); // They are the same instance!
}
{% endhighlight %}

<aside>
  <div class="alert alert-info">
    <strong>Tip:</strong>
    Other examples of compile-time
    constants are literal numbers and literal strings.
  </div>
</aside>

#### Factory constructors

Use the `factory` keyword
when implementing a constructor that
doesn't always create a new instance of its class.
For example, a factory constructor
might return an instance from a cache,
or it might return an instance of a subclass.

The following example demonstrates a factory constructor
returning objects from a cache.

{% highlight dart %}
class Logger {
  final String name;
  bool mute = false;

  static Map<String, Logger> _cache;

  factory Logger(String name) {
    if (_cache == null) {
      _cache = {};
    }

    if (_cache.containsKey(name)) {
      return _cache[name];
    } else {
      final logger = new Logger._internal(name);
      _cache[name] = logger;
      return logger;
    }
  }

  Logger._internal(this.name);

  log(String msg) {
    if (!mute) {
      print(msg);
    }
  }
}
{% endhighlight %}

As for other constructors,
to invoke a factory constructor you use the `new` keyword:

{% highlight dart %}
var logger = new Logger('UI');
logger.log('Button clicked');
{% endhighlight %}

<aside>
  <div class="alert alert-info">
    <strong>Tip:</strong>
    Factory constructors have no access to <code>this</code>.
  </div>
</aside>

You can use a factory constructor to return a subclass.
For example, the following code returns either a
file or directory, based on a constructor argument:

{% highlight dart %}
/** Some file system entry, either a directory or a file. */
class Entry {
  factory Entry(String path) {
    if (/* path is pointing to a file */) {
      return new File(path);
    } else {
      return new Directory(path);
    }
  }
}

class File extends Entry {
  ...
}

class Directory extends Entry {
  ...
}
{% endhighlight %}

Factory constructors are useful when you want to perform
non-trivial work on values destined for final fields.
In Dart, all final fields must be initialized in the constructor
initialization list. That means that, unlike Java and C#, we
don't have the luxury of having a nice constructor body where we
can do arbitrary statements to calculate stuff before we finally
know what to store in those fields. If you need to do that,
you can instead use a factory constructor to do that work, which
then delegates to the real constructor to initialize those fields.

{% highlight dart %}
class Name {
  final String first;
  final String last;

  factory Name(String name) {
    var parts = name.split(' ');
    return new Name._(parts[0], parts[1]);
  }

  Name._(this.first, this.last);
}
{% endhighlight %}

### Methods

Methods are functions that
provide behavior for an object.

#### Instance methods

Instance methods on objects can access instance variables and `this`.
The distanceTo() method in the following sample is an
example of an instance method.

{% highlight dart %}
class Point {
  num x, y;
  Point(this.x, this.y);

  num distanceTo(Point other) {
    return Math.sqrt(((x-other.x)*(x-other.x)) + ((y-other.y)*(y-other.y)));
  }
}
{% endhighlight %}

Here's how you invoke the distanceTo() method on
an instance of Point:

{% highlight dart %}
var point = new Point(2, 2);
num distance = point.distanceTo(new Point(4,4));
assert(distance < 2.9 && distance > 2.8);
{% endhighlight %}

<section id="classes-getters-and-setters" markdown="1">
#### Getters and setters

Getter and setter methods provide read and write access
to internal object state. When calling a getter
or setter, omit the trailing parentheses.
Define getters and setters using the `get` and `set`
keywords.

{% highlight dart %}
class Rectangle {
  num left, top, width, height;

  Rectangle(this.left, this.top, this.width, this.height);

  num get right()           => left + width;
      set right(num value)  => left = value - width;
  num get bottom()          => top + height;
      set bottom(num value) => top = value - height;
}
{% endhighlight %}

Use explicit getters and setters just like you
would use the generated getters and setters from
instance variables.

{% highlight dart %}
var rect = new Rectangle(3, 4, 20, 15);
assert(rect.left == 3);
rect.right = 12;
assert(rect.left == -8);
{% endhighlight %}

With getters and setters, you can start
with instance variables,
later wrapping them with methods,
all without changing client code.

<section id="classes-operators" markdown="1">
#### Operators as methods

Because operators are just instance methods with special names,
you can override [many operators](#op-methods).
Here's an example of a class that overrides the `+` and `-` operators.

{% highlight dart %}
class Vector {
  final int x,y;
  const Vector(this.x, this.y);

  Vector operator +(Vector v) { // Overrides + (a + b).
    return new Vector(x + v.x, y + v.y);
  }

  Vector operator -(Vector v) { // Overrides - (a - b).
    return new Vector(x - v.x, y - v.y);
  }

  Vector operator negate() {    // Overrides unary negation (-a).
    return new Vector(-x,-y);
  }

  String toString() => '($x,$y)';
}

main() {
  final v = new Vector(2,3);
  final w = new Vector(2,2);

  assert(v.x == 2 && v.y == 3);         // v   == (2,3)
  assert((-v).x == -2 && (-v).y == -3); // -v  == (-2,-3)
  assert((v+w).x == 4 && (v+w).y == 5); // v+w == (4,5)
  assert((v-w).x == 0 && (v-w).y == 1); // v-w == (0,1)
}{% endhighlight %}

<aside>
  <div class="alert alert-info">
    <strong>Tip:</strong>
    Overriding <code>-</code> affects only the binary subtraction operator.
    To override the unary form of <code>-</code>,
    you must use the special identifier <b>negate</b>.
  </div>
</aside>

</section>
</section>


### Abstract classes {#classes-abstract}

Dart supports abstract classes and methods.
Use the **abstract** keyword whenever you
want to create a class that leaves some implementation details
up to its subclasses.

In normal use, you shouldn't create instances of an abstract class.
However, Dart doesn't prevent you from doing so.
For example, you might instantiate an abstract class
to provide mock objects for testing.

You can mark either classes or methods as abstract.
If a class has any abstract methods, then the class itself is abstract.
Here's an example of declaring an abstract class that has an abstract method.

{% highlight dart %}
// This class is abstract because it has an abstract method.
class AbstractContainer {
  // ... define constructors, fields, methods ...

  abstract void updateChildren(); // Abstract methods have no body.
}
{% endhighlight %}

A subclass of an abstract class should either
implement all abstract methods or declare itself as abstract.
Here's an example of an abstract subclass.

{% highlight dart %}
abstract class AbstractSpecializedContainer extends AbstractContainer {
  // ... define more constructors, fields, methods ...

  // OK to not implement updateChildren(), since this class is abstract.
}
{% endhighlight %}

Finally, here's an example of implementing and instantiating
a subclass of an abstract class.

{% highlight dart %}
class SpecializedContainer extends AbstractSpecializedContainer {

  // Implement the abstract method defined by AbstractContainer.
  void updateChildren() {
    // ... Do something.
  }
}

main() {
  var c1 = new SpecializedContainer();

  // You can instantiate abstract classes (but you'll get a warning).
  var c2 = new AbstractContainer(); // WARNING

  assert(c1 is AbstractContainer);
  assert(c2 is AbstractContainer);
}
{% endhighlight %}


### Extending a class

Use `extends` to create a subclass, and `super` to
refer to the superclass.

{% highlight dart %}
class Television {
  void turnOn() {
    _illuminateDisplay();
    _activateIrSensor();
  }
}

class SmartTelevision extends Television {
  void turnOn() {
    super.turnOn();
    _bootNetworkInterface();
    _initializeMemory();
    _upgradeApps();
  }
}
{% endhighlight %}

Subclasses can override instance methods, getters, and setters.

### Class-level static members

Use the `static` keyword to implement class-wide variables and methods.

#### Static methods

Static methods (class methods) do not operate on an instance, and thus
do not have access to `this`.

{% highlight dart %}
class Point {
  num x, y;
  Point(this.x, this.y);

  static num distanceBetween(Point a, Point b) {
    return Math.sqrt(((a.x-b.x)*(a.x-b.x)) + ((a.y-b.y)*(a.y-b.y)));
  }
}

main() {
  var a = new Point(2, 2);
  var b = new Point(4, 4);
  var distance = Point.distanceBetween(a,b);
  assert(distance < 2.9 && distance > 2.8);
}
{% endhighlight %}

<aside>
  <div class="alert alert-info">
    <strong>Tip:</strong>
    Consider using top-level functions,
    instead of static methods, for common or widely
    used utilities and functionality.
  </div>
</aside>

#### Static variables

Static variables (class variables) are useful for class-wide state and
constants.

{% highlight dart %}
class Color {
  static final RED = const Color('red');
  final String name;
  const Color(this.name);
}

main() {
  assert(Color.RED.name == 'red');
}
{% endhighlight %}
