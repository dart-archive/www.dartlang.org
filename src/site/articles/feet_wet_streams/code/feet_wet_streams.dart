import 'dart:async';
import 'dart:io';


void main() {
  var options = new Options();
  var this_file = options.script;
  
  singleStream();
  
  singleFirst();
  singleLast();
  singleLength();
  singleIsEmpty();
  
  broadcast();
  
  streamSubsetsOfData();
  
  transformingStream();
  
  validatingStream();
  
  singleWhere();
  singleError();
  
  streamSubscription_handlersOnSubscription();
  streamSubscription_handlerFunctionArgs();
  
  unsubscribing();
  
  generic();
  
  readingAFile();
}

singleStream() {
  var data = [1,2,3,4,5]; // some sample data
  var stream = new Stream.fromIterable(data);  // create the stream

  // subscribe to the streams events
  stream.listen( (value) {    // 
    print("Received: $value"); // onData handler
  });   
   
}

singleFirst() {
  var data = [1,2,3,4,5]; // some sample data
  var stream = new Stream.fromIterable(data);  // create the stream

  stream.first.then((value) => print("stream.first: $value"));  // 1

  
}

singleLast() {
  var data = [1,2,3,4,5]; // some sample data
  var stream = new Stream.fromIterable(data);  // create the stream
  
  stream.last.then((value) => print("stream.last: $value")); // 5  
}

singleIsEmpty() {
  var data = [1,2,3,4,5]; // some sample data
  var stream = new Stream.fromIterable(data);  // create the stream

  stream.isEmpty.then((value) => print("stream.isEmpty: $value")); // false
  
}

singleLength() {
  var data = [1,2,3,4,5]; // some sample data
  var stream = new Stream.fromIterable(data);  // create the stream

  stream.length.then((value) => print("stream.length: $value")); // 5
}

broadcast() {
  var data = [1,2,3,4,5];
  var stream = new Stream.fromIterable(data);
  // get the stream as a broadcast stream
  var broadcastStream = stream.asBroadcastStream(); 
  
  broadcastStream.listen((value) => print("stream.listen: $value"));
  broadcastStream.first.then((value) => print("stream.first: $value"));
  broadcastStream.last.then((value) => print("stream.last: $value"));
  broadcastStream.isEmpty.then((value) => print("stream.isEmpty: $value"));
  broadcastStream.length.then((value) => print("stream.length: $value"));
}

streamSubsetsOfData() {
  var data = [1,2,3,4,5];
  var stream = new Stream.fromIterable(data);
  // get the stream as a broadcast stream
  var broadcastStream = stream.asBroadcastStream(); 
  
  // these all work on a normal single subscriber stream,
  // but using a broadcast stream allows me to attach multiple
  // listeners
  
  broadcastStream
      .where((value) => value % 2 == 0) // divisble by 2
      .listen((value) => print("where: $value")); // where: 2
                                                  // where: 4
  
  broadcastStream
      .take(3) // takes only the first three elements
      .listen((value) => print("take: $value")); // take: 1
                                                 // take: 2
                                                 // take: 3
  
  broadcastStream
      .skip(3)  // skips the first three elements
      .listen((value) => print("skip: $value")); // skip: 4
                                                 // skip: 5
  
  broadcastStream
      .takeWhile((value) => value < 3) // take while true
      .listen((value) => print("takeWhile: $value")); // takeWhile: 1
                                                      // takeWhile: 2

  broadcastStream
      .skipWhile((value) => value < 3) // skip while true
      .listen((value) => print("skipWhile: $value")); // skipWhile: 4
                                                      // skipWhile: 5

}


transformingStream() {
  var data = [1,2,3,4,5]; // some sample data
  var stream = new Stream.fromIterable(data);  // create the stream
  
  // define a stream transformer
  var transformer = new StreamTransformer(handleData: (value, sink) {
    // create two new values from the original value
    sink.add("Message: $value");
    sink.add("Body: $value");
  });
    
  // transform the stream and listen to its output
  stream.transform(transformer).listen((value) => print("listen: $value"));
}

validatingStream() {
  var data = [1,2,3,4,5];
  var stream = new Stream.fromIterable(data);
  // get the stream as a broadcast stream
  var broadcastStream = stream.asBroadcastStream(); 
  
  // these all work on a normal single subscriber stream,
  // but using a broadcast stream allows me to attach multiple
  // listeners
  
  broadcastStream
      .any((value) => value < 5)
      .then((result) => print("Any less than 5?: $result")); // true
  
  broadcastStream
      .every((value) => value < 5)
      .then((result) => print("All less than 5?: $result")); // false
  
  broadcastStream
      .contains(4)
      .then((result) => print("Contains 4?: $result")); // true
}

singleWhere() {
  var data = [1,2,3,4,5];
  var stream = new Stream.fromIterable(data);
  // get the stream as a broadcast stream
  var broadcastStream = stream.asBroadcastStream(); 
  
  broadcastStream
      .singleWhere((value) => value < 2) // formerly singleMatching 
      .then((value) => print("single value: $value"));
}

singleError() {
  var data = [1,2,3,4,5];
  var stream = new Stream.fromIterable(data);
  // get the stream as a broadcast stream
  var broadcastStream = stream.asBroadcastStream(); 
  
  broadcastStream
      .single 
      .then((value) => print("single value: $value"))
      .catchError((err) => print("Expected Error: $err"));
}

streamSubscription_handlersOnSubscription() {
  var data = [1,2,3,4,5];
  var stream = new Stream.fromIterable(data);
  
  // setup the handlers through the subscription's handler methods
  var subscription = stream.listen(null);
  subscription.onData((value) => print("listen: $value"));
  subscription.onError((err) => print("error: $err"));
  subscription.onDone(() => print("done"));
}

streamSubscription_handlerFunctionArgs() {
  var data = [1,2,3,4,5];
  var stream = new Stream.fromIterable(data);
  
  var subscription = stream.listen(
      (value) => print("listen: $value"),
      onError: (err) => print("error: $err"),
      onDone: () => print("done"));
}

unsubscribing() {
  var data = [1,2,3,4,5];
  var stream = new Stream.fromIterable(data);
  
  var subscription = stream.listen(null);
  subscription.onData((value) {
    print("listen: $value");
    if (value == 2) subscription.cancel(); // cancel the subscription
  });
  subscription.onError((err) => print("error: $err"));
  subscription.onDone(() => print("done"));
}

generic() {
  var data = [1,2,3,4,5]; // int's, valid
  // var data = ["1","2","3","4","5"]; // strings, not valid
  var stream = new Stream<int>.fromIterable(data); // Stream<int>
  stream.listen((value) { // value must be an int
    print("listen: $value");
  });
}

readingAFile() {
  // read this script file
  var options = new Options();
  var thisFilePath = options.script;
  
  File file = new File(thisFilePath);
  file
    .openRead()
    .transform(new StringDecoder())
    .listen((String data) {
      assert(data.length > 0);
    }, 
    onError: (error) => print("Error, could not open file"),
    onDone: () => print("Finished reading data"));
 
}