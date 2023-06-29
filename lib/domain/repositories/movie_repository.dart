import 'package:dartz/dartz.dart';
import 'package:movie_app_flutter/domain/entities/movie_detail.dart';

import '../../common/failure.dart';
import '../entities/movie.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();
  Future<Either<Failure, List<Movie>>> getNowPopularMovies();
  Future<Either<Failure, List<Movie>>> getTopRatedMovies();
  Future<Either<Failure, MovieDetail>> getMovieDetailById(int id);
}
