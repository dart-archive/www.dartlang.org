library hello_world;

import 'package:web_ui/web_ui.dart';

@observable
String superlative = 'awesome';

const List<String> alternatives =
    const <String>['wicked cool', 'sweet', 'fantastic', 'wonderful'];

int _alternativeCount = 0;

String get nextAlternative => alternatives[_alternativeCount++ % alternatives.length];

changeIt() {
  superlative = nextAlternative;
}

main() { }