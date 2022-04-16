import 'package:meronpan/domain/models/chapter.dart';
import 'package:meronpan/domain/repositories/manga_repository.dart';
import 'package:meronpan/domain/models/filter_list.dart';
import 'package:meronpan/domain/models/manga.dart';
import 'package:meronpan/domain/models/mangas_page.dart';

abstract class LocalSourceRepository extends MangaSourceRepository {
  
  /// Return a page with a list of manga
  ///
  /// [page] the page number to retrieve.
  Future<MangasPage> getFavoritesMangas();

  Future saveManga(Manga manga);

  Future saveChapters(List<Chapter> chapters);

  /// Returns  the request for the search manga given the page.
  ///
  /// [page] the page number to retrieve.
  /// [query] the search query.
  /// [filters] the list of filters to apply.
  Future<MangasPage> getSearchManga(
      int page, String query, FilterList filterList);

  Future<MangasPage> getMangaDetails(Manga manga);
}
