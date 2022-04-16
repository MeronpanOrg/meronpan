import 'package:meronpan/domain/models/filter_list.dart';
import 'package:meronpan/domain/models/mangas_page.dart';
import 'package:meronpan/domain/repositories/http_repository.dart';
import 'package:meronpan/domain/use_cases/interfaces/aget_search_use_case.dart';

class GetSearchUseCase extends AGetSearchUseCase {
  final HttpSourceRepository httpRepository;

  GetSearchUseCase({required this.httpRepository});

  @override
  Future<MangasPage> getMangas(int page, String query, FilterList filterList) async {
    return await httpRepository.fetchSearchManga(page, query, filterList);
  }


}
