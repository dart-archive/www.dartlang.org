import 'package:polymer/polymer.dart';
import 'package:a/a4.dart';
//import '../a4.dart';
import 'dart:html';

/**
 * A Polymer click counter element.
 */
@CustomTag('a-6')
class A6 extends PolymerElement {
  @published int count = 0;

  A6.created() : super.created() {
    var cc = new Element.tag('a-4') as A4;
  }

  void increment() {
    count++;
  }
}

