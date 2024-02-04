class MovieDetailsModel {
  final bool adult;
  final String backdropPath;
  final int budget;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final String imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieDetailsModel({
    required this.adult,
    required this.backdropPath,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetailsModel.fromMap(Map<String, dynamic> map) {
    return MovieDetailsModel(
      adult: map["adult"],
      backdropPath: map["backdrop_path"],
      budget: map["budget"],
      genres: (map["genres"] as List<dynamic>)
          .map((e) => Genre.fromMap(e))
          .toList(),
      homepage: map["homepage"],
      id: map["id"],
      imdbId: map["imdb_id"],
      originalLanguage: map["original_language"],
      originalTitle: map["original_title"],
      overview: map["overview"],
      popularity: map["popularity"],
      posterPath: map["poster_path"],
      releaseDate: map["release_date"],
      revenue: map["revenue"],
      runtime: map["runtime"],
      status: map["status"],
      tagline: map["tagline"],
      title: map["title"],
      video: map["video"],
      voteAverage: map["vote_average"],
      voteCount: map["vote_count"],
    );
  }
}

class Genre {
  int id;
  String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromMap(Map<String, dynamic> map) {
    return Genre(
      id: map["id"],
      name: map["name"],
    );
  }
}
