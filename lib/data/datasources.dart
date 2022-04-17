import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/data/tmo/remote/data_sources/tmo_source.dart';

final tmoSourceProvider = Provider<TmoSource>((ref) {
  return TmoSource(
    ref.read,
  );
});
