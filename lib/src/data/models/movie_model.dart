import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.id,
    required super.title,
    required super.releaseDate,
    required super.voteAverage,
    required super.popularity,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    //os resultados da api tem dados que não cumprem o contrato
    //por exemplo estão a enviar int em vez de double

    return MovieModel(
        id: json['id'] as int,
        title: json['title'] as String,
        releaseDate: json['release_date'] as String,
        voteAverage: (json['vote_average'] is int)
            ? (json['vote_average'] as int).toDouble()
            : json['vote_average'] as double,
        popularity: (json['popularity'] is int)
            ? (json['popularity'] as int).toDouble()
            : json['popularity'] as double);
  }
}
