import 'dart:io';
import 'dart:async';

void main() {
  Future.wait([expensiveA(), expensiveB(), expensiveC()])
        .then((List responses) => chooseBestResponse(responses))
        .catchError((e) => handleError(e));
}

Future expensiveA() => new Future.immediate('from expensiveA');
Future expensiveB() => new Future.immediate('from expensiveB');
Future expensiveC() => new Future.immediate('from expensiveC');

doSomethingWith(value) {
  print(value);
}

chooseBestResponse(List responses) {
  print(responses[1]);
}

handleError(e) {
  print('error handled');
}