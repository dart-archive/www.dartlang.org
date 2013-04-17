library observe_object;

import 'package:web_ui/web_ui.dart';

@observable
class Person {
  String name;
  
  Person(this.name);
}

final Person person = new Person('Bob');

const List<String> names = const <String>['Sally', 'Alice', 'Steph'];

int _nextCounter = 0;

String get nextName => names[_nextCounter++ % names.length];

newName() {
  person.name = nextName;
}

main() {}