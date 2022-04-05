import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/core/utils/models/filter.dart';
import 'package:meronpan/sources/es/tmo/data/request/tu_manga_online_filters.dart';

import '../../data/request/filters/filters.dart';

final tuMangaOnlineFiltersProvider =
    StateNotifierProvider<TuMangaOnlineFiltersNotifier, TuMangaOnlineFilters>(
        (ref) {
  return TuMangaOnlineFiltersNotifier();
});

class TuMangaOnlineFiltersNotifier extends StateNotifier<TuMangaOnlineFilters> {
  TuMangaOnlineFiltersNotifier()
      : super(
          TuMangaOnlineFilters.init(),
        );

  void changeTypeSelectionState(int newIndex) {
    state = state.copyWith(typeSelection: TypeSelection(state: newIndex));
  }

  void changeStatusSelectionState(int newIndex) {
    state = state.copyWith(statusSelection: StatusSelection(state: newIndex));
  }

  void changeTranslationStatusSelectionState(int newIndex) {
    state = state.copyWith(
        translationStatusSelection:
            TranslationStatusSelection(state: newIndex));
  }

  void changeDemographySelectionState(int newIndex) {
    state = state.copyWith(
        demographySelection: DemographySelection(state: newIndex));
  }

  void changeFilterBySelectionState(int newIndex) {
    state =
        state.copyWith(filterBySelection: FilterBySelection(state: newIndex));
  }

  void changeSortState(int newIndex, bool ascending) {
    final newState = Direction(index: newIndex, ascending: ascending);

    final sort = state.sort.copyWith(state: newState);

    state = state.copyWith(sort: sort);
  }

  void changeContentTypeListState(int index, bool? check) {
    final list = [...state.contentTypeList.content];

    final copy = list[index].copy();

    ContentType newValue;

    if (check == null) {
      newValue = copy.copyWith(state: triState.stateExclude);
    } else if (check == true) {
      newValue = copy.copyWith(state: triState.stateInclude);
    } else {
      newValue = copy.copyWith(state: triState.stateIgnore);
    }

    list.removeAt(index);
    list.insert(index, newValue);

    state = state.copyWith(contentTypeList: ContentTypeList(content: list));
  }

  void changeGenreListState(int index, bool? check) {
    final list = [...state.genreList.genres];

    final copy = list[index].copy();

    Genre newValue;

    if (check == null) {
      newValue = copy.copyWith(state: triState.stateExclude);
    } else if (check == true) {
      newValue = copy.copyWith(state: triState.stateInclude);
    } else {
      newValue = copy.copyWith(state: triState.stateIgnore);
    }

    list.removeAt(index);
    list.insert(index, newValue);

    state = state.copyWith(genreList: GenreList(genres: list));
  }
}
