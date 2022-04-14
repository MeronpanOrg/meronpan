import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/domain/models/manga.dart';
import 'package:meronpan/domain/use_cases/aget_details_use_case.dart';
import 'package:meronpan/domain/uses_cases.dart';

import 'package:meronpan/presentation/providers/manga/manga_page_state.dart';

final mangaPageProvider =
    StateNotifierProvider.autoDispose<MangaPageNotifier, MangaPageState>(
  (ref) {
    return MangaPageNotifier(ref.watch(getDetailsUseCaseProvider));
  },
  name: 'Manga Page Provider',
);

class MangaPageNotifier extends StateNotifier<MangaPageState> {
  final AGetDetailsUseCase getMangaDetailsUseCase;

  MangaPageNotifier(this.getMangaDetailsUseCase)
      : super(const MangaPageState.initial());

  fetchMangaDetails(Manga mangaSelected) async {}
}
