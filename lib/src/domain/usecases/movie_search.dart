import 'package:fpdart/fpdart.dart';

import '../../core/error.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetMovieSearch {
  final MovieRepository repository;

  const GetMovieSearch(this.repository);

  TaskEither<APIError, List<Movie>> call(String value) {
    return repository.search(value);
  }
}
