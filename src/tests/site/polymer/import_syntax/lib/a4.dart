library a4;

import 'package:polymer/polymer.dart';

/**
 * A Polymer click counter element.
 */
@CustomTag('a-4')
class A4 extends PolymerElement {
  @published int count = 0;

  A4.created() : super.created() {
  }

  void increment() {
    count++;
  }
}

