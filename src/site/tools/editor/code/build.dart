import 'dart:io';

void main() {
  for (String arg in new Options().arguments) {
    if (arg.startsWith('--changed=')) {
      String file = arg.substring('--changed='.length);

      if (file.endsWith('.foo')) {
        _processFile(file);
      }
    }
  }
}

void _processFile(String file) {
  String contents = new File(file).readAsStringSync();

  if (contents != null) {
    File outFile = new File('${file}bar');
    outFile.writeAsStringSync('// processed from ${file}:\n${contents}');
  }
}
