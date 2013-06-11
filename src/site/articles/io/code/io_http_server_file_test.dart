// BEGIN(io_http_server_file)
import 'dart:io';

_sendNotFound(HttpResponse response) {
  response.statusCode = HttpStatus.NOT_FOUND;
  response.close();
}

startServer(String basePath) {
  HttpServer.bind('127.0.0.1', 8080).then((server) {
    server.listen((HttpRequest request) {
      final String path =
          request.uri.path == '/' ? '/index.html' : request.uri.path;
      final File file = new File('${basePath}${path}');
      file.exists().then((bool found) {
        if (found) {
          // PENDING: Do more security checks here?
          file.fullPath().then((String fullPath) {
            file.openRead()
                .pipe(request.response)
                .catchError((e) { });
          });
        } else {
          _sendNotFound(request.response);
        }
      });
    });
  });
}

main() {
  // Compute base path for the request based on the location of the
  // script and then start the server.
  File script = new File(new Options().script);
  startServer(script.directory.path);
}
// END(io_http_server_file)