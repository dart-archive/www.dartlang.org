void onDataLoaded(HttpRequest req) {
  Map data = parse(req.responseText); // parse response text
  print(data["language"]); // dart
  print(data["targets"][0]); // dartium
  print(data["website"]["homepage"]); // www.dartlang.org
};