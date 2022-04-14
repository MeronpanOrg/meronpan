import 'package:meronpan/domain/models/mangas_page.dart';
import 'package:meronpan/domain/repositories/http_repository.dart';
import 'package:meronpan/domain/use_cases/aget_mangas.dart';

class GetMangasUseCase extends AGetMangasUseCase {
  final HttpSourceRepository httpRepository;

  GetMangasUseCase({required this.httpRepository});

  @override
  Future<MangasPage> getMangas(int page) async {
    return await httpRepository.fetchPopularManga(page);
  }
}
