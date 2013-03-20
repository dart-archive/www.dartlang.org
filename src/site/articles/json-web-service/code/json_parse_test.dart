import 'dart:json';

main() {
  String listAsJson = '["Dart",0.8]'; // input List of data
  List parsedList = parse(listAsJson);
  print(parsedList[0]); // Dart
  print(parsedList[1]); // 0.8

  String mapAsJson = '{"language":"dart"}';  // input Map of data
  Map parsedMap = parse(mapAsJson);
  print(parsedMap["language"]); // dart
}