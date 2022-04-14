import 'package:dio/src/dio.dart';
import 'package:dio/src/response.dart';
import 'package:meronpan/domain/repositories/http_repository.dart';
import 'package:meronpan/domain/sources/models/chapter.dart';
import 'package:meronpan/domain/sources/models/filter_list.dart';
import 'package:meronpan/domain/sources/models/manga.dart';
import 'package:meronpan/domain/sources/models/mangas_page.dart';

abstract class ITmoRepository implements HttpSourceRepository {
  @override
  // TODO: implement baseUrl
  String get baseUrl => throw UnimplementedError();

  @override
  Future<List<Chapter>> chapterListParse(Response response) {
    // TODO: implement chapterListParse
    throw UnimplementedError();
  }

  @override
  // TODO: implement client
  Dio get client => throw UnimplementedError();

  @override
  Future<MangasPage?> fetchLatestUpdates(int page) {
    // TODO: implement fetchLatestUpdates
    throw UnimplementedError();
  }

  @override
  Future<MangasPage?> fetchMangaDetails(Manga manga) {
    // TODO: implement fetchMangaDetails
    throw UnimplementedError();
  }

  @override
  Future<MangasPage?> fetchPopularManga(int page) {
    // TODO: implement fetchPopularManga
    throw UnimplementedError();
  }

  @override
  Future<MangasPage?> fetchSearchManga(int page, String query, FilterList filterList) {
    // TODO: implement fetchSearchManga
    throw UnimplementedError();
  }

  @override
  // TODO: implement icon
  String get icon => throw UnimplementedError();

  @override
  // TODO: implement lang
  String get lang => throw UnimplementedError();

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
  // TODO: implement name
  String get name => throw UnimplementedError();

  @override
  Future<MangasPage> popularMangaParse(Response response) {
    // TODO: implement popularMangaParse
    throw UnimplementedError();
  }

  @override
  Future<Response> popularMangaRequest(int page) {
    // TODO: implement popularMangaRequest
    throw UnimplementedError();
  }

  @override
  Future<MangasPage> searchMangaParse(Response response) {
    // TODO: implement searchMangaParse
    throw UnimplementedError();
  }

  @override
  Future<Response> searchMangaRequest(int page, String query, FilterList filters) {
    // TODO: implement searchMangaRequest
    throw UnimplementedError();
  }

  @override
  // TODO: implement versionId
  int get versionId => throw UnimplementedError();

}