import 'package:fpdart/fpdart.dart';

import '../../core/error.dart';
import '../entities/movie.dart';

abstract class MovieRepository {
  TaskEither<APIError, List<Movie>> search(String value);
  TaskEither<APIError, Map<String, List<Movie>>> getResults(List<Movie> list);
}
