import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/video.dart';

class FavoriteBloc extends BlocBase {
  Map<String, Video> _favorites = {};

  final _favController = BehaviorSubject<Map<String, Video>>.seeded({});

  FavoriteBloc() {
    // load saved favorites in local storage
    SharedPreferences.getInstance().then(
      (prefs) {
        if (prefs.getKeys().contains('favorites')) {
          _favorites = json.decode(prefs.getString('favorites')!).map(
            (key, value) {
              return MapEntry(key, Video.fromJson(value));
            },
          ).cast<String, Video>();
          _favController.add(_favorites);
        }
      },
    );
  }

  // access to the exit/output of stream
  Stream<Map<String, Video>> get outFavorites => _favController.stream;
  Map<String, Video> get favorites => _favorites;

  void toggleFavorite(Video video) {
    if (_favorites.containsKey(video.id)) {
      _favorites.remove(video.id);
    } else {
      _favorites[video.id] = video;
    }
    _favController.add(_favorites);
    _saveFavorites();
  }

  @override
  void dispose() {
    _favController.close();
    super.dispose();
  }

  void _saveFavorites() {
    SharedPreferences.getInstance()
        .then((prefs) => prefs.setString('favorites', json.encode(_favorites)));
  }
}
