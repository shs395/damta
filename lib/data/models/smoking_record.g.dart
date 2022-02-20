// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smoking_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SmokingRecordAdapter extends TypeAdapter<SmokingRecord> {
  @override
  final int typeId = 1;

  @override
  SmokingRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SmokingRecord(
      fields[0] as DateTime,
      fields[1] as int,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SmokingRecord obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.dateTime)
      ..writeByte(1)
      ..write(obj.count)
      ..writeByte(2)
      ..write(obj.cigarName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SmokingRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
