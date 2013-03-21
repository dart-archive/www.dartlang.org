import 'dart:io';
import 'dart:async';

void main() {
  expensiveA().then((aValue) => expensiveB()) 
              .then((bValue) => expensiveC()) 
              .then((cValue) => doSomethingWith(cValue));
}

Future expensiveA() => new Future.immediate('from expensiveA');
Future expensiveB() => new Future.immediate('from expensiveB');
Future expensiveC() => new Future.immediate('from expensiveC');

doSomethingWith(value) {
  print(value);
}
