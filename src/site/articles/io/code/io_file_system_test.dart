import 'dart:io';
import 'dart:async';

main() {
  var options = new Options();
  var file = new File(options.script);
  Future<String> finishedReading = file.readAsString(Encoding.ASCII);
  finishedReading.then((text) => print(text));
}