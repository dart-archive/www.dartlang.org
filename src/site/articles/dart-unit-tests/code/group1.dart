import 'package:unittest/unittest.dart';

main() {
  group('My test group', () {
    test('Test 1', () => expect(0, equals(1)));
    test('Test 2', () => expect(1, equals(0)));
  });
}
