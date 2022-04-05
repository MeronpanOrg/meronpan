import 'package:equatable/equatable.dart';
import 'package:meronpan/domain/entities/manga_hive.dart';

class MangaCard extends Equatable {
  final String id;
  final String title;
  final String coverPath;
  final String mangaUrl;
  final String sourceName;
  final bool isFavorited;

  const MangaCard({
    required this.id,
    required this.title,
    required this.coverPath,
    required this.mangaUrl,
    required this.sourceName,
    this.isFavorited = false,
  });

  factory MangaCard.fromMangaHive(MangaHive mangaHive) {
    return MangaCard(
      id: mangaHive.id,
      title: mangaHive.title,
      coverPath: mangaHive.coverPath,
      mangaUrl: mangaHive.mangaUrl,
      sourceName: mangaHive.source,
    );
  }

String get uniqueId => '$sourceName+$id';

  @override
  List<Object?> get props => [id, title, coverPath, mangaUrl, sourceName, isFavorited];

  @override
  bool? get stringify => true;
}
