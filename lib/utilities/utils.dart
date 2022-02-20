import 'dart:collection';
import 'package:damta/data/models/smoking_record.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:damta/common/theme.dart';

// 현재 날짜 기준으로 7일 전
List<DateTime> getSevenDaysFromNow() {
  List<DateTime> dateTimeList = [];
  for(int i = 6; i >= 0; i--) {
    dateTimeList.add(DateTime.now().subtract(Duration(days: i)));
  }
  return dateTimeList;
}

// 현재 날짜 기준으로 한 달 전
List<DateTime> getOneMonthFromNow() {
  List<DateTime> dateTimeList = [];
  for(int i = 29; i >= 0; i--) {
    dateTimeList.add(DateTime.now().subtract(Duration(days: i)));
  }
  return dateTimeList;
}

// 현재 날짜 기준으로 세 달 전
List<DateTime> getThreeMonthsFromNow() {
  List<DateTime> dateTimeList = [];
  for(int i = 89; i >= 0; i--) {
    dateTimeList.add(DateTime.now().subtract(Duration(days: i)));
  }
  return dateTimeList;
}

// 모든 날짜



// 차트 그리기를 위한 데이터 추출
List<charts.Series<DateTime, String>> createChartData(List<DateTime> dateTimeList, LinkedHashMap<DateTime, List<SmokingRecord>> smokingRecordLinkedHashMap) {
    return [
      new charts.Series<DateTime, String>(
        id: '',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(appTheme.mainGreen),
        domainFn: (DateTime dateTime, _) => DateFormat.Md().format(dateTime),
        measureFn: (DateTime dateTime, _) {
          int count = 0;
          if(smokingRecordLinkedHashMap[dateTime] == null ) {
            // return count;
          } else {
            smokingRecordLinkedHashMap[dateTime]?.forEach((element) {
            count = count + element.count;
          });
          return count;
          }
        },
        data: dateTimeList,
      )
    ];
  }


  // charts.MaterialPalette.blue.shadeDefault,