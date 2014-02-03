import 'dart:html';
import 'dart:convert';
import 'dart:async';

var wordList;

void main() {
  querySelector('#getWords').onClick.listen(makeRequest);
  wordList = querySelector('#wordList');
}

void makeRequest(Event e) {
  var path = 'portmanteaux_simple.json';
  HttpRequest.getString(path)
  .then(processString)
  .catchError(handleError);
}

processString(String jsonString) {
  List<String> portmanteaux = JSON.decode(jsonString);
  for (int i = 0; i < portmanteaux.length; i++) {
    wordList.children.add(new LIElement()..text = portmanteaux[i]);
  }
}

handleError(Error error) {
  wordList.children.add(new LIElement()..text = 'Request failed.');
}
