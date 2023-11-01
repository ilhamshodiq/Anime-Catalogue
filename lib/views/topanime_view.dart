import 'package:flutter/material.dart';
import 'package:anime_catalogue/viewmodel/services.dart';
import 'package:anime_catalogue/models/model_anime.dart';
import 'package:anime_catalogue/views/detail_topanime.dart';

class TopAnime extends StatefulWidget {
  const TopAnime({super.key});

  @override
  State<TopAnime> createState() => _TopAnimeState();
}

class _TopAnimeState extends State<TopAnime> {
  List<TopAnimeData> data = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getTopAnime().then((value) {
      data = value;
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading
          ? const CircularProgressIndicator()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final String gambar = data[index].images.toString();
                        final String sinopsis = data[index].synopsis.toString();
                        return InkWell(
                          onTap: () {
                            //navigate ke detail_topanime
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailTopAnimeScreenPage(
                                            id: data[index].malId.toString())));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  offset: Offset(
                                      0, 16), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 100,
                                      width: 84,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        image: DecorationImage(
                                          image: NetworkImage(gambar != null
                                              ? gambar
                                              : 'https://i.pinimg.com/originals/ea/3e/f2/ea3ef2a6e0f5c803a92b00bb69bdb6a3.png'),
                                        ),
                                      ),
                                    )),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            style:
                                                const TextStyle(fontSize: 14),
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
                                            style:
                                                const TextStyle(fontSize: 14),
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
                                            style:
                                                const TextStyle(fontSize: 14),
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
