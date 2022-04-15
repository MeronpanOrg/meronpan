import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/data/datasources.dart';
import 'package:meronpan/data/tmo/repositories/tmo_repository.dart';
import 'package:meronpan/domain/repositories/http_repository.dart';

final tmoRepositoryProvider = Provider<HttpSourceRepository>((ref) {
  return TmoRepository(ref.watch(tmoSourceProvider));
});
