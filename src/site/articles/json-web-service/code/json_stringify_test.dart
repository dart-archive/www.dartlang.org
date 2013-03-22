import 'dart:json';
import 'dart:html';
HttpRequest request;

void saveData() {
  
  // snip setting up HttpRequest

  var mapData = new Map();
  mapData["language"] = "dart";
  mapData["targets"] = new List();
  mapData["targets"].add("dartium");

  String jsonData = stringify(mapData); // convert map to String
  request.send(jsonData); // perform the async POST
}