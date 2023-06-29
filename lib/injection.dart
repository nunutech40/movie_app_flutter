import 'package:get_it/get_it.dart';
import 'package:movie_app_flutter/domain/usecases/get_movie_detail_byid.dart';
import 'package:movie_app_flutter/domain/usecases/get_movie_recommendation.dart';
import 'package:movie_app_flutter/domain/usecases/get_now_popular_movies.dart';
import 'package:movie_app_flutter/domain/usecases/get_top_rated_movies.dart';
import 'package:movie_app_flutter/domain/usecases/search_movies.dart';
import 'package:movie_app_flutter/presentation/provider/movie_detail_notifier.dart';
import 'package:movie_app_flutter/presentation/provider/movie_list_notifier.dart';
import 'package:movie_app_flutter/presentation/provider/movie_search_notifier.dart';
import 'package:movie_app_flutter/presentation/provider/popular_movies_notifier.dart';
import 'package:movie_app_flutter/presentation/provider/top_rated_movies_notifier.dart';
import 'package:movie_app_flutter/presentation/provider/watch_list_movies_notifier.dart';

import 'data/datasources/db/database_helper.dart';
import 'data/datasources/movie_local_data_source.dart';
import 'data/datasources/movie_remote_data_source.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'domain/repositories/movie_repository.dart';
import 'domain/usecases/get_now_playing_movies.dart';
import 'package:http/http.dart' as http;

import 'domain/usecases/get_watchlist_movie.dart';
import 'domain/usecases/get_watchlist_status.dart';
import 'domain/usecases/remove_watchlist.dart';
import 'domain/usecases/save_watchlist.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(() => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getNowPopularMovies: locator(),
      getTopRatedMovies: locator()));

  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetailById: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );

  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  // usecase
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetNowPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetailById(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localeDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
