import 'package:damta/common/theme.dart';
import 'package:damta/data/models/smoking_record.dart';
import 'package:damta/view/screens/create_smoking_record_page.dart';
import 'package:damta/view/widgets/custom_appbar.dart';
import 'package:damta/view/widgets/home_info_widget.dart';
import 'package:damta/view/widgets/home_smoking_list_widget.dart';
import 'package:damta/view_model/smoking_record_list_view_model.dart';
import 'package:damta/view_model/user_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:damta/common/theme.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/src/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SmokingRecordListViewModel smokingRecordList = context.watch<SmokingRecordListViewModel>();
    UserInfoViewModel _userInfoViewModel = Provider.of<UserInfoViewModel>(context);
    return Scaffold(
      appBar: CustomAppbar('홈'),
      backgroundColor: appTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment,
          children: [
            //expanded 사용 -> 광고, bottomnav 제외페이지 전체 사용
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 20, 15, 20),
                child: Column(
                  children: [
                    HomeInfoWidget(),
                    Padding(padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 20)),
                    HomeSmokingListWidget(),
                    Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Container(),
                          flex: 1,
                        ),
                        Expanded(
                          child: Center(
                            child: FloatingActionButton.large(
                              backgroundColor: appTheme.buttonAddBackgrounColor,
                              foregroundColor: appTheme.buttonAddForegroundColor,
                              elevation: 0.5,
                              child: Icon(Icons.add, size: 50),
                              onPressed: () {
                                if(_userInfoViewModel.userInfo.isStopSmoking == true) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('금연 기록 초기화'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: const <Widget>[
                                              Text('현재 금연 중입니다'),
                                              Text('금연을 포기하고 기록하시겠습니까?'),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text(
                                                '취소',
                                                style: TextStyle(
                                                  color: Colors.black
                                                )
                                              ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text(
                                              '기록',
                                              style: TextStyle(
                                                color: Colors.red
                                              )
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              _userInfoViewModel.endStopSmoking();
                                              smokingRecordList.addSmokingRecord(SmokingRecord(DateTime.now(), 1, ''));
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  smokingRecordList.addSmokingRecord(SmokingRecord(DateTime.now(), 1, ''));
                                }
                                
                              }
                            ),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Center(
                            child: FloatingActionButton(
                              backgroundColor: appTheme.buttonMoreBackgrounColor,
                              foregroundColor: appTheme.buttonMoreForegroundColor,
                              elevation: 0.5,
                              heroTag: 'good',
                              child: Icon(Icons.more_horiz),
                              onPressed: () {
                                showBarModalBottomSheet(
                                  context: context,
                                  builder: (context) => CreateSmokingRecordPage(),
                                );
                              },
                              
                            ),
                          ),
                          flex: 1,
                        )
                        // Center(child: Text('s'),),
                        // FloatingActionButton.large(
                        //   child: Text('add now'),
                        //   onPressed: () {
                        //     smokingRecordList.addSmokingRecord(SmokingRecord(DateTime.now(), 1, ''));
                        //   }
                        // ),
                        // FloatingActionButton(
                        //   heroTag: 'good',
                        //   child: Text('add someday'),
                        //   onPressed: () async {
                        //     await Navigator.push(
                        //       context,
                        //       PageTransition(
                        //         type: PageTransitionType.bottomToTop,
                        //         duration: Duration(milliseconds: 200),
                        //         reverseDuration: Duration(milliseconds: 200),
                        //         child: CreateSmokingRecord(),
                        //       )
                        //     );
                        //   }
                        // ),
                      ],
                    ),
                    
                  ],
                )
              )
            ),
          ]
        )
      )
    );
  }
}