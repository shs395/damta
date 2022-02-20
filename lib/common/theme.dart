import 'package:flutter/material.dart';

class appTheme {
  static const Color primaryColor = Color(0xFF4B39EF);
  static const Color secondaryColor = Color(0xFFFBAF7C);
  static const Color tertiaryColor = Color(0xFF39D2C0);

  //litemode
  // static const Color backgroundColor = Color(0xFF1A1F24);
  
  static const Color darkBackgroundColor = Color(0xFF111417);
  static const Color textColor = Colors.black;
  static const Color grayDark = Colors.black;
  static const Color grayLight = Colors.black;
  static const Color titleColor = Colors.black;
  
  
  // common 
  static const Color backgroundColor = white;
  // main_page
  static const Color bottomNavBackgroundColor = white;
  static const Color bottomNavSelectedColor = mainGreen;
  static const Color bottomNavUnselectedColor = grey;
  // home_page
  static const Color buttonAddBackgrounColor = mainGreen;
  static const Color buttonAddForegroundColor = white;
  static const Color buttonMoreBackgrounColor = mainGreen;
  static const Color buttonMoreForegroundColor = white;
  //home_info_widget
  static const Color homeInfoWidgetBackgroundColor = mainGrey;
  //home_smoking_list_widget
  static const Color homeSmokingListWidgetBackgroundColor = mainGrey;
  //calendar_view_widget

  //darkmode
  // static const Color backgroundColor = Colors.white;
  // static const Color darkBackgroundColor = Color(0xFF111417);
  // static const Color textColor = Color(0xFFFFFFFF);
  // static const Color grayDark = Color(0xFF57636C);
  // static const Color grayLight = Color(0xFF8B97A2);

  String primaryFontFamily = 'Poppins';
  String secondaryFontFamily = 'Roboto';

  static const Color mainGreen = Color.fromRGBO(44, 92, 104, 0.9);
  static const Color mainGrey = Color(0xFFF2F2F2);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;

   static const Color grey50 = Color(0xFFF2F4F6);
  static const Color lightMainGreen = Color.fromRGBO(44, 92, 104, 0.3);
}