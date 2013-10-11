library app_bootstrap;

import 'package:polymer/polymer.dart';
import 'dart:mirrors' show currentMirrorSystem;

import 'tute_slambookform.dart' as i0;

void main() {
  initPolymer([
      'tute_slambookform.dart',
    ], currentMirrorSystem().isolate.rootLibrary.uri.toString());
}
