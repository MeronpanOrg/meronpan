import 'package:meronpan/domain/models/mangas_page.dart';
import 'package:meronpan/domain/models/manga.dart';
import 'package:meronpan/domain/models/filter_list.dart';
import 'package:meronpan/domain/models/chapter.dart';
import 'package:meronpan/domain/repositories/local_repository.dart';

class HiveRepository extends LocalSourceRepository {
  int versionId = 1;
  @override
  String get name => 'Local';

  @override
  String get id => 'local/$versionId';

  @override
  Future<MangasPage> getFavoritesMangas() {
    // TODO: implement fetchFavoritesMangas
    throw UnimplementedError();
  }

  @override
  Future<MangasPage> getMangaDetails(Manga manga) {
    // TODO: implement fetchMangaDetails
    throw UnimplementedError();
  }

  @override
  Future<MangasPage> getSearchManga(
      int page, String query, FilterList filterList) {
    // TODO: implement fetchSearchManga
    throw UnimplementedError();
  }

  @override
  Future saveChapters(List<Chapter> chapters) {
    // TODO: implement saveChapters
    throw UnimplementedError();
  }

  @override
  Future saveManga(Manga manga) {
    // TODO: implement saveManga
    throw UnimplementedError();
  }
}
