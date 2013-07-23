import 'package:unittest/unittest.dart';
import 'package:unittest/vm_config.dart';
import 'dart:async';

checkProgress() {
  print('checking progress');
}

foo() {
  print('foo');
}

main() {
  useVMConfiguration();

  // BAD TEST (doesn't wait for checkProgress to be called)
  test('Timer test', () {
    new Timer(new Duration(milliseconds:100), checkProgress); 
  });
  
  // GOOD TEST (waits for checkProgress to be called)
  test('Window timeout test', () {
    new Timer(new Duration(milliseconds:100), expectAsync0(checkProgress)); 
  });
  
  test('Double callback', () {
    var callback = expectAsync0(foo, count: 2);
    new Timer(new Duration(milliseconds:100), callback);
    new Timer(new Duration(milliseconds:100), callback);
  });
}