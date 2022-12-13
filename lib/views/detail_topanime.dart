import 'package:flutter/material.dart';
import 'package:mobile_prak_uas_anime_catalogue/models/model_animedetail.dart';
import 'package:mobile_prak_uas_anime_catalogue/viewmodel/services.dart';

class DetailTopAnimeScreenPage extends StatefulWidget {
  //key untuk anime by id
  final String id;
  const DetailTopAnimeScreenPage({super.key, required this.id});

  @override
  State<DetailTopAnimeScreenPage> createState() =>
      _DetailTopAnimeScreenPageState();
}

class _DetailTopAnimeScreenPageState extends State<DetailTopAnimeScreenPage> {
  AnimeDetailData? data;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    getAnimeById(widget.id).then((value) {
      data = value;
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(data!.title),
            ),
            body: ListView(
              padding: const EdgeInsets.only(top: 0),
              children: <Widget>[
                Image.network(
                  data!.images.toString(),
                  height: MediaQuery.of(context).size.height / 2,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Text(
                                data!.title,                                                                
                                style: const TextStyle(fontSize: 28),
                              ),
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
                                    const Icon(Icons.tv, size: 24),
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
                                  'Source :',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  data!.source,
                                  // 'tipe',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                const Text(
                                  'Year :',
                                  // 'tipe',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  data!.year,
                                  // 'tipe',
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
                                  // 'tipe',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  data!.synopsis,
                                  // 'tipe',
                                  style: const TextStyle(fontSize: 16),
                                  softWrap: true, textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
