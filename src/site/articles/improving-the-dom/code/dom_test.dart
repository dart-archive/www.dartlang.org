import 'dart:html';
import 'dart:indexed_db';

Element elem;
Element child;
main() {


elem.query('#foo');
elem.queryAll('div');
elem.queryAll('[name="foo"]');
elem.queryAll('.foo');
elem.query('.foo .bar');
elem.queryAll('.foo .bar');

elem.attributes;
elem.children;
elem.classes;
elem.dataset;
elem.nodes;

elem.attributes.containsKey('name');
elem.attributes['name'];
elem.attributes['name'] = 'value';
elem.attributes.remove('name');

elem.nodes.isEmpty;
elem.nodes[0];
elem.nodes.add(child);

new DivElement();

new ButtonElement();
new InputElement(); 
new InputElement(type: 'checkbox');
new TableElement();
new StyleElement();

TableElement table = new Element.html(
    '<table><tr><td>Hello <em>Dart!</em></table>');

var subscription = elem.onClick.listen(
    (event) => print('click!'));

subscription.cancel();

elem.on['dynamiceventname'].listen(
    (event) => print('dynamic!'));

var f = window.navigator.getUserMedia;

var g = window.indexedDB.open;

// With Dart:
window.navigator.getUserMedia(audio:true, video: true)
  .then((stream) {
    var video = new VideoElement()
      ..autoplay = true
      ..src = Url.createObjectUrl(stream)
      ..onLoadedMetadata.listen((e) => print(e));
    document.body.append(video);
  })
  .catchError(reportIssue);

var dbName;
var version;
var storeName;

// With Dart:
window.indexedDB.open(dbName, version: version,
  onUpgradeNeeded: (e) {
    Database db = e.target.result;
    if (!db.objectStoreNames.contains(storeName)) {  
      db.createObjectStore(storeName);
    }
  })
  .then((db) {
    var txn = db.transaction("customers", "readwrite");
    var store = txn.objectStore("customers");
    return store.getObject("444-44-4444");
  })
  .then((obj) => displayObject(obj))
  .catchError((e) => reportError(e));

// With cascades:
var button = new ButtonElement()
  ..id = 'register'
  ..classes.add('important')
  ..text = 'Click to Register'
  ..onClick.listen((e) => registerAccount());
}

displayObject(obj) {}
reportError(e) {}
registerAccount() {}
reportIssue(e) {}

void handleMouseDown(e) {
  // Gets the first mouse up event, then automatically unregisters!
  elem.onMouseUp.first.then((event) => doCoolStuff());
}

doCoolStuff() {}