import 'package:equatable/equatable.dart';

import '../../domain/entities/movie.dart';

enum Status {
  loaded,
  loading,
  error,
  listCompletedError,
}

class MovieState extends Equatable {
  final Status status;
  final String? errorMessage;
  final List<Movie>? searchedList;
  final List<Movie>? savedList;
  final Map<String, List<Movie>>? results;

  const MovieState({
    this.status = Status.loaded,
    this.errorMessage,
    this.searchedList = const [],
    this.savedList = const [],
    this.results = const {},
  });

  MovieState copyWith(
      {Status? status,
      List<Movie>? searchedList,
      List<Movie>? savedList,
      String? errorMessage,
      Map<String, List<Movie>>? results}) {
    return MovieState(
      status: status ?? this.status,
      searchedList: searchedList ?? this.searchedList,
      savedList: savedList ?? this.savedList,
      errorMessage: errorMessage ?? this.errorMessage,
      results: results ?? this.results,
    );
  }

  @override
  List<Object?> get props => [
        status,
        searchedList,
        savedList,
        errorMessage,
        results,
      ];
}

extension SetAmountExtension on MovieState {
  bool get isLoaded => status == Status.loaded;
  bool get isLoading => status == Status.loading;
  bool get isError => status == Status.error;
  bool get isListCompleted => status == Status.listCompletedError;
}
