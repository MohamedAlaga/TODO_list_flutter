// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatsAdapter extends TypeAdapter<Stats> {
  @override
  final int typeId = 2;

  @override
  Stats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Stats(
      isFirstTime: fields[0] as bool,
      isUserLoggedIn: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Stats obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.isFirstTime)
      ..writeByte(1)
      ..write(obj.isUserLoggedIn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
