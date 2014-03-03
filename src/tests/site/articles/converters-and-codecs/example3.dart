import 'dart:convert';
import 'dart:async';

main() {
  // HtmlEscape synchronously converts Strings to Strings.
  print(const HtmlEscape().convert("foo"));  // "foo".
  // When used in a chunked way it converts from Strings
  // to Strings.
  new Stream.fromIterable(["f", "o", "o"])
      .transform(const HtmlEscape())
      .toList().then(print);  // ["f", "o", "o"].

  // LineSplitter synchronously converts Strings to Lists of String.
  print(const LineSplitter().convert("foo\nbar"));  // ["foo", "bar"]
  // However, asynchronously it converts from Strings to Strings (and
  // not Lists of Strings).
  new Stream.fromIterable(["fo", "o\nb", "ar"])
      .transform(const LineSplitter())
      .toList().then(print);  // ["foo", "bar"].
}
