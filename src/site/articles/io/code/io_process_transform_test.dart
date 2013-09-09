// BEGIN(io_process_transform)
import 'dart:io';
import 'dart:convert';

main() {
  Process.start('ls', ['-l']).then((process) {
    process.stdout.transform(new Utf8Decoder())
                  .transform(new LineSplitter())
                  .listen((String line) => print(line));
    process.stderr.listen((data) { });
    process.exitCode.then((exitCode) {
      print('exit code: $exitCode');
    });
  });
}
// END(io_process_transform)