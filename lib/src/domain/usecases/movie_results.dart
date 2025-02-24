import 'package:fpdart/fpdart.dart';

import '../../core/error.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetMovieResults {
  final MovieRepository repository;

  const GetMovieResults(this.repository);

  TaskEither<APIError, Map<String, List<Movie>>> call(List<Movie> list) {
    return repository.getResults(list);
  }
}
