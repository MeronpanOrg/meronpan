import 'package:equatable/equatable.dart';
import 'package:meronpan/domain/models/manga.dart';

enum ExploreStatus { initial, ongoing, success, failure }

class ExplorePaginaton extends Equatable {
  final ExploreStatus status;
  final List<Manga> mangas;
  final bool hasLoadMoreDone;

  const ExplorePaginaton({
    this.status = ExploreStatus.initial,
    this.mangas = const <Manga>[],
    this.hasLoadMoreDone = false,
  });

  ExplorePaginaton copyWith({
    ExploreStatus? status,
    List<Manga>? mangas,
    bool? hasLoadMoreDone,
  }) {
    return ExplorePaginaton(
      status: status ?? this.status,
      mangas: mangas ?? this.mangas,
      hasLoadMoreDone: hasLoadMoreDone ?? this.hasLoadMoreDone,
    );
  }

  @override
  String toString() {
    return '''ExplorePaginaton { status: $status, hasReachedMax: $hasLoadMoreDone, mangas: ${mangas.length} }''';
  }

  @override
  List<Object> get props => [status, mangas, hasLoadMoreDone];
}
