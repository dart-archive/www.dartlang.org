class Rectangle {
  num left, top;
  num _width, _height;

  Rectangle(this.left, this.top, this._width, this._height);

  num get width => _width;
  set width(num value) {
    if (value < 0) throw 'Width cannot be negative.';
    _width = value;
  }

  num get height => _height;
  set height(num value) {
    if (value < 0) throw 'Height cannot be negative.';
    _height = value;
  }

  num get right             => left + width;
      set right(num value)  => left = value - width;
  num get bottom            => top + height;
      set bottom(num value) => top = value - height;

}