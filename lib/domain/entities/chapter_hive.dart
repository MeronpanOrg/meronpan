import 'package:hive/hive.dart';

part 'chapter_hive.g.dart';

@HiveType(typeId: 1)
class ChapterHive extends HiveObject {
  @HiveField(0)
  final String mangaUniqueId;

  @HiveField(1)
  final Map<String, String> chapters;

  ChapterHive({required this.mangaUniqueId, required this.chapters});

  // Hive fields go here
}
