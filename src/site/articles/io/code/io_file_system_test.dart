// BEGIN(io_file_system)
import 'dart:io';
import 'dart:async';

main() {
  var file = new File(Platform.script.toFilePath());
  Future<String> finishedReading = file.readAsString(encoding: Encoding.ASCII);
  finishedReading.then((text) => print(text));
}
// END(io_file_system)
