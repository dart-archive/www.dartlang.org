library observable_object;

import 'package:web_ui/web_ui.dart';

@observable
class Person {
  String name;
  
  Person(this.name);
}

main() {
  var person = new Person('Bob');
  person.name = 'Alice';  // goes through the setter, which records the change
}