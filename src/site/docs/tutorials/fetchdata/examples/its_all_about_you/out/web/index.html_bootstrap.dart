library app_bootstrap;

import 'package:polymer/polymer.dart';
import 'dart:mirrors' show currentMirrorSystem;

import 'tute_its_all_about_you.dart' as i0;

void main() {
  initPolymer([
      'tute_its_all_about_you.dart',
    ], currentMirrorSystem().isolate.rootLibrary.uri.toString());
}
