library app_bootstrap;

import 'package:polymer/polymer.dart';
import 'dart:mirrors' show currentMirrorSystem;

import 'xmilestone.dart' as i0;
import 'xcountdown.dart' as i1;

void main() {
  initPolymer([
      'xmilestone.dart',
      'xcountdown.dart',
    ], currentMirrorSystem().isolate.rootLibrary.uri.toString());
}
