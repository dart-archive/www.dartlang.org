import "package:json_object/json_object.dart";

// Abstract class defines the interface of our JSON data structure
abstract class Language {
  String language;
  List targets;
  Map website;
}

/** Implementation class extends JsonObject, and uses the structure
 *  defined by implementing the Language abstract class. 
 *  JsonObject's noSuchMethod() function provides the actual underlying
 *  implementation.
 */
class LanguageImpl extends JsonObject implements Language {
  LanguageImpl(); 
  
  factory LanguageImpl.fromJsonString(string) {
    return new JsonObject.fromJsonString(string, new LanguageImpl());
  }
}

void onDataLoaded(HttpRequest req) {
  // Decode the JSON response text using LanguageImpl
  // The Language interface provides structure 
  Language data = new LanguageImpl.fromJsonString(req.responseText);

  // dot notation property access
  print(data.language);         // Get a simple value
  data.language = "Dart";       // Set a simple value
  print(data.targets[0]);       // Get a value in a list
  // iterate the website map
  data.website.foreach((key, value) => print("$key=$value")); 
};

void a() {
var data = new JsonObject();
data.language = "Dart";
data.targets = new List();
data.targets.add("Dartium");
}

void b() {
var data = new JsonObject();
data["language"] = "Dart"; // standard map syntax	
}

void c() {
var data = new JsonObject.fromJsonString(req.responseText);

// later...
// convert the JsonObject data back to a string
String json = stringify(data);

// and POST it back to the server
HttpRequest req = new HttpRequest();
req.open("POST", url);
req.send(json);	
}

