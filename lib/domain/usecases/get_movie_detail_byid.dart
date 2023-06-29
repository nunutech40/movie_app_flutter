import 'package:dartz/dartz.dart';
import 'package:movie_app_flutter/domain/entities/movie_detail.dart';

import '../../common/failure.dart';
import '../repositories/movie_repository.dart';

class GetMovieDetailById {
  final MovieRepository repository;

  GetMovieDetailById(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetailById(id);
  }
}
