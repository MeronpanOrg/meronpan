// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MangaHiveAdapter extends TypeAdapter<MangaHive> {
  @override
  final int typeId = 0;

  @override
  MangaHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MangaHive(
      uniqueId: fields[0] as String,
      id: fields[1] as String,
      title: fields[2] as String,
      coverPath: fields[3] as String,
      mangaUrl: fields[4] as String,
      description: fields[5] as String,
      source: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MangaHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.uniqueId)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.coverPath)
      ..writeByte(4)
      ..write(obj.mangaUrl)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.source);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MangaHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
