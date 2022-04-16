import 'package:meronpan/domain/models/mangas_page.dart';
import 'package:meronpan/domain/repositories/http_repository.dart';
import 'package:meronpan/domain/use_cases/interfaces/aget_populars.dart';

class GetPopularsUseCase extends AGetPopularsUseCase {
  final HttpSourceRepository httpRepository;

  GetPopularsUseCase({required this.httpRepository});

  @override
  Future<MangasPage> getMangas(int page) async {
    return await httpRepository.fetchPopularManga(page);
  }
}
