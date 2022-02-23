import 'dart:io';

import 'package:flutter/services.dart';

class AdHelper {

  // static String get bannerAdUnitId {
  //   if (Platform.isAndroid) {
  //     return 'ca-app-pub-3940256099942544/6300978111';
  //   } else if (Platform.isIOS) {
  //     return 'ca-app-pub-3940256099942544/2934735716';
  //   } else {
  //     throw new UnsupportedError('Unsupported platform');
  //   }
  // }

  // static String get interstitialAdUnitId {
  //   if (Platform.isAndroid) {
  //     return 'ca-app-pub-3940256099942544/1033173712';
  //   } else if (Platform.isIOS) {
  //     return 'ca-app-pub-3940256099942544/4411468910';
  //   } else {
  //     throw new UnsupportedError('Unsupported platform');
  //   }
  // }

  // static String get rewardedAdUnitId {
  //   if (Platform.isAndroid) {
  //     return 'ca-app-pub-3940256099942544/5224354917';
  //   } else if (Platform.isIOS) {
  //     return 'ca-app-pub-3940256099942544/1712485313';
  //   } else {
  //     throw new UnsupportedError('Unsupported platform');
  //   }
  // }

  static String get homeBannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6594029392934386/4419548624';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-6594029392934386/2416201817';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get calendarBannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6594029392934386/2143904923';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-6594029392934386/6818481257';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get statisticsBannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6594029392934386/2750409580';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-6594029392934386/2879236244';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get noSmokingBannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6594029392934386/8106596861';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-6594029392934386/9678203991';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get settingBannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6594029392934386/2086971663';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-6594029392934386/7376803274';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }
}

// Android
// AdMob app ID : ca-app-pub-3940256099942544~3347511713
// Banner : ca-app-pub-3940256099942544/6300978111
// Interstitial : ca-app-pub-3940256099942544/1033173712
// Rewarded : ca-app-pub-3940256099942544/5224354917

// ios
// AdMob app ID : ca-app-pub-3940256099942544~1458002511
// Banner : ca-app-pub-3940256099942544/2934735716
// Interstitial : ca-app-pub-3940256099942544/4411468910
// Rewarded : ca-app-pub-3940256099942544/1712485313
