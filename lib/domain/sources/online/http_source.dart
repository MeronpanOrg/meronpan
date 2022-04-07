import 'package:dio/dio.dart';
import 'package:meronpan/domain/sources/models/filter_list.dart';
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

  /// Returns the request for latest manga given the page.
  ///
  /// [page] the page number to retrieve.
  Future<Response> latestUpdatesRequest(int page);

  /// Parses the response from the site and returns a [MangasPage] object.
  ///
  ///  [response] the response from the site.
  Future<MangasPage> latestUpdatesParse(Response response);

  /// Returns  the request for the search manga given the page.
  ///
  /// [page] the page number to retrieve.
  /// [query] the search query.
  /// [filters] the list of filters to apply.
  Future<Response> searchMangaRequest(
      int page, String query, FilterList filters);

  ///
  /// Parses the response from the site and returns a [MangasPage] object.
  ///
  /// [response] the response from the site.
  Future<MangasPage> searchMangaParse(Response response);
}
