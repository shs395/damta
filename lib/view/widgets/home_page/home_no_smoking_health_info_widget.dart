import 'package:flutter/material.dart';
import 'package:damta/common/theme.dart';

class HomeNoSmokingHealthInfoWidget extends StatelessWidget {
  const HomeNoSmokingHealthInfoWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.92,
      height: MediaQuery.of(context).size.height * 0.11,
      decoration: BoxDecoration(
        color: appTheme.homeNoSmokingInfoWidgetBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          
          
        ],
      ),
    );
  }
}