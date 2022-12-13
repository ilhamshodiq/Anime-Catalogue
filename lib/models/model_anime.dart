import 'package:meta/meta.dart';
import 'dart:convert';

ModelAnime modelAnimeFromJson(String str) =>
    ModelAnime.fromJson(json.decode(str));

String modelAnimeToJson(ModelAnime data) => json.encode(data.toJson());

class ModelAnime {
  ModelAnime({
    required this.data,
  });

  final List<TopAnimeData> data;

  factory ModelAnime.fromJson(Map<String, dynamic> json) => ModelAnime(
        data: List<TopAnimeData>.from(
            json["data"].map((x) => TopAnimeData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TopAnimeData {
  TopAnimeData({
    required this.malId,
    required this.url,
    required this.images,
    required this.title,
    required this.titleEnglish,
    required this.titleJapanese,
    required this.type,
    required this.source,
    required this.score,
    required this.rank,
    required this.synopsis,
    required this.season,
    required this.year,
  });

  final String malId;
  final String url;
  final String images;
  final String title;
  final String titleEnglish;
  final String titleJapanese;
  final String type;
  final String source;
  final String score;
  final String rank;
  final String synopsis;
  final String season;
  final String year;

  factory TopAnimeData.fromJson(Map<String, dynamic> json) => TopAnimeData(
        malId: json["mal_id"].toString(),
        url: json["url"],
        images: json["images"]["jpg"]["image_url"],
        title: json["title"],
        titleEnglish:
            json["title_english"] == null ? "" : json["title_english"],
        titleJapanese: json["title_japanese"],
        type: json['type'],
        source: json["source"],
        score: json["score"].toString(),
        rank: json["rank"].toString(),
        synopsis: json["synopsis"],
        season: json["season"] == null ? "" : json["season"],
        year: json["year"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "url": url,
        "images": images,
        "title": title,
        "title_english": titleEnglish,
        "title_japanese": titleJapanese,
        "type": type,
        "source": source,
        "score": score,
        "rank": rank,
        "season": season,
        "year": year,
      };
}
