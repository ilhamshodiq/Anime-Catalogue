import 'package:flutter/material.dart';
import 'package:anime_catalogue/views/login_page.dart';

class IniDrawer extends StatefulWidget {
  final String name;
  final String email;
  final String image;
  const IniDrawer(
      {super.key,
      required this.name,
      required this.email,
      required this.image});

  @override
  State<IniDrawer> createState() => _IniDrawerState();
}

class _IniDrawerState extends State<IniDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        UserAccountsDrawerHeader(
          otherAccountsPictures: const [
            Icon(Icons.catching_pokemon),
          ],
          onDetailsPressed: () {},
          decoration: const BoxDecoration(
            color: Color.fromRGBO(129, 59, 231, 1),
          ),
          accountName: Text(widget.name),
          accountEmail: Text(widget.email),
          currentAccountPicture: InkWell(
            onTap: () {},
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.image),
            ),
          ),
        ),
        ListTile(
          leading: const Icon(
            Icons.logout,
            color: Colors.redAccent,
          ),
          title: const Text("Logout"),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
        ),
      ],
    ));
  }
}
