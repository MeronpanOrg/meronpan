import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/domain/repositories/imanga_repository.dart';
import 'package:meronpan/sources/es/tmo/data/repositories/tmo_manga_repository.dart';

final tmoMangaRepositoryProvider = Provider<IMangaRepository>((ref) {
  return TmoMangaRepository(ref.read);
});
