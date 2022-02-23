import 'dart:collection';
import 'package:damta/data/models/smoking_record.dart';
import 'package:damta/data/repository/smoking_record_repository.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SmokingRecordListViewModel with ChangeNotifier {
  late final SmokingRecordRepository _smokingRecordRepository;

  LinkedHashMap<DateTime, List<SmokingRecord>> get smokingRecordLinkedHashMap => _smokingRecordLinkedHashMap;
  LinkedHashMap<DateTime, List<SmokingRecord>> _smokingRecordLinkedHashMap = LinkedHashMap<DateTime, List<SmokingRecord>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  
  DateTime? get lastSmokingTime => _lastSmokingTime;
  DateTime? _lastSmokingTime = null;

  SmokingRecordListViewModel() {
    _smokingRecordRepository = SmokingRecordRepository();
    updateSmokingRecordLinkedHashMap();
    getLastSmokingTime();
    notifyListeners();
  }

  Future<void> updateSmokingRecordLinkedHashMap() async {
    List<SmokingRecord> _smokingRecordList = await getSmokingRecordList();
    await makeLinkedHashMap(_smokingRecordList);
    return;
    // notifyListeners();
  }

  Future<List<SmokingRecord>> getSmokingRecordList() async {
    return await _smokingRecordRepository.getSmokingRecordList();
  }

  Future<void> makeLinkedHashMap(List<SmokingRecord> smokingRecordList) async {
    _smokingRecordLinkedHashMap.clear();
    smokingRecordList.forEach((element) {
      addValueToMap(_smokingRecordLinkedHashMap, element.dateTime, element);
    });
    notifyListeners();
    return;
  }

  void addSmokingRecord(SmokingRecord smokingRecord) async {
    await _smokingRecordRepository.addSmokingRecord(smokingRecord);
    updateSmokingRecordLinkedHashMap();
    getLastSmokingTime();
    notifyListeners();
  }

  void modifySmokingRecord(SmokingRecord smokingRecordBeforModify, SmokingRecord smokingRecordAfterModify) async {
    await _smokingRecordRepository.modifySmokingRecord(smokingRecordBeforModify, smokingRecordAfterModify);
    updateSmokingRecordLinkedHashMap();
    getLastSmokingTime();
    notifyListeners();
  }

  // 기록 한 개 삭제
  void deleteSmokingRecord(SmokingRecord smokingRecord) async {
    await _smokingRecordRepository.deleteSmokingRecord(smokingRecord);
    updateSmokingRecordLinkedHashMap();
    getLastSmokingTime();
    notifyListeners();
  }

  //리스트 전체 삭제
  void deleteSmokingRecordList() async {
    await _smokingRecordRepository.deleteSmokingRecordList();
    updateSmokingRecordLinkedHashMap();
    getLastSmokingTime();
    notifyListeners();
  }

  DateTime getFirstDayInSmokingRecordLinkedHashMap() {
    dynamic max = _smokingRecordLinkedHashMap.keys.first;
    _smokingRecordLinkedHashMap.keys.forEach((element) {
      Duration diff = max.difference(element);
      if(diff.isNegative == false) max = element;
    });
    return max;
  }

  DateTime getLastDayInSmokingRecordLinkedHashMap() {
    dynamic max = _smokingRecordLinkedHashMap.keys.first;
    _smokingRecordLinkedHashMap.keys.forEach((element) {
      Duration diff = max.difference(element);
      if(diff.isNegative == true) max = element;
    });
    return max;
  }

  int? getTodaySmokingCount() {
    print(_smokingRecordLinkedHashMap[DateTime.now()]?.length);
    if(_smokingRecordLinkedHashMap[DateTime.now()]?.length == null) {
      return 0;
    } else {
      return _smokingRecordLinkedHashMap[DateTime.now()]?.length;
    }
  }

  int getSmokingCount(DateTime dateTime) {
    if(_smokingRecordLinkedHashMap[dateTime]?.length == null) {
      return 0;
    } else {
      int count = 0;
      _smokingRecordLinkedHashMap[dateTime]?.forEach((element) { 
        count = count + element.count;
      });
      return count;
    }
  }

  Future<void> getLastSmokingTime() async {
    List<SmokingRecord> _smokingRecordList = await getSmokingRecordList();
    _lastSmokingTime = null;
    late DateTime tempLastSmokingTime;
    print(_smokingRecordList);
    if(_smokingRecordList.length != 0) {
      print(_smokingRecordList);
      tempLastSmokingTime = _smokingRecordList[0].dateTime;
      _smokingRecordList.forEach((element) {
        if(tempLastSmokingTime.difference(element.dateTime).isNegative == true) {
          tempLastSmokingTime = element.dateTime;
          _lastSmokingTime = element.dateTime;
        } else if(tempLastSmokingTime == element.dateTime) {
          _lastSmokingTime = element.dateTime;
        }
      });
    }
    notifyListeners();
  }

  List<SmokingRecord> getSmokingRecordsForDay(DateTime day) {
    return _smokingRecordLinkedHashMap[day] ?? [];
  }
}

void addValueToMap<K, V>(Map<K, List<V>> map, K key, V value) =>
  map.update(key, (list) => list..add(value), ifAbsent: () => [value]);

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final calendarToday = DateTime.now();
final calendarFirstDay = DateTime(2010, 1, 1);
final calendarLastDay = DateTime(2050, 1, 1);