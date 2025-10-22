class Collection {
  int? id;
  String? name;
  String? posterPath;
  String? backdropPatch;

  Collection({this.id, this.name, this.posterPath, this.backdropPatch});

  Collection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    posterPath = json['poster_path'];
    backdropPatch = json['backdrop_patch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['poster_path'] = posterPath;
    data['backdrop_patch'] = backdropPatch;
    return data;
  }
}
