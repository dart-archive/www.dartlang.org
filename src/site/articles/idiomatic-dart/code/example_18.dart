import 'dart:async';

Future lengthyComp() { }

Future doLengthyComputation() {
  return lengthyComp().then((value) => print(value))
                      .catchError((e) => print(e));
}