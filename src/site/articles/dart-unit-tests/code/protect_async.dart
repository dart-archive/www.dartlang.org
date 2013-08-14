import 'package:unittest/unittest.dart';
import 'package:unittest/vm_config.dart';
import 'dart:async';
import 'dart:io';

my_function(x, {successCallback, errorCallback}) {
}

main() {
  useVMConfiguration();

  test('two callbacks', () {
    my_function('foo',
        successCallback:
          expectAsync1(() {}),
        errorCallback:
          protectAsync1((e) =>
              expect(true, isFalse, reason: 'Should not be reached')));
  });

  test('two callbacks', () {
    my_function('foo',
        successCallback:
          expectAsync1(() {}),
        errorCallback:
          (e) => guardAsync(() {
            expect(true, isFalse, reason: 'Should not be reached');
          }));
  });
}
