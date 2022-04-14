import 'package:meronpan/domain/sources/models/manga.dart';

abstract class AGetMangaDetailsUseCase {
  Future getMangaDetails(Manga manga) ;
}