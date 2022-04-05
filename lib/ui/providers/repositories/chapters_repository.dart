import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/data/repositories/save_chapters_repository.dart';

final chaptersRepositoyProvider = Provider<SaveChaptersRepository>((ref) {
  return SaveChaptersRepository(ref.read);
});