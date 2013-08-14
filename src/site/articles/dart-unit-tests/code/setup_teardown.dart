import 'package:unittest/unittest.dart';

main() {
  group('outer', () {
    test('outer test 1', () => print('outer test 1'));
    setUp(() => print('outer setup 1'));
    tearDown(() => print('outer teardown 1'));
    test('outer test 2', () => print('outer test 2'));
    setUp(() => print('outer setup 2'));
    tearDown(() => print('outer teardown 2'));
    test('outer test 3', () => print('outer test 3'));
    group('inner', () {
      test('inner test 1', () => print('inner test 1'));
      setUp(() => print('inner setup 1'));
      tearDown(() => print('inner teardown'));
      test('inner test 2', () => print('inner test 2'));
      setUp(() => print('inner setup 2'));
      test('inner test 3', () => print('inner test 3'));
      setUp(() => print('inner setup 3'));
    });
  });
}