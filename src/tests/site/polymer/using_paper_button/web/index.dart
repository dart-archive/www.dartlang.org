import 'dart:html';

import 'package:polymer_elements/paper_button.dart';
import 'package:polymer/polymer.dart';

/// Mentioning [PaperButton] in this comment removes "unused import"
/// warnings from the analyzer.
main() async {
  await initPolymer();

  // Note: The "tap" event processes faster than the "click" event.
  querySelector('paper-button').on['tap'].listen((_) {
    print('Button tapped!');
  });
}
