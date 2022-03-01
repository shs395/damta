
import 'package:damta/data/models/smoking_record.dart';
import 'package:damta/view/widgets/bar_chart.dart';
import 'package:damta/view/widgets/chart_tab_bar_widget.dart';
import 'package:damta/view/widgets/custom_appbar.dart';
import 'package:damta/view/widgets/statistics_page/daily_bar_chart.dart';
import 'package:damta/view/widgets/statistics_page/monthly_bar_chart.dart';
import 'package:damta/view/widgets/statistics_page/weekly_bar_chart.dart';
import 'package:damta/view_model/smoking_record_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:damta/common/theme.dart';
import 'package:provider/src/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({ Key? key }) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> with SingleTickerProviderStateMixin {
  // late TabController _tabController;
  
  @override
  void initState() {
    // _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar('통계'),
      // body: ChartTabBar()
      backgroundColor: appTheme.backgroundColor,
      body: ListView(
        padding: EdgeInsetsDirectional.fromSTEB(15, 20, 15, 20),
        children: <Widget>[
          DailyBarChart(),
          Padding(padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 20)),
          WeeklyBarChart(),
          Padding(padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 20)),
          MonthlyBarChart(),
        ],
      )
      
    );
  }
}

