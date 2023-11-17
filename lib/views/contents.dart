import 'package:anime_catalogue/views/inidrawer.dart';
import 'package:anime_catalogue/views/topanime_view.dart';
import 'package:anime_catalogue/views/topmanga_view.dart';
import 'package:flutter/material.dart';

class ContentPage extends StatefulWidget {
  final String name;
  final String email;
  final String image;

  const ContentPage(
      {super.key,
      required this.name,
      required this.email,
      required this.image});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: Text('Anime Catalogue'),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight * 1.6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 12),
                    child: Text(
                      'Yokoso!!, ${widget.name}',
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
                        child: Text('Top Manga',
                            style:
                                TextStyle(fontSize: 14, color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            )),
        // endDrawer: IniDrawer(
        //     name: widget.name, email: widget.email, image: widget.image),
        extendBody: true,
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
