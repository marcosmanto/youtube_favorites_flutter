import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youtube_favorites_flutter/keys/api_keys.dart';
import 'package:youtube_favorites_flutter/models/video.dart';

class YoutubeApi {
  static String? _search;
  static String? _nextToken;

  static Future<List<Video>> search(String search) async {
    _search = search;
    http.Response response = await http.get(
      Uri.parse(
          '${FirebaseApi.baseUri.value}search?part=snippet&maxResults=10&q=$search&type=video&key=${FirebaseApi.key.value}'),
    );

    return _decode(response);
  }

  static Future<List<Video>> nextPage() async {
    http.Response response = await http.get(
      Uri.parse(
          '${FirebaseApi.baseUri.value}search?part=snippet&maxResults=10&q=$_search&type=video&key=${FirebaseApi.key.value}&pageToken=$_nextToken'),
    );

    return _decode(response);
  }

  static List<Video> _decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      _nextToken = decoded['nextPageToken'];

      List<Video> videos = decoded['items'].map<Video>((video) {
        return Video.fromJson(video);
      }).toList();

      return videos;
    } else {
      throw Exception('Failed to load videos');
    }
  }
}
