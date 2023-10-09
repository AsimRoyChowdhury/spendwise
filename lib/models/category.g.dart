// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 1;

  @override
  Category read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 101:
        return Category.food;
      case 102:
        return Category.travel;
      case 103:
        return Category.leisure;
      case 104:
        return Category.work;
      case 105:
        return Category.stationary;
      default:
        return Category.food;
    }
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    switch (obj) {
      case Category.food:
        writer.writeByte(101);
        break;
      case Category.travel:
        writer.writeByte(102);
        break;
      case Category.leisure:
        writer.writeByte(103);
        break;
      case Category.work:
        writer.writeByte(104);
        break;
      case Category.stationary:
        writer.writeByte(105);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
