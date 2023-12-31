import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_providers.dart' as app_providers;

///Light Theme
//Body Colours
var firstBackgroundLight = const Color(0xFFB9B2B2); //-320xFFBBBBBB
var secondBackgroundLight = const Color(0xFFD3CCCC); //-160xFFD7D7D7
var thirdBackgroundLight = const Color(0xFFFFFFFF); //-80xFFE1E1E1
var thirdBackgroundLightAlt = const Color(0xFFEBEBEB); //0xFFCDCDCD

//Outline Colours
var secondOutlineLight = const Color(0xFFF3F3F3);
var thirdOutlineLight = const Color(0xFFFDFDFD);
var thirdOutlineLightAlt = const Color(0xFFCBCBCB);

//Text Colours
var firstTextLight = const Color(0xFF121212);
var secondTextLight = const Color(0xFF121212).withOpacity(0.75);
var thirdTextLight = const Color(0xFF121212).withOpacity(0.60);
var fourthTextLight = const Color(0x66121212).withOpacity(0.40);

///Darker Theme
//Body Colours
var firstBackgroundDarker = const Color(0xFF0C0C0C);
var secondBackgroundDarker = const Color(0xFF1A1A1A);
var thirdBackgroundDarker = const Color(0xFF2B2B2B);
var thirdBackgroundDarkerAlt = const Color(0xFF272727);

//Outline Colours
var secondOutlineDarker = const Color(0xFF191919);
var thirdOutlineDarker = const Color(0xFF222222);
var thirdOutlineDarkerAlt = const Color(0xFF292929);

//Text Colours
var firstTextDarker = const Color(0xFFFFFFFF);
var secondTextDarker = const Color(0xFFFFFFFF).withOpacity(0.75);
var thirdTextDarker = const Color(0xFFFFFFFF).withOpacity(0.5);
var fourthTextDarker = const Color(0xFFFFFFFF).withOpacity(0.25);

///Theme Classes
class AppTheme {
  Color firstBackground;
  Color secondBackground;
  Color thirdBackground;
  Color thirdBackgroundAlt;

  Color secondOutline;
  Color thirdOutline;
  Color thirdOutlineAlt;

  Color firstText;
  Color secondText;
  Color thirdText;
  Color fourthText;

  AppTheme({
    required this.firstBackground,
    required this.secondBackground,
    required this.thirdBackground,
    required this.thirdBackgroundAlt,
    required this.secondOutline,
    required this.thirdOutline,
    required this.thirdOutlineAlt,
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
      firstBackground: firstBackgroundDarker,
      secondBackground: secondBackgroundDarker,
      thirdBackground: thirdBackgroundDarker,
      thirdBackgroundAlt: thirdBackgroundDarkerAlt,
      secondOutline: secondOutlineDarker,
      thirdOutline: thirdOutlineDarker,
      thirdOutlineAlt: thirdOutlineDarkerAlt,
      firstText: firstTextDarker,
      secondText: secondTextDarker,
      thirdText: thirdTextDarker,
      fourthText: fourthTextDarker,
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
      thirdBackgroundAlt: thirdBackgroundLightAlt,
      secondOutline: secondOutlineLight,
      thirdOutline: thirdOutlineLight,
      thirdOutlineAlt: thirdOutlineLightAlt,
      firstText: firstTextLight,
      secondText: secondTextLight,
      thirdText: thirdTextLight,
      fourthText: fourthTextLight,
    );
  }
}