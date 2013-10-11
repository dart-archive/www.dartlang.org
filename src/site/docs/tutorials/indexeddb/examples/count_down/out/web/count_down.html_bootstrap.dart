library app_bootstrap;

import 'package:polymer/polymer.dart';
import 'dart:mirrors' show currentMirrorSystem;

import 'tute_milestone.dart' as i0;
import 'tute_countdown.dart' as i1;

void main() {
  initPolymer([
      'tute_milestone.dart',
      'tute_countdown.dart',
    ], currentMirrorSystem().isolate.rootLibrary.uri.toString());
}
