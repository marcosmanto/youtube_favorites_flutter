import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:youtube_favorites_flutter/blocs/favorite_bloc.dart';

import '../models/video.dart';

class VideoTile extends StatelessWidget {
  final Video video;
  const VideoTile(this.video, {super.key});

  @override
  Widget build(BuildContext context) {
    final blocFavorites = BlocProvider.getBloc<FavoriteBloc>();

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
              StreamBuilder<Map<String, Video>>(
                //initialData: blocFavorites.favorites,
                stream: blocFavorites.outFavorites,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return IconButton(
                      onPressed: () => blocFavorites.toggleFavorite(video),
                      icon: Icon(
                        snapshot.data!.containsKey(video.id)
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.white,
                        size: 30,
                      ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
