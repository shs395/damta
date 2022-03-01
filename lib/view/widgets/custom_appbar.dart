import 'package:damta/view/widgets/top_info_bar.dart';
import 'package:flutter/material.dart';
import 'package:damta/common/theme.dart';

class CustomAppbar extends AppBar {
  CustomAppbar(title):super(
    title: Text(
      '$title',
      style: TextStyle(
        color: appTheme.titleColor,
        fontSize: 25
      )
    ),
    backgroundColor: appTheme.white,
    titleSpacing: 30, //title 
    centerTitle: false,
    automaticallyImplyLeading: false, // 뒤로가기 자동생성 방지
    elevation: 0, // appbar 아래 그림자
    actions: [
      TopInfoBar()
    ],
  );
}