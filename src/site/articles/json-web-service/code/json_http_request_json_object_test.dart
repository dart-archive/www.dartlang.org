void onDataLoaded(HttpRequest req) {
  // decode the JSON response text using JsonObject
  JsonObject data = new JsonObject.fromJsonString(req.responseText);

  // dot notation property access
  print(data.language);         // Get a simple value
  data.language = "Dart";       // Set a simple value
  print(data.targets[0]);       // Get a value in a list
  // iterate the website map
  data.website.foreach((key, value) => print("$key=$value")); 
};