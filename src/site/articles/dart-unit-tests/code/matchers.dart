library test;
import 'package:unittest/unittest.dart';
import 'package:unittest/vm_config.dart';

class Foo {

}

class _IsFoo extends TypeMatcher {
  const _IsFoo() : super('Foo');
  bool matches(item, Map matchState) => item is Foo;
}
const isFoo = const _IsFoo();


main() {
  useVMConfiguration();

  test('Exception type', () {
      expect(()=> throw 'X',
      throwsA(new isInstanceOf<String>()));

      var x = null;
      expect(x, isFoo);
  });

  test('Range Error', () {
    expect(()=> throw new RangeError("out of range"),
        throwsRangeError);
  });

  test('other', () {
    expect([1, 2, 3, 4], contains(isNonZero));
    var isString = predicate((e) => e is String, 'is a String');

    expect(() => throw 'X', throwsA(isString));
  });
}
