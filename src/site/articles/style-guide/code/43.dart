class SomeType {

}

main() {
  var obj;
  var object;
  var a, b, c, d;
  var condition;

  a = 1 + 2 / (3 * -b);
  c = !condition == a > b;
  d = condition ? b : object.method(a, b, c);
  if (obj is! SomeType) print('not SomeType');

  // Bad

  a=1+2/(3* - b);
  c= ! condition==a>b;
  d= condition?b:object.method(a,b,c);
  if (obj is !SomeType) print('not SomeType');
}