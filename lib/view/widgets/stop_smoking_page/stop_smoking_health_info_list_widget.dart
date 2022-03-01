import 'package:damta/data/models/health_chart_data.dart';
import 'package:damta/view_model/user_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:damta/common/theme.dart';
import 'package:provider/src/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StopSmokingHealthInfoListWidget extends StatefulWidget {
  const StopSmokingHealthInfoListWidget({ Key? key }) : super(key: key);

  @override
  _StopSmokingHealthInfoListWidgetState createState() => _StopSmokingHealthInfoListWidgetState();
}

class _StopSmokingHealthInfoListWidgetState extends State<StopSmokingHealthInfoListWidget> {

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
            fontSize: 12,
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
    return Expanded(
      child: ListView.builder(
        itemCount: healthInfoDataList.length,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.92,
            height: MediaQuery.of(context).size.height * 0.12,
            margin: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
            decoration: BoxDecoration(
              color: appTheme.mainBeige,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: StreamBuilder(
                    stream: Stream.periodic(const Duration(seconds: 1)),
                    builder: (context, snapshot) {
                      return _getHealthDoughnutChart(_userInfoViewModel.userInfo.startStopSmokingDate!, healthInfoDataList[index]['duration']);
                    }
                  ) 
                  
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${healthInfoDataList[index]['step']}    ',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: appTheme.mainGreen
                              ),
                            ),
                            Text(
                              '${healthInfoDataList[index]['time']}',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ), 
                        SizedBox(
                          height: 5
                        ),
                        Text(
                          '${healthInfoDataList[index]['content']}',
                          style: TextStyle(
                            fontSize: 10
                          ),
                        )
                      ],
                    )
                  ),
                ),
              ],
            )
          );
        }
      ),
    );
  }
}

