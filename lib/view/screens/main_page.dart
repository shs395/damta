import 'package:damta/utilities/ad_helper.dart';
import 'package:damta/common/theme.dart';
import 'package:damta/view/screens/home_page.dart';
import 'package:damta/view/screens/setting_page.dart';
import 'package:damta/view/screens/statistics_page.dart';
import 'package:damta/view/screens/stop_smoking_page.dart';
import 'package:damta/view/widgets/calendar_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  late BannerAd _mainBannerAd;
  bool _isMainBannerAdReady = false;

  int _counter = 0;
  final channel = MethodChannel('com.damta');

  Future<void> _incrementCounter() async {
    print('watch click');
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });

    // Send data to Native
    await channel.invokeMethod(
        "flutterToWatch", {"method": "sendCounterToNative", "data": _counter});
  }

  Future<void> _initFlutterChannel() async {
    channel.setMethodCallHandler((call) async {
      // Receive data from Native
      switch (call.method) {
        case "sendCounterToFlutter":
          _counter = call.arguments["data"]["counter"];
          _incrementCounter();
          break;
        default:
          break;
      }
    });
  }
  
  @override
  void initState() {
    _initFlutterChannel();
    _mainBannerAd = BannerAd(
      adUnitId: AdHelper.homeBannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isMainBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isMainBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _mainBannerAd.load();
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
              width: _mainBannerAd.size.width.toDouble(),
              height: _mainBannerAd.size.height.toDouble(),
              child: AdWidget(ad: _mainBannerAd),
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

