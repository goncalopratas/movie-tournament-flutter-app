import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../core/error.dart';
import '../../domain/entities/movie.dart';
import '../models/movie_model.dart';

class MovieDatasource {
  final Dio dio;

  const MovieDatasource(this.dio);

  TaskEither<APIError, List<Movie>> search(String value) {
    return TaskEither.tryCatch(() async {
      final response = await dio.get(
        'http://localhost:8000/search',
        queryParameters: {'movieTitle': value},
      );

      final list =
          List.from(response.data).map((e) => MovieModel.fromJson(e)).toList();
      return list;
    }, (error, _) {
      return APIError(error.toString());
    });
  }

  TaskEither<APIError, Map<String, List<Movie>>> getResults(
      List<Movie> movieList) {
    //dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));

    return TaskEither.tryCatch(() async {
      final response = await dio.post(
        'http://localhost:8000/startTournament',
        data: {
          'movieList': movieList.map((movie) => movie.toJson()).toList(),
        },
      );

      Map<String, dynamic> decodedData = response.data;
      // if (response.data is String) {
      //   decodedData = jsonDecode(response.data);
      // } else if (response.data is Map<String, dynamic>) {
      //   decodedData = response.data;
      // } else {
      //   throw APIError('Unexpected response format');
      // }

      //final Map<String, dynamic> decodedData = jsonDecode(response.data);

      Map<String, List<Movie>> result = decodedData.map((key, value) {
        List<Movie> movies =
            (value as List).map((item) => MovieModel.fromJson(item)).toList();
        return MapEntry(key, movies);
      });

      return result;
    }, (error, _) {
      return APIError(error.toString());
    });
  }
}
