import 'dart:collection';

import 'package:damta/data/datasource/local_datasource.dart';
import 'package:damta/data/models/smoking_record.dart';

class SmokingRecordRepository {
  final LocalDataSource _localDataSource = LocalDataSource();

  Future<List<SmokingRecord>> getSmokingRecordList() async {
    return _localDataSource.getSmokingRecordList();
  }
  
  Future<void> addSmokingRecord(SmokingRecord smokingRecord) async {
    return _localDataSource.addSmokingRecord(smokingRecord);
  }

  Future<void> modifySmokingRecord(SmokingRecord smokingRecordBeforModify, SmokingRecord smokingRecordAfterModify) async {
    return _localDataSource.modifySmokingRecord(smokingRecordBeforModify, smokingRecordAfterModify);
  }

  Future<void> deleteSmokingRecord(SmokingRecord smokingRecord) async {
    return _localDataSource.deleteSmokingRecord(smokingRecord);
  }

  Future<void> deleteSmokingRecordList() async {
    return _localDataSource.deleteSmokingRecordList();
  }
}