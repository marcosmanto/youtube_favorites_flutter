import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favorites_flutter/blocs/favorite_bloc.dart';
import 'package:youtube_favorites_flutter/youtube_api.dart';

import 'blocs/videos_bloc.dart';
import 'pages/home.dart';

void main() {
  YoutubeApi.search('alababa');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return BlocProvider(
      dependencies: [],
      blocs: [Bloc((i) => VideosBloc()), Bloc((i) => FavoriteBloc())],
      child: MaterialApp(
        title: 'FlutterTube',
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.black,
            secondary: const Color(0xFFfd0100),
            tertiary: Colors.grey[800],
          ),
        ),
        home: Home(),
      ),
    );
  }
}
