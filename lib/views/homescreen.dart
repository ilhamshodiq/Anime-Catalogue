import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mobile_prak_uas_anime_catalogue/models/model_anime.dart';
import 'package:mobile_prak_uas_anime_catalogue/models/model_user.dart';
import 'package:mobile_prak_uas_anime_catalogue/views/topanime_view.dart';
import 'package:mobile_prak_uas_anime_catalogue/views/topmanga_view.dart';

class HomeScreenPage extends StatefulWidget {
  String nama;
  HomeScreenPage({super.key, required this.nama});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(129, 59, 231, 1),
        appBar: AppBar(
            title: Text('Anime Catalogue'),
            flexibleSpace: Column(
              children: [
                Container(
                  child: Text('test',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w100,
                      )),
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight * 1.6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 12),
                    child: Text(
                      'Yokoso!!, ${widget.nama}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TabBar(
                    indicatorWeight: 2,
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(
                        child: Text('Top Anime',
                            style:
                                TextStyle(fontSize: 14, color: Colors.white)),
                      ),
                      Tab(
                        text: 'Top Manga',
                      ),
                    ],
                  ),
                ],
              ),
            )),
        endDrawer: Drawer(),
        body: TabBarView(
          children: [
            TopAnime(),
            TopManga(),
          ],
        ),
      ),
    );
  }
}
