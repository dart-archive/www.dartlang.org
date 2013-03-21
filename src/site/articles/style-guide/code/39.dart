import 'dart:async';

main() {
  new Future.delayed(const Duration(seconds:1), () {
    print('I am a callback');
  });

  // Bad
  new Future.delayed(const Duration(seconds:1), () {
        print('I am a callback');
      });
}