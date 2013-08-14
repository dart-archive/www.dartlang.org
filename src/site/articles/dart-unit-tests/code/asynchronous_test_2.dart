import 'package:unittest/unittest.dart';
import 'package:unittest/vm_config.dart';
import 'dart:async';

main() {
  useVMConfiguration();
  
  var stream = new Stream.fromFuture(new Future.value('done'));
  var subscription;
  var value;

  test('callbacks', () {
    stream.listen(
        (v) {
          value = v;
          print("listen: value = $v");
        },
        onError:
          expectAsync1((e) =>
              expect(false, isTrue, reason: 'Should not be reached')),
        onDone:
          expectAsync0(() =>
              expect(value, equals('done')))
    );
  });
}