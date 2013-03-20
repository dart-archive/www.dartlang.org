import 'dart:io';

main() {
  Process.start('ls', ['-l']).then((process) {
    process.stdout.transform(new StringDecoder())
                  .transform(new LineTransformer())
                  .listen((String line) => print(line));
    process.stderr.listen((data) { });
    process.exitCode.then((exitCode) {
      print('exit code: $exitCode');
    });
  });
}