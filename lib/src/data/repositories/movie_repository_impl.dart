import 'package:fpdart/fpdart.dart';

import '../../core/error.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_datasource.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieDatasource datasource;

  const MovieRepositoryImpl(this.datasource);

  @override
  TaskEither<APIError, List<Movie>> search(String value) {
    return datasource.search(value);
  }

  @override
  TaskEither<APIError, Map<String, List<Movie>>> getResults(List<Movie> list) {
    return datasource.getResults(list);
  }
}
