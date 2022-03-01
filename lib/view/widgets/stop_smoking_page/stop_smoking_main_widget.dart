import 'dart:math';
import 'package:damta/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class StopSmokingMainWidget extends StatefulWidget {
  const StopSmokingMainWidget({ Key? key }) : super(key: key);

  @override
  _StopSmokingMainWidgetState createState() => _StopSmokingMainWidgetState();
}

class _StopSmokingMainWidgetState extends State<StopSmokingMainWidget> {

  late TooltipBehavior _tooltip;
  bool isCardView = true;

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true, format: 'point.x : point.y%');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCircularChart(
        title: ChartTitle(text: isCardView ? 'ㅇ' : 'Composition of ocean water'),
        legend: Legend(
            isVisible: !isCardView, overflowMode: LegendItemOverflowMode.wrap),
        series: _getDefaultDoughnutSeries(),
        tooltipBehavior: _tooltip,
      )
    );
  }

  List<DoughnutSeries<ChartSampleData, String>> _getDefaultDoughnutSeries() {
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          radius: '80%',
          explode: true,
          explodeOffset: '10%',
          dataSource: <ChartSampleData>[
            ChartSampleData(x: 'Chlorine', y: 55, text: '55%'),
            ChartSampleData(x: 'Sodium', y: 31, text: '31%'),
            ChartSampleData(x: 'Magnesium', y: 7.7, text: '7.7%'),
            ChartSampleData(x: 'Sulfur', y: 3.7, text: '3.7%'),
            ChartSampleData(x: 'Calcium', y: 1.2, text: '1.2%'),
            ChartSampleData(x: 'Others', y: 1.4, text: '1.4%'),
          ],
          xValueMapper: (ChartSampleData data, _) => data.x as String,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelMapper: (ChartSampleData data, _) => data.text,
          dataLabelSettings: const DataLabelSettings(isVisible: true))
    ];
  }
}


class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num? y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num? yValue;

  /// Holds y value of the datapoint(for 2nd series)
  final num? secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
  final num? thirdSeriesYValue;

  /// Holds point color of the datapoint
  final Color? pointColor;

  /// Holds size of the datapoint
  final num? size;

  /// Holds datalabel/text value mapper of the datapoint
  final String? text;

  /// Holds open value of the datapoint
  final num? open;

  /// Holds close value of the datapoint
  final num? close;

  /// Holds low value of the datapoint
  final num? low;

  /// Holds high value of the datapoint
  final num? high;

  /// Holds open value of the datapoint
  final num? volume;
}