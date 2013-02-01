library youtube;

import 'dart:io';
import 'dart:uri';
import 'dart:json' as JSON;
import 'dart:async';

final String YT_PLAYLIST_URL = 'http://gdata.youtube.com/feeds/api/playlists/';

Future<Map> fetchPlaylist(String playlistId) {
  var completer = new Completer();
  var client = new HttpClient();
  var conn = client.getUrl(new Uri('$YT_PLAYLIST_URL$playlistId?alt=json'));
  conn.onResponse = (HttpClientResponse resp) {
    var buffer = new StringBuffer();
    var input = resp.inputStream;
    input.onData = () => buffer.add(new String.fromCharCodes(input.read()));
    input.onClosed = () {
      print('Done loading JSON from API');
      client.shutdown();  // XXX do this or the app remains running
      completer.complete(JSON.parse(buffer.toString()));
    };
    input.onError = (e) {
      completer.completeError("ERROR reading from input: $e");
    };
  };
  conn.onError = (e) {
    completer.completeError("ERROR CONNECTING TO YT: $e");
  };
  return completer.future;
}