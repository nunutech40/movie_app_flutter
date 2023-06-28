import 'package:get_it/get_it.dart';
import 'package:movie_app_flutter/domain/usecases/get_now_popular_movies.dart';
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
      getNowPlayingMovies: locator(), getNowPopularMovies: locator()));

  // usecase
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetNowPopularMovies(locator()));

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
