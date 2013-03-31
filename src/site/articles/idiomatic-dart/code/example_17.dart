class Vector {
  num x, y;
  Vector(this.x, this.y);
  operator +(Vector other) => new Vector(x + other.x, y + other.y);
}

main() {
  var position = new Vector(3, 4);
  var velocity = new Vector(1, 2);
  var newPosition = position + velocity;
}