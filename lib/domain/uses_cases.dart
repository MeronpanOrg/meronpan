import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/data/repositories.dart';
import 'package:meronpan/domain/use_cases/aget_manga_details_use_case.dart';
import 'package:meronpan/domain/use_cases/aget_mangas.dart';
import 'package:meronpan/domain/use_cases/get_manga_details_use_case.dart';
import 'package:meronpan/domain/use_cases/get_mangas.dart';

final getMangasUseCaseProvider = Provider<AGetMangasUseCase>((ref) {
  return GetMangasUseCase(httpRepository: ref.watch(tmoRepositoryProvider));
});
final getMangasDetailsUseCaseProvider = Provider<AGetMangaDetailsUseCase>((ref) {
  return GetMangaDetailsUseCase(httpRepository: ref.watch(tmoRepositoryProvider));
});
