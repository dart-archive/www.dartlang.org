import 'package:unittest/unittest.dart';

main() {
  var description = 'a test description';
  
  group('foo', () {
    setUp(() {/*...*/});
    tearDown(() {/*...*/});
    test(description, () {/*...*/});
    /*...*/
  });
}