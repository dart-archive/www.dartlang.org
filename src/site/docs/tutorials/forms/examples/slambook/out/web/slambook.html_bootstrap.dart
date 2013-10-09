library app_bootstrap;

import 'package:polymer/polymer.dart';
import 'dart:mirrors' show currentMirrorSystem;

import 'xslambookform.dart' as i0;

void main() {
  initPolymer([
      'xslambookform.dart',
    ], currentMirrorSystem().isolate.rootLibrary.uri.toString());
}
