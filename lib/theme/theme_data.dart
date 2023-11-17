import 'package:flutter/material.dart';

const warnaUngu = Color.fromRGBO(129, 59, 231, 1);
const warnaUnguBg = Color.fromRGBO(230, 216, 250, 1);

final lightTheme = ThemeData(
  fontFamily: 'Poppins-Regular',
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromRGBO(129, 59, 231, 1),
    foregroundColor: Colors.white,
  ),
  primarySwatch: Colors.grey,
  primaryColor: Color(0xFFFFFFFF),
  brightness: Brightness.light,
  scaffoldBackgroundColor: Color(0xFFF5F2F2),
);

final darkTheme = ThemeData(
  fontFamily: 'Poppins-Regular',
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black87,
    foregroundColor: Colors.white,
  ),
  primarySwatch: Colors.grey,
  primaryColor: Color(0xFF181717),
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFF21252B),
);
