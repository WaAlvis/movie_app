import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  List<Movie> onPlayNow = [];

  MoviesProvider() {
    print('Movies provider inicializado');
    getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    String _baseUrl = 'api.themoviedb.org';
    String _api_key = 'c517e987f05c52d873863f6591cbbb29';
    String _endPoint = '3/movie/now_playing';
    String _language = 'es-ES';

    var url = Uri.https(_baseUrl, _endPoint, {
      'api_key': _api_key,
      'language': _language,
      'page': '1',
    });
    var response = await http.get(
      url,
    );

    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    onPlayNow = nowPlayingResponse.results;
    notifyListeners();
  }
}
