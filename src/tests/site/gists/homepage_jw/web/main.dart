import 'dart:html' show HttpRequest;

main() async {
  // Asychronously get text to display.
  var lines = await getLines();

  // If result is non-null, print it.
  lines?.forEach((line) => print(line));
}

// Reads a file, returning its lines.
getLines() async {
  var jabber = await HttpRequest.getString(
      'https://www.dartlang.org/samples-files/jabberwocky.txt');
  var lines = jabber.split('\n');
  lines.retainWhere((line) =>
      line.toLowerCase().contains('jabberwock'));
  return lines;
}
