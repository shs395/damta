
import 'package:damta/view/widgets/calendar_view_widget.dart';
import 'package:damta/view/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:damta/common/theme.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar('달력'),
      backgroundColor: appTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CalendarViewWidget()
            // Test(),
          ],
        ),
      )
    );
  }
}