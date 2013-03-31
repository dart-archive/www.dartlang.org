class Rectangle {
  num width, height;

  bool contains(num x, num y) {
    return (x < width) && (y < height);
  }

  num area() {
    return width * height;
  }
}