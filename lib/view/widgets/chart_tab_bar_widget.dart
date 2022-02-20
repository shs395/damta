import 'package:damta/common/theme.dart';
import 'package:damta/utilities/utils.dart';
import 'package:damta/view/widgets/bar_chart.dart';
import 'package:flutter/material.dart';

class ChartTabBar extends StatefulWidget {
  const ChartTabBar({ Key? key }) : super(key: key);

  @override
  _ChartTabBarState createState() => _ChartTabBarState();
}

class _ChartTabBarState extends State<ChartTabBar> with SingleTickerProviderStateMixin {
  // late TabController _tabController;
  // List<bool> isSelected1 = [true, false, false];
  // List<List<bool>> isSelected2List = [[true, false, false, false], [true, false, false], [true, false]];
  // List<Widget> screenList = [
    // BarChartForSevenDays(),
    // BarChartForOneMonth(),s
    // BarChartForThreeMonths() 
  // ];
  // List<List<Widget>> _selectedWidgetList = [[
  //   Text('1주'),
  //   Text('1달'),
  //   Text('3달'),
  //   Text('전체'),
  // ],[
  //   Text('1달'),
  //   Text('3달'),
  //   Text('전체'),
  // ],[
  //   Text('3달'),
  //   Text('전체'),
  // ]];
  List<Widget> _viewWidget = [
    BarChart(dateTimeList: getSevenDaysFromNow()),
    BarChart(dateTimeList: getOneMonthFromNow()),
    BarChart(dateTimeList: getThreeMonthsFromNow())
  ];
  late List<bool> isSelected2;
  late List<Widget> _selectedWidget;
  int isSelectedIndex = 0;
  @override
  void initState() {
    // _selectedWidget = _selectedWidgetList[0];
    // isSelected2 = isSelected2List[0];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appTheme.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BarChart(dateTimeList: getSevenDaysFromNow()),
        // child: Column(
        //   children: [
            // Row(
            //   // mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
                
                // ToggleButtons(
                //   children: <Widget>[
                //     Text('일별'),
                //     Text('주별'),
                //     Text('월별'),

                //   ],
                //   onPressed: (int index) {
                //     setState(() {
                //       isSelectedIndex = index;
                //       _selectedWidget = _selectedWidgetList[isSelectedIndex];
                //       isSelected2 = isSelected2List[isSelectedIndex];
                //       for (int buttonIndex = 0; buttonIndex < isSelected1.length; buttonIndex++) {
                //         if (buttonIndex == index) {
                //           isSelected1[buttonIndex] = true;
                //         } else {
                //           isSelected1[buttonIndex] = false;
                //         }
                //       }
                //     });
                //   },
                //   isSelected: isSelected1,
                // ),
                // Spacer(),
                // ToggleButtons(
                //   children: _selectedWidget,
                //   onPressed: (int index) {
                //     setState(() {
                //       for (int buttonIndex = 0; buttonIndex < isSelected2.length; buttonIndex++) {
                //         if (buttonIndex == index) {
                //           isSelected2[buttonIndex] = true;
                //         } else {
                //           isSelected2[buttonIndex] = false;
                //         }
                //       }
                //     });
                //   },
                //   isSelected: isSelected2,
                // ),
            //   ],
            // ),
            // tab bar view here
            // Expanded(
            //   child: TabBarView(
            //     controller: _tabController,
            //     children: [
            //       // first tab bar view widget 
            //       Center(
            //         child: _viewWidget[isSelectedIndex]
            //       ),

            //       // second tab bar view widget
            //       Center(
            //         // child: BarChartForOneMonth()
            //       ),
            //       Center()
            //     ],
            //   ),
            // ),
        //   ],
        // ),
      ),
    );
  }
}