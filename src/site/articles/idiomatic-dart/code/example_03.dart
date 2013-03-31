import 'dart:math';

class Point {
  num x, y;
  Point(this.x, this.y);
  Point.zero() : x = 0, y = 0;
  Point.polar(num theta, num radius) {
    x = cos(theta) * radius;
    y = sin(theta) * radius;
  }
}

main() {
  var a = new Point(1, 2);
  var b = new Point.zero();
  var c = new Point.polar(PI, 4.0);
}