import 'package:damta/utilities/ad_helper.dart';
import 'package:damta/view/widgets/custom_appbar.dart';
import 'package:damta/view_model/smoking_record_list_view_model.dart';
import 'package:damta/view_model/user_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:damta/common/theme.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/src/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    SmokingRecordListViewModel smokingRecordListViewModel = context.watch<SmokingRecordListViewModel>();
    UserInfoViewModel userInfoViewModel = context.watch<UserInfoViewModel>();
    return Scaffold(
      appBar: CustomAppbar('설정'),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
        child: ListView(
          children: <Widget>[
            // ListTile(
            //   title: Text('평균 가격 수정하기'),
            //   onTap: () {
            //   }
            // ),
            ListTile(
              title: Text(
                '초기화',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              // contentPadding: EdgeInsetsGeometry
            ),
            ListTile(
              title: Text('흡연 기록 초기화'),
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('흡연 기록 초기화'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('모든 흡연 기록이 사라집니다.'),
                            Text('삭제하시겠습니까?'),
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
                            '초기화',
                            style: TextStyle(
                              color: Colors.red
                            )
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            smokingRecordListViewModel.deleteSmokingRecordList();
                          },
                        ),
                      ],
                    );
                  },
                );
                
              }
            ),
            ListTile(
              title: Text('금연 기록 초기화'),
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('금연 기록 초기화'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('모든 금연 기록이 사라집니다.'),
                            Text('삭제하시겠습니까?'),
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
                            '초기화',
                            style: TextStyle(
                              color: Colors.red
                            )
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            userInfoViewModel.endStopSmoking();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            ),
            ListTile(
              title: Text('모든 기록 초기화'),
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('모든 기록 초기화'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('모든 흡연 및 금연 기록이 사라집니다.'),
                            Text('삭제하시겠습니까?'),
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
                            '초기화',
                            style: TextStyle(
                              color: Colors.red
                            )
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            smokingRecordListViewModel.deleteSmokingRecordList();
                            userInfoViewModel.endStopSmoking();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            ),
            // ListTile(
            //   title: Text(
            //     '문의하기',
            //     style: TextStyle(
            //       fontWeight: FontWeight.w700,
            //       fontSize: 18,
            //     ),
            //   ),
            // ),
            // ListTile(
            //   title: Text('개인정보처리방침'),
            // ),
          ]
        )
      )
    );
  }
}
