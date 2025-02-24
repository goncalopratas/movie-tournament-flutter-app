import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../data/datasources/movie_datasource.dart';
import '../data/repositories/movie_repository_impl.dart';
import '../domain/repositories/movie_repository.dart';
import '../domain/usecases/movie_results.dart';
import '../domain/usecases/movie_search.dart';
import '../presentation/cubit/movie_cubit.dart';

final getIt = GetIt.instance;

void inject() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerFactory<MovieDatasource>(() => MovieDatasource(Dio()));
  getIt.registerFactory<MovieRepository>(
      () => MovieRepositoryImpl(getIt<MovieDatasource>()));
  getIt.registerFactory<GetMovieSearch>(
      () => GetMovieSearch(getIt<MovieRepository>()));
  getIt.registerFactory<GetMovieResults>(
      () => GetMovieResults(getIt<MovieRepository>()));
  getIt.registerLazySingleton<MovieCubit>(() => MovieCubit(
        getIt<GetMovieSearch>(),
        getIt<GetMovieResults>(),
      ));
}
