import 'package:flutter/material.dart';

const primaryColor = Color(0xfffafafa);
const accentColor = Color(0xFFF57C00);
const myGrey = Color(0xFF7F8C8D);

final ThemeData appTheme = ThemeData(
  primaryColor: primaryColor,
  accentColor: accentColor,
  fontFamily: 'Montserrat',
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
  ),
  iconTheme: IconThemeData(color: Colors.black),
);
