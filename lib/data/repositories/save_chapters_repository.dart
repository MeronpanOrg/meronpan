import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/domain/entities/chapter_hive.dart';
import 'package:meronpan/domain/repositories/isave_chapters_repository.dart';
import 'package:meronpan/ui/providers/services/chapters_hive_provider.dart';

class SaveChaptersRepository implements ISaveChaptersRepository {
  Reader read;
  Box<ChapterHive> box;

  SaveChaptersRepository(this.read) : box = read(chaptersHiveProvider);

  @override
  Future deleteChapters(ChapterHive manga) {
    // TODO: implement deleteChapters
    throw UnimplementedError();
  }

  @override
  ChapterHive? getChaptersAt(int index) {
    // TODO: implement getChaptersAt
    throw UnimplementedError();
  }

  @override
  ChapterHive? getChaptersByUniqueId(String uniqueId) {
    if (box.isNotEmpty) {
      final chaptersList = box.values.toList();
      if (chaptersList.any((element) => element.mangaUniqueId == uniqueId)) {
        final chapters = chaptersList
            .firstWhere((element) => element.mangaUniqueId == uniqueId);

        return chapters;
      }
    }
    return null;
  }

  @override
  Future<int> saveChapters(ChapterHive chapters) async {
    return box.add(chapters);
  }

  @override
  Future updateChapters(ChapterHive manga) {
    // TODO: implement updateChapters
    throw UnimplementedError();
  }
}
