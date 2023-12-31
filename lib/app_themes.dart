import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_providers.dart' as app_providers;

///Light Theme
//Body Colours
var firstBackgroundLight = const Color(0xFFD7CECE); //-320xFFBBBBBB
var secondBackgroundLight = const Color(0xFFE8E0E0); //-160xFFD7D7D7
var thirdBackgroundLight = const Color(0xFFFFF6F6); //-80xFFE1E1E1
var fourthBackgroundLight = const Color(0xFFEBEBEB); //0xFFCDCDCD

//Outline Colours
var secondOutlineLight = const Color(0xFFF3F3F3);
var thirdOutlineLight = const Color(0xFFFDFDFD);
var fourthOutlineLight = const Color(0xFFCBCBCB);

//Text Colours
var firstTextLight = const Color(0xFF121212);
var secondTextLight = const Color(0xFF121212).withOpacity(0.75);
var thirdTextLight = const Color(0xFF121212).withOpacity(0.60);
var fourthTextLight = const Color(0x66121212).withOpacity(0.40);

///Dark Theme
//Body Colours
var firstBackgroundDark = const Color(0xFF0C0C0C);
var secondBackgroundDark = const Color(0xFF1A1A1A);
var thirdBackgroundDark = const Color(0xFF2B2B2B);
var fourthBackgroundDark = const Color(0xFF404040);

//Outline Colours
var secondOutlineDark = const Color(0xFF191919);
var thirdOutlineDark = const Color(0xFF222222);
var fourthOutlineDark = const Color(0xFF484848);

//Text Colours
var firstTextDark = const Color(0xFFFFFFFF);
var secondTextDark = const Color(0xFFFFFFFF).withOpacity(0.75);
var thirdTextDark = const Color(0xFFFFFFFF).withOpacity(0.5);
var fourthTextDark = const Color(0xFFFFFFFF).withOpacity(0.25);

///Theme Classes
class AppTheme {
  Color firstBackground;
  Color secondBackground;
  Color thirdBackground;
  Color fourthBackground;

  Color secondOutline;
  Color thirdOutline;
  Color fourthOutline;

  Color firstText;
  Color secondText;
  Color thirdText;
  Color fourthText;

  AppTheme({
    required this.firstBackground,
    required this.secondBackground,
    required this.thirdBackground,
    required this.fourthBackground,
    required this.secondOutline,
    required this.thirdOutline,
    required this.fourthOutline,
    required this.firstText,
    required this.secondText,
    required this.thirdText,
    required this.fourthText,
  });
}

AppTheme theme(bool isDarkTheme, WidgetRef ref) {
  if (isDarkTheme) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
    return AppTheme(
      firstBackground: firstBackgroundDark,
      secondBackground: secondBackgroundDark,
      thirdBackground: thirdBackgroundDark,
      fourthBackground: fourthBackgroundDark,
      secondOutline: secondOutlineDark,
      thirdOutline: thirdOutlineDark,
      fourthOutline: fourthOutlineDark,
      firstText: firstTextDark,
      secondText: secondTextDark,
      thirdText: thirdTextDark,
      fourthText: fourthTextDark,
    );
  } else {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ));
    return AppTheme(
      firstBackground: firstBackgroundLight,
      secondBackground: secondBackgroundLight,
      thirdBackground: thirdBackgroundLight,
      fourthBackground: fourthBackgroundLight,
      secondOutline: secondOutlineLight,
      thirdOutline: thirdOutlineLight,
      fourthOutline: fourthOutlineLight,
      firstText: firstTextLight,
      secondText: secondTextLight,
      thirdText: thirdTextLight,
      fourthText: fourthTextLight,
    );
  }
}