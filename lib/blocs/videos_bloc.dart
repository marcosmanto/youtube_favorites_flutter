import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:youtube_favorites_flutter/models/video.dart';
import 'package:youtube_favorites_flutter/youtube_api.dart';

class VideosBloc extends BlocBase {
  List<Video> videos = [];
  final _videosController = StreamController<List<Video>>();
  // receives data from outside
  final _searchController = StreamController<String?>();

  VideosBloc() {
    _searchController.stream.listen(_search);
  }

  // exposes stream's sink to add outside data (search terms)
  Sink get inSearch => _searchController.sink;
  // access to stream's data output present in '.stream'
  Stream<List<Video>> get outVideos => _videosController.stream;

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
    super.dispose();
  }

  void _search(String? search) async {
    if (search != null) {
      videos = await YoutubeApi.search(search);
    } else {
      // Adding next page to existing list. Dart allows list unions using +=
      videos += await YoutubeApi.nextPage();
    }
    _videosController.add(videos);
  }
}
