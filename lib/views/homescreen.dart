import 'package:anime_catalogue/views/inidrawer.dart';
import 'package:anime_catalogue/views/topanime_view.dart';
import 'package:anime_catalogue/views/topmanga_view.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScreenPage extends StatefulWidget {
  final String name;
  final String email;
  final String image;

  const HomeScreenPage(
      {super.key,
      required this.name,
      required this.email,
      required this.image});

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
                          text: 'Top Manga',
                        ),
                      ],
                    ),
                  ],
                ),
              )),
          endDrawer: IniDrawer(
              name: widget.name, email: widget.email, image: widget.image),
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

