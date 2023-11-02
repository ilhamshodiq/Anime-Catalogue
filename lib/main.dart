import 'package:anime_catalogue/views/navpage.dart';
import 'package:flutter/material.dart';
import 'package:anime_catalogue/views/homescreen.dart';
import 'dart:io';


class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = new PostHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UAS Mobile',
      theme: ThemeData(
          fontFamily: 'Poppins-Regular',
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromRGBO(129, 59, 231, 1),
            foregroundColor: Colors.white,
          )),
      home:  NavPage(),
    );
  }
}
