import 'dart:html';

main() async {
  const findMe = 'jabberwock';

  // Find an element with the ID "jw".
  var displayer = querySelector('#jw');

  // Get the text to display, and display it.
  var lines = await getLines(findMe);
  lines?.forEach((line) {
    print(line);
    displayer?.text += line + '\n';
  });

  // Find all elements with the class "searchString".
  querySelectorAll('.searchString').forEach((el) {
    // Set each one's text and highlight it.
    el..text = findMe
      ..classes.add('highlighted');
  });
}

// Reads a file, returning its lines.
getLines(String withString) async {
  var jabber = await HttpRequest.getString(
      'https://www.dartlang.org/samples-files/jabberwocky.txt');
  var lines = jabber.split('\n');
  lines.retainWhere((line) =>
      line.toLowerCase().contains(withString));
  return lines;
}
