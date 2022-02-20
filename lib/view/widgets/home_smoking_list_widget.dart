import 'package:damta/utilities/utils.dart';
import 'package:damta/view/widgets/bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:damta/common/theme.dart';

class HomeSmokingListWidget extends StatefulWidget {
  const HomeSmokingListWidget({ Key? key }) : super(key: key);

  @override
  _HomeSmokinglistWidgetState createState() => _HomeSmokinglistWidgetState();
}

class _HomeSmokinglistWidgetState extends State<HomeSmokingListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.92,
      height: MediaQuery.of(context).size.height * 0.23,
      decoration: BoxDecoration(
        color: appTheme.homeSmokingListWidgetBackgroundColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
              decoration: BoxDecoration(
                color: appTheme.mainGrey,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text('최근 일주일'),
              )
            )
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: appTheme.mainGrey,
                borderRadius: BorderRadius.circular(25),
              ),
              child: BarChart(dateTimeList: getSevenDaysFromNow())
            )
          ),
        ],
      )
    );
  }
}