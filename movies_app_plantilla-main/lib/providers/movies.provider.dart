import 'package:flutter/cupertino.dart';

import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import '../models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = 'c285100fed27987e889ae495dc67eda2';
  String _language = 'es-ES';
  String _page = '1';

  List<Movie> onDisplayMovies = [];
  List<Movie> onPopularMovies = [];

  Map<int, List<Cast>> casting = {};

  MoviesProvider() {
    this.getOnDisplayMovies();
    this.getOnDisplayPopular();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': _page,
    });

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final nowPlayingResponse = NowPlayingResponse.fromJson(result.body);

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getOnDisplayPopular() async {
    var url = Uri.https(_baseUrl, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _page,
    });

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final popularResponse = Populars.fromJson(result.body);

    onPopularMovies = popularResponse.results;

    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int idMovie) async {
    print('entrando server');

    var url = Uri.https(_baseUrl, '3/movie/$idMovie/credits', {
      'api_key': _apiKey,
      'language': _language,
      'page': _page,
    });

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final creditsResponse = CreditsResponse.fromJson(result.body);
    casting[idMovie] = creditsResponse.cast;

    return creditsResponse.cast;
  }
}
