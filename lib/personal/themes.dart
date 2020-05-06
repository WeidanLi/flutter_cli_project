import 'package:flutter/material.dart';

final QUICKSAND_FONT_NAME = 'Quicksand';

class Themes {

  static final ThemeData kIOSTheme = ThemeData(
      primarySwatch: Colors.orange,
      primaryColor: Colors.grey[100],
      accentColor: Colors.green,
      primaryColorBrightness: Brightness.light,
      fontFamily: QUICKSAND_FONT_NAME,
      backgroundColor: Colors.white
  );

  static final ThemeData blackTheme = ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.black,
      fontFamily: QUICKSAND_FONT_NAME,
      backgroundColor: Colors.white,
  );

}