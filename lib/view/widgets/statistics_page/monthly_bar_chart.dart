import 'dart:collection';
import 'package:damta/data/models/smoking_record.dart';
import 'package:damta/utilities/utils.dart';
import 'package:damta/view_model/smoking_record_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:damta/common/theme.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';

class MonthlyBarChart extends StatefulWidget {
  const MonthlyBarChart({ Key? key }) : super(key: key);

  @override
  _MonthlyBarChartState createState() => _MonthlyBarChartState();
}

class _MonthlyBarChartState extends State<MonthlyBarChart> {
  int standardYear = DateTime.now().year;

  void _nextDuration() {
    setState(() {
      standardYear = standardYear + 1;
    });
  }

  void _beforDuration() {
    setState(() {
      standardYear = standardYear - 1;
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
                      ' 월별',
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
                          '${standardYear}년',
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
                        fontSize: 12,
                      ),
                      margin: 5,
                      getTitles: (double value) {
                        switch (value.toInt()) {
                          case 0:
                            return '1월';
                          case 1:
                            return '2월';
                          case 2:
                            return '3월';
                          case 3:
                            return '4월';
                          case 4:
                            return '5월';
                          case 5:
                            return '6월';
                          case 6:
                            return '7월';
                          case 7:
                            return '8월';
                          case 8:
                            return '9월';
                          case 9:
                            return '10월';
                          case 10:
                            return '11월';
                          case 11:
                            return '12월';
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
                            y: smokingRecordListViewModel.getSmokingCountOfMonth(standardYear, DateTime.january).toDouble(), colors: [appTheme.mainGreen])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                            y: smokingRecordListViewModel.getSmokingCountOfMonth(standardYear, DateTime.february).toDouble(), colors: [appTheme.mainGreen])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(
                            y: smokingRecordListViewModel.getSmokingCountOfMonth(standardYear, DateTime.march).toDouble(), colors: [appTheme.mainGreen])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: [
                        BarChartRodData(
                            y: smokingRecordListViewModel.getSmokingCountOfMonth(standardYear, DateTime.april).toDouble(), colors: [appTheme.mainGreen])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 4,
                      barRods: [
                        BarChartRodData(
                            y: smokingRecordListViewModel.getSmokingCountOfMonth(standardYear, DateTime.may).toDouble(), colors: [appTheme.mainGreen])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 5,
                      barRods: [
                        BarChartRodData(
                            y: smokingRecordListViewModel.getSmokingCountOfMonth(standardYear, DateTime.june).toDouble(), colors: [appTheme.mainGreen])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 6,
                      barRods: [
                        BarChartRodData(
                            y: smokingRecordListViewModel.getSmokingCountOfMonth(standardYear, DateTime.july).toDouble(), colors: [appTheme.mainGreen])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 7,
                      barRods: [
                        BarChartRodData(
                            y: smokingRecordListViewModel.getSmokingCountOfMonth(standardYear, DateTime.august).toDouble(), colors: [appTheme.mainGreen])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 8,
                      barRods: [
                        BarChartRodData(
                            y: smokingRecordListViewModel.getSmokingCountOfMonth(standardYear, DateTime.september).toDouble(), colors: [appTheme.mainGreen])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 9,
                      barRods: [
                        BarChartRodData(
                            y: smokingRecordListViewModel.getSmokingCountOfMonth(standardYear, DateTime.october).toDouble(), colors: [appTheme.mainGreen])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 10,
                      barRods: [
                        BarChartRodData(
                            y: smokingRecordListViewModel.getSmokingCountOfMonth(standardYear, DateTime.november).toDouble(), colors: [appTheme.mainGreen])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 11,
                      barRods: [
                        BarChartRodData(
                            y: smokingRecordListViewModel.getSmokingCountOfMonth(standardYear, DateTime.december).toDouble(), colors: [appTheme.mainGreen])
                      ],
                      showingTooltipIndicators: [0],
                    ),
                  ],
                  alignment: BarChartAlignment.spaceAround,
                  // maxY: smokingRecordListViewModel.getMaxSmokingCountInSevenDays(sevenDaysList).toDouble() * 1.2 ,
                  maxY: smokingRecordListViewModel.getMaxSmokingCountInYear(standardYear).toDouble() * 1.2 ,
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