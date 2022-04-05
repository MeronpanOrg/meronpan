import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meronpan/domain/entities/manga_card.dart';

part 'explore_mangas_state.freezed.dart';

@Freezed()
class ExploreMangasState with _$ExploreMangasState {
const factory ExploreMangasState({
    @Default(1) int page,
    List<MangaCard>? mangas,
    @Default(true) bool isLoading,
    @Default(false) bool isLoadMoreError,
    @Default(false) bool isLoadMoreDone,
  }) = _ExploreMangasState;

  const ExploreMangasState._();
}
