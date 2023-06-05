// ignore_for_file: public_member_api_docs, sort_constructors_first
class FavoriteMovies {
  final List<FavMovieData> item;
  FavoriteMovies({
    required this.item,
  });
  factory FavoriteMovies.fromJson(Map<String, dynamic> json) {
    List movies = json['results'];
    List<FavMovieData> moviesData =
        movies.map((e) => FavMovieData.fromJson(e)).toList();
    return FavoriteMovies(item: moviesData);
  }
  FavoriteMovies copyWith({
    List<FavMovieData>? item,
  }) {
    return FavoriteMovies(
      item: item ?? this.item,
    );
  }
}

class FavMovieData {
  String? backdropPath;
  final int? id;
  final String? mediaType;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final List<dynamic>? genrId;
  final num? voteAverage;
  final num? voteCount;
  FavMovieData({
    required this.backdropPath,
    required this.id,
    required this.mediaType,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.genrId,
    required this.voteAverage,
    required this.voteCount,
  });
  factory FavMovieData.fromJson(Map<String, dynamic> json) {
    return FavMovieData(
        backdropPath: json['backdrop_path'],
        id: json['id'],
        mediaType: json['media_type'],
        genrId: json['genre_ids'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['poster_path'],
        releaseDate: json['release_date'],
        title: json['title'],
        video: json['video'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count']);
  }
}
