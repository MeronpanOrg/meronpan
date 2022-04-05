import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/domain/entities/manga_card.dart';

final selectedMangaProvider = StateProvider<MangaCard>((ref) {
  return const MangaCard(
      id: '', title: '', coverPath: '', mangaUrl: '', sourceName: '');
}, name: 'Selected Manga');
