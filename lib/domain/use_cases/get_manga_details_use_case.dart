import 'package:meronpan/domain/repositories/http_repository.dart';
import 'package:meronpan/domain/use_cases/aget_manga_details_use_case.dart';
import 'package:meronpan/domain/models/manga.dart';

class GetMangaDetailsUseCase extends AGetMangaDetailsUseCase {
  final HttpSourceRepository httpRepository;

  GetMangaDetailsUseCase({required this.httpRepository});

  @override
  Future getMangaDetails(Manga manga) async {
    return await httpRepository.fetchMangaDetails(manga);
  }
}
