class Movie {
  final int id;
  final String title;
  final String releaseDate;
  final double voteAverage;
  final double popularity;

  const Movie({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.voteAverage,
    required this.popularity,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'release_date': releaseDate,
      'vote_average': voteAverage,
      'popularity': popularity,
    };
  }
}
