import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStyle = const TextStyle(
    color: Colors.black54,
    fontSize: 16.0,
    fontWeight: FontWeight.normal
    
);


ThemeData appTheme = ThemeData(
  hintColor: Colors.white,
  primaryColor: blueColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            primary: blueColor
        )
    )
);

Color blackColor = const Color(0xFF31393c);

Color blueColor = const Color(0xFF2176ff);

Color blueLightColor = const Color(0xFF33a1fd);

Color orangeDarkColor = const Color(0xFFf79824);

Color orangeColor = const Color(0xFFfab132);

Color orangeLightColor = const Color(0xFFfdca40);

Color backgroundColor = const Color(0xFFe9e8ed);

List<Color> blueGradient = [
    const Color(0xFF2176ff),
    const Color(0xFF33a1fd)
];

List<Color> orangeGradient = [
    orangeDarkColor,
    orangeLightColor
];

TextStyle buttonTextStyle = GoogleFonts.ptSans(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold
);

TextStyle popupText = GoogleFonts.nunito(
    color: Colors.black54,
    fontSize: 19.0,
);

TextStyle inputText = GoogleFonts.nunito(
    color: Colors.white,
    fontSize: 21.0,
);

Color IconColor = const Color(0xaabc4ecf);