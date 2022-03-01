
import 'package:damta/data/models/user_info.dart';
import 'package:damta/view/widgets/custom_appbar.dart';
import 'package:damta/view/widgets/stop_smoking_page/start_stop_smoking_widget.dart';
import 'package:damta/view/widgets/stop_smoking_page/stop_smoking_health_info_list_widget.dart';
import 'package:damta/view/widgets/stop_smoking_page/stop_smoking_health_info_widget.dart';
import 'package:damta/view/widgets/stop_smoking_page/stop_smoking_main_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    UserInfoViewModel _userInfoViewModel = context.watch<UserInfoViewModel>();
    return Scaffold(
      appBar: CustomAppbar('금연'),
      backgroundColor: appTheme.backgroundColor,
      body: !_userInfoViewModel.userInfo.isStopSmoking ? StartStopSmokingWidget() : Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 20, 15, 20),
              child: Column(
                children: [
                  StopSmokingHealthInfoWidget(),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Center(
                      child: Text(
                        '금연 후 신체변화',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15
                        ),
                      ),
                    )
                  ),
                  StopSmokingHealthInfoListWidget(),
                ],
              )
            )
          )
        ],
      )
    );
  }
}
