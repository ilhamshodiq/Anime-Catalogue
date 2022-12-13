import 'package:meta/meta.dart';
import 'dart:convert';

ModelManga modelMangaFromJson(String str) =>
    ModelManga.fromJson(json.decode(str));

String modelMangaToJson(ModelManga data) => json.encode(data.toJson());

class ModelManga {
  ModelManga({
    required this.data,
  });

  final List<TopMangaData> data;

  factory ModelManga.fromJson(Map<String, dynamic> json) => ModelManga(
        data: List<TopMangaData>.from(
            json["data"].map((x) => TopMangaData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TopMangaData {
  TopMangaData({
    required this.malId,
    required this.url,
    required this.images,
    required this.title,
    required this.titleEnglish,
    required this.titleJapanese,
    required this.type,
    required this.chapters,
    required this.volumes,
    required this.status,
    required this.score,
    required this.rank,
    required this.synopsis,
  });

  final int malId;
  final String url;
  final String images;
  final String title;
  final String titleEnglish;
  final String titleJapanese;
  final String type;
  final String chapters;
  final String volumes;
  final String status;
  final String score;
  final String rank;
  final String synopsis;

  factory TopMangaData.fromJson(Map<String, dynamic> json) => TopMangaData(
        malId: json["mal_id"],
        url: json["url"],
        images: json["images"]["jpg"]["image_url"],
        title: json["title"],
        titleEnglish:
            json["title_english"] == null ? "" : json["title_english"],
        titleJapanese: json["title_japanese"],
        type: json["type"],
        chapters: json["chapters"] == null ? "" : json["chapters"].toString(),
        volumes: json["volumes"] == null ? "" : json["volumes"].toString(),
        status: json["status"],
        score: json["score"].toString(),
        rank: json["rank"].toString(),
        synopsis: json["synopsis"],
      );

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "url": url,
        "images": images,
        "title": title,
        "title_english": titleEnglish,
        "title_japanese": titleJapanese,
        "type": type,
        "chapters": chapters,
        "volumes": volumes,
        "status": status,
        "score": score,
        "rank": rank,
        "synopsis": synopsis,
      };
}
