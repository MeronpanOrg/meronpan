import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/domain/entities/manga_hive.dart';
import 'package:meronpan/domain/entities/manga_page.dart';
import 'package:meronpan/domain/repositories/ifavoritebox_repository.dart';
import 'package:meronpan/ui/providers/services/favorites_hive_provider.dart';

class FavoriteRepository extends IFavoriteBoxRepository {
  Reader read;
  Box<MangaHive> box;

  FavoriteRepository(this.read) : box = read(favoritesHiveProvider);

  @override
  Future<int> saveManga(MangaPage manga) async {

    return box.add(MangaHive.fromMangaPage(manga));
  }

  @override
  MangaHive? getMangaAt(int index) {
    return box.getAt(index);
  }

  @override
  MangaHive? getMangaByUniqueId(String uniqueId) {
    if (box.isNotEmpty) {
      final mangas = box.values.toList();
      if (mangas.any((element) => element.uniqueId == uniqueId)) {
        final manga =
            mangas.firstWhere((element) => element.uniqueId == uniqueId);

        return manga;
      }
    }
    return null;
  }

  @override
  Future updateManga(MangaHive manga) async {
    if (manga.isInBox) {
      manga.save();
    }
  }

  @override
  bool deleteManga(MangaHive manga) {
    if (manga.isInBox) {
      manga.delete();
      return true;
    } else {
      final mangas = box.values.toList();
      if (mangas.any((element) => element.uniqueId == manga.uniqueId)) {
        final m =
            mangas.firstWhere((element) => element.uniqueId == manga.uniqueId);

        m.delete();
        return true;
      }
    }
    return false;
  }

  MangaHive? find(MangaHive manga) {
    if (box.isNotEmpty) {
      final mangas = box.values.toList();
      if (mangas.any((element) => element.uniqueId == manga.uniqueId)) {
        final m =
            mangas.firstWhere((element) => element.uniqueId == manga.uniqueId);

        return m;
      }
    }
    return null;
  }

  @override
  bool isFavorited(String uniqueId) {
    final manga = getMangaByUniqueId(uniqueId);
    if (manga != null) {
      return true;
    }
    return false;
  }

  @override
  List<MangaHive> getMangas() {
    return box.values.toList();
  }
}
