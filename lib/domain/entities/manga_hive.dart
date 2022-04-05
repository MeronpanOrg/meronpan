import 'package:hive/hive.dart';
import 'package:meronpan/domain/entities/manga_page.dart';

part 'manga_hive.g.dart';

@HiveType(typeId: 0)
class MangaHive extends HiveObject {
  @HiveField(0)
  final String uniqueId;

  @HiveField(1)
  final String id;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String coverPath;

  @HiveField(4)
  final String mangaUrl;

  @HiveField(5)
  final String description;

  @HiveField(6)
  final String source;

  MangaHive({
    required this.uniqueId,
    required this.id,
    required this.title,
    required this.coverPath,
    required this.mangaUrl,
    required this.description,
    required this.source,
  });

  factory MangaHive.fromMangaPage(MangaPage manga) {
    return MangaHive(
      uniqueId: manga.uniqueId,
      id: manga.id,
      title: manga.title,
      coverPath: manga.coverPath,
      mangaUrl: manga.mangaUrl,
      description: manga.description,
      source: manga.sourceName,
    );
  }
  MangaPage toMangaPage() {
    return MangaPage(
        id: id,
        title: title,
        coverPath: coverPath,
        mangaUrl: mangaUrl,
        sourceName: source,
        description: description);
  }
}
