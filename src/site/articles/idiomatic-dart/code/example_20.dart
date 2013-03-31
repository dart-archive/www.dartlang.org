import 'dart:async';

doTheThingThatMightFail() { }

Future doLengthyComputation() {
  return new Future.delayed(const Duration(seconds: 0),
      () => doTheThingThatMightFail());
}