import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/domain/entities/manga_hive.dart';
import 'package:meronpan/domain/entities/manga_page.dart';
import 'package:meronpan/domain/repositories/ifavoritebox_repository.dart';
import 'package:meronpan/ui/providers/repositories/favorite_repository_provider.dart';

final mangaFavoritesProvider =
    StateNotifierProvider<MangaFavoritesNotifier, List<MangaHive>>((ref) {
  return MangaFavoritesNotifier(ref.watch(favoriteRepositoryProvider));
}, name: 'Manga Favorites Provider');

class MangaFavoritesNotifier extends StateNotifier<List<MangaHive>> {
  IFavoriteBoxRepository repository;

  MangaFavoritesNotifier(this.repository) : super([]) {
    _updateState();
  }

  void _updateState() {
    final mangas = repository.getMangas();
    state = [...mangas];
  }

  void addFavoriteManga(MangaPage manga) async {
    final index = await repository.saveManga(manga);
    if (index > 0) {
      _updateState();
    }
  }

  void removeManga(MangaPage manga) {
    if (repository.deleteManga(MangaHive.fromMangaPage(manga))) {
      _updateState();
    }
  }
}
