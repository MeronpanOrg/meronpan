import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/data/repositories/favorites_repository.dart';

final favoriteRepositoryProvider = Provider<FavoriteRepository>((ref) {
  return FavoriteRepository(ref.read);
});
