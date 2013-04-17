import 'dart:async';

/** Combines strings, breaking them at 80 characters. */
class BlockBreaker extends StreamEventTransformer<String, String> {
  String carry = '';
  void handleData(String data, EventSink<String> output) {
    data = carry + data;
    data = data.replaceAll(new RegExp('\n'), ' '); // Remove newlines.
    while (data.length >= 80) {
      output.add(data.substring(0, 80));
      data = data.substring(80);
    }
    carry = data;
  }
  void handleError(Error error, EventSink<String> output) {
    output.addError(error);
  }
  void handleDone(EventSink<String> output) {
    if (carry.length > 0) {
      output.add(carry);
    }
    output.close();
  }
}

main() {
  var part1 = '''
Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium
doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore
veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim
ipsam voluptatem quia voluptas sit ''';
  var part2 = '''
aspernatur aut odit aut fugit, sed quia
consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.
Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur,
adipisci velit, sed quia non numquam eius modi tempora ''';
  var part3 = '''
incidunt ut labore et
dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis
nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid
ex ea commodi consequatur?
''';

  var text = new StreamController<String>();
  Stream lines = text.stream.transform(new BlockBreaker());
  var lineCount = 0;
  var sub;
  sub = lines.listen((String line) {
    lineCount++;
    print('$lineCount: $line');
  }, onDone: () {
    print('Lines received: $lineCount');
  });
  text.add(part1);
  text.add(part2);
  text.add(part3);
  text.close();
}
