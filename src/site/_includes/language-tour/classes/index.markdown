Dart is an object-oriented language with classes
and single inheritance.

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

#### this

Inside of a class, the `this` keyword references the
current instance. Only use `this` when there is a name
conflict. Otherwise, Dart style omits the `this`.

{% pc dart 0 %}
class Point {
  num x, y;

  moveX(num amount) {
    // no need for this.x
    x += amount;
  }
}
{% endpc %}

### Constructors

The most common form of constructor, the generative constructor,
creates a new instance of a class.
If you do not declare a constructor,
a default, or zero argument, constructor is provided for you.

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

The pattern of assigning a constructor argument to
a member variable is so common, Dart has syntactic sugar
for this convention.

{% pc dart 0 %}
class Point {
  num x, y;
  // this is sugar for this.x = x
  Point(this.x, this.y);
}
{% endpc %}

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
var origin = new Point.fromJson({'x':1, 'y':2});
{% endpc %}

#### const constructors

`const` objects are compile-time expressions. `const`
constructors allow you to define objects that
can take part in compile-time expressions. `const`
objects are immutable.

Dart wishes to avoid allowing arbitrary expressions for
initial field values, which lead to complications
in other languages. `const` is one way to specify initial
values in an efficient and predictable way. In fact,
`const` objects are the only values allowed in
initial instance field values.

<aside class="note">Another example of a compile-time
  constant is a literal number or literal string.</aside>

{% pc dart 0 %}
class Point {
  final num x, y;
  const Point(this.x, this.y);
  static final Point origin = const Point(0, 0);
}
{% endpc %}

Constructing `const` objects returns compile-time
canonicalized objects.

{% pc dart 0 %}
void main() {
  var a = const Point(1, 1);
  var b = const Point(1, 1);
  print(a == b); // true!
}
{% endpc %}

All instance fields must be final if you have a `const`
constructor in your class.

#### Factory constructors

Factory constructors can return instances that are not
freshly allocated. For example, a factory constructor
may return an instance from a cache.

Factory constructors may return instances of different classes.
For example a factory constructor may return a subclass.

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

<aside class="note">There is no `this` inside a factory constructor.</aside>

### Methods

Classes have methods, which are functions that
provide behavior for an object. Methods may
read or change the state of an object.

{% pc dart 0 %}
class Point {
  num x, y;
  Point(this.x, this.y);

  num distanceTo(Point other) {
    return Math.sqrt(((x-other.x)*(x-other.x)) + ((y-other.y)*(y-other.y)));
  }
}
{% endpc %}

Here's how you call the distanceTo() method on a Point:

{% pc dart 0 %}
var point = new Point(2, 2);
num distance = point.distanceTo(new Point(4,4));
print(distance);  // 2.82842...
{% endpc %}

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
  Best practice: Because Dart has top-level functions, you
  don't always need a static method if all you need is to
  provide some generic functionality.
</aside>

#### Getters and setters

Getters and setters provide read and write access
to internal object state. They appear as properties
to callers.

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

Use getters and setters as you would use properties.

{% pc dart 0 %}
var rect = new Rectange(3, 4, 20, 15);
print(rect.left); // 3
rect.right = 12;
{% endpc %}

Getters and setters help you to start with properties,
and later wrap implementation details with proper methods,
all without changing client code.

Final and non-final variables generate
an implicit getter method.

{% pc dart 0 %}
var point = new Point(2, 2);
print(point.x);  // 2
{% endpc %}

Non-final variables generate an implicit
setter method.

{% pc dart 0 %}
var point = new Point(2, 2);
point.y = 4;
print(point.y);  // 4
{% endpc %}

### Instance variable initialization

Dart only allows compile-time constants as initializers
for class-level instance variables.

<aside class="note">Note: this restriction is currently under review.</aside>

Compile-time constants such as numbers and strings can be used
to initialize an instance variable at the class level:

{% pc dart 0 %}
class Point {
  num x = 0,  // compile-time constants such as numbers works here
      y = 0;
}
{% endpc %}

### Abstract classes

Dart supports abstract classes and abstract methods.

As of 2012-04-04, abstract is not yet implemented. Follow
bugs [1603](http://code.google.com/p/dart/issues/detail?id=1603)
and [1605](http://code.google.com/p/dart/issues/detail?id=1605)
to track the progress.

### Extending a class

Dart supports single inheritance class hierarchies.
Use `extends` to subclass a class, and `super` to
access the superclass.

Subclasses may override instance methods, getters, and setters.

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
