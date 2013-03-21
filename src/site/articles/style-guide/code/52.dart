test1() {
  // Good
  var list = new List()
      ..addAll([1,2,3])
      ..addAll([4,5,6]);
}

test2() {
  // Bad
  var list = new List()
    ..addAll([1,2,3])
    ..addAll([4,5,6]);
}
