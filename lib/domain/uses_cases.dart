import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/data/repositories.dart';
import 'package:meronpan/domain/use_cases/aget_details_use_case.dart';
import 'package:meronpan/domain/use_cases/aget_latest.dart';
import 'package:meronpan/domain/use_cases/aget_populars.dart';
import 'package:meronpan/domain/use_cases/get_details_use_case.dart';
import 'package:meronpan/domain/use_cases/get_latest.dart';
import 'package:meronpan/domain/use_cases/get_populars.dart';

final getPopularsUseCaseProvider = Provider<AGetPopularsUseCase>((ref) {
  return GetPopularsUseCase(httpRepository: ref.watch(tmoRepositoryProvider));
});

final getLatestUseCaseProvider = Provider<AGetLatestUseCase>((ref) {
  return GetLatestUseCase(httpRepository: ref.watch(tmoRepositoryProvider));
});

final getDetailsUseCaseProvider = Provider<AGetDetailsUseCase>((ref) {
  return GetDetailsUseCase(httpRepository: ref.watch(tmoRepositoryProvider));
});
