// BEGIN(io_random_access)
import 'dart:io';

main() {
  var semicolon = ';'.codeUnitAt(0);
  var result = [];

  new File(Platform.script.toFilePath()).open(mode: FileMode.READ).then((RandomAccessFile file) {
    // Callback to deal with each byte.
    void onByte(int byte) {
      result.add(byte);
      if (byte == semicolon) {
        print(new String.fromCharCodes(result));
        file.close();
      } else {
        file.readByte().then(onByte);
      }
    }
    file.readByte().then(onByte);
  });
}
// END(io_random_access)
