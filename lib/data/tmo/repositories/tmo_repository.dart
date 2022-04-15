import 'package:dio/dio.dart';
import 'package:meronpan/data/tmo/remote/data_sources/tmo_source.dart';
import 'package:meronpan/domain/models/manga_details.dart';
import 'package:meronpan/domain/models/mangas_page.dart';
import 'package:meronpan/domain/models/manga.dart';
import 'package:meronpan/domain/models/filter_list.dart';
import 'package:meronpan/domain/repositories/itmo_repository.dart';

class TmoRepository extends ITmoRepository {
  final TmoSource source;

  @override
  String get id => '$baseUrl/$lang/$versionId';

  TmoRepository(this.source);

  @override
  Future<MangasPage> fetchPopularManga(int page) async {
    late MangasPage mangasPage;
    try {
      final res = await source.popularMangaRequest(page);
      mangasPage = await source.popularMangaParse(res);
    } on DioError catch (_) {
      return MangasPage([], false);
    }
    return mangasPage;
  }

  @override
  Future<MangasPage> fetchLatestUpdates(int page) async {
    late MangasPage mangasPage;
    try {
      final res = await source.latestUpdatesRequest(page);
      mangasPage = await source.latestUpdatesParse(res);
    } on DioError catch (_) {
      return MangasPage([], false);
    }
    return mangasPage;
  }

  @override
  Future<MangaDetails> fetchMangaDetails(Manga manga) async {
    late MangaDetails mangaDetails;
    try {
      final res = await source.mangaDetailsRequest(manga);
      final mangaParsed = await source.mangaDetailsParse(res);
      final chapters = await source.chapterListParse(res, true);

      mangaDetails = MangaDetails(manga: mangaParsed, chapters: chapters);
    } on DioError catch (_) {
      return MangaDetails(manga: manga, chapters: []);
    }
    return mangaDetails;
  }

  @override
  Future<MangasPage> fetchSearchManga(
      int page, String query, FilterList filterList) async {
    late MangasPage mangasPage;
    try {
      final res = await source.searchMangaRequest(page, query, filterList);
      mangasPage = await source.popularMangaParse(res);
    } on DioError catch (_) {
      return MangasPage([], false);
    }
    return mangasPage;
  }
}
