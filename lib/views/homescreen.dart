import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mobile_prak_uas_anime_catalogue/models/model_anime.dart';
import 'package:mobile_prak_uas_anime_catalogue/models/model_user.dart';

class HomeScreenPage extends StatefulWidget {
  String nama;
  HomeScreenPage({super.key, required this.nama});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
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
    return Scaffold(
      backgroundColor: Color.fromRGBO(129, 59, 231, 1),
      appBar: AppBar(
        title: const Text('Anime Catalogue'),
      ),
      drawer: Drawer(),
      body: Center(
        child: Column(
          children: [
            Text(
              'Welcome, ${widget.nama}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "Katalog Anime 😱",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final String gambar = data[index].images.toString();
                    final String sinopsis = data[index].synopsis.toString();
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 0,
                              blurRadius: 0,
                              offset:
                                  Offset(0, 10), // changes position of shadow
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
                                      image: NetworkImage(gambar),
                                      // image:
                                      //     AssetImage('images/jotarotpose.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      data[index].title,
                                      // 'judul',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.tv, size: 20),
                                      SizedBox(width: 2),
                                      Text(
                                        data[index].type,
                                        // 'tipe',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(
                                        Icons.star,
                                        size: 20,
                                        color: Colors.orange,
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        data[index].score,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        size: 20,
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        data[index].season,
                                        style: TextStyle(fontSize: 14),
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
      ),
    );
  }
}
