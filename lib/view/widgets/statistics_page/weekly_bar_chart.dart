import 'dart:collection';

import 'package:damta/data/models/smoking_record.dart';
import 'package:damta/utilities/utils.dart';
import 'package:damta/view_model/smoking_record_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:damta/common/theme.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';


class WeeklyBarChart extends StatefulWidget {
  const WeeklyBarChart({ Key? key }) : super(key: key);
  @override
  _WeeklyBarChartState createState() => _WeeklyBarChartState();
}

class _WeeklyBarChartState extends State<WeeklyBarChart> {
  DateTime standardDateTime = DateTime.now();
  List<List<DateTime>> fourWeeksList = [
    getSevenDaysFromDate(DateTime.now().subtract(Duration(days: 22))),
    getSevenDaysFromDate(DateTime.now().subtract(Duration(days: 15))),
    getSevenDaysFromDate(DateTime.now().subtract(Duration(days: 8))),
    getSevenDaysFromDate(DateTime.now().subtract(Duration(days: 1))),
  ];

  void _nextDuration() {
    setState(() {
      standardDateTime = standardDateTime.add(Duration(days: 28));
      fourWeeksList = [
        getSevenDaysFromDate(standardDateTime.subtract(Duration(days: 22))),
        getSevenDaysFromDate(standardDateTime.subtract(Duration(days: 15))),
        getSevenDaysFromDate(standardDateTime.subtract(Duration(days: 8))),
        getSevenDaysFromDate(standardDateTime.subtract(Duration(days: 1))),
      ];
    });
  }

  void _beforDuration() {
    setState(() {
      standardDateTime = standardDateTime.subtract(Duration(days: 28));
      fourWeeksList = [
        getSevenDaysFromDate(standardDateTime.subtract(Duration(days: 22))),
        getSevenDaysFromDate(standardDateTime.subtract(Duration(days: 15))),
        getSevenDaysFromDate(standardDateTime.subtract(Duration(days: 8))),
        getSevenDaysFromDate(standardDateTime.subtract(Duration(days: 1))),
      ];
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
        height: MediaQuery.of(context).size.height * 0.26,
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
                      ' 주별',
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
                          '${DateFormat('MM/dd', 'ko_KR').format(fourWeeksList[0][0])} ~ ${DateFormat('MM/dd', 'ko_KR').format(fourWeeksList[3][6])}',
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
                        fontSize: 13,
                      ),
                      margin: 5,
                      getTitles: (double value) {
                        switch (value.toInt()) {
                          case 0:
                            return '${DateFormat('MM/dd', 'ko_KR').format(fourWeeksList[0][0])}~${DateFormat('dd', 'ko_KR').format(fourWeeksList[0][6])}';
                          case 1:
                            return '${DateFormat('MM/dd', 'ko_KR').format(fourWeeksList[1][0])}~${DateFormat('dd', 'ko_KR').format(fourWeeksList[1][6])}';
                          case 2:
                            return '${DateFormat('MM/dd', 'ko_KR').format(fourWeeksList[2][0])}~${DateFormat('dd', 'ko_KR').format(fourWeeksList[2][6])}';
                          case 3:
                            return '${DateFormat('MM/dd', 'ko_KR').format(fourWeeksList[3][0])}~${DateFormat('dd', 'ko_KR').format(fourWeeksList[3][6])}'; 
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
                            y: smokingRecordListViewModel.getSmokinCountOfWeek(fourWeeksList[0]).toDouble(), colors: [appTheme.mainGreen])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                            y: smokingRecordListViewModel.getSmokinCountOfWeek(fourWeeksList[1]).toDouble(), colors: [appTheme.mainGreen])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(
                            y: smokingRecordListViewModel.getSmokinCountOfWeek(fourWeeksList[2]).toDouble(), colors: [appTheme.mainGreen])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: [
                        BarChartRodData(
                            y: smokingRecordListViewModel.getSmokinCountOfWeek(fourWeeksList[3]).toDouble(), colors: [appTheme.mainGreen])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                  ],
                  alignment: BarChartAlignment.spaceAround,
                  maxY: smokingRecordListViewModel.getMaxSmokingCountInFourWeeks(fourWeeksList).toDouble() * 1.2 ,
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