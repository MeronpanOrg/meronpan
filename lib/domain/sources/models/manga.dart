import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meronpan/domain/sources/utils/status_enum.dart';

part 'manga.g.dart';

@JsonSerializable()
class Manga {
  String url;
  String title;
  String artist;
  String author;
  String description;
  String genre;
  statusEnum status;
  String thumbnailUrl;
  bool initialized;

  Manga({
    required this.url,
    required this.title,
    this.artist = '',
    this.author = '',
    this.description = '',
    this.genre = '',
    this.status = statusEnum.unknown,
    this.thumbnailUrl = '',
    this.initialized = false,
  });

  void copyFrom(Manga other) {
    if (other.author != '') {
      author = other.author;
    }

    if (other.artist != '') {
      artist = other.artist;
    }

    if (other.description != '') {
      description = other.description;
    }

    if (other.genre != '') {
      genre = other.genre;
    }

    if (other.thumbnailUrl != '') {
      thumbnailUrl = other.thumbnailUrl;
    }

    status = other.status;

    if (!initialized) {
      initialized = other.initialized;
    }
  }

  factory Manga.fromJson(Map<String, dynamic> json) => _$MangaFromJson(json);

  Map<String, dynamic> toJson() => _$MangaToJson(this);
}
