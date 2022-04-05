import 'package:meronpan/domain/entities/chapter_hive.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:meronpan/domain/entities/manga_card.dart';
import 'package:meronpan/domain/entities/manga_page.dart';

class MangaService {
  MangaService() : _webScraper = WebScraper('https://lectortmo.com');
  final WebScraper _webScraper;

  Future<MangaPage> getMangaPage(MangaCard manga) async {
    String path = manga.mangaUrl.substring(22);

    if (await _webScraper.loadWebPage(path)) {
      List<Map<String, dynamic>> description =
          _webScraper.getElement('p.element-description', ['']);

      if (description.isNotEmpty) {
        if (description[0].containsKey('title')) {
          final descrition = description[0]['title'];
          return MangaPage.fromMangaCard(card: manga, description: descrition);
        }
      }
    }
    return MangaPage.fromMangaCard(card: manga, description: 'Sin descripcion');
  }

  Future<ChapterHive> getMangaChapters(MangaCard manga) async {
    String path = manga.mangaUrl.substring(22);
    if (await _webScraper.loadWebPage(path)) {
      List<Map<String, dynamic>> chapters = _webScraper.getElement(
          'div.chapters > ul.list-group > li.list-group-item', ['data-index']);
      List<Map<String, dynamic>> chaptersHidden = _webScraper.getElement(
          'div.chapters > ul.list-group > div > li.list-group-item',
          ['data-index']);
      List<Map<String, dynamic>> rawLinks = _webScraper.getElement(
          'li.list-group-item > div.row > div.col-2 > a.btn  ', ['href']);

      List<String> chaps = [];
      List<String> links = [];

      if (chapters.isNotEmpty) {
        final t = chapters.map((e) {
          final s = e['title'].toString().trim().split(' ');
          final num = RegExp(r'[0-9]*\.[0-9]*').firstMatch(s[1])?.group(0);

          return '${s[0]} $num';
        }).toList();
        chaps.addAll(t);
      }
      if (chaptersHidden.isNotEmpty) {
        final t = chaptersHidden.map((e) {
          final s = e['title'].toString().trim().split(' ');
          final num = RegExp(r'[0-9]*\.[0-9]*').firstMatch(s[1])?.group(0);

          return '${s[0]} $num';
        }).toList();
        chaps.addAll(t);
      }

      if (rawLinks.isNotEmpty) {
        for (var element in rawLinks) {
          if (element.containsKey('attributes')) {
            final l = element['attributes']['href'];
            links.add(l);
          }
        }
      }
      Map<String, String> chaptersMap = {};
      for (int i = 0; i < chaps.length; i++) {
        chaptersMap.addEntries({chaps[i]: links[i]}.entries);
      }


      return ChapterHive(
          mangaUniqueId: '${manga.sourceName}+${manga.id}',
          chapters: chaptersMap);
    }
    return ChapterHive(
        mangaUniqueId: '${manga.sourceName}+${manga.id}',
        chapters: <String, String>{});
  }
}
