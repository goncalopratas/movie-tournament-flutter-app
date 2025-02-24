import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/dependecy_injector.dart';
import '../../widgets/custom_appbar.dart';
import '../cubit/movie_cubit.dart';
import '../cubit/movie_state.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieCubit>(
      create: (context) => getIt<MovieCubit>(),
      child: _MovieListManageView(),
    );
  }
}

class _MovieListManageView extends StatelessWidget {
  const _MovieListManageView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<MovieCubit>();

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Lista de filmes',
        hasMenu: true,
      ),
      body: BlocConsumer<MovieCubit, MovieState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(
              right: 16,
              left: 16,
              bottom: 32,
              top: 40,
            ),
            child: Column(
              children: [
                ...state.savedList!.map(
                  (e) => ListTile(
                    title: Text(
                      e.title,
                    ),
                    trailing: IconButton(
                        onPressed: () => cubit.toggleMovie(e),
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
