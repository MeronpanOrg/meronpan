import 'package:meronpan/domain/models/mangas_page.dart';

abstract class AGetLatestUseCase {
  Future<MangasPage> getMangas(int page);
}
