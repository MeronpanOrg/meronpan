import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/domain/repositories/imangas_repository.dart';
import 'package:meronpan/sources/es/tmo/providers/repositories/tmo_mangas_repository_provider.dart';
import 'package:meronpan/ui/providers/manga/explore_mangas/explore_mangas_state.dart';

final exploreMangasProvider =
    StateNotifierProvider<ExploreMangasNotifier, ExploreMangasState>((ref) {
  return ExploreMangasNotifier(ref.watch(tmoMangasRepositoryProvider));
});

class ExploreMangasNotifier extends StateNotifier<ExploreMangasState> {
  final IMangasRepository mangasRepository;

  ExploreMangasNotifier(this.mangasRepository)
      : super(const ExploreMangasState()) {
    _initProvider();
  }

  Future<void> _initProvider([int? initPage]) async {
    final page = initPage ?? state.page;

    final mangas = await mangasRepository.popularMangaRequest(page);

    if (mangas.isEmpty) {
      state = state.copyWith(page: page, isLoading: false);
      return;
    }

    state = state.copyWith(page: page, isLoading: false, mangas: mangas);
  }

  Future<void> getMoreMangas() async {
    if (state.isLoading) {
      return;
    }

    state = state.copyWith(
        isLoading: true, isLoadMoreDone: false, isLoadMoreError: false);

    final mangas = await mangasRepository.popularMangaRequest(state.page + 1);

    if (mangas.isEmpty) {
      // error
      state = state.copyWith(isLoadMoreError: true, isLoading: false);
      return;
    }

    if (mangas.isNotEmpty) {
      // if load more return a list not empty, => increment page
      state = state.copyWith(
          page: state.page + 1,
          isLoading: false,
          isLoadMoreDone: mangas.isEmpty,
          mangas: [...(state.mangas ?? []), ...mangas]);
    } else {
      // not increment page
      state = state.copyWith(
        isLoading: false,
        isLoadMoreDone: mangas.isEmpty,
      );
    }
  }

  Future<void> refresh() async {
    _initProvider(1);
  }
}
