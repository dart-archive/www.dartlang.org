import 'dart:io';

main() {
  HttpServer.bind('127.0.0.1', 8080).then((server) {
    server.listen((HttpRequest request) {
      request.response.addString('Hello, world');
      request.response.close();
    });
  });
}