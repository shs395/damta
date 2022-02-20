
import 'package:damta/common/theme.dart';
import 'package:damta/view_model/smoking_record_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';

class HomeInfoWidget extends StatefulWidget {
  const HomeInfoWidget({ Key? key }) : super(key: key);

  @override
  _HomeInfoWidgetState createState() => _HomeInfoWidgetState();
}

class _HomeInfoWidgetState extends State<HomeInfoWidget> {
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

   @override 
  void didChangeDependencies() {
    super.didChangeDependencies(); 
    initializeDateFormatting(Localizations.localeOf(context).languageCode); 
  }
  
  @override
  Widget build(BuildContext context) {
    SmokingRecordListViewModel smokingRecordListViewModel = context.watch<SmokingRecordListViewModel>();
    List<Widget> iconList = [
      Icon(Icons.minimize),
      Icon(Icons.arrow_upward),
      Icon(Icons.arrow_downward),
    ];
    int iconListIndex = 0;
    if(smokingRecordListViewModel.getSmokingCount(DateTime.now()) - smokingRecordListViewModel.getSmokingCount(DateTime.now().subtract(Duration(days:1))) == 0) {
      iconListIndex = 0;
    } else if(smokingRecordListViewModel.getSmokingCount(DateTime.now()) - smokingRecordListViewModel.getSmokingCount(DateTime.now().subtract(Duration(days:1))) < 0) {
      iconListIndex = 2;
    } else {  
      iconListIndex = 1;
    }
    List<Widget> lastSmokingList = [
      Text(''),
      Text(
        '${DateFormat('yy년 MM월 dd일 a h시 m분', 'ko_KR').format(smokingRecordListViewModel.lastSmokingTime)}',
        style: TextStyle(
          fontSize: 12
        ),
      ),
    ];
    int lastSmokingIndex = 0;
    if(smokingRecordListViewModel.lastSmokingTime != DateTime(2010, 1, 1)) {
      setState(() {
        lastSmokingIndex = 1;
      });
    }
    return Container(
      width: MediaQuery.of(context).size.width * 0.92,
      height: MediaQuery.of(context).size.height * 0.23,
      decoration: BoxDecoration(
        color: appTheme.homeInfoWidgetBackgroundColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: appTheme.mainGrey,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                '흡연',
                style: TextStyle(
                  // fontWeight: FontWeight/,
                  fontSize: 18
                ),
              )
            )
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: appTheme.mainGrey,
                borderRadius: BorderRadius.circular(25),
              ),
              // child: Text('오늘 10개                           어제 5개                            5^')
              child: Row(
                children: [
                  Text('오늘 ${smokingRecordListViewModel.getSmokingCount(DateTime.now())} 개'),
                  Spacer(),
                  Text('어제 ${smokingRecordListViewModel.getSmokingCount(DateTime.now().subtract(Duration(days:1)))} 개'),
                  Spacer(),
                  Text('${smokingRecordListViewModel.getSmokingCount(DateTime.now()) - smokingRecordListViewModel.getSmokingCount(DateTime.now().subtract(Duration(days:1)))}'),
                  iconList[iconListIndex],
                ],
              )
            )
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: appTheme.mainGrey,
                borderRadius: BorderRadius.circular(25),
              ),
              // child: Text('오늘 10개                           어제 5개                            5^')
              child: Row(
                children: [
                  Text('마지막 흡연')
                ],
              )
            )
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: appTheme.mainGrey,
                borderRadius: BorderRadius.circular(25),
              ),
              // child: 
              child: Row(
                children: [
                  lastSmokingList[lastSmokingIndex],
                  // Text('${DateTime.now().difference(smokingRecordListViewModel.lastSmokingTime)}')
                  Spacer(),
                  StreamBuilder(
                    stream: Stream.periodic(const Duration(seconds: 1)),
                    builder: (context, snapshot) {
                      if(smokingRecordListViewModel.lastSmokingTime == DateTime(2010, 1, 1)) {
                        return Text('흡연 기록이 없습니다');
                      } else {
                        return Text(
                          '+${formatDuration(DateTime.now().difference(smokingRecordListViewModel.lastSmokingTime))}',
                          style: TextStyle(
                            fontSize: 12
                          ),  
                        );
                      }
                      
                    }
                  )
                ],
              )
            )
          ),
          // Expanded(
          //   flex: 2,
          //   child: Container(
          //     alignment: Alignment.center,
          //     color: Colors.green,
          //     child: Text('오늘 사용 금액                                   5000원'),
          //   )
          // )
        ],
      )
        // Text('오늘의 흡연량 ${smokingRecordList.getSmokingCount(DateTime.now())} 개, 마지막으로 부터 몇 분 지났나, 어제보다 몇개 더 많이?, 어제의 흡연량')
        
    );
  }
}
