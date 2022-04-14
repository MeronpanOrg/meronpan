import 'package:dio/dio.dart';
import 'package:meronpan/data/tmo/remote/data_sources/tmo_source.dart';
import 'package:meronpan/domain/models/mangas_page.dart';
import 'package:meronpan/domain/models/manga.dart';
import 'package:meronpan/domain/models/filter_list.dart';
import 'package:meronpan/domain/models/chapter.dart';

import 'package:meronpan/domain/repositories/itmo_repository.dart';

class TmoRepository extends ITmoRepository {
  final TmoSource source;

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
  Future<MangasPage> fetchMangaDetails(Manga manga) {
    // TODO: implement fetchMangaDetails
    throw UnimplementedError();
  }

  @override
  Future<MangasPage> fetchSearchManga(
      int page, String query, FilterList filterList) {
    // TODO: implement fetchSearchManga
    throw UnimplementedError();
  }

  @override
  // TODO: implement id
  String get id => throw UnimplementedError();
}
