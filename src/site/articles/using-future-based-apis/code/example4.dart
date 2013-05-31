import 'dart:io';
import 'dart:async';

void main() {
  expensiveA().then((aValue) => expensiveB()) 
              .then((bValue) => expensiveC()) 
              .then((cValue) => doSomethingWith(cValue));
}

Future expensiveA() => new Future.value('from expensiveA');
Future expensiveB() => new Future.value('from expensiveB');
Future expensiveC() => new Future.value('from expensiveC');

doSomethingWith(value) {
  print(value);
}
