import 'package:damta/utilities/ad_helper.dart';
import 'package:damta/utilities/setting_helper.dart';
import 'package:damta/view/widgets/custom_appbar.dart';
import 'package:damta/view_model/smoking_record_list_view_model.dart';
import 'package:damta/view_model/user_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:damta/common/theme.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/src/provider.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:in_app_review/in_app_review.dart';


class SettingPage extends StatelessWidget {
  const SettingPage({ Key? key }) : super(key: key);

  // 메일 전송
  
  
  @override
  Widget build(BuildContext context) { 
    const String _groupChatUrl = 'https://open.kakao.com/o/gWeM6q0d';
    const String _damtaChannel = 'https://pf.kakao.com/_zBLab';
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
            ListTile(
              title: Text(
                '문의 및 개선사항',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              title: Text(
                '메일로 문의하기',
              ),
              trailing: Icon(
                Icons.open_in_new,
                size: 20
              ),
              onTap: () {
                SettingHelper.sendEmail(context);
              },
            ),
            ListTile(
              title: Text(
                '카카오톡 단톡방 참여하기',
              ),
              trailing: Icon(
                Icons.open_in_new,
                size: 20
              ),
              onTap: () async {
                if (!await launch(_groupChatUrl)) throw 'Could not launch $_groupChatUrl';
              }
            ),
            ListTile(
              title: Text(
                '카카오톡 채널로 문의하기',
              ),
              trailing: Icon(
                Icons.open_in_new,
                size: 20
              ),
              onTap: () async {
                if (!await launch(_damtaChannel)) throw 'Could not launch $_damtaChannel';
              }
            ),
            ListTile(
              title: Text(
                '리뷰',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              title: Text(
                '앱 리뷰하기',
              ),
              trailing: Icon(
                Icons.open_in_new,
                size: 20
              ),
              onTap: () {
                final inAppReview = InAppReview.instance;
                inAppReview.openStoreListing(
                  appStoreId: '1610315100',
                );
              }
            ),
            ListTile(
              title: Text(
                '앱 정보',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              title: Text(
                '오픈소스 라이선스',
              ),
              trailing: Icon(
                Icons.navigate_next,
                size: 25
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => Theme(
                      data: ThemeData(
                        primarySwatch: MaterialColor(
                          0xFFFFFFFF,
                          const <int, Color>{
                            50: const Color(0xFFFFFFFF),
                            100: const Color(0xFFFFFFFF),
                            200: const Color(0xFFFFFFFF),
                            300: const Color(0xFFFFFFFF),
                            400: const Color(0xFFFFFFFF),
                            500: const Color(0xFFFFFFFF),
                            600: const Color(0xFFFFFFFF),
                            700: const Color(0xFFFFFFFF),
                            800: const Color(0xFFFFFFFF),
                            900: const Color(0xFFFFFFFF),
                          },
                        )
                      ),
                      child: LicensePage(
                        applicationName: '담타 - 담배, 타임!',
                        applicationVersion: 'ver 1.0.6'
                      ),
                    ),
                  ),
                );
              }
            ),
            ListTile(
              title: Text(
                '앱 버전', 
              ),
              trailing: Text(
                '1.0.6',
              ),
            ),
            
          ]
        )
      )
    );
  }
}
