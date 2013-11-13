// BEGIN(io_stream)
import 'dart:io';
import 'dart:async';

main() {
  List result = [];

  Stream<List<int>> stream = new File(Platform.script.toFilePath()).openRead();
  int semicolon = ';'.codeUnitAt(0);
  StreamSubscription subscription;
  subscription = stream.listen((data) {
    for (int i = 0; i < data.length; i++) {
      result.add(data[i]);
      if (data[i] == semicolon) {
        print(new String.fromCharCodes(result));
        subscription.cancel();
        return;
      }
    }
  });
}
// END(io_stream)
