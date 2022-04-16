import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/core/config/preferences/preferences_keys.dart';
import 'package:meronpan/core/config/preferences/preferences_provider.dart';
import 'package:meronpan/data/tmo/remote/data_sources/tmo_source.dart';

final tmoSourceProvider = Provider<TmoSource>((ref) {
  return TmoSource(
    ref.read,
    isSFWMode: ref.watch(preferencesProvider).get(PreferencesKeys.sfw) ?? true,
  );
});
