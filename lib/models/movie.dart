import 'package:cine_bot/models/movie_details.dart';

class Movie {
  Movie({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    this.details,
  });

  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  String? releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;
  MovieDetails? details;

  String get heroID => '$id-$title';

  String get posterImage => posterPath != null
      ? 'https://image.tmdb.org/t/p/w500${posterPath}'
      : 'https://i.stack.imgur.com/GNhxO.png';

  get backdropImage => backdropPath != null
      ? 'https://image.tmdb.org/t/p/original${backdropPath}'
      : 'https://i.stack.imgur.com/GNhxO.png';

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    adult: json["adult"] ?? false,
    backdropPath: json["backdrop_path"],
    genreIds: json['genre_id'] != null
        ? List<int>.from(json["genre_id"].map((x) => x))
        : [],
    id: json["id"] ?? -1,
    originalLanguage: json["original_language"] ?? '',
    originalTitle: json["original_title"] ?? '',
    overview: json["overview"] ?? '',
    popularity: double.tryParse(json["popularity"].toString()) ?? 0,
    posterPath: json["poster_path"],
    releaseDate: json["release_date"],
    title: json["title"] ?? '',
    video: json["video"] ?? false,
    voteAverage: double.tryParse(json["vote_average"].toString()) ?? 0,
    voteCount: int.tryParse(json["vote_count"].toString()) ?? 0,
    details: json['details'] != null
        ? MovieDetails.fromJson(json['details'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'adult': adult,
    'backdrop_path': backdropPath,
    'genre_id': genreIds,
    'id': id,
    'original_language': originalLanguage,
    'original_title': originalTitle,
    'overview': overview,
    'popularity': popularity,
    'poster_path': posterPath,
    'release_date': releaseDate,
    'title': title,
    'video': video,
    'vote_average': voteAverage,
    'vote_count': voteCount,
    'details': details?.toJson(),
  };
}
