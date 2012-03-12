Dart is an object oriented language with classes
and single inheritance.

Here's how you declare, and then instantiate,
a class with member (aka instance) variables:

{% pc dart 0 %}
class Point {
  num x, y;
}

var point = new Point();
{% endpc %}

#### Constructors

The familiar constructor will create a new instance of a class.

A default, or zero argument, constructor is provided
if you do not declare a constructor.

Declare a constructor by creating a method with the
same name as its class.

{% pc dart 0 %}
class Point {
  num x, y;

  Point(x, y) {
    this.x = x;
    this.y = y;
  }
}
{% endpc %}

The pattern of assigning a constructor argument to
a member variable is so common, Dart has "syntactic suger"
for this convention:

{% pc dart 0 %}
class Point {
  num x, y;
  Point(this.x, this.y);
}
{% endpc %}

#### Getters and setters

Final and non-final variables will generate
an implicit getter method.

{% pc dart 0 %}
var point = new Point(2, 2);
print(point.x);  // 2
{% endpc %}

Non-final variables will generate an implicit
setter method.

{% pc dart 0 %}
var point = new Point(2, 2);
point.y = 4;
print(point.y);  // 4
{% endpc %}

#### Methods

Classes have methods, which are functions that
provide behavior and modify the state of an object.

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

#### Instance variable initialization

Dart only allows compile time constants as initializers
for class level instance variables.

<aside class="note">Note: this restriction is currently under review.</aside>

Compile time constants like numbers and strings can be used
to initialize an instance variable at the class level:

{% pc dart 0 %}
class Point {
  num x = 0,  // compile time constants like numbers works here
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

  Point(x, y) : x = x, y = y;
}
{% endpc %}

An initializer list does not have access to `this`.
Use a static method 

Add a constructor body after an initializer list to
build additional state.

{% pc dart 0 %}
class Point {
  final num x, y;

  Point(x, y) : x = x, y = y {
    
  }
}
{% endpc %}