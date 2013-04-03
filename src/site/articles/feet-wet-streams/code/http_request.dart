import 'dart:html';

void main() {
  // BEGIN(http_request)
  var url = "http://example.com/userCount";
  HttpRequest.getString(url).then((String result) {  // callback function
    print("User count: $result");  
  });
  // END(http_request)
}