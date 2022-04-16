import 'package:meronpan/domain/models/mangas_page.dart';
import 'package:meronpan/domain/repositories/http_repository.dart';
import 'package:meronpan/domain/use_cases/interfaces/aget_latest.dart';

class GetLatestUseCase extends AGetLatestUseCase {
  final HttpSourceRepository httpRepository;

  GetLatestUseCase({required this.httpRepository});

  @override
  Future<MangasPage> getMangas(int page) async {
    return await httpRepository.fetchLatestUpdates(page);
  }
}
