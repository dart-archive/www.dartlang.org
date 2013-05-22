library manual_watching;

import 'dart:html';
import 'package:web_ui/web_ui.dart';

@observable
String msg;

updateMsg() {
  msg = new DateTime.now().toString();
}

main() {
  observe(() => msg, (_) {
    query('#msg').text = msg;
  });
}