import 'package:hive/hive.dart';

part 'smoking_record.g.dart';

@HiveType(typeId : 1)
class SmokingRecord {
  @HiveField(0)
  late DateTime dateTime;

  @HiveField(1)
  late int count;

  @HiveField(2)
  late String cigarName;

  SmokingRecord(DateTime dateTime, int count, String cigarName) {
    this.dateTime = dateTime;
    this.count = count;
    this.cigarName = cigarName;
  }
  // const SmokingRecord(this.dateTime, this.count, this.cigarName);

  // @override
  // String toString() => cigarName;
}
