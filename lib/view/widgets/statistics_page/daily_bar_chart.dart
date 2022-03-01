import 'dart:collection';

import 'package:damta/data/models/smoking_record.dart';
import 'package:damta/utilities/utils.dart';
import 'package:damta/view_model/smoking_record_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:damta/common/theme.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';

class DailyBarChart extends StatefulWidget {
  const DailyBarChart({ Key? key }) : super(key: key);

  @override
  _SevenDaysBarChartState createState() => _SevenDaysBarChartState();
}

class _SevenDaysBarChartState extends State<DailyBarChart> {
  DateTime standardDateTime = DateTime.now();
  List<DateTime> sevenDaysList = getSevenDaysFromDate(DateTime.now());

  void _nextDuration() {
    setState(() {
      standardDateTime = standardDateTime.add(Duration(days: 7));
      sevenDaysList = getSevenDaysFromDate(standardDateTime);
    });
  }

  void _beforDuration() {
    setState(() {
      standardDateTime = standardDateTime.subtract(Duration(days: 7));
      sevenDaysList = getSevenDaysFromDate(standardDateTime);
    });
  }
  @override
  Widget build(BuildContext context) {
    SmokingRecordListViewModel smokingRecordListViewModel = context.watch<SmokingRecordListViewModel>();
    return GestureDetector(
      onHorizontalDragEnd: (dragEndDetails) {
        if (dragEndDetails.primaryVelocity! < 0) {
          _nextDuration();
        } else if (dragEndDetails.primaryVelocity! > 0) {
          _beforDuration();
        } else {
          
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.92,
        height: MediaQuery.of(context).size.height * 0.25,
        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
        decoration: BoxDecoration(
          color: appTheme.mainBeige,
          borderRadius: BorderRadius.circular(10),
        ),
        // elevation: 0,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      ' 일별',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.chevron_left),
                          onPressed: _beforDuration,
                          enableFeedback: false,
                          splashColor: Colors.transparent
                        ),
                        Text(
                          '${DateFormat('MM/dd', 'ko_KR').format(sevenDaysList[0])} ~ ${DateFormat('MM/dd', 'ko_KR').format(sevenDaysList[6])}',
                          // textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500 
                          )
                        ),
                        IconButton(
                          icon: Icon(Icons.navigate_next),
                          onPressed: _nextDuration,
                          enableFeedback: false,
                          splashColor: Colors.transparent
                        ),
                      ],
                    ) 
                    
                  ),
                ],
              )
            ),
            Expanded(
              flex: 4,
              child: BarChart(
                BarChartData(
                  gridData: FlGridData(
                    show: false,
                  ),
                  barTouchData: BarTouchData(
                    // enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.transparent,
                      tooltipPadding: const EdgeInsets.all(0),
                      tooltipMargin: 1,
                      getTooltipItem: (
                        BarChartGroupData group,
                        int groupIndex,
                        BarChartRodData rod,
                        int rodIndex,
                      ) {
                        return BarTooltipItem(
                          rod.y.round().toString(),
                          const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTextStyles: (context, value) => const TextStyle(
                        color: appTheme.mainGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      margin: 5,
                      getTitles: (double value) {
                        switch (value.toInt()) {
                          case 0:
                            return '${DateFormat('MM/dd', 'ko_KR').format(sevenDaysList[0])}';
                          case 1:
                            return '${DateFormat('MM/dd', 'ko_KR').format(sevenDaysList[1])}';
                          case 2:
                            return '${DateFormat('MM/dd', 'ko_KR').format(sevenDaysList[2])}';
                          case 3:
                            return '${DateFormat('MM/dd', 'ko_KR').format(sevenDaysList[3])}';
                          case 4:
                            return '${DateFormat('MM/dd', 'ko_KR').format(sevenDaysList[4])}';
                          case 5:
                            return '${DateFormat('MM/dd', 'ko_KR').format(sevenDaysList[5])}';
                          case 6:
                            return '${DateFormat('MM/dd', 'ko_KR').format(sevenDaysList[6])}';
                          default:
                            return '';
                        }
                      },
                    ),
                    leftTitles: SideTitles(showTitles: false),
                    topTitles: SideTitles(showTitles: false),
                    rightTitles: SideTitles(showTitles: false),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                            y: smokingRecordListViewModel.getSmokingCount(sevenDaysList[0]).toDouble(), colors: [appTheme.mainGreen])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                            y: smokingRecordListViewModel.getSmokingCount(sevenDaysList[1]).toDouble(), colors: [appTheme.mainGreen])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(
                            y: smokingRecordListViewModel.getSmokingCount(sevenDaysList[2]).toDouble(), colors: [appTheme.mainGreen])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: [
                        BarChartRodData(
                            y: smokingRecordListViewModel.getSmokingCount(sevenDaysList[3]).toDouble(), colors: [appTheme.mainGreen])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 4,
                      barRods: [
                        BarChartRodData(
                            y: smokingRecordListViewModel.getSmokingCount(sevenDaysList[4]).toDouble(), colors: [appTheme.mainGreen])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 5,
                      barRods: [
                        BarChartRodData(
                            y: smokingRecordListViewModel.getSmokingCount(sevenDaysList[5]).toDouble(), colors: [appTheme.mainGreen])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 6,
                      barRods: [
                        BarChartRodData(
                            y: smokingRecordListViewModel.getSmokingCount(sevenDaysList[6]).toDouble(), colors: [appTheme.mainGreen])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                  ],
                  alignment: BarChartAlignment.spaceAround,
                  maxY: smokingRecordListViewModel.getMaxSmokingCountInSevenDays(sevenDaysList).toDouble() * 1.2 ,
                  // maxY: 1
                ),
                swapAnimationDuration: const Duration(milliseconds: 0),
                swapAnimationCurve: Curves.linear,
              ),
            ),
          ],
        )
      )
    );
  }
}

