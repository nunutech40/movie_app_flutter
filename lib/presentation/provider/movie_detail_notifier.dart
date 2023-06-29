import 'package:flutter/cupertino.dart';
import 'package:movie_app_flutter/common/state_enum.dart';
import 'package:movie_app_flutter/domain/entities/movie_detail.dart';
import 'package:movie_app_flutter/domain/usecases/get_movie_detail_byid.dart';

class MovieDetailNotifier extends ChangeNotifier {
  final GetMovieDetailById getMovieDetailById;

  MovieDetailNotifier({required this.getMovieDetailById});

  late MovieDetail _movie;
  MovieDetail get movie => _movie;

  RequestState _movieState = RequestState.Empty;
  RequestState get movieState => _movieState;

  String _message = '';
  String get message => _message;

  Future<void> fetchMovieDetail(int id) async {
    _movieState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getMovieDetailById.execute(id);
    detailResult.fold(
      (failure) {
        _movieState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (movie) {
        _movie = movie;
        _movieState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
