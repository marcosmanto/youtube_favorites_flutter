import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:youtube_favorites_flutter/blocs/favorite_bloc.dart';
import 'package:youtube_favorites_flutter/blocs/videos_bloc.dart';
import 'package:youtube_favorites_flutter/delegates/data_search.dart';
import 'package:youtube_favorites_flutter/widgets/video_tile.dart';

import '../models/video.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<VideosBloc>();
    final blocFavorites = BlocProvider.getBloc<FavoriteBloc>();

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
              child: StreamBuilder<Map<String, Video>>(
                stream: blocFavorites.outFavorites,
                builder: (context, snapshot) {
                  return Text(snapshot.hasData
                      ? snapshot.data!.length.toString()
                      : '0');
                },
              ),
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
              if (result != null && result.trim() != '') {
                bloc.inSearch.add(result);
              }
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: StreamBuilder<List<Video>>(
        initialData: [],
        stream: bloc.outVideos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length + 1,
              itemBuilder: (context, index) {
                if (index < snapshot.data!.length) {
                  return VideoTile(snapshot.data![index]);
                } else if (index > 1) {
                  // ONLY ALLOWS DISPLAY OF LOAD MORE WIDGET
                  // IF VIDEO SEARCH LIST IS NOT EMPTY WHICH MEANS THAT INDEX FOR
                  // THE LOAD MORE WIDGET WILL BE MORE THAN 1

                  // last item of list is above this
                  // add next items by calling search with null which results in calling nextPage
                  // this block is triggered only when this element is reached by user scrolling
                  bloc.inSearch.add(null);

                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Html(
                      data:
                          '''Realize uma pesquisa <strong>clicando na lupa</strong> <lupa></lupa> para listar os vídeos.''',
                      style: {
                        'body': Style(
                          color: Colors.white,
                          fontSize: FontSize(16),
                          textAlign: TextAlign.center,
                          lineHeight: LineHeight(1.5),
                        )
                      },
                      customRender: {
                        "lupa": (RenderContext context, Widget child) {
                          return Transform.translate(
                            offset: Offset(0, 4.5),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 2, 0),
                              child: Icon(
                                Icons.search_outlined,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      },
                      tagsList: Html.tags..addAll(["lupa"]),
                    ),
                  );
                }
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
