import 'dart:convert';

import 'package:movie_app_flutter/common/exception.dart';
import 'package:movie_app_flutter/data/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app_flutter/data/models/movie_response.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';
  final http.Client client;

  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY'));

    if (response.statusCode == 200) {
      var resutlnya =
          MovieResponse.fromJson(json.decode(response.body)).movieList;

      return resutlnya;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY'));

    if (response.statusCode == 200) {
      var resutlnya =
          MovieResponse.fromJson(json.decode(response.body)).movieList;

      return resutlnya;
    } else {
      throw ServerException();
    }
  }
}
