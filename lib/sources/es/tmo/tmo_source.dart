import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;
import 'package:meronpan/core/config/preferences/preferences_keys.dart';
import 'package:meronpan/core/config/preferences/preferences_provider.dart';
import 'package:meronpan/domain/sources/models/chapter.dart';
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
      final res = await latestUpdatesRequest(page);
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

    final title =
        document.querySelector('h2.element-subtitle')?.text ?? ' Sin titulo';

    final list = document.querySelectorAll('h5.card-title');

    String author = 'Sin autor';
    String artist = 'Sin artista';

    if (list.isNotEmpty) {
      author = list[0].attributes['title']?.replaceAll(',', '') ?? 'Sin autor';

      if (list.length > 1) {
        artist =
            list[1].attributes['title']?.replaceAll(',', '') ?? 'Sin artista';
      }
    }

    final description = document.querySelector('p.element-description')?.text ??
        'Sin descripcion';

    final status =
        parseStatus(document.querySelector('span.book-status')?.text ?? '');
    final thumbnailUrl =
        document.querySelector('.book-thumbnail')?.attributes['src'] ?? '';

    return Manga(
        title: title,
        url: response.requestOptions.path,
        description: description,
        author: author,
        artist: artist,
        status: status,
        thumbnailUrl: thumbnailUrl);
  }

  String get _oneShotChapterListSelector => 'li.list-group-item';
  String get _regularChapterListSelector => 'li.p-0.list-group-item';

  Chapter oneShotChapterFromElement(Element element) {
    final url =
        element.querySelector('div.row > .text-right > a')?.attributes['href'];
    const name = 'One Shot';
    final scanlator =
        element.querySelector('div.col-md-6.text-truncate')?.text.trim();

    return Chapter(
        url: url!,
        name: name,
        dateUpload: 1,
        chapterNumber: 1,
        scanlator: scanlator!);
  }

  Chapter regularChapterFromElement(
      Element element, String chName, String number) {
    final url = element
            .querySelector('div.row > .text-right > a')
            ?.attributes['href'] ??
        '';
    final name = chName;
    final chapterNumber = double.parse(number);
    final scanlator =
        element.querySelector('div.col-md-6.text-truncate')?.text.trim() ?? '';
    final dateUpload =
        element.querySelector('span.badge.badge-primary.p-2')?.text;

    return Chapter(
        url: url,
        name: name,
        dateUpload: 1,
        chapterNumber: chapterNumber,
        scanlator: scanlator);
  }

  @override
  Future<List<Chapter>> chapterListParse(Response response) async {
    final document = parse(response.data);

    // One-shot
    if (document.querySelectorAll('div.chapters').isEmpty) {
      return document
          .querySelectorAll(_oneShotChapterListSelector)
          .map((e) => oneShotChapterFromElement(e))
          .toList();
    }

    List<Chapter> chapters = [];

    document.querySelectorAll(_regularChapterListSelector).forEach((element) {
      final chapternumber =
          element.querySelector('a.btn-collapse')?.text ?? 'SN';
      String num = '';
      if (chapternumber.contains(':')) {
        final end = chapternumber.indexOf(':');
        final t = chapternumber.substring(0, end);
        num = t.substring(t.indexOf('o') + 1).trim();
      } else {
        num = chapternumber.substring(chapternumber.indexOf('o') + 1).trim();
      }

      final name =
          element.querySelector('div.col-10.text-truncate')?.text.trim() ??
              'Sin nombre';

      var translators = element.querySelectorAll('ul.chapter-list > li');

      if (read(preferencesProvider).get(PreferencesKeys.showAllScans)) {
        var scans = translators
            .map((e) => regularChapterFromElement(e, name, num))
            .toList();
        chapters.addAll(scans);
      } else {
        var scan = regularChapterFromElement(translators.first, name, num);
        chapters.add(scan);
      }
    });
    return chapters;
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
