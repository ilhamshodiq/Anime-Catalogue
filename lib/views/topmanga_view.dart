import 'package:anime_catalogue/models/db.dart';
import 'package:anime_catalogue/models/model_manga.dart';
import 'package:anime_catalogue/viewmodel/services.dart';
import 'package:anime_catalogue/views/detail_topmanga.dart';
import 'package:flutter/material.dart';

class TopManga extends StatefulWidget {
  const TopManga({super.key});

  @override
  State<TopManga> createState() => _TopMangaState();
}

class _TopMangaState extends State<TopManga> {
  final DatabaseHelper databaseHelper = DatabaseHelper();

  List<TopMangaData> data = [];
  List<bool?> isFavoriteData = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshPageManga();
  }

  Future<void> refreshPageManga() async {
    setState(() {
      isLoading = true;
    });
    getTopManga().then((value) {
      data = value;
      if (mounted) {
        isFavoriteData = List.generate(data.length, (index) => null);
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refreshPageManga,
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final String gambar = data[index].images.toString();
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailTopMangaScreenPage(
                                      id: data[index].malId.toString(),
                                    ),
                                  ),
                                );
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
                                child: Stack(children: [
                                  Row(
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
                                                image: NetworkImage(gambar !=
                                                        null
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
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Text(
                                                data[index].title,
                                                // 'judul',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.book,
                                                  size: 20,
                                                  color: Colors.black,
                                                ),
                                                const SizedBox(width: 2),
                                                Text(
                                                  data[index].type,
                                                  // 'tipe',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
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
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                const Text(
                                                  'Volume :',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(width: 2),
                                                Text(
                                                  data[index].chapters,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    top: 8.0,
                                    right: 8.0,
                                    child: IconButton(
                                      icon: FutureBuilder<bool?>(
                                        future: databaseHelper
                                            .checkDuplicate(data[index].malId),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<bool?> snapshot) {
                                          final isFavorite = snapshot.data;
                                          return Icon(
                                            isFavorite == true
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: Colors.red,
                                          );
                                        },
                                      ),
                                      onPressed: () {
                                        databaseHelper
                                            .checkDuplicate(data[index].malId)
                                            .then((isFavorite) {
                                          if (isFavorite == true) {
                                            databaseHelper
                                                .deleteBookmark(Bookmark(
                                              malid: data[index].malId,
                                              title: data[index].title,
                                              img: data[index].images,
                                              type: data[index].type,
                                            ));
                                            setState(() {
                                              isFavoriteData[index] = false;
                                            });
                                          } else {
                                            databaseHelper
                                                .insertBookmark(Bookmark(
                                              malid: data[index].malId,
                                              title: data[index].title,
                                              img: data[index].images,
                                              type: data[index].type,
                                            ));
                                            setState(() {
                                              isFavoriteData[index] = true;
                                            });
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ]),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
