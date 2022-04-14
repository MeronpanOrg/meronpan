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
  Future<List<Chapter>> chapterListParse(Response response) {
    // TODO: implement chapterListParse
    throw UnimplementedError();
  }

  @override
  // TODO: implement client
  Dio get client => throw UnimplementedError();

  @override
  Future<MangasPage> fetchLatestUpdates(int page) {
    // TODO: implement fetchLatestUpdates
    throw UnimplementedError();
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

  @override
  Future<MangasPage> latestUpdatesParse(Response response) {
    // TODO: implement latestUpdatesParse
    throw UnimplementedError();
  }

  @override
  Future<Response> latestUpdatesRequest(int page) {
    // TODO: implement latestUpdatesRequest
    throw UnimplementedError();
  }

  @override
  Future<Manga> mangaDetailsParse(Response response) {
    // TODO: implement mangaDetailsParse
    throw UnimplementedError();
  }

  @override
  Future<Response> mangaDetailsRequest(Manga manga) {
    // TODO: implement mangaDetailsRequest
    throw UnimplementedError();
  }

  @override
  Future<MangasPage> searchMangaParse(Response response) {
    // TODO: implement searchMangaParse
    throw UnimplementedError();
  }

  @override
  Future<Response> searchMangaRequest(
      int page, String query, FilterList filters) {
    // TODO: implement searchMangaRequest
    throw UnimplementedError();
  }
}
