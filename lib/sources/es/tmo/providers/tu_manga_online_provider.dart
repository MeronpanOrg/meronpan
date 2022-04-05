import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/sources/es/tmo/data/request/tu_manga_online.dart';

final tuMangaOnlineProvider = Provider<TuMangaOnline>((ref) {
  return TuMangaOnline();
});
