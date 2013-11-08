import 'dart:html';
import 'dart:async';
import 'package:polymer/polymer.dart';

@CustomTag('tute-stopwatch')
class TuteStopwatch extends PolymerElement {
  @observable String get counter => __$counter; String __$counter='00:00'; set counter(String value) { __$counter = notifyPropertyChange(#counter, __$counter, value); }
  
  Stopwatch mywatch = new Stopwatch();
  Timer mytimer;
  
  ButtonElement stopButton;
  ButtonElement startButton;
  ButtonElement resetButton;
  
  void inserted() {
    super.inserted();
    startButton = $['startButton'];
    stopButton = $['stopButton'];
    resetButton = $['resetButton'];
        
    stopButton.disabled = true;
    resetButton.disabled = true;
  }
  
  void removed() {
    super.removed();
    mytimer.cancel();
  }
  
  void start(Event e, var detail, Node target) {
    mywatch.start();
    var oneSecond = new Duration(seconds:1);
    mytimer = new Timer.periodic(oneSecond, updateTime);
    startButton.disabled = true;
    stopButton.disabled = false;
    resetButton.disabled = true;
  }
  
  void stop(Event e, var detail, Node target) {
    mywatch.stop();
    mytimer.cancel();
    startButton.disabled = false;
    resetButton.disabled = false;
    stopButton.disabled = true;
  }
  
  void reset(Event e, var detail, Node target) {
    mywatch.reset();
    counter = '00:00';
    resetButton.disabled = true;
  }
  
  void updateTime(Timer _) {
    var s = mywatch.elapsedMilliseconds~/1000;
    var m = 0;
    
    if (s >= 60) { m = s ~/ 60; s = s % 60; }
      
    String minute = (m <= 9) ? '0$m' : '$m';
    String second = (s <= 9) ? '0$s' : '$s';
    counter = '$minute:$second';
  }
}