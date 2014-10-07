library a5;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'a6/a6.dart';

/**
 * A Polymer click counter element.
 */
@CustomTag('a-5')
class A5 extends PolymerElement {
  @published int count = 0;

  A5.created() : super.created() {
    var a6 = new Element.tag('a-6') as A6;
  }

  void increment() {
    count++;
  }
}

