import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/domain/sources/online/http_source.dart';
import 'package:meronpan/sources/es/tmo/providers/filter/tmo_filter_provider.dart';
import 'package:meronpan/sources/es/tmo/providers/source/tmo_source_provider.dart';
import 'package:meronpan/sources/es/tmo/providers/tmo_mangas_state.dart';

final tmoMangasProvider =
    StateNotifierProvider<TMOMangasNotifier, TMOState>((ref) {
  return TMOMangasNotifier(ref.watch(tmoSourceProvider), ref.read);
});

class TMOMangasNotifier extends StateNotifier<TMOState> {
  HttpSource source;
  Reader read;

  TMOMangasNotifier(this.source, this.read) : super(const TMOState()) {
    _initProvider();
  }

  Future<void> _initProvider([int? initPage]) async {
    final page = initPage ?? state.page;

    final mangasPage = await source.fetchPopularManga(page);
    final mangas = mangasPage!.mangas;

    if (mangas.isEmpty) {
      state = state.copyWith(page: page, isLoading: false);
      return;
    }

    state = state.copyWith(page: page, isLoading: false, mangas: mangas);
  }

  Future<void> fetchMoreMangas() async {
    if (state.isLoading) {
      return;
    }

    state = state.copyWith(
        isLoading: true, isLoadMoreDone: false, isLoadMoreError: false);

    final mangasPage = await source.fetchPopularManga(state.page + 1);
    final mangas = mangasPage!.mangas;

    if (mangas.isEmpty) {
      state = state.copyWith(isLoadMoreError: true, isLoading: false);
      return;
    }

    if (mangas.isNotEmpty) {
      // if load more return a list not empty, => increment page
      state = state.copyWith(
          page: state.page + 1,
          isLoading: false,
          isLoadMoreDone: !mangasPage.hasNextpage,
          mangas: [...(state.mangas ?? []), ...mangas]);
    } else {
      // not increment page
      state = state.copyWith(
        isLoading: false,
        isLoadMoreDone: mangas.isEmpty,
      );
    }
  }

  Future<void> fetchMangasByFilter() async {
    if (state.isLoading) {
      return;
    }

    final request = read(tmoFilterProvider);

    state = state.copyWith(
      isLoading: true,
      isLoadMoreDone: false,
      isLoadMoreError: false,
    );

    final mangasPage = await source.fetchSearchManga(
        state.page + 1, '', request.getFilterList());
    final mangas = mangasPage!.mangas;

    if (mangas.isEmpty) {
      state = state.copyWith(isLoadMoreError: true, isLoading: false);
      return;
    }

    if (mangas.isNotEmpty) {
      // if load more return a list not empty, => increment page
      state = state.copyWith(
          page: state.page + 1,
          isLoading: false,
          isLoadMoreDone: !mangasPage.hasNextpage,
          mangas: [...(state.mangas ?? []), ...mangas]);
    } else {
      // not increment page
      state = state.copyWith(
        isLoading: false,
        isLoadMoreDone: mangas.isEmpty,
      );
    }
  }

  Future<void> fetchMangasByTitle(String query) async {
    if (state.isLoading) {
      return;
    }

    final request = read(tmoFilterProvider);

    state = state.copyWith(
      isLoading: true,
      isLoadMoreDone: false,
      isLoadMoreError: false,
    );

    final mangasPage = await source.fetchSearchManga(
        state.page + 1, query, request.getFilterList());
    final mangas = mangasPage!.mangas;

    if (mangas.isEmpty) {
      state = state.copyWith(isLoadMoreError: true, isLoading: false);
      return;
    }

    if (mangas.isNotEmpty) {
      // if load more return a list not empty, => increment page
      state = state.copyWith(
          page: state.page + 1,
          isLoading: false,
          isLoadMoreDone: !mangasPage.hasNextpage,
          mangas: [...(state.mangas ?? []), ...mangas]);
    } else {
      // not increment page
      state = state.copyWith(
        isLoading: false,
        isLoadMoreDone: mangas.isEmpty,
      );
    }
  }

  void clean() {
    state = state.copyWith(mangas: null, page: 0, isLoading: false);
  }

  void refresh() {
    clean();
    _initProvider(1);
  }
}
