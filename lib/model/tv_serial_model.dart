// class TvSerialModel {
//   TvSerialModel({
//     required this.episodeRunTime,
//     required this.genres,
//     required this.id,
//     required this.name,
//     required this.overview,
//     required this.posterPath,
//     required this.voteCount,
//   });

//   final List<int> episodeRunTime;
//   final List<Genre> genres;
//   final int? id;
//   final String? name;
//   final String? overview;
//   final String? posterPath;
//   final int? voteCount;

//   factory TvSerialModel.fromMap(Map<String, dynamic> map) {
//     return TvSerialModel(
//         episodeRunTime: map["episode_run_time"],
//         id: map["id"],
//         name: map["name"],
//         overview: map["overview"],
//         posterPath: map["poster_path"],
//         voteCount: map["vote_count"],
//         genres: (map["genres"] as List<dynamic>)
//             .map((e) => Genre.fromMap(e))
//             .toList());
//   }
// }

// class Genre {
//   final int id;
//   final String name;

//   Genre({
//     required this.id,
//     required this.name,
//   });

//   factory Genre.fromMap(Map<String, dynamic> map) {
//     return Genre(
//       id: map["id"],
//       name: map["name"],
//     );
//   }
// }
