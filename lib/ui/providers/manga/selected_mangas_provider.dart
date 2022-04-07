import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/domain/sources/models/manga.dart';

final selectedMangasProvider = StateProvider<List<Manga>>((ref) {
  return [];
});
