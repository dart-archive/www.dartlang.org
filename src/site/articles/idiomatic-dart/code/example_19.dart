import 'dart:async';

Future lengthyComp() { }

Future doLengthyComputation() {
  Future future = lengthyComp();
  future.then((value) => print(value));

  // BAD! You'll only get errors from future, not from then().
  // BAD! Your caller never sees any errors that occur.
  future.catchError((e) => print(e));
  return future;
}