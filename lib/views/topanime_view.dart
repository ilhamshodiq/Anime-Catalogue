import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_prak_uas_anime_catalogue/models/model_anime.dart';

class TopAnime extends StatefulWidget {
  const TopAnime({super.key});

  @override
  State<TopAnime> createState() => _TopAnimeState();
}

class _TopAnimeState extends State<TopAnime> {
  final String dataUrl = 'https://api.jikan.moe/v4/top/anime';

  Future<List<Datum>> getListHit() async {
    Response response = await Dio().get(dataUrl);
    final dataModel =
        ModelAnime.fromJson(response.data as Map<String, dynamic>);
    return dataModel.data;
  }

  List<Datum> data = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getListHit().then((value) {
      data = value;
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: isLoading
                ? const CircularProgressIndicator()
                : ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final String gambar = data[index].images.toString();
                      final String sinopsis = data[index].synopsis.toString();
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                spreadRadius: 0,
                                blurRadius: 0,
                                offset:
                                    Offset(0, 16), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 100,
                                    width: 84,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      image: DecorationImage(
                                        image: NetworkImage(gambar != null
                                            ? gambar
                                            : 'https://i.pinimg.com/originals/ea/3e/f2/ea3ef2a6e0f5c803a92b00bb69bdb6a3.png'),
                                      ),
                                    ),
                                  )),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        data[index].title,
                                        // 'judul',
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.tv, size: 20),
                                        const SizedBox(width: 2),
                                        Text(
                                          data[index].type,
                                          // 'tipe',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(width: 10),
                                        const Icon(
                                          Icons.star,
                                          size: 20,
                                          color: Colors.orange,
                                        ),
                                        const SizedBox(width: 2),
                                        Text(
                                          data[index].score,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(width: 10),
                                        const Icon(
                                          Icons.calendar_month_outlined,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 2),
                                        Text(
                                          data[index].season != 'null'
                                              ? data[index].season
                                              : 'N/A',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
          ),
        ],
      ),
    );
  }
}
