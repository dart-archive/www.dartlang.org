import 'dart:html';
import 'package:unittest/unittest.dart';
import 'package:unittest/html_config.dart';

void main() {
  var elem = query("#sample_text_id");
  
  elem..text = "Click me!"
      ..onClick.listen(reverseText);
  
  // TESTING CODE IS HERE
  useHtmlConfiguration();
  
  group('Text', () {
    test('exists', () =>
        expect(elem.text, isNotNull) );
    
    test('says Click me!', () =>
      expect(elem.text, equals("Click me!")) );
  });
  
  test('Click listener', () =>
      expect(elem.onClick, isNotNull) );
  
  filterTests('Click'); // Run tests 2 and 3
//  runTests(); // Isn't necessary.
}

void reverseText(MouseEvent event) {
  var text = query("#sample_text_id").text;
  var buffer = new StringBuffer();
  for (int i = text.length - 1; i >= 0; i--) {
    buffer.write(text[i]);
  }
  query("#sample_text_id").text = buffer.toString();
}
