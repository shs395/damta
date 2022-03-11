import 'package:damta/data/models/smoking_record.dart';
import 'package:damta/data/models/user_info.dart';
import 'package:damta/view/screens/main_page.dart';
import 'package:damta/view_model/smoking_record_list_view_model.dart';
import 'package:damta/view_model/user_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:damta/common/theme.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


Future<void> main() async {
  // 광고 시작
  // WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize();

  // hive 시작
  await Hive.initFlutter();
  Hive.registerAdapter(SmokingRecordAdapter());
  Hive.registerAdapter(UserInfoAdapter());

  runApp(const DamTa());
}


// class DamTa extends StatefulWidget {
//   const DamTa({ Key? key }) : super(key: key);

//   @override
//   _DamTaState createState() => _DamTaState();
// }

// class _DamTaState extends State<DamTa> {

//   @override
//   Widget build(BuildContext context) {
    
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<CountProvider>(create: (_) => CountProvider()),
//         ChangeNotifierProvider<UserInfo>(create: (_) => UserInfo()),
//       ],
//       child: MaterialApp(
//         title: '담타',
//         initialRoute: '/',
//         routes: {
//           '/': (context) => MainPage(),
//         },
//       ),
//     );
//   }
// }

class DamTa extends StatelessWidget {
  const DamTa({ Key? key }) : super(key: key);
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(      
      providers: [
        ChangeNotifierProvider<SmokingRecordListViewModel>(create: (_) => SmokingRecordListViewModel()),
        ChangeNotifierProvider<UserInfoViewModel>(create: (_) => UserInfoViewModel()),
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'NotoSansKR'),
        debugShowCheckedModeBanner: false,
        title: '담타',
        initialRoute: '/',
        routes: {
          '/': (context) => MainPage(),
        },
      ),
    );
  }
}
