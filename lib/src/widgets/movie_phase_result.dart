import 'package:flutter/widgets.dart';

import '../domain/entities/movie.dart';

class MoviePhaseResult extends StatelessWidget {
  final String title;
  final List<Movie> list;
  const MoviePhaseResult({
    super.key,
    required this.title,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...list.map((e) => Text(e.title)),
        ],
      ),
    );
  }
}
