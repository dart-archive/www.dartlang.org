import 'package:unittest/unittest.dart';
import 'package:unittest/vm_config.dart';
import 'dart:math';

main() {
  useVMConfiguration();
  
  test('An empty test', () {
    // a test with expectations and matchers
  });
  
  test('Addition test', () {
    expect(2 + 2, equals(4));
  });
  
  test('Addition test', () {
    expect(2 + 2 == 5, isTrue);
  });
  
  test('Addition test', () => expect(2 + 2 == 5,
                                     isTrue,
                                     reason:'Two twos are not five'));
  
  var x = 11;
  test('Prime test', () =>
      expect(isPrime(x), isTrue, reason:'${x} is not prime')
      );
  
  filterTests('Addition');
}

// Flawed implementation of prime number checker.
bool isPrime(int x) {
  if (x==11) return true;
  return false;
}

unreachable() {
  expect(false, isTrue, reason:'Unreachable');
}