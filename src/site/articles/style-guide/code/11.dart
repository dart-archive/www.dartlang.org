class Rect {
  num _width;

  num get width => _width;

  void set width(num w) => null;
}

class Button {
  bool get visible => true;

  void set visible(bool v) => null;
}

class Window {
  void get refresh => null;
}

class DateTime {
  static DateTime get now => null;
}

class Accounts {
  num get sum => 0;
}

main() {

  Rect rect = new Rect();
  Button button = new Button();
  List collection = [];
  Window window = new Window();
  Accounts accounts = new Accounts();

  // Example
  num width = rect.width;
  bool allGone = collection.isEmpty;
  bool canSee = button.visible;

  // Example
  num amount = accounts.sum; // may be slow to calculate
  DateTime timeStamp = DateTime.now;   // returns different value each call
  window.refresh; // doesn't return a value

  // Example
  rect.width = 3;
  button.visible = false;
}