class _BarChart extends StatelessWidget {
  // final LinkedHashMap<DateTime, List<SmokingRecord>> smokingRecordLinkedHashmap;
  final SmokingRecordListViewModel smokingRecordListViewModel;
  final List<DateTime> dateTimeList;
  const _BarChart({Key? key, required this.smokingRecordListViewModel, required this.dateTimeList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        gridData: gridData,
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        alignment: BarChartAlignment.spaceAround,
        maxY: 40,
        baselineY: 10
      ),
    );
  }

  FlGridData get gridData => FlGridData(
    show: false,
  );


  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 1,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.y.round().toString(),
              const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: appTheme.mainGreen,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          margin: 5,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return '${DateFormat('MM/dd', 'ko_KR').format(dateTimeList[0])}';
              case 1:
                return '${DateFormat('MM/dd', 'ko_KR').format(dateTimeList[1])}';
              case 2:
                return '${DateFormat('MM/dd', 'ko_KR').format(dateTimeList[2])}';
              case 3:
                return '${DateFormat('MM/dd', 'ko_KR').format(dateTimeList[3])}';
              case 4:
                return '${DateFormat('MM/dd', 'ko_KR').format(dateTimeList[4])}';
              case 5:
                return '${DateFormat('MM/dd', 'ko_KR').format(dateTimeList[5])}';
              case 6:
                return '${DateFormat('MM/dd', 'ko_KR').format(dateTimeList[6])}';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false
        
        ),
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
      );

  // 차트 전체 부분 테두리
  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
                y: smokingRecordListViewModel.getSmokingCount(dateTimeList[0]).toDouble(), colors: [appTheme.mainGreen])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
                y: smokingRecordListViewModel.getSmokingCount(dateTimeList[1]).toDouble(), colors: [appTheme.mainGreen])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
                y: smokingRecordListViewModel.getSmokingCount(dateTimeList[2]).toDouble(), colors: [appTheme.mainGreen])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
                y: smokingRecordListViewModel.getSmokingCount(dateTimeList[3]).toDouble(), colors: [appTheme.mainGreen])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
                y: smokingRecordListViewModel.getSmokingCount(dateTimeList[4]).toDouble(), colors: [appTheme.mainGreen])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
                y: smokingRecordListViewModel.getSmokingCount(dateTimeList[5]).toDouble(), colors: [appTheme.mainGreen])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
                y: smokingRecordListViewModel.getSmokingCount(dateTimeList[6]).toDouble(), colors: [appTheme.mainGreen])
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}
