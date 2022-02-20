import 'dart:collection';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:damta/data/models/smoking_record.dart';
import 'package:damta/utilities/utils.dart';
import 'package:damta/view_model/smoking_record_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class BarChart extends StatefulWidget {
  final List<DateTime> dateTimeList;
  const BarChart({ Key? key, required this.dateTimeList }) : super(key: key);

  @override
  _BarChartForSevenDaysState createState() => _BarChartForSevenDaysState();
}

class _BarChartForSevenDaysState extends State<BarChart> {
  late SmokingRecordListViewModel smokingRecordListViewModel;
  final bool animate = false;
  @override
  Widget build(BuildContext context) {
    smokingRecordListViewModel = context.watch<SmokingRecordListViewModel>();
    final LinkedHashMap<DateTime, List<SmokingRecord>> smokingRecordLinkedHashmap = smokingRecordListViewModel.smokingRecordLinkedHashMap;
    final List<DateTime> _dateTimeList = widget.dateTimeList;
    final List<charts.Series<dynamic, String>> seriesList = createChartData(_dateTimeList, smokingRecordLinkedHashmap);
    return charts.BarChart(
      seriesList,
      animate: animate,
    );
  }
}