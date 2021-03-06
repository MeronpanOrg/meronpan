import 'package:meronpan/domain/models/manga_details.dart';
import 'package:meronpan/domain/repositories/http_repository.dart';
import 'package:meronpan/domain/use_cases/interfaces/aget_details_use_case.dart';
import 'package:meronpan/domain/models/manga.dart';

class GetDetailsUseCase extends AGetDetailsUseCase {
  final HttpSourceRepository httpRepository;

  GetDetailsUseCase({required this.httpRepository});

  @override
  Future<MangaDetails> getMangaDetails(Manga manga) async {
    return await httpRepository.fetchMangaDetails(manga);
  }
}
