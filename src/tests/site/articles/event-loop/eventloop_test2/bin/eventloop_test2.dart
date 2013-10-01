import 'dart:async';
main() {
  print('main #1 of 2');
  runAsync(() => print('runAsync #1 of 3'));

  new Future.delayed(new Duration(seconds:1),
      () => print('future #1 (delayed)'));
  
  new Future(() => print('future #2 of 4'))
      .then((_) => print('future #2a'))
      .then((_) {
        print('future #2b');
        runAsync(() => print('runAsync #0 (from future #2b)'));
      })
      .then((_) => print('future #2c'));

  runAsync(() => print('runAsync #2 of 3'));

  new Future(() => print('future #3 of 4'))
      .then((_) => new Future(
                   () => print('future #3a (a new future)')))
      .then((_) => print('future #3b'));

  new Future(() => print('future #4 of 4'));
  runAsync(() => print('runAsync #3 of 3'));
  print('main #2 of 2');
}
