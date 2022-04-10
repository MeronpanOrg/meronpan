import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;
import 'package:meronpan/core/config/preferences/preferences_keys.dart';
import 'package:meronpan/core/config/preferences/preferences_provider.dart';
import 'package:meronpan/domain/sources/models/manga.dart';
import 'package:meronpan/domain/sources/models/mangas_page.dart';
import 'package:meronpan/domain/sources/models/filter_list.dart';
import 'package:meronpan/domain/sources/online/http_source.dart';
import 'package:meronpan/domain/sources/utils/status_enum.dart';
import 'package:meronpan/sources/es/tmo/filters/tmo_filters.dart';
import 'package:meronpan/domain/sources/models/filter.dart';

class TMOSource extends HttpSource {
  Reader read;

  TMOSource(this.read);

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

  @override
  int get versionId => 1;

  final sfwGenderId = ['6', '17', '18', '19'];

  bool getSFWMode() {
    return read(preferencesProvider).get(PreferencesKeys.sfw) ?? true;
  }

  String get getSFWUrlPart => !getSFWMode()
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
  Future<MangasPage?> fetchPopularManga(int page) async {
    MangasPage? mangasPage;
    try {
      final res = await popularMangaRequest(page);
      mangasPage = await popularMangaParse(res);
    } on DioError catch (e) {
      print(e.message);
    }
    return mangasPage;
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
  Future<MangasPage?> fetchLatestUpdates(int page) async {
    MangasPage? mangasPage;
    try {
      final res = await latestUpdatesRequest(1);
      mangasPage = await latestUpdatesParse(res);
    } catch (e) {
      print(e);
    }
    return mangasPage;
  }

  @override
  Future<Response> searchMangaRequest(
      int page, String query, FilterList filters) async {
    final Map<String, String> queryParams = {};

    queryParams.addAll({'page': '$page'});
    queryParams.addAll({'_pg': '1'});
    queryParams.addAll({'title': query});

    if (getSFWMode()) {
      for (String element in sfwGenderId) {
        queryParams.addAll({'exlude_gender[]': element});
      }
    }

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
        queryParams.addAll({'filter_by': element.toUriPart()});
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

    print(url.toString());

    final response = await client.getUri(url,
        options: Options(responseType: ResponseType.plain));

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
  Future<MangasPage?> fetchSearchManga(
      int page, String query, FilterList filterList) async {
    MangasPage? mangasPage;
    try {
      final res = await searchMangaRequest(page, query, filterList);
      mangasPage = await searchMangaParse(res);
    } catch (e) {
      print(e);
    }
    return mangasPage;
  }

  Manga popularMangaFromElement(Element element) {
    final link = element.querySelector('a');
    final title = element.querySelector('h4.text-truncate');
    final cover = element.querySelector('style');

    final path = cover!.text;

    final start = path.indexOf('(\'') + 2;
    final end = path.indexOf('\')');

    final thumbnailUrl = path.substring(start, end);

    return Manga(
      url: link!.attributes['href']!.trim(),
      title: title!.text,
      thumbnailUrl: thumbnailUrl,
    );
  }

  @override
  Future<Response> mangaDetailsRequest(Manga manga) async {
    final response = await client.get(manga.url,
        options: Options(responseType: ResponseType.plain));

    return response;
  }

  @override
  Future<Manga> mangaDetailsParse(Response response) async {
    final document = parse(response.data);

    final title = document.querySelector('h2.element-subtitle')?.text;

    final list = document.querySelectorAll('h5.card-title');

    String? author;
    String? artist;

    if (list.isNotEmpty) {
      author = list[0].attributes['title']!.substring(2);

      if (list.length > 1) {
        artist = list[1].attributes['title']!.substring(2);
      }
    }

    final description = document.querySelector('p.element-description')?.text;

    final status =
        parseStatus(document.querySelector('span.book-status')!.text);
    final thumbnailUrl =
        document.querySelector('.book-thumbnail')!.attributes['src'];

    return Manga(
        title: title ?? 'Sin titulo',
        url: response.requestOptions.path,
        description: description ?? 'Sin descripcion',
        author: author ?? 'Sin autor',
        artist: artist ?? 'Sin artista',
        status: status,
        thumbnailUrl: thumbnailUrl!);
  }

  @override
  Future<MangasPage?> fetchMangaDetails(Manga manga) async {
    Manga? details;
    try {
      final res = await mangaDetailsRequest(manga);
      details = await mangaDetailsParse(res);
    } catch (e) {
      print(e);
    }
    return MangasPage([details!], false);
  }

  statusEnum parseStatus(String status) {
    switch (status) {
      case 'Publicándose':
        return statusEnum.ongoing;
      case 'Finalizado':
        return statusEnum.completed;
    }
    return statusEnum.unknown;
  }
}
