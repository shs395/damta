import 'dart:collection';
import 'package:damta/data/models/smoking_record.dart';
import 'package:damta/data/models/user_info.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

class LocalDataSource {

  Future<List<SmokingRecord>> getSmokingRecordList() async {
    var box = await Hive.openBox<SmokingRecord>('smokingRecords');
    return box.values.toList();
  }

  Future<void> addSmokingRecord(SmokingRecord smokingRecord) async {
    var box = await Hive.openBox<SmokingRecord>('smokingRecords');
    await box.add(smokingRecord);
  }
  
  Future<void> modifySmokingRecord(SmokingRecord smokingRecordBeforeModify, SmokingRecord smokingRecordAfterModify) async {
    var box = await Hive.openBox<SmokingRecord>('smokingRecords');
    box.values.forEach((element) {
      if(element.dateTime == smokingRecordBeforeModify.dateTime) {
        element.dateTime = smokingRecordAfterModify.dateTime;
        element.count = smokingRecordAfterModify.count;
        element.cigarName = smokingRecordAfterModify.cigarName;
      }
    });
  }

  Future<void> deleteSmokingRecord(SmokingRecord smokingRecord) async {
    var box = await Hive.openBox<SmokingRecord>('smokingRecords');
    int _index = 0;
    box.values.forEach((element) {
      if(element.dateTime == smokingRecord.dateTime) {
        box.deleteAt(_index);
      }
      _index++;
    });
  }

  Future<void> deleteSmokingRecordList() async {
    var box = await Hive.openBox<SmokingRecord>('smokingRecords');
    await box.clear();
  }

  Future<UserInfo> getUserInfo() async {
    var box = await Hive.openBox<UserInfo>('userInfo');
    print(box.values);
    print(box.values.runtimeType);
    print(box.values.toList());
    print(box.values.toList().runtimeType);
    if(box.values.isEmpty == true) {
      return UserInfo(false, null);
    } else {
      print(box.values.elementAt(0));
      return box.values.elementAt(0);
    }
  }

  Future<void> modifyUserInfo(UserInfo userInfo) async {
    var box = await Hive.openBox<UserInfo>('userInfo');
    await box.clear();
    await box.add(userInfo);
  }
  
}

