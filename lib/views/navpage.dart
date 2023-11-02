import 'package:anime_catalogue/views/bookmark.dart';
import 'package:anime_catalogue/views/homescreen.dart';
import 'package:anime_catalogue/views/profile.dart';
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
      HomeScreenPage(
        email: 'ilhambheh@gmail.com',
        name: 'Ilham Shodiq',
        image:
            'https://cdn.discordapp.com/attachments/709536226184527963/1052370083659391016/eula_mcd.jpg',
      ),
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
        padding: const EdgeInsets.all(8.0),
        child: DotNavigationBar(
          margin: EdgeInsets.only(left: 10, right: 10),
          currentIndex: _selectedIndex,
          dotIndicatorColor: Colors.red,
          unselectedItemColor: Colors.grey[300],
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
              selectedColor: Color(0xff73544C),
            ),

            /// Likes
            DotNavigationBarItem(
              icon: Icon(Icons.favorite),
              selectedColor: Color(0xff73544C),
            ),
            DotNavigationBarItem(
              icon: Icon(Icons.person),
              selectedColor: Color(0xff73544C),
            ),
          ],
        ),
      ),
    );
  }
}
