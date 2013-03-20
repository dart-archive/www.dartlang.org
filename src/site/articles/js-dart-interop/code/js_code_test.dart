import 'package:js/js.dart' as js;

a() {
var context = js.context;

js.context.alert('Hello from Dart via JavaScript.');

var canvas = query('#map_canvas');
var googlemaps = js.context.google.maps;
var googlemap = new js.Proxy(googlemaps.Map, canvas);	

var options = js.map({ 'zoom': 9,
                       'mapTypeId': googlemaps.MapTypeId.ROADMAP,
                       'center': new js.Proxy(googlemaps.LatLng, 47.6097, -122.3331) });	

var canvas = query('#map_canvas');
var googlemaps = js.context.google.maps;
var googlemap = new js.Proxy(googlemaps.Map, canvas);	

googlemap.setOptions(options);	

js.context.handler = new js.Callback.once(display);

var script = new ScriptElement();
script.src
 = 'http://search.twitter.com/search.json?q=dartlang&rpp=10&callback=handler';
document.body.nodes.add(script);

js.scoped(() {
  js.context.alert('Hello from Dart via JavaScript.');
});

}

b() {
var googlemap;
js.scoped(() {
  var canvas = query('#map_canvas');
  var googlemaps = js.context.google.maps;
  googlemap = new js.Proxy(googlemaps.Map, canvas);
  js.retain(googlemap);
});	

js.release(googlemap);  // Allow googlemap to be garbage collected.

js.context.handler = new js.Callback.once(display);

var callback = new js.Callback.many(display);
js.context.handler = callback;

callback.dispose();  // Allow the callback function to be garbage collected.
}