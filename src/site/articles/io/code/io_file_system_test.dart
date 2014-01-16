// BEGIN(io_file_system)
import 'dart:io';
import 'dart:async';
import 'dart:convert';

main() {
  var file = new File(Platform.script.toFilePath());
  Future<String> finishedReading = file.readAsString(encoding: ASCII);
  finishedReading.then((text) => print(text));
}
// END(io_file_system)
