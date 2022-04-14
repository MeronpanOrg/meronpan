import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/domain/models/manga.dart';
import 'package:meronpan/presentation/providers/explore/explore_provider.dart';

final mangasProvider = StateProvider<List<Manga>>((ref) {
  final List<Manga> data = [];
  final explore = ref.watch(exploreProvider);

  if (explore.isSuccess) {
    data.addAll(explore.data!);
  }

  return data;
});
