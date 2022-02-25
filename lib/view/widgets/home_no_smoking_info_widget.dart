import 'package:flutter/material.dart';
import 'package:damta/common/theme.dart';

class HomeNoSmokingInfoWidget extends StatelessWidget {
  const HomeNoSmokingInfoWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.92,
      height: MediaQuery.of(context).size.height * 0.09,
      decoration: BoxDecoration(
        color: appTheme.homeNoSmokingInfoWidgetBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text('금연 중')
          ),
          Expanded(
            flex: 1,
            child: Text('금연 중')
          )
        ],
      ),
    );
  }
}