import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/dependecy_injector.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/show_custom_dialog.dart';
import '../cubit/movie_cubit.dart';
import '../cubit/movie_state.dart';

class MovieSearchPage extends StatelessWidget {
  const MovieSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<MovieCubit>();
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Pesquisa de filmes',
        hasAutomaticLeading: true,
        onLeadingTap: () {
          cubit.clearSearchList();
          context.pop();
        },
      ),
      body: Padding(
          padding: const EdgeInsets.only(
            right: 16,
            left: 16,
            bottom: 32,
            top: 40,
          ),
          child: BlocConsumer<MovieCubit, MovieState>(
            bloc: cubit,
            listener: (context, state) {
              if (state.isError) {
                showCustomDialog(
                  context,
                  icon: Icons.error_outline,
                  message: state.errorMessage,
                  onTap: () => context.pop(),
                );
              }
              if (state.isListCompleted) {
                showCustomDialog(
                  context,
                  icon: Icons.error_outline,
                  message: 'Lista já se encontra completa',
                  onTap: () => context.pop(),
                );
              }
            },
            builder: (context, state) {
              if (state.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Enter text',
                        //border: OutlineInputBorder(),
                      ),
                      onSubmitted: (value) {
                        cubit.search(value);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Column(
                        children: [
                          ...cubit.state.searchedList!.map(
                            (e) => ListTile(
                              title: Text(
                                e.title,
                              ),
                              trailing: Icon(
                                cubit.movieAlreadyAdded(e)
                                    ? Icons.remove_outlined
                                    : Icons.done_outlined,
                              ),
                              onTap: () => cubit.toggleMovie(e),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
