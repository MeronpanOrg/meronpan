import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/domain/models/manga.dart';
import 'package:meronpan/domain/use_cases/aget_latest.dart';
import 'package:meronpan/domain/use_cases/aget_populars.dart';
import 'package:meronpan/domain/uses_cases.dart';
import 'package:meronpan/presentation/providers/explore/state/explore_provider_state.dart';

final exploreProvider =
    StateNotifierProvider<ExploreNotifier, ExplorePaginatonState<List<Manga>>>((ref) {
  return ExploreNotifier(
    ref.watch(getPopularsUseCaseProvider),
    ref.watch(getLatestUseCaseProvider),
  );
});

class ExploreNotifier extends StateNotifier<ExplorePaginatonState<List<Manga>>> {
  final AGetPopularsUseCase getPopularsUseCase;
  final AGetLatestUseCase getLatestUseCase;

  int _currentPage = 1;
  bool _canFetchMore = true;

  ExploreNotifier(this.getPopularsUseCase, this.getLatestUseCase)
      : super(const ExplorePaginatonState.init()) {
    _init();
  }

  Future<void> _init() async {
    if (state.isLoading) {
      return;
    }

    state = const ExplorePaginatonState.loading();

    final mangasPage = await getPopularsUseCase.getMangas(_currentPage);
    _canFetchMore = mangasPage.hasNextpage;
    _currentPage++;

    state = ExplorePaginatonState.success(mangasPage.mangas);
  }

  Future<void> getLatest() async {
    if (state.isLoading) {
      return;
    }

    state = const ExplorePaginatonState.loading();

    final mangasPage = await getLatestUseCase.getMangas(_currentPage);
    _canFetchMore = mangasPage.hasNextpage;
    _currentPage++;

    state = ExplorePaginatonState.success(mangasPage.mangas);
  }

  Future<void> getMorePopulars() async {
    if (_canFetchMore) {
      if (state.isLoading) {
        return;
      }

      final pre = state.data ?? [];

      state = const ExplorePaginatonState.loading();

      final mangasPage = await getPopularsUseCase.getMangas(_currentPage);
      _canFetchMore = mangasPage.hasNextpage;
      _currentPage++;

      state = ExplorePaginatonState.success([...pre, ...mangasPage.mangas]);
    }
  }

  Future<void> getMoreLatest() async {
    if (_canFetchMore) {
      if (state.isLoading) {
        return;
      }

      final pre = state.data ?? [];

      state = const ExplorePaginatonState.loading();

      final mangasPage = await getLatestUseCase.getMangas(_currentPage);
      _canFetchMore = mangasPage.hasNextpage;
      _currentPage++;

      state = ExplorePaginatonState.success([...pre, ...mangasPage.mangas]);
    }
  }

  void refresh() {
    clean();
    _init();
  }

  void clean() {
    _currentPage = 1;
    _canFetchMore = true;
    state = const ExplorePaginatonState.success([]);
    state = const ExplorePaginatonState.init();
  }
}
