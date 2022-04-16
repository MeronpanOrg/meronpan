import 'package:meronpan/domain/models/mangas_page.dart';

abstract class AGetPopularsUseCase {
  Future<MangasPage> getMangas(int page) ;
}