import 'package:damta/utilities/ad_helper.dart';
import 'package:damta/common/theme.dart';
import 'package:damta/view/screens/home_page.dart';
import 'package:damta/view/screens/setting_page.dart';
import 'package:damta/view/screens/statistics_page.dart';
import 'package:damta/view/screens/stop_smoking_page.dart';
import 'package:damta/view/widgets/calendar_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class MainPage extends StatefulWidget {
  MainPage({ Key? key }) : super(key: key);
  
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _screenIndex = 0;
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  List<Widget> screenList = [
    HomePage(), 
    // CalendarPage(),
    CalendarViewWidget(),
    // Test(),
    StatisticsPage(),
    StopSmokingPage(), 
    SettingPage(),
  ];

  // List<String> bannerIdList= [ 
  //   AdHelper.homeBannerAdUnitId,
  //   AdHelper.calendarBannerAdUnitId,
  //   AdHelper.homeBannerAdUnitId,
  //   AdHelper.homeBannerAdUnitId,
  //   AdHelper.homeBannerAdUnitId,
  // ];

  // BannerAd makeBannerAd(int index) {
  //   return BannerAd(
  //     adUnitId: bannerIdList[index],
  //     // adUnitId: AdHelper.bannerAdUnitId,
  //     request: AdRequest(),
  //     size: AdSize.banner,
  //     listener: BannerAdListener(
  //       onAdLoaded: (_) {
  //         setState(() {
  //           _isBannerAdReady = true;
  //         });
  //       },
  //       onAdFailedToLoad: (ad, err) {
  //         print('Failed to load a banner ad: ${err.message}');
  //         _isBannerAdReady = false;
  //         ad.dispose();
  //       },
  //     ),
  //   );
  // }

  @override
  void initState() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.homeBannerAdUnitId,
      // adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
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
            Container(
              color: appTheme.backgroundColor,
              // width: _bannerAd.size.width.toDouble(),
              width: _bannerAd.size.width.toDouble(),
              height: _bannerAd.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd),
            )
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

