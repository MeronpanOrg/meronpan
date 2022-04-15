// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Manga _$MangaFromJson(Map<String, dynamic> json) => Manga(
      url: json['url'] as String,
      title: json['title'] as String,
      artist: json['artist'] as String? ?? '',
      author: json['author'] as String? ?? '',
      description: json['description'] as String? ?? '',
      genre: json['genre'] as String? ?? '',
      status: $enumDecodeNullable(_$statusEnumEnumMap, json['status']) ??
          statusEnum.unknown,
      thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
      initialized: json['initialized'] as bool? ?? false,
    );

Map<String, dynamic> _$MangaToJson(Manga instance) => <String, dynamic>{
      'url': instance.url,
      'title': instance.title,
      'artist': instance.artist,
      'author': instance.author,
      'description': instance.description,
      'genre': instance.genre,
      'status': _$statusEnumEnumMap[instance.status],
      'thumbnailUrl': instance.thumbnailUrl,
      'initialized': instance.initialized,
    };

const _$statusEnumEnumMap = {
  statusEnum.unknown: 0,
  statusEnum.ongoing: 1,
  statusEnum.completed: 2,
  statusEnum.licensed: 3,
  statusEnum.publishingFinished: 4,
  statusEnum.cancelled: 5,
  statusEnum.onHiatus: 6,
};
