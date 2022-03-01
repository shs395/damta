import 'package:damta/data/models/user_info.dart';
import 'package:damta/view_model/user_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:damta/common/theme.dart';
import 'package:provider/provider.dart';

class StartStopSmokingWidget extends StatefulWidget {
  const StartStopSmokingWidget({ Key? key }) : super(key: key);

  @override
  _StartStopSmokingWidgetState createState() => _StartStopSmokingWidgetState();
}

class _StartStopSmokingWidgetState extends State<StartStopSmokingWidget> {
  @override
  Widget build(BuildContext context) {
    UserInfoViewModel _userInfoViewModel = context.watch<UserInfoViewModel>();
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.smoke_free,
              size: 150,
              color: appTheme.mainGreen,
            )
          ],
        ),
        Container(
          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 30),
          child: Text(
            '금연을 시작하고 건강 상태 변화를 알아보세요',
            style: TextStyle(
              fontSize: 17
            ),
          )
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.05,
          child: ElevatedButton(
            onPressed: (){
              _userInfoViewModel.modifyUserInfo(UserInfo(true, DateTime.now()));
            }, 
            child: Text('금연시작'),
            style: ElevatedButton.styleFrom(
              primary: appTheme.mainGreen,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(8.0),
              ),
            )
          ),
        )
      ],
    );
  }
}