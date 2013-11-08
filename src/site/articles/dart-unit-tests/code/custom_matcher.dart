library test;
import 'package:unittest/unittest.dart';

class PrefixMatcher extends Matcher {
  final String _prefix;
  PrefixMatcher(prefix) : this._prefix = collapseWhitespace(prefix);
  bool matches(item, Map matchState) {
    return item is String &&
        collapseWhitespace(item).startsWith(_prefix);
  }
  Description describe(Description description) =>
    description.add('a string starting with ').
        addDescriptionOf(collapseWhitespace(_prefix)).
        add(' ignoring whitespace');
}

class Widget {
  int price;
}

class _Price extends CustomMatcher {
  _Price(matcher) : super('Widget with price that is', 'price', matcher);
  featureValueOf(actual) => actual.price;
}
Matcher price(m) => new _Price(wrapMatcher(m));

main() {
  var widget = new Widget();
  var special = new Widget();
  expect(widget, price(greaterThan(0)));

  var isFree = price(0);
  expect(special, isFree);
}

