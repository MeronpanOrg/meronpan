import 'package:meronpan/domain/models/manga.dart';

abstract class AGetMangaDetailsUseCase {
  Future getMangaDetails(Manga manga) ;
}