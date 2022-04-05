import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/sources/es/tmo/data/repositories/tmo_mangas_repository.dart';

final tmoMangasRepositoryProvider = Provider<TMOMangasRepository>((ref) {
  return TMOMangasRepository(ref.read);
});
