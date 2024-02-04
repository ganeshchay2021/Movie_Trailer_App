class TraillerModel {
  String? iso6391;
  String? iso31661;
  String? name;
  String? key;
  String? site;
  int? size;
  String? type;
  bool? official;
  String? publishedat;
  String? id;

  TraillerModel({
    this.iso6391,
    this.iso31661,
    this.name,
    this.key,
    this.site,
    this.size,
    this.type,
    this.official,
    this.publishedat,
    this.id,
  });

  factory TraillerModel.fromMap(Map<String, dynamic> map) {
    return TraillerModel(
        iso6391: map['iso_639_1'],
        iso31661: map['iso_3166_1'],
        name: map['name'],
        key: map['key'],
        site: map['site'],
        size: map['size'],
        type: map['type'],
        official: map['official'],
        publishedat: map['published_at'],
        id: map['id']);
  }
}
