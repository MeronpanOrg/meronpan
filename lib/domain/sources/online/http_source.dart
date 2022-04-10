import 'package:dio/dio.dart';
import 'package:meronpan/domain/sources/models/filter_list.dart';
import 'package:meronpan/domain/sources/models/manga.dart';
import 'package:meronpan/domain/sources/models/mangas_page.dart';

import '../source.dart';

abstract class HttpSource implements Source {
  String get baseUrl;
  int get versionId;
  Dio get client;

  @override
  String get id => '$baseUrl/$lang/$versionId';

  /// Returns the request for the popular manga given the page.
  ///
  /// [page] the page number to retrieve.
  Future<Response> popularMangaRequest(int page);

  ///
  /// Parses the response from the site and returns a [MangasPage] object.
  ///
  /// [response] the response from the site.
  Future<MangasPage> popularMangaParse(Response response);

  /// Return a page with a list of manga
  ///
  /// [page] the page number to retrieve.
  Future<MangasPage?> fetchPopularManga(int page);

  /// Returns the request for latest manga given the page.
  ///
  /// [page] the page number to retrieve.
  Future<Response> latestUpdatesRequest(int page);

  /// Parses the response from the site and returns a [MangasPage] object.
  ///
  ///  [response] the response from the site.
  Future<MangasPage> latestUpdatesParse(Response response);

  /// Return a page with a list of manga
  ///
  /// [page] the page number to retrieve.
  Future<MangasPage?> fetchLatestUpdates(int page);

  /// Returns  the request for the search manga given the page.
  ///
  /// [page] the page number to retrieve.
  /// [query] the search query.
  /// [filters] the list of filters to apply.
  Future<Response> searchMangaRequest(
      int page, String query, FilterList filters);

  /// Parses the response from the site and returns a [MangasPage] object.
  ///
  /// [response] the response from the site.
  Future<MangasPage> searchMangaParse(Response response);

  /// Return a page with a list of manga
  ///
  /// [page] the page number to retrieve.
  /// [query] the search query.
  /// [filters] the list of filters to apply.
  Future<MangasPage?> fetchSearchManga(
      int page, String query, FilterList filterList);

  /// Returns the request for the details of a manga. Override only if it's needed to change the
  /// url, send different headers or request method like POST.
  ///
  /// [manga] the manga to be updated.
  Future<Response> mangaDetailsRequest(Manga manga);

  /// Parses the response from the site and returns the details of a manga.
  ///
  /// [response] the response from the site.
  Future<Manga> mangaDetailsParse(Response response);

  /// Return a page with a list of manga
  ///
  /// [manga] the manga to be updated.
  Future<MangasPage?> fetchMangaDetails(Manga manga);
}
