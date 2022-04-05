
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meronpan/domain/entities/chapter_hive.dart';
import 'package:meronpan/domain/entities/manga_page.dart';

part 'manga_page_state.freezed.dart';



@Freezed()
class MangaPageState with _$MangaPageState {
  ///Initial
  const factory MangaPageState.initial() = _MangaPageStateInitial;

  ///Loading
  const factory MangaPageState.loading() = _MangaPageStateLoading;

  ///Data
  const factory MangaPageState.data(
      {required MangaPage page,
      required ChapterHive chapters}) = _MangaPageStateData;

  ///Error
  const factory MangaPageState.error([String? error]) = _MangaPageStateError;
}