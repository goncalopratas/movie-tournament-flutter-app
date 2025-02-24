import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/movie_results.dart';
import '../../domain/usecases/movie_search.dart';
import 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final GetMovieSearch _getMovieSearch;
  final GetMovieResults _getMovieResults;

  MovieCubit(
    this._getMovieSearch,
    this._getMovieResults,
  ) : super(const MovieState());

  Future<void> search(String movie) async {
    emit(state.copyWith(status: Status.loading));
    final response = await _getMovieSearch(movie).run();

    if (isClosed) return;

    response.fold(
      (error) {
        emit(state.copyWith(
          status: Status.error,
          errorMessage: error.message,
        ));
      },
      (result) {
        emit(state.copyWith(
          status: Status.loaded,
          searchedList: result,
        ));
      },
    );
  }

  void toggleMovie(Movie movie) {
    emit(state.copyWith(status: Status.loaded));

    final list = List<Movie>.from(state.savedList!);
    if (list.contains(movie)) {
      list.remove(movie);
    } else {
      if (state.savedList!.length == 8) {
        return emit(
          state.copyWith(status: Status.listCompletedError),
        );
      }
      list.add(movie);
    }

    emit(state.copyWith(status: Status.loaded, savedList: list));
  }

  void clearSearchList() {
    emit(state.copyWith(status: Status.loaded, searchedList: []));
  }

  bool movieAlreadyAdded(Movie movie) {
    final movieAlreadyAdded = state.savedList!.firstWhereOrNull(
      (e) => e.title == movie.title,
    );
    return movieAlreadyAdded != null;
  }

  void resetState() {
    emit(state.copyWith(status: Status.loaded));
  }

  Future<void> getResults(List<Movie> movieList) async {
    emit(state.copyWith(status: Status.loading));
    final response = await _getMovieResults(movieList).run();

    if (isClosed) return;

    response.fold(
      (error) {
        emit(state.copyWith(
          status: Status.error,
          errorMessage: error.message,
        ));
      },
      (result) {
        emit(state.copyWith(
          status: Status.loaded,
          results: result,
        ));
      },
    );
  }
}
