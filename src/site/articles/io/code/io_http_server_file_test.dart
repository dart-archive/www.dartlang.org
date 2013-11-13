// BEGIN(io_http_server_file)
import 'dart:io';

_sendNotFound(HttpResponse response) {
  response.statusCode = HttpStatus.NOT_FOUND;
  response.close();
}

startServer(String basePath) {
  HttpServer.bind('127.0.0.1', 8080).then((server) {
    server.listen((HttpRequest request) {
      final Path path = new Path(request.uri.path).canonicalize();
      if (!path.isAbsolute) {
        _sendNotFound(request.response);
        return;
      }
      // PENDING: Do more security checks here?
      final String stringPath =
          path.toString() == '/' ? '/index.html' : path.toString();
      final File file = new File('${basePath}${stringPath}');
      file.exists().then((bool found) {
        if (found) {
          file.openRead()
              .pipe(request.response)
              .catchError((e) { });
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
  File script = new File(Platform.script.toFilePath());
  startServer(script.directory.path);
}
// END(io_http_server_file)
