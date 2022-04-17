import 'package:meronpan/domain/models/manga_details.dart';
import 'package:meronpan/domain/repositories/manga_repository.dart';
import 'package:meronpan/domain/models/filter_list.dart';
import 'package:meronpan/domain/models/manga.dart';
import 'package:meronpan/domain/models/mangas_page.dart';

abstract class HttpSourceRepository extends MangaSourceRepository {
  String get baseUrl;
  int get versionId;
  String get lang;

  @override
  String get id => '$baseUrl/$lang/$versionId';

  /// Return a page with a list of manga
  ///
  /// [page] the page number to retrieve.
  Future<MangasPage> fetchPopularManga(int page);

  /// Return a page with a list of manga
  ///
  /// [page] the page number to retrieve.
  Future<MangasPage> fetchLatestUpdates(int page);

  /// Returns  the request for the search manga given the page.
  ///
  /// [page] the page number to retrieve.
  /// [query] the search query.
  /// [filters] the list of filters to apply.

  Future<MangasPage> fetchSearchManga(
      int page, String query, FilterList filterList);

  Future<MangaDetails> fetchMangaDetails(Manga manga);
}
