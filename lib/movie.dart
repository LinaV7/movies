class Movie {
  final int id;
  final String title;
  final double voteAverage;
  final String releaseDate;
  final String overview;
  final String? posterPath;

  Movie(
      {required this.id,
      required this.title,
      required this.voteAverage,
      required this.releaseDate,
      required this.overview,
      this.posterPath});

  // Movie.fromJson(Map<String, dynamic> parsedJson) {
  //   this.id = parsedJson['id'];
  //   this.title = parsedJson['title'];
  //   this.voteAverage = parsedJson['vote_average'] * 1.0;
  //   this.releaseDate = parsedJson['release_date'];
  //   this.overview = parsedJson['overview'];
  //   this.posterPath = parsedJson['poster_path'];
  // }

  factory Movie.fromJson(Map<String, dynamic> parsedJson) {
    return Movie(
      id: parsedJson['id'] as int,
      title: parsedJson['title'] as String,
      voteAverage: (parsedJson['vote_average'] as num).toDouble(),
      releaseDate: parsedJson['release_date'] as String,
      overview: parsedJson['overview'] as String,
      posterPath: parsedJson['poster_path'] as String?,
    );
  }
}
