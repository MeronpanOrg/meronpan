import 'package:meronpan/domain/models/manga.dart';

abstract class AGetDetailsUseCase {
  Future getMangaDetails(Manga manga) ;
}