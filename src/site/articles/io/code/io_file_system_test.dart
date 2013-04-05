// BEGIN(io_file_system)
import 'dart:io';
import 'dart:async';

main() {
  var options = new Options();
  var file = new File(options.script);
  Future<String> finishedReading = file.readAsString(encoding: Encoding.ASCII);
  finishedReading.then((text) => print(text));
}
// END(io_file_system)