library app_bootstrap;

import 'package:polymer/polymer.dart';
import 'dart:mirrors' show currentMirrorSystem;

import 'tute_stopwatch.dart' as i0;

void main() {
  initPolymer([
      'tute_stopwatch.dart',
    ], currentMirrorSystem().isolate.rootLibrary.uri.toString());
}
