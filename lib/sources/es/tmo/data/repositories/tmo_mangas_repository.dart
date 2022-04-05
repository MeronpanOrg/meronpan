import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/domain/entities/manga_card.dart';
import 'package:meronpan/domain/repositories/imangas_repository.dart';
import 'package:meronpan/sources/es/tmo/data/request/tu_manga_online.dart';
import 'package:meronpan/ui/providers/services/settings_box_provider.dart';
import 'package:web_scraper/web_scraper.dart';

class TMOMangasRepository implements IMangasRepository {
  final WebScraper _webScraper;
  Reader read;

  TMOMangasRepository(this.read)
      : _webScraper = WebScraper('https://lectortmo.com');

  @override
  Future<List<MangaCard>> latestUpdatesRequest(int page) {
    // TODO: implement latestUpdatesRequest
    throw UnimplementedError();
  }

  @override
  Future<List<MangaCard>> popularMangaRequest(int page) async {
    final settingsbox = read(settingsBoxProvider);
    final adultContent =
        settingsbox.get('adultContent')?.compareTo('true') == 0;

    if (await _webScraper
        .loadWebPage(TuMangaOnline(pg: page.toString()).popularMangaRequest(adultContent))) {
      List<Map<String, dynamic>> ids =
          _webScraper.getElement('div.element ', ['data-identifier']);
      List<Map<String, dynamic>> titles =
          _webScraper.getElement('div.element h4', ['title']);
      List<Map<String, dynamic>> covers =
          _webScraper.getElement('div.element style', ['']);
      List<Map<String, dynamic>> links =
          _webScraper.getElement('div.element a', ['href']);

      final List<MangaCard> mangas = [];

      for (int i = 0; i < ids.length; i++) {
        final id = ids[i]['attributes']['data-identifier'];
        final title = titles[i]['title'];
        final coverPath = covers[i]['title'].toString().trim().split('\'')[1];
        final url = links[i]['attributes']['href'];

        mangas.add(MangaCard(
            id: id,
            title: title,
            coverPath: coverPath,
            mangaUrl: url,
            sourceName: 'tmo'));
      }

      return mangas;
    }

    return [];
  }

  @override
  Future<List<MangaCard>> searchMangaRequest(int page) {
    // TODO: implement searchMangaRequest
    throw UnimplementedError();
  }
}
