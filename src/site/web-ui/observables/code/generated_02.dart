import 'package:web_ui/web_ui.dart';

String __$superlative = 'awesome';
String get superlative {
  if (__observe.observeReads) {
    __observe.notifyRead(__changes, __observe.ChangeRecord.FIELD, 'superlative');
  }
  return __$superlative;
}
set superlative(String value) {
  if (__observe.hasObservers(__changes)) {
    __observe.notifyChange(__changes, __observe.ChangeRecord.FIELD, 'superlative',
        __$superlative, value);
  }
  __$superlative = value;
}