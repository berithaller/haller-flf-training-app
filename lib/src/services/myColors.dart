import 'package:flutter/material.dart';

class MyColors {
  ///Default Theme / cold Bright Theme
  static const backgroundcolor = const Color(0xFFC2E3F4);
  static const buttoncolor = const Color(0xFFEFB730);
  static const lightcontrastcolor = const Color(0xFFF2F4EF);
  static const darkcontrastcolor = const Color(0xFF030305);

  ///Theme2 / heavy Dark Theme
  static const backgroundcolor2 = const Color(0xFF504E63);
  static const buttoncolor2 = const Color(0xFFA88661);
  static const lightcontrastcolor2 = const Color(0xFFEAD6BD);
  static const darkcontrastcolor2 = const Color(0xFF00142F);

  ///Theme3 / peaceful Dark Theme
  static const backgroundcolor3 = const Color(0xFF847072);
  static const buttoncolor3 = const Color(0xFF869DAB);
  static const lightcontrastcolor3 = const Color(0xFFDCC1B0);
  static const darkcontrastcolor3 = const Color(0xFF3D313F);

  ///Theme4 / sunny Bright Theme
  static const backgroundcolor4 = const Color(0xFFE4B660);
  static const buttoncolor4 = const Color(0xFFF2AB39);
  static const lightcontrastcolor4 = const Color(0xFFFFD954);
  static const darkcontrastcolor4 = const Color(0xFF69491A);

  ///Theme5 / yellow Dark Theme
  static const backgroundcolor5 = const Color(0xFF655C57);
  static const buttoncolor5 = const Color(0xFFF3B749);
  static const lightcontrastcolor5 = const Color(0xFFFEF0BF);
  static const darkcontrastcolor5 = const Color(0xFF2E1E11);

  ///Theme6 / cold Dark Theme
  static const backgroundcolor6 = const Color(0xFFA5B7C1);
  static const buttoncolor6 = const Color(0xFF535D55);
  static const lightcontrastcolor6 = const Color(0xFFDBDBE5);
  static const darkcontrastcolor6 = const Color(0xFF514644);

  ///Theme7 / girlish Dark Theme
  static const backgroundcolor7 = const Color(0xFF92617E);
  static const buttoncolor7 = const Color(0xFF982827);
  static const lightcontrastcolor7 = const Color(0xFFCC5B3B);
  static const darkcontrastcolor7 = const Color(0xFF3C1832);

  ///Theme8 / natural Bright Theme
  static const backgroundcolor8 = const Color(0xFFBD8E62);
  static const buttoncolor8 = const Color(0xFFA46843);
  static const lightcontrastcolor8 = const Color(0xFFD5D2C1);
  static const darkcontrastcolor8 = const Color(0xFF370D00);

  static ThemeData mybasicTheme() {
    final basicTheme = ThemeData.light();
    return basicTheme.copyWith(
      primaryColor: buttoncolor,
      primaryColorDark: darkcontrastcolor,
      primaryColorLight: lightcontrastcolor,
      scaffoldBackgroundColor: backgroundcolor,
      buttonColor: buttoncolor,
      bottomAppBarColor: darkcontrastcolor,
      backgroundColor: backgroundcolor,
    );
  }
}
