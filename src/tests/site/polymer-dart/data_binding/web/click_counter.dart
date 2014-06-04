import 'package:polymer/polymer.dart';
import 'dart:html' show Event, Node;

@CustomTag('click-counter')
class ClickCounterElement extends PolymerElement {
  @observable int count = 0;

  ClickCounterElement.created() : super.created();

  void increment(Event e, var detail, Node target) {
    count += 1;
  }
}