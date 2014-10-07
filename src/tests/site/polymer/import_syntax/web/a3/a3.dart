library a3; //TODO: mention that you'll need to have a separate lib?

import 'package:polymer/polymer.dart';

/**
 * A Polymer click counter element.
 */
@CustomTag('a-3')
class A3 extends PolymerElement {
  @published int count = 0;

  A3.created() : super.created() {
  }

  void increment() {
    count++;
  }
}

