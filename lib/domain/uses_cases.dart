import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/data/repositories.dart';
import 'package:meronpan/domain/use_cases/get_search_use_case.dart';
import 'package:meronpan/domain/use_cases/interfaces/aget_details_use_case.dart';
import 'package:meronpan/domain/use_cases/interfaces/aget_latest.dart';
import 'package:meronpan/domain/use_cases/interfaces/aget_populars.dart';
import 'package:meronpan/domain/use_cases/get_details_use_case.dart';
import 'package:meronpan/domain/use_cases/get_latest.dart';
import 'package:meronpan/domain/use_cases/get_populars.dart';

final getPopularsUseCaseProvider = Provider<AGetPopularsUseCase>((ref) {
  return GetPopularsUseCase(httpRepository: ref.watch(tmoRepositoryProvider));
});

final getLatestUseCaseProvider = Provider<AGetLatestUseCase>((ref) {
  return GetLatestUseCase(httpRepository: ref.watch(tmoRepositoryProvider));
});

final getSearchUseCaseProvider = Provider<GetSearchUseCase>((ref) {
  return GetSearchUseCase(httpRepository: ref.watch(tmoRepositoryProvider));
});

final getDetailsUseCaseProvider = Provider<AGetDetailsUseCase>((ref) {
  return GetDetailsUseCase(httpRepository: ref.watch(tmoRepositoryProvider));
});
