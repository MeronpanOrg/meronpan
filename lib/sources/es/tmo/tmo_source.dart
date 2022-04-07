import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;
import 'package:meronpan/domain/sources/models/manga.dart';
import 'package:meronpan/domain/sources/models/mangas_page.dart';
import 'package:meronpan/domain/sources/models/filter_list.dart';
import 'package:meronpan/domain/sources/online/http_source.dart';
import 'package:meronpan/sources/es/tmo/filters/tmo_filters.dart';
import 'package:meronpan/domain/sources/models/filter.dart';

class TMOSouce extends HttpSource {
  final Dio _dio = Dio();

  @override
  String get name => 'TuMangaOnline';

  @override
  String get baseUrl => 'https://lectortmo.com';

  @override
  Dio get client => _dio;

  @override
  String get icon => 'https://nakamasweb.com/favicons/tumangaonline.ico';

  @override
  String get lang => 'es';

  String get getSFWUrlPart => true
      ? '&exclude_genders%5B%5D=6&exclude_genders%5B%5D=17&exclude_genders%5B%5D=18&exclude_genders%5B%5D=19&erotic=false'
      : '';

  @override
  Future<Response> popularMangaRequest(int page) async {
    final response = await client.get(
        '$baseUrl/library?order_item=likes_count&order_dir=desc&filter_by=title$getSFWUrlPart&_pg=1&page=$page',
        options: Options(responseType: ResponseType.plain));

    return response;
  }

  @override
  Future<MangasPage> popularMangaParse(Response response) async {
    final document = parse(response.data);

    final mangas = document
        .querySelectorAll('div.element')
        .map((e) => popularMangaFromElement(e))
        .toList();

    final hasNextPage = document.querySelector('a.page-link');

    return MangasPage(mangas, hasNextPage != null);
  }

  @override
  Future<Response> latestUpdatesRequest(int page) async {
    final response = await client.get(
        '$baseUrl/library?order_item=creation&order_dir=desc&filter_by=title$getSFWUrlPart&_pg=1&page=$page',
        options: Options(responseType: ResponseType.plain));

    return response;
  }

  @override
  Future<MangasPage> latestUpdatesParse(Response response) async {
    final document = parse(response.data);

    final mangas = document
        .querySelectorAll('div.element')
        .map((e) => popularMangaFromElement(e))
        .toList();

    final hasNextPage = document.querySelector('a.page-link');

    return MangasPage(mangas, hasNextPage != null);
  }

  @override
  Future<Response> searchMangaRequest(
      int page, String query, FilterList filters) async {
    final Map<String, String> queryParams = {};

    queryParams.addAll({'page': '$page'});
    queryParams.addAll({'_pg': '1'});
    queryParams.addAll({'title': query});

    for (var element in filters.list) {
      if (element is TypeSelection) {
        queryParams.addAll({'type': (element).toUriPart()});
      }
      if (element is DemographySelection) {
        queryParams.addAll({'demography': (element).toUriPart()});
      }
      if (element is StatusSelection) {
        queryParams.addAll({'status': (element).toUriPart()});
      }
      if (element is TranslationStatusSelection) {
        queryParams.addAll({'translation_status': (element).toUriPart()});
      }
      if (element is FilterBySelection) {
        queryParams.addAll(
            {'filter_by': (element as TranslationStatusSelection).toString()});
      }
      if (element is Sort) {
        if (element.state != null) {
          queryParams
              .addAll({'order_item': sortables[element.state!.index].value});
          queryParams
              .addAll({'order_dir': element.state!.ascending ? 'asc' : 'desc'});
        }
      }
      if (element is ContentTypeList) {
        for (var content in element.content) {
          // If (SFW mode is not enabled) OR (SFW mode is enabled AND filter != erotic) -> Apply filter
          // else -> ignore filter
          if (content.id != 'erotic') {
            switch (content.state) {
              case triState.stateIgnore:
                queryParams.addAll({content.id: ''});
                break;
              case triState.stateInclude:
                queryParams.addAll({content.id: 'true'});
                break;
              case triState.stateExclude:
                queryParams.addAll({content.id: 'false'});
                break;
            }
          }
        }
      }
      if (element is GenreList) {
        for (var genre in element.genres) {
          switch (genre.state) {
            case triState.stateIgnore:
              break;
            case triState.stateInclude:
              queryParams.addAll({'genders': genre.id});
              break;
            case triState.stateExclude:
              queryParams.addAll({'exclude_genders': genre.id});
              break;
          }
        }
      }
    }
    final Uri url = Uri.https('lectortmo.com', '/library', queryParams);

    final response = await client.getUri(url);

    return response;
  }

  @override
  Future<MangasPage> searchMangaParse(Response response) async {
    final document = parse(response.data);

    final mangas = document
        .querySelectorAll('div.element')
        .map((e) => popularMangaFromElement(e))
        .toList();

    final hasNextPage = document.querySelector('a.page-link');

    return MangasPage(mangas, hasNextPage != null);
  }

  @override
  int get versionId => 1;

  Manga popularMangaFromElement(Element element) {
    final link = element.querySelector('a');
    final title = element.querySelector('h4.text-truncate');
    final cover = element.querySelector('style');

    final path = cover!.text;

    final start = path.indexOf('(\'') + 1;
    final end = path.indexOf('\')');

    final thumbnailUrl = path.substring(start, end);

    return Manga(
      url: link!.attributes['href']!,
      title: title!.text,
      thumbnailUrl: thumbnailUrl,
    );
  }
}
