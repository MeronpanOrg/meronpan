import 'package:meronpan/domain/models/filter_list.dart';
import 'package:meronpan/domain/models/mangas_page.dart';

abstract class AGetSearchUseCase {
  Future<MangasPage> getMangas(int page, String query, FilterList filterList) ;
}