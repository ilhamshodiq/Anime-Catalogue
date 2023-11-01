import 'package:dio/dio.dart';
import 'package:anime_catalogue/models/model_anime.dart';
import 'package:anime_catalogue/models/model_animedetail.dart';
import 'package:anime_catalogue/models/model_manga.dart';
import 'package:anime_catalogue/models/model_mangadetail.dart';

final String dataUrlAnime = 'https://api.jikan.moe/v4/top/anime';
final String dataUrlAnimeDariId = 'https://api.jikan.moe/v4/anime/';

final String dataUrlManga = 'https://api.jikan.moe/v4/top/manga';
final String dataUrlMangaDariId = 'https://api.jikan.moe/v4/manga/';

//fetching top anime
Future<List<TopAnimeData>> getTopAnime() async {
  Response response = await Dio().get(dataUrlAnime);
  final dataModel = ModelAnime.fromJson(response.data as Map<String, dynamic>);
  return dataModel.data;
}

//fetching top Manga
Future<List<TopMangaData>> getTopManga() async {
  Response response = await Dio().get(dataUrlManga);
  final dataModel = ModelManga.fromJson(response.data as Map<String, dynamic>);
  return dataModel.data;
}

//fetching anime by id
Future<AnimeDetailData> getAnimeById(String id) async {
  Response response = await Dio().get(dataUrlAnimeDariId + id);
  final dataModel =
      ModelAnimeDetail.fromJson(response.data as Map<String, dynamic>);
  return dataModel.data;
}

//fetching manga by id
Future<MangaDetailData> getMangaById(String id) async {
  Response response = await Dio().get(dataUrlMangaDariId + id);
  final dataModel =
      ModelMangaDetail.fromJson(response.data as Map<String, dynamic>);
  return dataModel.data;
}

