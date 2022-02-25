import 'package:flutter/material.dart';
import 'package:damta/common/theme.dart';
import 'package:damta/view_model/smoking_record_list_view_model.dart';
import 'package:provider/src/provider.dart';

class HomeSmokingInfoWidget extends StatelessWidget {
  const HomeSmokingInfoWidget({ Key? key }) : super(key: key);

  List<Widget> getCountDifferenceWidget(int countDifference) {
    if(countDifference == 0) {
      // 어제 오늘 같을 때 
      return [
        Text(
          '${countDifference}',
          style: TextStyle(
            fontSize: 30,
            color: appTheme.homeInfoWidgetSameIconColor
          )
        ),
        Icon(
          Icons.horizontal_rule,
          color: appTheme.homeInfoWidgetSameIconColor
        ),
      ];
    } else if(countDifference > 0) {
      // 오늘이 더 많을 때
      return [
        Text(
          '${countDifference}',
          style: TextStyle(
            fontSize: 30,
            color: appTheme.homeInfoWidgetUpwardIconColor
          )
        ),
        Icon(
          Icons.arrow_upward,
          color: appTheme.homeInfoWidgetUpwardIconColor
        ),
      ];
    } else {
      // 오늘이 더 적을 때
      return [
        Text(
          '${countDifference}',
          style: TextStyle(
            fontSize: 30,
            color: appTheme.homeInfoWidgetDownwardIconColor
          )
        ),
        Icon(
          Icons.arrow_downward,
          color: appTheme.homeInfoWidgetDownwardIconColor
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    SmokingRecordListViewModel smokingRecordListViewModel = context.watch<SmokingRecordListViewModel>();
    // 어제 오늘 흡연 개수 차이
    int countDifference = smokingRecordListViewModel.getSmokingCount(DateTime.now()) - smokingRecordListViewModel.getSmokingCount(DateTime.now().subtract(Duration(days:1)));

    return Container(
      width: MediaQuery.of(context).size.width * 0.92,
      height: MediaQuery.of(context).size.height * 0.09,
      decoration: BoxDecoration(
        color: appTheme.homeInfoWidgetBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '오늘',
                  style: TextStyle(
                    fontSize: 12,
                    color: appTheme.mainGreen,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  '${smokingRecordListViewModel.getSmokingCount(DateTime.now())} 개',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            )
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '어제',
                  style: TextStyle(
                    fontSize: 12,
                    color: appTheme.mainGreen,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  '${smokingRecordListViewModel.getSmokingCount(DateTime.now().subtract(Duration(days:1)))} 개',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            )
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: getCountDifferenceWidget(countDifference),
            )
          ),
        ],
      ),
    );
  }
}