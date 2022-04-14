import 'package:meronpan/domain/models/mangas_page.dart';

abstract class AGetMangasUseCase {
  Future<MangasPage> getMangas(int page) ;
}