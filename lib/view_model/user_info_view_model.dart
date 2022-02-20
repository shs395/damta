import 'package:damta/data/models/user_info.dart';
import 'package:damta/data/repository/user_info_repository.dart';
import 'package:flutter/material.dart';

class UserInfoViewModel with ChangeNotifier {
  late final UserInfoRepository _userInfoRepository;

  UserInfo _userInfo = UserInfo(false, null);
  // late UserInfo _userInfo;

  UserInfo get userInfo => _userInfo;

  UserInfoViewModel() {
    _userInfoRepository = UserInfoRepository();
    getUserInfo();
    // notifyListeners();
  }

  void getUserInfo() async {
    _userInfo = await _userInfoRepository.getUserInfo();
    notifyListeners();
  }

  void modifyUserInfo(UserInfo userInfo) async {
    await _userInfoRepository.modifyUserInfo(userInfo);
    getUserInfo();
    notifyListeners();
  }

  void startStopSmoking() {
    if(_userInfo.isStopSmoking == false) {
      _userInfo.isStopSmoking = true;
      _userInfo.startStopSmokingDate = DateTime.now();
      modifyUserInfo(_userInfo);
    }
  }

  void endStopSmoking() {
    if(_userInfo.isStopSmoking == true) {
      _userInfo.isStopSmoking = false;
      _userInfo.startStopSmokingDate = null;
      modifyUserInfo(_userInfo);
    }
  }


}