import 'dart:html';
import 'dart:indexed_db';

Element elem;
Element child;
main() {

// BEGIN(element_query)
// New:
elem.querySelector('#foo');
elem.querySelectorAll('div');
elem.querySelectorAll('[name="foo"]');
elem.querySelectorAll('.foo');
elem.querySelector('.foo .bar');
elem.querySelectorAll('.foo .bar');
// END(element_query)

elem.attributes;
elem.children;
elem.classes;
elem.dataset;
elem.nodes;

// BEGIN(element_attributes)
// New:
elem.attributes.containsKey('name');
elem.attributes['name'];
elem.attributes['name'] = 'value';
elem.attributes.remove('name');
// END(element_attributes)

// BEGIN(element_nodes)
// New:
elem.nodes.isEmpty;
elem.nodes[0];
elem.nodes.add(child);
// END(element_nodes)

// BEGIN(element_constructors)
// New:
new DivElement();
new ButtonElement();
new InputElement();
new InputElement(type: 'checkbox');
new TableElement();
new StyleElement();
// END(element_constructors)

// BEGIN(element_table)
TableElement table = new Element.html(
    '<table><tr><td>Hello <em>Dart!</em></table>');
// END(element_table)

// BEGIN(element_listen)
// New:
var subscription = elem.onClick.listen(
    (event) => print('click!'));

subscription.cancel();
// END(element_listen)

// BEGIN(element_listen_dynamic)
// New:
elem.on['dynamiceventname'].listen(
    (event) => print('dynamic!'));
// END(element_listen_dynamic)

var f = window.navigator.getUserMedia;

var g = window.indexedDB.open;

// BEGIN(element_get_user_media)
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
// END(element_get_user_media)

var dbName;
var version;
var storeName;

// BEGIN(element_indexdb)
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
// END(element_indexdb)

// BEGIN(element_cascades)
// With cascades:
var button = new ButtonElement()
  ..id = 'register'
  ..classes.add('important')
  ..text = 'Click to Register'
  ..onClick.listen((e) => registerAccount());
// END(element_cascades)
}

displayObject(obj) {}
reportError(e) {}
registerAccount() {}
reportIssue(e) {}

// BEGIN(handleMouseDown)
void handleMouseDown(e) {
  // Gets the first mouse up event, then automatically unregisters!
  elem.onMouseUp.first.then((event) => doCoolStuff());
}
// END(handleMouseDown)

doCoolStuff() {}