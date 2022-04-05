import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/domain/entities/manga_hive.dart';

final favoritesHiveProvider = Provider<Box<MangaHive>>((ref) {
  return Hive.box('favorites');
});
