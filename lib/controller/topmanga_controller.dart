import 'package:dio/dio.dart';
import 'package:mobile_prak_uas_anime_catalogue/models/model_manga.dart';

final String dataUrlManga = 'https://api.jikan.moe/v4/top/manga';



//fetching top Manga
Future<List<TopMangaData>> getTopManga() async {
  Response response = await Dio().get(dataUrlManga);
  final dataModel = ModelManga.fromJson(response.data as Map<String, dynamic>);
  return dataModel.data;
}
