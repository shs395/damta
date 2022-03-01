import 'package:damta/utilities/utils.dart';
import 'package:damta/view_model/user_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:damta/common/theme.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';

class HomeNoSmokingInfoWidget extends StatelessWidget {
  const HomeNoSmokingInfoWidget({ Key? key }) : super(key: key);
  
  Widget getTimeFromStopSmokingDateWidget(DateTime stopSmokingDate) {
    return Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(text: '경과   ', style: TextStyle(fontSize: 12, color: appTheme.mainGreen, fontWeight: FontWeight.w500)),
          TextSpan(
            text: '+${formatDuration(DateTime.now().difference(stopSmokingDate))}',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)
          ),
        ]
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    UserInfoViewModel _userInfoViewModel = context.watch<UserInfoViewModel>();
    return Container(
      width: MediaQuery.of(context).size.width * 0.92,
      height: MediaQuery.of(context).size.height * 0.11,
      decoration: BoxDecoration(
        color: appTheme.homeNoSmokingInfoWidgetBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Center(
              child: Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: '금연 ', style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500
                    )),
                    TextSpan(
                      text: '${DateTime.now().difference(_userInfoViewModel.userInfo.startStopSmokingDate!).inDays}',
                      style: TextStyle(
                        fontSize: 25, color: appTheme.mainGreen,
                        fontWeight: FontWeight.w500
                      )
                    ),
                    TextSpan(text: ' 일', style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500
                    )),
                  ]
                )
              ),
            ) 
          ),
          Expanded(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: '시작일   ', style: TextStyle(fontSize: 12, color: appTheme.mainGreen, fontWeight: FontWeight.w500)),
                      TextSpan(
                        text: '${DateFormat('yyyy.MM.dd').format(_userInfoViewModel.userInfo.startStopSmokingDate!)}',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500 )
                      ),
                    ]
                  )
                ),
                SizedBox(
                  height: 2,
                ),
                StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    return getTimeFromStopSmokingDateWidget(_userInfoViewModel.userInfo.startStopSmokingDate!);
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