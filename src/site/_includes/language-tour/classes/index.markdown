Dart is an object oriented language with classes
and single inheritance.

Here's how you declare a class with member variables
and a constructor:

{% pretty_code dart 0 %}
class Point {
	var x, y;
	Point(x, y) {
	  this.x = x;
	  this.y = y;
	}
}
{% endpretty_code %}

The pattern of assigning a constructor argument to
a member variable is so common, Dart has "syntactic suger"
for this common case:

{% pretty_code dart 0 %}
class Point {
	var x, y;
	Point(this.x, this.y);
}
{% end_prettycode %}

