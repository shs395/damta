import 'package:damta/data/models/health_chart_data.dart';
import 'package:damta/view_model/user_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:damta/common/theme.dart';
import 'package:provider/src/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StopSmokingHealthInfoWidget extends StatefulWidget {
  const StopSmokingHealthInfoWidget({ Key? key }) : super(key: key);

  @override
  _StopSmokingHealthInfoWidgetState createState() => _StopSmokingHealthInfoWidgetState();
}

class _StopSmokingHealthInfoWidgetState extends State<StopSmokingHealthInfoWidget> {


  Stack _getHealthDoughnutChart(DateTime startStopSmokingDate, Duration totalDuration) {
    int timeFromStopSmoking = DateTime.now().difference(startStopSmokingDate).inSeconds;
    int remainTimeToComplete = (totalDuration - DateTime.now().difference(startStopSmokingDate)).inSeconds;
    if(timeFromStopSmoking > totalDuration.inSeconds) {
      timeFromStopSmoking = totalDuration.inSeconds;
      remainTimeToComplete = 0;
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        SfCircularChart(
          palette: const <Color>[appTheme.mainGreen, appTheme.lightMainGreen],
          // backgroundColor: appTheme.mainGreen,
          // title: ChartTitle(text: 'Composition of ocean water'),
          series: [
            DoughnutSeries<int, String>(
              // enableTooltip: false,
              animationDuration: 0,
              radius: '100%',
              innerRadius: '75%',
              explode: false,
              // explodeOffset: '10%',
              dataSource: <int>[
                timeFromStopSmoking,
                remainTimeToComplete,
              ],
              xValueMapper: (int data, _) => '',
              yValueMapper: (int data, _) => data,
              dataLabelMapper: (int data, _) => '',
                // dataLabelSettings: const DataLabelSettings(isVisible: true)
            )
          ]
        ),
        Text(
          '${((timeFromStopSmoking / totalDuration.inSeconds) * 100).round()}%',
          style: TextStyle(
            color: appTheme.mainGreen,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        )
      ]
    );
  }

  Map _getCurrentHealthInfo(DateTime startStopSmokingDate) {
    int timeFromStopSmoking = DateTime.now().difference(startStopSmokingDate).inSeconds;
    Map _currentHealthInfo = {};
    for(int i = 0 ; i < healthInfoDataList.length; i++) { 
      if(timeFromStopSmoking < healthInfoDataList[i]['duration'].inSeconds) {
        _currentHealthInfo = healthInfoDataList[i];
        break;
      }
    }
    return _currentHealthInfo;
  }

  @override
  Widget build(BuildContext context) {
    UserInfoViewModel _userInfoViewModel = context.watch<UserInfoViewModel>();
    Map _currentHealthInfo = _getCurrentHealthInfo(_userInfoViewModel.userInfo.startStopSmokingDate!);
    return Container(
      width: MediaQuery.of(context).size.width * 0.92,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        color: appTheme.homeNoSmokingInfoWidgetBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                return _getHealthDoughnutChart(_userInfoViewModel.userInfo.startStopSmokingDate!, _currentHealthInfo['duration']);
              }
            )
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 10, 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        '${_currentHealthInfo['step']}    ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: appTheme.mainGreen
                        ),
                      ),
                      Text(
                        '${_currentHealthInfo['time']}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${_currentHealthInfo['content']}',
                    style: TextStyle(
                      fontSize: 15,
                      // color: appTheme.mainGreen
                    ),
                  )
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}