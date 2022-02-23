import 'package:damta/utilities/utils.dart';
import 'package:damta/view_model/smoking_record_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:damta/common/theme.dart';
import 'package:provider/src/provider.dart';

class HomeDateWidget extends StatefulWidget {
  const HomeDateWidget({ Key? key }) : super(key: key);

  @override
  _HomeDateWidgetState createState() => _HomeDateWidgetState();
}

class _HomeDateWidgetState extends State<HomeDateWidget> {

  List<Widget> getLastSmokingTimeWidget(DateTime? lastSmokingTime) {
    if(lastSmokingTime == null) {
      return [
        Text('마지막 흡연'),
        SizedBox(
          height: 2,
        ),
        Text('흡연 기록이 없습니다'),
      ];
    } else {
      return [
        Text(
          '마지막 흡연',
          style: TextStyle(
            fontSize: 12,
            color: appTheme.mainGreen
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          '${DateFormat('yyyy년 MM월 dd일', 'ko_KR').format(lastSmokingTime)}',
          style: TextStyle(
            fontSize: 15
          ),
        ),
        Text(
          '${DateFormat('a h시 m분', 'ko_KR').format(lastSmokingTime)}',
          style: TextStyle(
            fontSize: 15
          ),
        )
      ];
      
    }
  }

  Widget getTimeFromLastSmokingTimeWidget(DateTime? lastSmokingTime) {
    if(lastSmokingTime == null) {
      return Text('');
    } else {
      return Text(
        '+${formatDuration(DateTime.now().difference(lastSmokingTime))}',
        style: TextStyle(
          fontSize: 17
        ),  
      );
    }
  }

  @override 
  void didChangeDependencies() {
    super.didChangeDependencies(); 
    initializeDateFormatting(Localizations.localeOf(context).languageCode); 
  }

  @override
  Widget build(BuildContext context) {
    SmokingRecordListViewModel smokingRecordListViewModel = context.watch<SmokingRecordListViewModel>();
    DateTime? lastSmokingTime = smokingRecordListViewModel.lastSmokingTime;

    return Container(
      width: MediaQuery.of(context).size.width * 0.92,
      height: MediaQuery.of(context).size.height * 0.11,
      decoration: BoxDecoration(
        color: appTheme.homeDateWidgetBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: getLastSmokingTimeWidget(lastSmokingTime),
            )
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '경과',
                  style: TextStyle(
                    fontSize: 12,
                    color: appTheme.mainGreen
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    return getTimeFromLastSmokingTimeWidget(lastSmokingTime);
                  }
                )
              ],
            )
          )
        ],
      ),
    );
  }
}
