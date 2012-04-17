Dart is an object-oriented language with classes
and single inheritance. The root class is
[Object](http://api.dartlang.org/dart_core/Object.html). 

### Instance variables

Here's how you declare
a class with instance variables
(also known as member variables):

{% pc dart 0 %}
class Point {
  num x, y;
}
{% endpc %}

All uninitialized instance variables have the value `null`.

Both final and non-final instance variables generate
an implicit getter method. Non-final instance variables
generate an implicit setter method.
([Getters and setters](#classes-getters-and-setters) are discussed more later.)

{% pc dart 0 %}
main() {
  var point = new Point();

  // use the setter method for x
  point.x = 4;

  // use the getter method for x
  print(point.x);  // 4

  // values default to null
  print(point.y);  // null
}
{% endpc %}

#### Instance variable initialization

If you initialize an instance variable
where it is declared
(instead of in a constructor or method),
the initial value must be a compile-time constant.

<aside class="note">
**Note:** This restriction is currently under review.
</aside>

An example of a compile-time constant is a number literal:

{% pc dart 0 %}
class Point {
  num x = 0,
      y = 0;
}
{% endpc %}

Use the constructor body, demonstrated in the next section,
to assign non-constant values to instance variables.

### Constructors

Declare a constructor by creating a method with the
same name as its class. The most common form of constructor,
the generative constructor,
creates a new instance of a class.

{% pc dart 0 %}
class Point {
  num x, y;

  Point(num x, num y) {
    // there's a better way to do this, stay tuned
    this.x = x;
    this.y = y;
  }
}
{% endpc %}

The `this` keyword references the current instance.

<aside class="note">
**Note:** Use `this` only when there is a name
conflict. Otherwise, Dart style omits the `this`.
</aside>

The pattern of assigning a constructor argument to
a member variable is so common, Dart has syntactic sugar
to make it easy.

{% pc dart 0 %}
class Point {
  num x, y;

  // syntactic sugar for this.x = x and this.y = y
  Point(this.x, this.y);
}
{% endpc %}

#### Default constructors

If you don't declare a constructor,
a default constructor is provided for you.
The default constructor has no arguments and invokes the
the no-argument constructor in the superclass.

#### Initializer list

Final variables must be initialized before the object is assigned to `this`.
Use the initializer list, which runs before the constructor body,
to initialize any final variables.

{% pc dart 0 %}
#import('dart:html');

class Button {
  final Collection<ButtonHandler> handlers;
  final String domId;
  final Element elem;
  
                // what follows the : is the initializer list
  Button(domId) : domId = domId,
                  handlers = [],
                  elem = document.query(domId) {
    bindHandlers();
  }

  bindHandlers() {
   // ...
  }
}
{% endpc %}

The right-hand side of an initializer does not have access
to `this`.

#### Named constructors

Use a named constructor to implement multiple
constructors for a class or to provide extra clarity.

{% pc dart 0 %}
class Point {
  num x, y;

  // named constructor
  Point.fromJson(Map json) : x = json['x'], y = json['y'];

  Point(this.x, this.y);
}
{% endpc %}

Create new instances from a named constructor with `new`:

{% pc dart 0 %}
var jsonData = JSON.parse('{"x":1, "y":2}');
var point = new Point.fromJson(jsonData);
{% endpc %}

#### Constant constructors

Dart has deterministic object creation,
thus avoiding tricky situations found in other languages.
To achieve this, only immutable
compile-time expressions are allowed
for the initial values of instance variable declarations.

An immutable compile-time constant object is known as a `const` object.
Creating a `const` object requires defining a `const`
constructor and ensuring all instance fields are `final`.

{% pc dart 0 %}
class Point {
  final num x, y;
  const Point(this.x, this.y);
  static final Point origin = const Point(0, 0);
}
{% endpc %}

Because compile-time constants are constant and immutable,
constructing two identitical `const` objects results in
a single, canonical instance.

{% pc dart 0 %}
void main() {
  var a = const Point(1, 1);
  var b = const Point(1, 1);

  print(a === b); // true, they are the same instance!
}
{% endpc %}

<aside class="note">
**Note:** Other examples of compile-time
constants are literal numbers and literal strings.
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

{% pc dart 0 %}
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
{% endpc %}

As for other constructors,
to invoke a factory constructor you use the `new` keyword:

{% pc dart 0 %}
var logger = new Logger('UI');
logger.log('Button clicked');
{% endpc %}

<aside class="note">
**Note:** Factory constructors have no access to `this`.
</aside>

### Methods

Methods are functions that
provide behavior for an object.

#### Instance methods

Instance methods on objects can access instance variables and `this`.
The distanceTo() method in the following sample is an
example of an instance method.

{% pc dart 0 %}
class Point {
  num x, y;
  Point(this.x, this.y);

  num distanceTo(Point other) {
    return Math.sqrt(((x-other.x)*(x-other.x)) + ((y-other.y)*(y-other.y)));
  }
}
{% endpc %}

Here's how you invoke the distanceTo() method on
an instance of Point:

{% pc dart 0 %}
var point = new Point(2, 2);
num distance = point.distanceTo(new Point(4,4));
print(distance);  // 2.82842...
{% endpc %}

<section id="classes-getters-and-setters">
#### Getters and setters

Getter and setter methods provide read and write access
to internal object state. When calling a getter
or setter, omit the trailing parentheses.
Define getters and setters using the `get` and `set`
keywords.

{% pc dart 0 %}
class Rectangle {
  num left, top, width, height;

  Rectangle(this.left, this.top, this.width, this.height);

  num get right()           => left + width;
      set right(num value)  => left = value - width;
  num get bottom()          => top + height;
      set bottom(num value) => top = value - height;
}
{% endpc %}

Use explicit getters and setters just like you
would use the generated getters and setters from
instance variables.

{% pc dart 0 %}
var rect = new Rectangle(3, 4, 20, 15);
print(rect.left); // 3
rect.right = 12;
print(rect.left); // -8
{% endpc %}

With getters and setters, you can start
with instance variables,
later wrapping them with methods,
all without changing client code.

<section id="classes-operators">
#### Operators

Because operators are just instance methods with special names,
you can override [many operators](#op-methods).
Here's an example of a class that overrides the `+` and `-` operators.

{% pc dart 0 %}
class Vector {
  final int x,y;
  const Vector(this.x, this.y);

  Vector operator +(Vector v) { //overrides + (a + b)
    return new Vector(x + v.x, y + v.y);
  }
  
  Vector operator -(Vector v) { //overrides - (a - b)
    return new Vector(x - v.x, y - v.y);
  }
  
  Vector operator negate() {    //overrides unary negation (-a)
    return new Vector(-x,-y);
  }
  
  String toString() => '($x,$y)';
}

main() {
  Vector v = new Vector(2,3);
  Vector w = new Vector(2,2);
  print(v);   //(2,3)
  print(-v);  //(-2,-3)
  print(v+w); //(4,5)
  print(v-w); //(0,1)
}{% endpc %}

<aside class="note">
**Implementation note:**
Overriding `-` affects only the binary subtraction operator.
To override the unary form of `-`,
you must use the special identifier **negate**.
</aside>

</section>
</section>


### Abstract classes

Dart will support abstract classes and abstract methods.

As of 2012-04-04, abstract is not yet implemented. Follow
bugs [1603](http://code.google.com/p/dart/issues/detail?id=1603)
and [1605](http://code.google.com/p/dart/issues/detail?id=1605)
to track the progress.

### Extending a class

Use `extends` to create a subclass, and `super` to
refer to the superclass.

{% pc dart 0 %}
class Television {
  turnOn() {
    _illuminateDisplay();
    _activeIrSensor();
  }
}

class SmartTelevision extends Television {
  turnOn() {
    super.turnOn();
    _bootNetworkInterface();
    _initializeMemory();
    _upgradeApps();
  }
}
{% endpc %}

Subclasses can override instance methods, getters, and setters.

### Class-level static members

Use the `static` keyword to implement class-wide variables and methods.

#### Static methods

Static methods (class methods) do not operate on an instance, and thus
do not have access to `this`.

{% pc dart 0 %}
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
  print(Point.distanceBetween(a, b));  // 2.82842...
}
{% endpc %}

<aside class="note">
  **Best practice:** Consider using top-level functions,
  instead of static methods, for common or widely
  used utilities and functionality.
</aside>

#### Static variables

Static variables (class variables) are useful for class-wide state and
constants.

{% pc dart 0 %}
class Color {
  static final RED = const Color('red');
  final String name;
  const Color(this.name);
  String toString() => name;
}

main() {
  print(Color.RED); // 'red'
}
{% endpc %}