import 'package:damta/common/theme.dart';
import 'package:damta/view_model/smoking_record_list_view_model.dart';
import 'package:damta/view_model/user_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopInfoBar extends StatefulWidget {
  const TopInfoBar({ Key? key }) : super(key: key);

  @override
  _TopInfoBarState createState() => _TopInfoBarState();
}

class _TopInfoBarState extends State<TopInfoBar> {
  late SmokingRecordListViewModel _smokingRecordListViewModel;
  late UserInfoViewModel _userInfoViewModel;

  String makeReturnText(UserInfoViewModel userInfoViewModel) {
    if(userInfoViewModel.userInfo.isStopSmoking == false) {
      return '오늘 ${_smokingRecordListViewModel.getSmokingCount(DateTime.now())} 개';
    } else {
      return '금연 ${DateTime.now().difference(_userInfoViewModel.userInfo.startStopSmokingDate!).inDays}일 째';
    }
  }

  @override
  Widget build(BuildContext context) {
    _smokingRecordListViewModel = Provider.of<SmokingRecordListViewModel>(context);
    _userInfoViewModel = Provider.of<UserInfoViewModel>(context);
    print(_userInfoViewModel.userInfo.isStopSmoking);
    print(_userInfoViewModel.userInfo.startStopSmokingDate);
    return Container(
      padding: EdgeInsets.only(right: 20),
      child: Center(
        child: Container(
          width: 100,
          height: 30,
          decoration: BoxDecoration(
            // color: Color(0xFF5E778C),
            color: appTheme.mainGreen,
            // border: Border.all(
            //   // color: Colors.white
            // ),
            borderRadius: BorderRadius.all(Radius.circular(25))
          ),
          child: Center(
            child: Text(
              makeReturnText(_userInfoViewModel),
              style: TextStyle(
                color: Colors.white
              ),
            )
          )
        )
      ),
    );
  }
}