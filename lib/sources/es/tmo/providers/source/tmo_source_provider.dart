import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/sources/es/es.dart';

final tmoSourceProvider = Provider<TMOSource>((ref) {
  return TMOSource(ref.read);
});
