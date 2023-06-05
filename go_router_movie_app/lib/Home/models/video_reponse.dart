// ignore_for_file: public_member_api_docs, sort_constructors_first

class VideosList {
  List<VideoReponse> videos;
  VideosList({
    required this.videos,
  });
  factory VideosList.fromJson(Map<String, dynamic> json) {
    List videoData = json['results'];
    List<VideoReponse> response =
        videoData.map((key) => VideoReponse.fromJson(key)).toList();
    return VideosList(videos: response);
  }
}

class VideoReponse {
  final String? iso6391;
  final String? iso31661;
  final String? name;
  final String? key;
  final String? site;
  final int? size;
  final String? type;
  final bool? official;
  final String? publishedAt;
  final String? id;
  VideoReponse({
    this.iso6391,
    this.iso31661,
    this.name,
    this.key,
    this.site,
    this.size,
    this.type,
    this.official,
    this.publishedAt,
    this.id,
  });
  factory VideoReponse.fromJson(Map<String, dynamic> json) {
    return VideoReponse(
        iso6391: json['iso6391'],
        iso31661: json['iso31661'],
        name: json['name'],
        key: json['key'],
        site: json['site'],
        size: json['size'],
        type: json['type'],
        official: json['official'],
        publishedAt: json['publishedAt'],
        id: json['id']);
  }
  Map<String, dynamic> toJson() => {
        'iso6391': iso6391,
        'iso31661': iso31661,
        'name': name,
        'site': site,
        'size': size,
        'type': type,
        'official': official,
        'publishedAt': publishedAt,
        'id': id,
      };
}
