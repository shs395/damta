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
  List<Widget> screenList = [
    HomePage(), 
    // CalendarPage(),
    CalendarViewWidget(),
    // Test(),
    StatisticsPage(),
    StopSmokingPage(), 
    SettingPage(),
  ];

  List<BannerAd> bannerAdList = [];
  List<bool> isBannerAdReadyList = [false, false, false, false, false];
  List<String> bannerIdList= [ 
    AdHelper.homeBannerAdUnitId,
    AdHelper.calendarBannerAdUnitId,
    AdHelper.statisticsBannerAdUnitId,
    AdHelper.noSmokingBannerAdUnitId,
    AdHelper.settingBannerAdUnitId,
  ];


  late BannerAd _homeBanner;
  late BannerAd _calendarBanner;
  late BannerAd _statisticsBanner;
  late BannerAd _nosmokingBanner;
  late BannerAd _settingBanner;

  bool _isHomeBannerAdReady = false;
  bool _isCalendarBannerAdReady = false;
  bool _isStatisticsBannerAdReady = false;
  bool _isNosmokingBannerAdReady = false;
  bool _isSettingBannerAdReady = false;
  
  

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
    for (int i = 0; i < 5; i++) {
      bannerAdList.add( BannerAd(
        adUnitId: bannerIdList[i],
        // adUnitId: AdHelper.bannerAdUnitId,
        request: AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          onAdLoaded: (_) {
            setState(() {
              isBannerAdReadyList[i] = true;
            });
          },
          onAdFailedToLoad: (ad, err) {
            print('Failed to load a banner ad: ${err.message}');
            isBannerAdReadyList[i] = false;
            ad.dispose();
          },
        ),
      )
    );

      bannerAdList[i].load();
    }
    

    // _bannerAd = BannerAd(
    //   adUnitId: AdHelper.homeBannerAdUnitId,
    //   // adUnitId: AdHelper.bannerAdUnitId,
    //   request: AdRequest(),
    //   size: AdSize.banner,
    //   listener: BannerAdListener(
    //     onAdLoaded: (_) {
    //       setState(() {
    //         _isBannerAdReady = true;
    //       });
    //     },
    //     onAdFailedToLoad: (ad, err) {
    //       print('Failed to load a banner ad: ${err.message}');
    //       _isBannerAdReady = false;
    //       ad.dispose();
    //     },
    //   ),
    // );

    // _bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    // isBannerAdReadyList.forEach((element) {
    //   print(element.toString());
    // });
    print(bannerAdList[_screenIndex].adUnitId);
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
              width: bannerAdList[_screenIndex].size.width.toDouble(),
              height: bannerAdList[_screenIndex].size.height.toDouble(),
              child: AdWidget(ad: bannerAdList[_screenIndex]),
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

