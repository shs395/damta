import 'dart:collection';

import 'package:damta/data/datasource/local_datasource.dart';
import 'package:damta/data/models/user_info.dart';

class UserInfoRepository {
  final LocalDataSource _localDataSource = LocalDataSource();

  Future<UserInfo> getUserInfo() async {
    return _localDataSource.getUserInfo();
  }

  Future<void> modifyUserInfo(UserInfo userInfo) async {
    return _localDataSource.modifyUserInfo(userInfo);
  }
  
  // Future<void> addSmokingRecord(SmokingRecord smokingRecord) async {
  //   return _localDataSource.addSmokingRecord(smokingRecord);
  // }

  // Future<void> deleteSmokingRecordList() async {
  //   return _localDataSource.deleteSmokingRecordList();
  // }
}