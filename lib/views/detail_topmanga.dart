import 'package:anime_catalogue/models/db.dart';
import 'package:anime_catalogue/models/model_mangadetail.dart';
import 'package:anime_catalogue/viewmodel/services.dart';
import 'package:flutter/material.dart';

class DetailTopMangaScreenPage extends StatefulWidget {
  //key untuk anime by id
  final String id;

  const DetailTopMangaScreenPage({super.key, required this.id});

  @override
  State<DetailTopMangaScreenPage> createState() =>
      _DetailTopMangaScreenPageState();
}

class _DetailTopMangaScreenPageState extends State<DetailTopMangaScreenPage> {
  final DatabaseHelper databaseHelper = DatabaseHelper();

  bool? isFavorite;
  MangaDetailData? data;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getMangaById(widget.id).then((value) {
      data = value;
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: FutureBuilder<MangaDetailData?>(
          future: getMangaById(widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              if (snapshot.hasData && snapshot.data != null) {
                MangaDetailData data = snapshot.data!;
                return Text(data.title);
              } else {
                return Text("...");
              }
            }
          },
        ),
      ),
      body: isLoading
          ? Center(child: const CircularProgressIndicator())
          : ListView(
        padding: EdgeInsets.only(top: 0),
        children: <Widget>[
          Image.network(
            data!.images.toString(),
            height: MediaQuery.of(context).size.height / 2,
            fit: BoxFit.cover,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        data!.title,
                        style: const TextStyle(fontSize: 28),
                      ),
                    ),
                    IconButton(
                      icon: FutureBuilder<bool?>(
                        future: databaseHelper
                            .checkDuplicate(data!.malId),
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
                            .checkDuplicate(data!.malId)
                            .then((isFavorite) {
                          if (isFavorite == true) {
                            databaseHelper
                                .deleteBookmark(Bookmark(
                              malid: data!.malId,
                              title: data!.title,
                              img: data!.images,
                              type: data!.type,
                            ));
                            setState(() {
                              isFavorite = false;
                            });
                          } else {
                            databaseHelper
                                .insertBookmark(Bookmark(
                              malid: data!.malId,
                              title: data!.title,
                              img: data!.images,
                              type: data!.type,
                            ));
                            setState(() {
                              isFavorite = true;
                            });
                          }
                        });
                      },
                    ),
                  ],
                ),
                Text(
                  data!.titleJapanese,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.book, size: 24),
                        const SizedBox(width: 2),
                        Text(
                          data!.type,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 24,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          data!.score,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Text(
                      'Volume :',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      data!.volumes,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Text(
                      'Chapters :',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      data!.chapters,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Synopsis :',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      data!.synopsis,
                      style: const TextStyle(fontSize: 16),
                      softWrap: true,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
