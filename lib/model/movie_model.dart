class MoviesModel {
  bool? adult;
  String? backdroppath;
  int? id;
  String? title;
  String? originallanguage;
  String? originaltitle;
  String? overview;
  String? posterpath;
  String? mediatype;
  List<int?>? genreids;
  double? popularity;
  String? releasedate;
  bool? video;
  double? voteaverage;
  int? votecount;

  MoviesModel({
    this.adult,
    this.backdroppath,
    this.id,
    this.title,
    this.originallanguage,
    this.originaltitle,
    this.overview,
    this.posterpath,
    this.mediatype,
    this.genreids,
    this.popularity,
    this.releasedate,
    this.video,
    this.voteaverage,
    this.votecount,
  });

  factory MoviesModel.fromMap(Map<String, dynamic> map) {
    return MoviesModel(
        adult: map['adult'],
        backdroppath: map['backdrop_path'],
        id: map['id'],
        title: map['title'],
        originallanguage: map['original_language'],
        originaltitle: map['original_title'],
        overview: map['overview'],
        posterpath: map['poster_path'] ?? "/wwemzKWzjKYJFfCeiB57q3r4Bcm.png",
        mediatype: map['media_type'],
        popularity: map['popularity'],
        releasedate: map['release_date'],
        video: map['video'],
        voteaverage: map['vote_average'],
        votecount: map['vote_count']);
  }
}
