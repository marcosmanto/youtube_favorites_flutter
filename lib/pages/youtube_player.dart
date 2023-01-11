import 'package:flutter/material.dart';
import 'package:flutter_youtube_view/flutter_youtube_view.dart';

import '../models/video.dart';

class YoutubePlayer extends StatelessWidget {
  final Video video;
  const YoutubePlayer({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        centerTitle: true,
        title: Text(video.title),
      ),
      body: Center(
        child: FlutterYoutubeView(
          //onViewCreated: _onYoutubeCreated,
          //listener: this,
          scaleMode: YoutubeScaleMode.none, // <option> fitWidth, fitHeight
          params: YoutubeParam(
            videoId: video.id,
            showUI: true,
            startSeconds: 0.0, // <option>
            autoPlay: true,
          ), // <option>
        ),
      ),
    );
  }
}
