import 'package:web_ui/web_ui.dart';

@observable
class Person  extends Observable {
  String __$name;
  String get name {
    if (__observe.observeReads) {
      __observe.notifyRead(this, __observe.ChangeRecord.FIELD, 'name');
    }
    return __$name;
  }
  set name(String value) {
    if (__observe.hasObservers(this)) {
      __observe.notifyChange(this, __observe.ChangeRecord.FIELD, 'name',
          __$name, value);
    }
    __$name = value;
  }
  
  Person(name) : __$name = name;
}