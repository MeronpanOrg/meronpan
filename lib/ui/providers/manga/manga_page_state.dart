import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meronpan/domain/sources/models/chapter.dart';
import 'package:meronpan/domain/sources/models/manga.dart';

part 'manga_page_state.freezed.dart';

@Freezed()
class MangaPageState with _$MangaPageState {
  ///Initial
  const factory MangaPageState.initial() = _MangaPageStateInitial;

  ///Loading
  const factory MangaPageState.loading() = _MangaPageStateLoading;

  ///Data
  const factory MangaPageState.data(
      {required Manga page, List<Chapter>? chapters}) = _MangaPageStateData;

  ///Error
  const factory MangaPageState.error([String? error]) = _MangaPageStateError;
}
