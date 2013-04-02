// BEGIN(html_streams)
import 'dart:html';

void main() {
  var button = new ButtonElement();
  document.body.children.add(button);
  
  button.text = "Foo"; 
  var clickCount = 0;
  button.onClick.listen((mouseEvent) {
    print("clicked"); // remain subscribed for all clicks
  });
  
  var subscription = button.onClick.listen(null);
  subscription.onData((mouseEvent) {
    print("copy that");
    clickCount++;
    window.alert("Clicked");
    if (clickCount == 3) {
      subscription.cancel(); // unsubscribe after the third click
    }
  });  
}
// END(html_streams)