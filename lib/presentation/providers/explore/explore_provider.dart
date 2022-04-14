import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/domain/models/manga.dart';
import 'package:meronpan/domain/use_cases/aget_mangas.dart';
import 'package:meronpan/domain/uses_cases.dart';
import 'package:meronpan/presentation/providers/explore/state/explore_provider_state.dart';

final exploreProvider =
    StateNotifierProvider<ExploreNotifier, ExploreState<List<Manga>>>((ref) {
  return ExploreNotifier(ref.watch(getMangasUseCaseProvider));
});

class ExploreNotifier extends StateNotifier<ExploreState<List<Manga>>> {
  final AGetMangasUseCase getMangasUseCase;
  int _currentPage = 1;
  bool canFetchMore = true;

  ExploreNotifier(this.getMangasUseCase) : super(const ExploreState.init()) {
    _init();
  }

  Future<void> _init() async {
    if (state.isLoading) {
      return;
    }

    state = const ExploreState.loading();

    final mangasPage = await getMangasUseCase.getMangas(_currentPage);
    canFetchMore = mangasPage.hasNextpage;
    _currentPage++;

    state = ExploreState.success(mangasPage.mangas);
  }

  Future<void> getMoreMangas() async {
    if (canFetchMore) {
      if (state.isLoading) {
        return;
      }

      final mangasPage = await getMangasUseCase.getMangas(_currentPage);
      canFetchMore = mangasPage.hasNextpage;
      _currentPage++;

      state = ExploreState.success([...state.data!, ...mangasPage.mangas]);
    }
  }

  void refresh() {
    _currentPage = 1;
    canFetchMore = true;
    state = const ExploreState.init();
    _init();
  }
}
