// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserHiveDbAdapter extends TypeAdapter<UserHiveDb> {
  @override
  final int typeId = 0;

  @override
  UserHiveDb read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserHiveDb(
      currentUser: fields[0] as bool,
      user: fields[1] as UserDb,
    );
  }

  @override
  void write(BinaryWriter writer, UserHiveDb obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.currentUser)
      ..writeByte(1)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserHiveDbAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserDbAdapter extends TypeAdapter<UserDb> {
  @override
  final int typeId = 1;

  @override
  UserDb read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDb(
      token: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserDb obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDbAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
