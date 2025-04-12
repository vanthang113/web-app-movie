class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final double voteAverage;
  final String releaseDate;
  final List<String> genres;
  final int runtime;
  final String trailerUrl;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.genres,
    required this.runtime,
    required this.trailerUrl,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      title: json['title'] as String,
      overview: json['overview'] as String,
      posterPath: json['poster_path'] as String,
      backdropPath: json['backdrop_path'] as String,
      voteAverage: (json['vote_average'] as num).toDouble(),
      releaseDate: json['release_date'] as String,
      genres: (json['genres'] as List<dynamic>).map((e) => e['name'] as String).toList(),
      runtime: json['runtime'] as int,
      trailerUrl: json['trailer_url'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'vote_average': voteAverage,
      'release_date': releaseDate,
      'genres': genres,
      'runtime': runtime,
      'trailer_url': trailerUrl,
    };
  }
} 