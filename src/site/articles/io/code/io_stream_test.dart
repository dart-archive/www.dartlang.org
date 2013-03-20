import 'dart:io';

main() {
  Options options = new Options();
  List result = [];

  Stream<List<int>> stream = new File(options.script).openRead();
  int semicolon = ';'.charCodeAt(0);
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