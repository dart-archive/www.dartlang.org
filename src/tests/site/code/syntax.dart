import 'dart:math';                   // Import a library.

abstract class Shape {
  num get area;
  num rotation = 0;
  num outlineWidth = 1;
  String color = 'black';
}

class Ellipse extends Shape {              // Declare a class.
  num majorAxis = 0;                       // An instance variable (property).
  num minorAxis = 0;
  static const num C = PI/4;              // A constant.
  num get area => C*majorAxis*minorAxis;   // A property implemented with a getter.

  Ellipse(this.majorAxis, this.minorAxis); // Compact constructor syntax.
  Ellipse.circle(diameter) {               // A named constructor.
    minorAxis = majorAxis = diameter;
  }
  
  // Override Object's toString() method.
  String toString() =>
      'Ellipse: ${majorAxis}x${minorAxis} ($area); rotation: $rotation; $color';
}

// Functions and variables can be inside or outside of classes.
var shapes = new List();              // A global variable.
addShape(shape) => shapes.add(shape); // Function shorthand syntax.

// Every app has a main() function, where execution starts.
main() {  
  // The cascade operator (..) saves you from repetitive typing.
  addShape(new Ellipse(10, 20)..rotation = 45*PI/180
                              ..color = 'rgb(0,129,198)'
                              ..outlineWidth = 0);
  
  // Convert expressions to strings using ${...}.
  print('Area of the first shape: ${shapes[0].area}');
  print(shapes[0]);
}