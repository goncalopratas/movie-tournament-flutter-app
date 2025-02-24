import 'package:go_router/go_router.dart';

import 'src/presentation/pages/movie_list_page.dart';
import 'src/presentation/pages/movie_results_page.dart';
import 'src/presentation/pages/movie_search_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => MovieListPage(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => MovieSearchPage(),
    ),
    GoRoute(
      path: '/movieResults',
      builder: (context, state) => MovieResultsPage(),
    ),
  ],
);
