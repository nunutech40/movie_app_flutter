import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/movie.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();
  Future<Either<Failure, List<Movie>>> getNowPopularMovies();
}
