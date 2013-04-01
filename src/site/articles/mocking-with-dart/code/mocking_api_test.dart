// #!/usr/bin/env dart_analyzer --enable_type_checks --extended-exit-code --type-checks-for-inferred-types

import 'package:unittest/unittest.dart';
import 'package:unittest/mock.dart';
import 'dart:math' as math;
    
class T{}

class MockT extends Mock implements T {}

testMockConstructor() {
  LogEntryList log;
  Mock m = new Mock();
  /*
      Mock.custom({this.name,
               this.log,
               throwIfNoBehavior: false,
               enableLogging: true}) 
   */
  Mock mc = new Mock.custom(name: "mc",
      log: log,
      throwIfNoBehavior: false,
      enableLogging: true);
  
  
  m.when(callsTo('sqrt', isNegative)).
  alwaysThrow('No imaginary number support');
  m.when(callsTo('sqrt', isNonNegative)).alwaysCall((x) => math.sqrt(x));
  
  m.when(callsTo('add')).alwaysReturn(0);
  m.add(1, 2);
  
  m.when(callsTo('add', 1)).alwaysReturn(0);
  m.add(1, 2);
  m.add(1);
  
  m.when(callsTo('add', anything, anything)).alwaysReturn(0);
  m.add(1);
  
  m.when(callsTo('get length')).alwaysReturn(0);
  
  m.getLogs(callsTo('bar')).verify(happenedExactly(2)).
  verify(sometimeReturned(6)).verify(neverReturned(5));
  
  m.getLogs(callsTo('bar'), returning(5)).verify(neverHappened);
  
  m.getLogs(callsTo('bar')).verify(neverReturned(5));
}

/*
class LogEntryList {
  final String filter;
  List<LogEntry> logs;
  …
  LogEntryList getMatches([String mockNameFilter,
                      CallMatcher logFilter,
                      Matcher actionMatcher,
                      bool destructive = false]);
}

class LogEntry {
  Date time; // The time of the event.
  final String mockName; // The mock object name, if any.
  final String methodName; // The method name.
  final List args; // The parameters.
  final Action action; // The behavior that resulted.
  final value; // The value that was returned (if no throw).
  …
}

class Mock {
...
  LogEntryList getLogs([CallMatcher logFilter, Matcher actionMatcher,
    bool destructive = false]);
}
*/

testSharedLogs() {
  var log = new LogEntryList();
  var m1 = new Mock.custom(name: 'm1', log: log);
  var m2 = new Mock.custom(name: 'm2', log: log);
// fails dart_analyzer
//  m1.foo();
//  m2.foo();
//  m1.bar();
//  m2.bar();
  
  m1.getLogs(callsTo('foo'));
  log.getMatches('m1', callsTo('foo'));
  
  log.getMatches(null, callsTo('foo')).verify(happenedExactly(2));
}

main() {}