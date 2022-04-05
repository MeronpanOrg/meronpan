import 'package:meronpan/domain/entities/manga_card.dart';
import 'package:meronpan/domain/entities/manga_hive.dart';

class MangaPage extends MangaCard {
  final String description;

  const MangaPage(
      {required String id,
      required String title,
      required String coverPath,
      required String mangaUrl,
      required String sourceName,
      required this.description,
      bool isFavorited = false})
      : super(
          id: id,
          title: title,
          coverPath: coverPath,
          sourceName: sourceName,
          mangaUrl: mangaUrl,
          isFavorited: isFavorited,
        );

  factory MangaPage.fromMangaCard(
      {required MangaCard card, required String description}) {
    return MangaPage(
        id: card.id,
        title: card.title,
        coverPath: card.coverPath,
        mangaUrl: card.mangaUrl,
        sourceName: card.sourceName,
        description: description);
  }
  factory MangaPage.fromMangaHive(
      MangaHive mangaHive) {
    return MangaPage(
        id: mangaHive.id,
        title: mangaHive.title,
        coverPath: mangaHive.coverPath,
        mangaUrl: mangaHive.mangaUrl,
        sourceName: mangaHive.source,
        description: mangaHive.description);
  }
}
