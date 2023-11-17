import 'package:anime_catalogue/theme/theme_data.dart';
import 'package:anime_catalogue/views/navpage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(
       Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                NavPage(),
          ),
        );
      },
    );
    return Scaffold(
      backgroundColor: warnaUngu,
      body: Center(
        child: Image.asset('images/animecatalogue.gif'),
      ),
    );
  }
}
