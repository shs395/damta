import 'dart:io';

import 'package:damta/data/models/smoking_record.dart';
import 'package:damta/utilities/ad_helper.dart';
import 'package:damta/common/theme.dart';
import 'package:damta/view/screens/home_page.dart';
import 'package:damta/view/screens/setting_page.dart';
import 'package:damta/view/screens/statistics_page.dart';
import 'package:damta/view/screens/stop_smoking_page.dart';
import 'package:damta/view/widgets/calendar_view_widget.dart';
import 'package:damta/view_model/smoking_record_list_view_model.dart';
import 'package:damta/view_model/user_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/src/provider.dart';


class MainPage extends StatefulWidget {
  MainPage({ Key? key }) : super(key: key);
  
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _screenIndex = 0;
  List<Widget> screenList = [
    HomePage(), 
    // CalendarPage(),
    CalendarViewWidget(),
    // Test(),
    StatisticsPage(),
    StopSmokingPage(), 
    SettingPage(),
  ];

  late BannerAd _mainBannerAd;
  bool _isMainBannerAdReady = false;

  late SmokingRecordListViewModel _smokingRecordListViewModel;
  late UserInfoViewModel _userInfoViewModel;
  final channel = MethodChannel('com.damta');

  Future<void> _sendTodaySmokingCountToNative() async {
    await channel.invokeMethod(
        "flutterToWatch", {"method": "sendTodaySmokingCountToNative", "data": _smokingRecordListViewModel.getSmokingCount(DateTime.now())});
  }

  Future<void> _sendIsStopSmokingToNative() async {
    await channel.invokeMethod(
        "flutterToWatch", {"method": "sendIsStopSmokingToNative", "data": _userInfoViewModel.userInfo.isStopSmoking});
  }

  Future<void> _sendStopSmokingDaysToNative() async {
    await channel.invokeMethod(
        "flutterToWatch", {"method": "sendIsStopSmokingToNative", "data": DateTime.now().difference(_userInfoViewModel.userInfo.startStopSmokingDate!).inDays});
  }

  Future<void> _sendUpdateToNative() async {
    _smokingRecordListViewModel = context.read<SmokingRecordListViewModel>();
    _userInfoViewModel = context.read<UserInfoViewModel>();
    if(_userInfoViewModel.userInfo.isStopSmoking == true) {
      print('정보 불러오기 - 금연 중');
       print( _userInfoViewModel.userInfo.isStopSmoking);
      await channel.invokeMethod(
        "flutterToWatch", {"method": "sendIsStopSmokingToNative", "data": _userInfoViewModel.userInfo.isStopSmoking});

      await channel.invokeMethod(
        "flutterToWatch", {"method": "sendStopSmokingDaysToNative", "data": DateTime.now().difference(_userInfoViewModel.userInfo.startStopSmokingDate!).inDays});
      
    } else if(_userInfoViewModel.userInfo.isStopSmoking == false) {
       print('정보 불러오기 - 흡연 중');
       print( _userInfoViewModel.userInfo.isStopSmoking);
       await channel.invokeMethod(
        "flutterToWatch", {"method": "sendIsStopSmokingToNative", "data": _userInfoViewModel.userInfo.isStopSmoking});

      await channel.invokeMethod(
        "flutterToWatch", {"method": "sendTodaySmokingCountToNative", "data": _smokingRecordListViewModel.getSmokingCount(DateTime.now())});
    }
    
  }

  Future<void> _addSmokingRecord() async {
    _smokingRecordListViewModel.addSmokingRecord(SmokingRecord(DateTime.now(), 1, ''));
  }


  Future<void> _initFlutterChannel() async {
    _smokingRecordListViewModel = context.read<SmokingRecordListViewModel>();
    _userInfoViewModel = context.read<UserInfoViewModel>();

    if(_userInfoViewModel.userInfo.isStopSmoking == true) {
      // 금연 중
      await channel.invokeMethod(
        "flutterToWatch", {"method": "sendIsStopSmokingToNative", "data": _userInfoViewModel.userInfo.isStopSmoking});

      await channel.invokeMethod(
        "flutterToWatch", {"method": "sendIsStopSmokingToNative", "data": DateTime.now().difference(_userInfoViewModel.userInfo.startStopSmokingDate!).inDays});
      
    } else {
      await channel.invokeMethod(
        "flutterToWatch", {"method": "sendIsStopSmokingToNative", "data": _userInfoViewModel.userInfo.isStopSmoking});

      await channel.invokeMethod(
        "flutterToWatch", {"method": "sendTodaySmokingCountToNative", "data": _smokingRecordListViewModel.getSmokingCount(DateTime.now())});
    }

    channel.setMethodCallHandler((call) async {
      // Receive data from Native
      switch (call.method) {
        case "addSmokingRecordToFlutter":
          _addSmokingRecord();
          break;
        case "requestUpdateToFlutter":
          _sendUpdateToNative();
          break;
        default:
          break;
      }
    });

  }
  
  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      _initFlutterChannel();
    }
      

    // 광고 로드
    // _mainBannerAd = BannerAd(
    //   // adUnitId: AdHelper.homeBannerAdUnitId,
    //   adUnitId: AdHelper.calendarBannerAdUnitId,
    //   // adUnitId: AdHelper.testBannerAdUnitId,
    //   request: AdRequest(),
    //   size: AdSize.banner,
    //   listener: BannerAdListener(
    //     onAdLoaded: (_) {
    //       setState(() {
    //         _isMainBannerAdReady = true;
    //       });
    //     },
    //     onAdFailedToLoad: (ad, err) {
    //       print('Failed to load a banner ad: ${err.message}');
    //       print(err.responseInfo);
    //       print(err.code);
    //       print(err.domain);
    //       print(err.message);
    //       _isMainBannerAdReady = false;
    //       ad.dispose();
    //     },
    //   ),
    // );

    // _mainBannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    _smokingRecordListViewModel = context.watch<SmokingRecordListViewModel>();
    _userInfoViewModel = context.watch<UserInfoViewModel>();
    if (Platform.isIOS) {
      _sendIsStopSmokingToNative();
      _sendTodaySmokingCountToNative();
    }
    return Scaffold(
      backgroundColor: appTheme.backgroundColor,
      body: Padding(
        padding: EdgeInsetsDirectional.all(0),
        child: Column(
          children: [
            Expanded(child: Container(
                child: screenList[_screenIndex],
              ),
            ),
            // 광고
            // Container(
            //   color: appTheme.backgroundColor,
            //   width: _mainBannerAd.size.width.toDouble(),
            //   height: _mainBannerAd.size.height.toDouble(),
            //   // width: 320,
            //   // height: 50,
            //   child: AdWidget(ad: _mainBannerAd),
            // )
          ],
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: appTheme.bottomNavBackgroundColor,
        selectedItemColor: appTheme.bottomNavSelectedColor,
        unselectedItemColor: appTheme.bottomNavUnselectedColor,
        currentIndex: _screenIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), 
            label: '홈'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range), 
            label: '달력'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment), 
            label: '통계'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.smoke_free), 
            label: '금연'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings), 
            label: '설정'
          ),
        ],
        onTap: (value) {
          setState(() { 
            _screenIndex = value;
          });
        },
      )
    );
  }
}

