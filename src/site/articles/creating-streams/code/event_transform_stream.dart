import 'dart:async';

Stream<int> timedCounter(Duration interval, [int maxCount]) {
  StreamController<int> controller;
  Timer timer;
  int counter = 0;
  
  void tick(_) {
    counter++;
    controller.add(counter); // Ask stream to send counter values as event.
    if (maxCount != null && counter >= maxCount) {
      timer.cancel();
      controller.close();    // Ask stream to shut down and tell listeners.
    }
  }
  
  // Respond to pause or subscription state change.
  void updatePauseState() {
    if (controller.isPaused) {
      // Stop the timer while paused.
      if (timer != null) {
        timer.cancel();
        timer = null;
      }
    } else if (timer == null) {
      // Restart timer.
      timer = new Timer.periodic(interval, tick);
    }
  }
  controller = new StreamController<int>(
      onListen: updatePauseState,
      onPause: updatePauseState,
      onResume: updatePauseState);
  return controller.stream;
}

class MyMultiplyingStream extends EventTransformStream<int, int> {
  // Create a new stream that repeats all events of [source] [times] times.
  MyMultiplyingStream(Stream<int> source, int times)
      : super(source, new MultiplyingEventTransformer(times));

  // And the reason you needed to extend Stream.
  num someMethodOnMyStream() => 42;
}

class MultiplyingEventTransformer extends StreamEventTransformer<int, int> {
  final int times;
  MultiplyingEventTransformer(this.times);

  void handleData(int data, EventSink<int> sink) {
    for (int i = 0; i < times; i++) sink.add(data);
  }
}

main() {
  Stream<int> stream = 
      new MyMultiplyingStream(timedCounter(const Duration(seconds: 1), 15), 2);
  stream.listen(print);  // Prints 1, 1, 2, 2, ..., 15, 15.
}
