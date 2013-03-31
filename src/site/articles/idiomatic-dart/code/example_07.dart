class Rectangle {
  num width, height;
  bool contains(num x, num y) => (x < width) && (y < height);
  num area() => width * height;
}