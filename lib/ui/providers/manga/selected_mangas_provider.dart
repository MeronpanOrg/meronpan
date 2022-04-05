import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/domain/entities/manga_card.dart';

final selectedMangasProvider = StateProvider<List<MangaCard>>((ref) {
  return [];
});
