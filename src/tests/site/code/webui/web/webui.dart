import 'package:web_ui/web_ui.dart';

@observable
var shout = new Shout();

@observable 
class Shout {
  String myString = '';
  String get shouted => myString.toUpperCase();
  String get palindrome =>
      myString + myString.split('').reversed.join();
}

main() {}
