import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:youtube_favorites_flutter/blocs/favorite_bloc.dart';
import 'package:youtube_favorites_flutter/models/video.dart';
import 'package:youtube_favorites_flutter/pages/youtube_player.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<FavoriteBloc>();
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Favoritos'),
        ),
        body: ListTileTheme(
          contentPadding: const EdgeInsets.all(15),
          iconColor: Colors.amber,
          textColor: Colors.white,
          style: ListTileStyle.list,
          child: StreamBuilder<Map<String, Video>>(
            stream: bloc.outFavorites,
            builder: (context, snapshot) {
              var snapDataLength = snapshot.data?.length ?? 0;
              if (snapDataLength > 0) {
                final favVideos = snapshot.data!.values.toList();
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    YoutubePlayerPage(video: favVideos[index]),
                              ),
                            );
                          },
                          leading: IconButton(
                            onPressed: () =>
                                bloc.toggleFavorite(favVideos[index]),
                            icon: Icon(
                              Icons.star,
                            ),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(0, 10, 8, 10),
                          trailing: SizedBox(
                            width: 110,
                            height: 110,
                            child: Image.network(
                              favVideos[index].thumb,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          title: Html(
                            data: favVideos[index].title,
                            style: {
                              'body': Style(
                                  maxLines: 2,
                                  textOverflow: TextOverflow.ellipsis,
                                  margin: EdgeInsets.zero,
                                  color: Colors.white)
                            },
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              favVideos[index].channel,
                              style: TextStyle(
                                  color: Colors.white38, letterSpacing: 0.25),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white54,
                          height: 1,
                        )
                      ],
                    );
                  },
                );
              } else {
                return Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Html(
                      data:
                          '''Você ainda não adicionou nenhum <strong>vídeo favorito</strong>.''',
                      style: {
                        'body': Style(
                          color: Colors.white,
                          fontSize: FontSize(16),
                          textAlign: TextAlign.center,
                          lineHeight: LineHeight(1.5),
                        )
                      },
                    ));
              }
            },
          ),
        ));
  }
}
