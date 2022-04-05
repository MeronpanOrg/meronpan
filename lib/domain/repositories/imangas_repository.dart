import 'package:meronpan/domain/entities/manga_card.dart';

abstract class IMangasRepository {
  Future<List<MangaCard>> popularMangaRequest(int page);
  Future<List<MangaCard>> latestUpdatesRequest(int page);
  Future<List<MangaCard>> searchMangaRequest(int page);
}
