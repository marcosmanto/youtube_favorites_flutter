import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:youtube_player_iframe_plus/youtube_player_iframe_plus.dart';
import '../models/video.dart';

class YoutubePlayerPage extends StatelessWidget {
  final Video video;
  const YoutubePlayerPage({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController ytController = YoutubePlayerController(
      initialVideoId: video.id,
      params: YoutubePlayerParams(
        //playlist: ['nPt8bK2gbaU', 'gQDByCdjUXw'], // Defining custom playlist
        //startAt: Duration(seconds: 30),
        showControls: true,
        showFullscreenButton: true,
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        centerTitle: true,
        title: Html(
          data: video.title,
          style: {'body': Style(color: Colors.white, fontSize: FontSize(16))},
        ),
      ),
      body: Center(
        child: YoutubePlayerIFramePlus(
          controller: ytController,
          aspectRatio: 16 / 9,
        ),
      ),
    );
  }
}
