import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/domain/entities/chapter_hive.dart';
import 'package:meronpan/domain/entities/manga_card.dart';
import 'package:meronpan/domain/entities/manga_page.dart';
import 'package:meronpan/domain/repositories/imanga_repository.dart';
import 'package:meronpan/sources/es/tmo/data/services/manga_service.dart';
import 'package:meronpan/ui/providers/repositories/chapters_repository.dart';
import 'package:meronpan/ui/providers/repositories/favorite_repository_provider.dart';

class TmoMangaRepository implements IMangaRepository {
  Reader read;
  final _mangaService = MangaService();

  TmoMangaRepository(this.read);

  @override
  Future<MangaPage> getManga(MangaCard mangaCard) async {
    final manga =
        read(favoriteRepositoryProvider).getMangaByUniqueId(mangaCard.uniqueId);

    if (manga != null) {
      return manga.toMangaPage();
    }

    return await _mangaService.getMangaPage(mangaCard);
  }

  @override
  Future<ChapterHive> getChapters(MangaCard mangaCard) async {
    final chapters = read(chaptersRepositoyProvider)
        .getChaptersByUniqueId(mangaCard.uniqueId);

    if (chapters != null) {
      return chapters;
    }

    final data = await _mangaService.getMangaChapters(mangaCard);

    read(chaptersRepositoyProvider).saveChapters(data);

    return data;
  }
}
