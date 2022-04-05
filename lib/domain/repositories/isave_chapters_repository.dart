import 'package:meronpan/domain/entities/chapter_hive.dart';

abstract class ISaveChaptersRepository {
  Future<int> saveChapters(ChapterHive chapters);
  ChapterHive? getChaptersAt(int index);
  ChapterHive? getChaptersByUniqueId(String uniqueId);
  Future updateChapters(ChapterHive manga);
  Future deleteChapters(ChapterHive manga);
}
