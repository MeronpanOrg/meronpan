// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChapterHiveAdapter extends TypeAdapter<ChapterHive> {
  @override
  final int typeId = 1;

  @override
  ChapterHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChapterHive(
      mangaUniqueId: fields[0] as String,
      chapters: (fields[1] as Map).cast<String, String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ChapterHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.mangaUniqueId)
      ..writeByte(1)
      ..write(obj.chapters);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChapterHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
