// BEGIN(io_process_stdio)
import 'dart:io';

main() {
  var output = new File('output.txt').openWrite();
  Process.start('ls', ['-l']).then((process) {
    process.stdout.pipe(output);
    process.stderr.listen((data) { });
    process.exitCode.then((exitCode) {
        print('exit code: $exitCode');
    });
  });
}
// END(io_process_stdio)