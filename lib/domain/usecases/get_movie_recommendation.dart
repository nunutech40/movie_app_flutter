import 'package:dartz/dartz.dart';
import 'package:movie_app_flutter/domain/repositories/movie_repository.dart';

import '../../common/failure.dart';
import '../entities/movie.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
