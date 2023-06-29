import 'package:get_it/get_it.dart';
import 'package:movie_app_flutter/domain/usecases/get_movie_detail_byid.dart';
import 'package:movie_app_flutter/domain/usecases/get_movie_recommendation.dart';
import 'package:movie_app_flutter/domain/usecases/get_now_popular_movies.dart';
import 'package:movie_app_flutter/domain/usecases/get_top_rated_movies.dart';
import 'package:movie_app_flutter/presentation/provider/movie_detail_notifier.dart';
import 'package:movie_app_flutter/presentation/provider/movie_list_notifier.dart';

import 'data/datasources/movie_remote_data_source.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'domain/repositories/movie_repository.dart';
import 'domain/usecases/get_now_playing_movies.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(() => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getNowPopularMovies: locator(),
      getTopRatedMovies: locator()));

  locator.registerFactory(() => MovieDetailNotifier(
      getMovieDetailById: locator(), getMovieRecommendations: locator()));

  // usecase
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetNowPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetailById(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
}
