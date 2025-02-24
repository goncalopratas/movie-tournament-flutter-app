import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/dependecy_injector.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/movie_phase_result.dart';
import '../../widgets/show_custom_dialog.dart';
import '../cubit/movie_cubit.dart';
import '../cubit/movie_state.dart';

class MovieResultsPage extends StatelessWidget {
  const MovieResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<MovieCubit>();
    cubit.getResults(cubit.state.savedList!);

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Resultados do campeonato',
        hasAutomaticLeading: true,
        onLeadingTap: () {
          context.pop();
          cubit.resetState();
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
          },
          builder: (context, state) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state.isError) {
              return SizedBox();
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...cubit.state.results!.entries
                      .map((entry) => MoviePhaseResult(
                            title: 'Fase ${entry.key}',
                            list: entry.value,
                          )),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
