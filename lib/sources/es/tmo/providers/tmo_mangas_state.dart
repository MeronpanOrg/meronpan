
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meronpan/domain/sources/models/manga.dart';

part 'tmo_mangas_state.freezed.dart';

@Freezed()
class TMOState with _$TMOState {
const factory TMOState({
    @Default(1) int page,
    List<Manga>? mangas,
    @Default(true) bool isLoading,
    @Default(false) bool isLoadMoreError,
    @Default(false) bool isLoadMoreDone,
  }) = _TMOState;

  const TMOState._();
}