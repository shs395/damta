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

// 인풋 날짜 기준 7일 전
List<DateTime> getSevenDaysFromDate(DateTime date) {
  List<DateTime> dateTimeList = [];
  for(int i = 6; i >= 0; i--) {
    dateTimeList.add(date.subtract(Duration(days: i)));
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

// 한 달에 며칠 있는지
int daysInMonth(DateTime date){
  DateTime firstDayThisMonth = new DateTime(date.year, date.month, date.day);
  DateTime firstDayNextMonth = new DateTime(firstDayThisMonth.year, firstDayThisMonth.month + 1, firstDayThisMonth.day);
  return firstDayNextMonth.difference(firstDayThisMonth).inDays;
}
// 모든 날짜



// 차트 그리기를 위한 데이터 추출
List<charts.Series<DateTime, String>> createChartData(List<DateTime> dateTimeList, LinkedHashMap<DateTime, List<SmokingRecord>> smokingRecordLinkedHashMap) {
    return [
      new charts.Series<DateTime, String>(
        id: '',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xFF145374)),
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



String formatDuration(Duration d) {
  var seconds = d.inSeconds;
  final days = seconds~/Duration.secondsPerDay;
  seconds -= days*Duration.secondsPerDay;
  final hours = seconds~/Duration.secondsPerHour;
  seconds -= hours*Duration.secondsPerHour;
  final minutes = seconds~/Duration.secondsPerMinute;
  seconds -= minutes*Duration.secondsPerMinute;

  final List<String> tokens = [];
  if (days != 0) {
    tokens.add('${days}일');
  }
  if (tokens.isNotEmpty || hours != 0){
    tokens.add('${hours}시간');
  }
  if (tokens.isNotEmpty || minutes != 0) {
    tokens.add('${minutes}분');
  }
  tokens.add('${seconds}초');

  return tokens.join(' ');
}


  // charts.MaterialPalette.blue.shadeDefault,