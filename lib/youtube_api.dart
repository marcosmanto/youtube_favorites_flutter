import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youtube_favorites_flutter/keys/api_keys.dart';
import 'package:youtube_favorites_flutter/models/video.dart';

class YoutubeApi {
  static Future<List<Video>> search(String search) async {
    http.Response response = await http.get(
      Uri.parse(
          '${FirebaseApi.baseUri.value}search?part=snippet&maxResults=10&q=$search&type=video&key=${FirebaseApi.key.value}'),
    );

    return _decode(response);
  }

  static List<Video> _decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      List<Video> videos = decoded['items'].map<Video>((video) {
        return Video.fromJson(video);
      }).toList();

      return videos;
    } else {
      throw Exception('Failed to load videos');
    }
  }
}
