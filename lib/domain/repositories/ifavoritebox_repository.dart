import 'package:meronpan/domain/entities/manga_hive.dart';
import 'package:meronpan/domain/entities/manga_page.dart';

abstract class IFavoriteBoxRepository {
  Future<int> saveManga(MangaPage manga);
  MangaHive? getMangaAt(int index);
  MangaHive? getMangaByUniqueId(String uniqueId);
  List<MangaHive> getMangas();
  Future updateManga(MangaHive manga);
  bool deleteManga(MangaHive manga);
  bool isFavorited(String uniqueId);
}
