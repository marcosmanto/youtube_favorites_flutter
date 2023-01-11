import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../models/video.dart';

class VideoTile extends StatelessWidget {
  final Video video;
  const VideoTile(this.video, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              video.thumb,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Html(
                        data: video.title,
                        style: {
                          'body': Style(
                              color: Colors.white,
                              margin: EdgeInsets.zero,
                              fontSize: FontSize(14),
                              fontWeight: FontWeight.w300,
                              letterSpacing: 1.05)
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 4, 8, 10),
                      child: Text(
                        video.channel,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.star_border,
                    color: Colors.white,
                    size: 30,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
