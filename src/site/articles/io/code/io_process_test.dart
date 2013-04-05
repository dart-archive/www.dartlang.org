// BEGIN(io_process)
import 'dart:io';

main() {
  // List all files in the current directory,
  // in UNIX-like operating systems.
  Process.run('ls', ['-l']).then((ProcessResult results) {
    print(results.stdout);
  });
}
// END(io_process)