import 'package:flutter/cupertino.dart';
import 'package:movie_app_flutter/common/state_enum.dart';
import 'package:movie_app_flutter/domain/entities/movie_detail.dart';
import 'package:movie_app_flutter/domain/usecases/get_movie_detail_byid.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_movie_recommendation.dart';

class MovieDetailNotifier extends ChangeNotifier {

  final GetMovieDetailById getMovieDetailById;
  final GetMovieRecommendations getMovieRecommendations;

  MovieDetailNotifier(
      {required this.getMovieDetailById,
      required this.getMovieRecommendations});

  late MovieDetail _movie;
  MovieDetail get movie => _movie;

  RequestState _movieState = RequestState.Empty;
  RequestState get movieState => _movieState;

  List<Movie> _movieRecommendations = [];
  List<Movie> get movieRecommendations => _movieRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  Future<void> fetchMovieDetail(int id) async {
    _movieState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getMovieDetailById.execute(id);
    final recommendationResult = await getMovieRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _movieState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (movie) {
        // notif dulu kalau movie detail sudah berhasil di load
        _recommendationState = RequestState.Loading;
        _movie = movie;
        notifyListeners();

        // load selanjutnya recomendation movie
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (movies) {
            _recommendationState = RequestState.Loaded;
            _movieRecommendations = movies;
          },
        );
        _movieState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
