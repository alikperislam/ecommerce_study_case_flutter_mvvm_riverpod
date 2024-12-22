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
      categoryField: fields[1] as CategoryField?,
    );
  }

  @override
  void write(BinaryWriter writer, UserDb obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.categoryField);
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

class CategoryFieldAdapter extends TypeAdapter<CategoryField> {
  @override
  final int typeId = 2;

  @override
  CategoryField read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryField(
      createdDate: fields[0] as DateTime,
      categories: (fields[1] as List).cast<CategoryModelDb>(),
    );
  }

  @override
  void write(BinaryWriter writer, CategoryField obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.createdDate)
      ..writeByte(1)
      ..write(obj.categories);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryFieldAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategoryModelDbAdapter extends TypeAdapter<CategoryModelDb> {
  @override
  final int typeId = 3;

  @override
  CategoryModelDb read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryModelDb(
      categoryName: fields[0] as String,
      products: (fields[1] as List).cast<ProductModelDb>(),
    );
  }

  @override
  void write(BinaryWriter writer, CategoryModelDb obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.categoryName)
      ..writeByte(1)
      ..write(obj.products);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModelDbAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductModelDbAdapter extends TypeAdapter<ProductModelDb> {
  @override
  final int typeId = 4;

  @override
  ProductModelDb read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModelDb(
      id: fields[0] as int,
      name: fields[1] as String,
      author: fields[2] as String,
      description: fields[3] as String,
      cover: fields[4] as String,
      price: fields[5] as double,
      sales: fields[6] as int,
      slug: fields[7] as String,
      likesCount: fields[8] as int,
      url: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModelDb obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.author)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.cover)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.sales)
      ..writeByte(7)
      ..write(obj.slug)
      ..writeByte(8)
      ..write(obj.likesCount)
      ..writeByte(9)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelDbAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
