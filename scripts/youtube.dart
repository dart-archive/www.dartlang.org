library youtube;

import 'dart:io';
import 'dart:uri';
import 'dart:json' as JSON;
import 'dart:async';

import 'package:http/http.dart' as http;

final String YT_PLAYLIST_URL = 'http://gdata.youtube.com/feeds/api/playlists/';

Future<Map> fetchPlaylist(String playlistId) {
  var uri = new Uri('$YT_PLAYLIST_URL$playlistId?alt=json');
  return http.get(uri).then((resp) => JSON.parse(resp.body));
}