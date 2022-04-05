import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/domain/entities/chapter_hive.dart';

final chaptersHiveProvider = Provider<Box<ChapterHive>>((ref) {
  return Hive.box('chapters');
});
