Dart is an object-oriented language with classes
and single inheritance. The root class is
[Object](http://api.dartlang.org/dart_core/Object.html). 

Here's how you declare, and then instantiate,
a class with member variables (also known as instance variables):

{% pc dart 0 %}
class Point {
  num x, y;
}

main() {
  var point = new Point();
  point.x = 4;
  print(point.x);
}
{% endpc %}

### Constructors

The most common form of constructor, the generative constructor,
creates a new instance of a class.

Declare a constructor by creating a method with the
same name as its class.

{% pc dart 0 %}
class Point {
  num x, y;

  Point(x, y) {
    // there's a better way to do this, stay tuned
    this.x = x;
    this.y = y;
  }
}
{% endpc %}

The `this` keyword references the current instance.

<aside class="note">
*Note*: Only use `this` when there is a name
conflict. Otherwise, Dart style omits the `this`.
</aside>

The pattern of assigning a constructor argument to
a member variable is so common, Dart has syntactic sugar
to make it easy.

{% pc dart 0 %}
class Point {
  num x, y;

  // syntactic sugar for this.x = x
  Point(this.x, this.y);
}
{% endpc %}

#### Default constructors

If you don't declare a constructor,
a default constructor is provided for you.
The default constructor has no arguments and invokes the
superclasses's no-argument constructor.

#### Initializer list

Final variables must be initialized before the object is given to `this`.
Use the initializer list to initialize any final variable.
This initializer list is run before the constructor body.

{% pc dart 0 %}
// an immutable point
class ImmutablePoint {
  final num x, y;

  // what follows the : is the initializer list
  Point(x, y) : x = x, y = y;
}
{% endpc %}

#### Named constructors

Use a named constructor to more clearly indicate what the
constructor is doing. This is useful when multiple
constructors exist for a class.

{% pc dart 0 %}
class Point {
  num x, y;

  // named constructor
  Point.fromJson(Map json) : x = json['x'], y = json['y'];

  Point(this.x, this.y);
}
{% endpc %}

Call a named constructor with `new`:

{% pc dart 0 %}
var jsonData = JSON.parse('{"x":1, "y":2}');
var origin = new Point.fromJson(jsonData);
{% endpc %}

#### Constant constructors

Dart has deterministic object creation,
thus avoiding tricky situations found in other languages.
To achieve this, only immutable
compile-time expressions are allowed
for initial values of instance variable declarations.

An immutable compile-time constant object is a `const` object.
Creating a `const` object requires defining a `const`
constructor and ensuring all instance fields are `final`.

<aside class="note">
*Note*: Another example of a compile-time
constant is a literal number or literal string.
</aside>

{% pc dart 0 %}
class Point {
  final num x, y;
  const Point(this.x, this.y);
  static final Point origin = const Point(0, 0);
}
{% endpc %}

Because compile-time constants are constant and immutable,
constructing two identitical `const` objects results in
one single canonical instance.

{% pc dart 0 %}
void main() {
  var a = const Point(1, 1);
  var b = const Point(1, 1);
  print(a == b); // true!
}
{% endpc %}

#### Factory constructors

Factory constructors can return instances that are not
freshly allocated. For example, a factory constructor
might return an instance from a cache.

Factory constructors can return instances of different classes.
For example a factory constructor might return a subclass.

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

<aside class="note">
Factory constructors have no access to `this`.
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

#### Getters and setters

Getters and setters provide read and write access
to internal object state. They are methods that
do not require trailing parentheses.

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

Both final and non-final variables generate
an implicit getter method.

{% pc dart 0 %}
var point = new Point(2, 2);
print(point.x);  // 2
{% endpc %}

Non-final variables also generate an implicit
setter method.

{% pc dart 0 %}
var point = new Point(2, 2);
point.y = 4;
print(point.y);  // 4
{% endpc %}

### Abstract classes

Dart will support abstract classes and abstract methods.

As of 2012-04-04, abstract is not yet implemented. Follow
bugs [1603](http://code.google.com/p/dart/issues/detail?id=1603)
and [1605](http://code.google.com/p/dart/issues/detail?id=1605)
to track the progress.

### Extending a class

Use `extends` to subclass a class, and `super` to
refer to the superclass.

Subclasses can override instance methods, getters, and setters.

{% pc dart 0 %}
class Television {
  bool _on;

  turnOn() {
    illuminateDisplay();
    activeIrSensor();
    _on = true;
  }

  bool get on() => _on;
}

class SmartTelevision extends Television {
  turnOn() {
    super.turnOn();
    bootNetworkInterface();
    initializeMemory();
    upgradeApps();
  }
}
{% endpc %}

### Instance variable initialization

If you initialize an instance variable where
at the class level declaration
(instead of in a constructor or method),
the initial value must be a compile-time constant.

<aside class="note">
**Note:** this restriction is currently under review.
</aside>

An example of a compile-time constant is a number literal:

{% pc dart 0 %}
class Point {
  num x = 0,
      y = 0;
}
{% endpc %}

### Class level statics

#### Static methods

Methods that belong to a class are called static methods.
These methods do not operate on an instance, and thus
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
  *Best practice*: Consider using top-level functions,
  instance of static methods, for common or widely
  used utilities and functionality.
</aside>

#### Static variables

Variables that belong to a class are called static variables.

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