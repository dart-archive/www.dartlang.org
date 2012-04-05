Dart is an object-oriented language with classes
and single inheritance.

Here's how you declare, and then instantiate,
a class with member variables (also known as instance variables):

{% pc dart 0 %}
class Point {
  num x, y;
}

var point = new Point();
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

#### Constructors

The constructor creates a new instance of a class.
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

#### Methods

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

#### Instance variable initialization

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

#### Initializer list

Final variables must be initialized before the object is given to `this`.
Use the initializer list to initialize any final variable.
This initializer list is run before the constructor body.

{% pc dart 0 %}
// an immutable point
class Point {
  final num x, y;

  // what follows the : is the initializer list
  Point(x, y) : x = x, y = y;
}
{% endpc %}