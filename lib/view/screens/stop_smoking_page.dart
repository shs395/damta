
import 'package:damta/data/models/user_info.dart';
import 'package:damta/view/screens/start_stop_smoking_page.dart';
import 'package:damta/view/screens/stop_smoking_view_list_page.dart';
import 'package:damta/view/widgets/custom_appbar.dart';
import 'package:damta/view_model/user_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:damta/common/theme.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';


class StopSmokingPage extends StatefulWidget {
  const StopSmokingPage({ Key? key }) : super(key: key);

  @override
  _StopSmokingPageState createState() => _StopSmokingPageState();
}

class _StopSmokingPageState extends State<StopSmokingPage> {
  late UserInfoViewModel _userInfoViewModel;
  late String screenIndex;
  Map<String, Widget> screenMap = {
    "before" : StartStopSmokingPage(), 
    "start" : StopSmokingViewListPage()
  };
  // @override
  // void initState() {
  //   super.initState();
    
  // }

  @override
  Widget build(BuildContext context) {
    _userInfoViewModel = Provider.of<UserInfoViewModel>(context);
    if(_userInfoViewModel.userInfo.isStopSmoking == true) {
      screenIndex = "start";
    } else {
      screenIndex = "before";
    }
    return Scaffold(
      appBar: CustomAppbar('금연'),
      backgroundColor: appTheme.backgroundColor,
      body: screenMap[screenIndex]
    );
  }
}

// ElevatedButton(
//             onPressed: (){}, 
//             child: Text('금연 시작'),
//             style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all(appTheme.buttonAddBackgrounColor),
//             ),
//           )