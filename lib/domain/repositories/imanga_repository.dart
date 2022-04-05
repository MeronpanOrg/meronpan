import 'package:meronpan/domain/entities/chapter_hive.dart';
import 'package:meronpan/domain/entities/manga_card.dart';
import 'package:meronpan/domain/entities/manga_page.dart';

abstract class IMangaRepository {
  Future<MangaPage> getManga(MangaCard mangaCard);
  Future<ChapterHive> getChapters(MangaCard mangaCar);
}
