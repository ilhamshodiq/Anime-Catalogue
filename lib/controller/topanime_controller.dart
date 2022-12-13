import 'package:dio/dio.dart';
import 'package:mobile_prak_uas_anime_catalogue/models/model_anime.dart';
import 'package:mobile_prak_uas_anime_catalogue/models/model_manga.dart';

final String dataUrlAnime = 'https://api.jikan.moe/v4/top/anime';
final String dataUrlManga = 'https://api.jikan.moe/v4/top/manga';

//fetching top anime
Future<List<TopAnimeData>> getTopAnime() async {
  Response response = await Dio().get(dataUrlAnime);
  final dataModel = ModelAnime.fromJson(response.data as Map<String, dynamic>);
  return dataModel.data;
}



