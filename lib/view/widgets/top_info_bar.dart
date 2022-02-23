import 'package:damta/common/theme.dart';
import 'package:damta/view_model/smoking_record_list_view_model.dart';
import 'package:damta/view_model/user_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';

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
      return '금연 ${DateTime.now().difference(_userInfoViewModel.userInfo.startStopSmokingDate!).inDays}일';
    }
  }

  @override
  Widget build(BuildContext context) {
    _smokingRecordListViewModel = Provider.of<SmokingRecordListViewModel>(context);
    _userInfoViewModel = Provider.of<UserInfoViewModel>(context);
    print(_userInfoViewModel.userInfo.isStopSmoking);
    print(_userInfoViewModel.userInfo.startStopSmokingDate);
    return Container(
      padding: EdgeInsets.only(right: 15),
      child: Center(
        child: Container(
          width: 90,
          height: 30,
          decoration: BoxDecoration(
            // color: appTheme.mainBeige,
            // color: appTheme.mainGreen,
            // border: Border.all(
            //   // color: Colors.white
            // ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            // border: Border.all(color: Colors.grey)
          ),
          child: Center(
            // child: Text(
            //   makeReturnText(_userInfoViewModel),
            //   style: TextStyle(
            //     color: Colors.black
            //   ),
            // )
            child: Center(
              child: Badge(
                // shape: BadgeShape.square,
                // borderRadius: BorderRadius.circular(10),
                // padding: EdgeInsets.all(2),
                // position: BadgePosition.topEnd(top: -12, end: -20),
                // alignment: Alignment.bottomLeft,
                badgeContent: Text('1', style: TextStyle(color: Colors.white, fontSize: 12),),
                badgeColor:Color(0xFF145374),
                child: Icon(Icons.smoke_free, color: Colors.black),
                toAnimate: false
              ),
            )
          )
        )
      ),
    );
  }
}