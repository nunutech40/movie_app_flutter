import 'package:dartz/dartz.dart';
import 'package:movie_app_flutter/common/failure.dart';
import 'package:movie_app_flutter/domain/entities/movie.dart';
import 'package:movie_app_flutter/domain/repositories/movie_repository.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
