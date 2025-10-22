import 'dart:convert';
import 'dart:io';
import 'package:cine_bot/models/movie.dart';
import 'package:cine_bot/models/movie_details.dart';
import 'package:cine_bot/models/search_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MovieService {
  late final String _apiKey;
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = Platform.localeName;

  MovieService() {
    final apiKey = dotenv.env['TMDB_API_KEY'];

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('Missing TMDB_API_KEY in .env file');
    }

    _apiKey = apiKey;
  }

  Future<Movie?> searchMovie(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(jsonDecode(response.body));
    return searchResponse.results.firstOrNull;
  }

  Future<MovieDetails> getMovieDetails(int id) async {
    final url = Uri.https(_baseUrl, '3/movie/$id', {
      'api_key': _apiKey,
      'language': _language,
      'append_to_response': 'credits',
    });
    final response = await http.get(url);
    final details = MovieDetails.fromJson(jsonDecode(response.body));
    return details;
  }
}
