import 'package:hive/hive.dart';

part 'user_info.g.dart';

@HiveType(typeId : 2)
class UserInfo {
  @HiveField(0)
  late bool isStopSmoking;

  @HiveField(1)
  late DateTime? startStopSmokingDate;

  UserInfo(bool isStopSmoking, DateTime? startStopSmokingDate) {
    this.isStopSmoking = isStopSmoking;
    this.startStopSmokingDate = startStopSmokingDate;
  }
  // const SmokingRecord(this.dateTime, this.count, this.cigarName);

  // @override
  // String toString() => cigarName;
}
