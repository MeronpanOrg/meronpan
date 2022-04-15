import 'package:equatable/equatable.dart';
import 'package:meronpan/domain/models/manga_details.dart';

enum PageStatus { initial, ongoing, success, failure }

class PageState extends Equatable {
  final PageStatus status;
  final MangaDetails mangaDetails;

  const PageState(
      {this.status = PageStatus.initial, required this.mangaDetails});

  PageState copyWith({PageStatus? status, MangaDetails? mangaDetails}) {
    return PageState(
      status: status ?? this.status,
      mangaDetails: mangaDetails ?? this.mangaDetails
    );
  }

  @override
  String toString() {
    return '''ExplorePaginaton { status: $status, manga: $mangaDetails }''';
  }

  @override
  List<Object> get props => [status, mangaDetails];
}
