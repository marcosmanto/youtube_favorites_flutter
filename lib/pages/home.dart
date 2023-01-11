import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favorites_flutter/blocs/videos_bloc.dart';
import 'package:youtube_favorites_flutter/delegates/data_search.dart';
import 'package:youtube_favorites_flutter/widgets/video_tile.dart';

import '../models/video.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        title: SizedBox(
          height: 25,
          child: Image.asset('assets/yt_logo_rgb_dark.png'),
        ),
        elevation: 0,
        actions: [
          Align(
            alignment: Alignment.center,
            child: Transform.translate(
              offset: Offset(0, 2.25),
              child: Text('0'),
            ),
          ),
          SizedBox(
            width: 30,
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: Icon(Icons.star),
            ),
          ),
          IconButton(
            onPressed: () async {
              String? result = await showSearch(
                context: context,
                delegate: DataSearch(),
              );
              if (result != null) {
                BlocProvider.getBloc<VideosBloc>().inSearch.add(result);
              }
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: StreamBuilder<List<Video>>(
        stream: BlocProvider.getBloc<VideosBloc>().outVideos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return VideoTile(snapshot.data![index]);
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
