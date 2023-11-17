import 'package:anime_catalogue/theme/theme_data.dart';
import 'package:anime_catalogue/views/bookmark.dart';
import 'package:anime_catalogue/views/contents.dart';
import 'package:anime_catalogue/views/profile.dart';
import 'package:anime_catalogue/views/search_page.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      ContentPage(
        email: 'ilhambheh@gmail.com',
        name: 'Ilham Shodiq',
        image:
            'https://cdn.discordapp.com/attachments/709536226184527963/1052370083659391016/eula_mcd.jpg',
      ),
      SearchPage(),
      BookmarkPage(),
      ProfilePage()
    ];

    return Scaffold(
      body: PageView(
        controller: pageController,
        children: screens,
        onPageChanged: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: DotNavigationBar(
          margin: EdgeInsets.only(left: 10, right: 10),
          currentIndex: _selectedIndex,
          backgroundColor: Color.fromRGBO(129, 59, 231, 1),
          dotIndicatorColor: warnaUnguBg,
          unselectedItemColor: Color.fromRGBO(175, 168, 168, 1.0),
          splashBorderRadius: 50,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              pageController.jumpToPage(index);
            });
          },
          items: [
            /// Home
            DotNavigationBarItem(
              icon: Icon(Icons.home),
              selectedColor: Colors.white,
            ),
            //search
            DotNavigationBarItem(
              icon: Icon(Icons.search),
              selectedColor: Colors.white,
            ),
            DotNavigationBarItem(
              icon: Icon(Icons.favorite),
              selectedColor: Colors.white,
            ),
            DotNavigationBarItem(
              icon: Icon(Icons.person),
              selectedColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
