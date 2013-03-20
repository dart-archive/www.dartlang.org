import 'dart:io';

main() {
  var options = new Options();
  var semicolon = ';'.charCodeAt(0);
  var result = [];

  new File(options.script).open(FileMode.READ).then((RandomAccessFile file) {
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