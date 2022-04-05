import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/domain/entities/manga_card.dart';
import 'package:meronpan/domain/repositories/ifavoritebox_repository.dart';
import 'package:meronpan/domain/repositories/imanga_repository.dart';
import 'package:meronpan/sources/es/tmo/providers/repositories/tmo_manga_repository_provider.dart';
import 'package:meronpan/ui/providers/manga/manga_page/manga_page_state.dart';
import 'package:meronpan/ui/providers/repositories/favorite_repository_provider.dart';

final mangaPageProvider =
    StateNotifierProvider.autoDispose<MangaPageNotifier, MangaPageState>((ref) {
  return MangaPageNotifier(ref.watch(tmoMangaRepositoryProvider),
      ref.watch(favoriteRepositoryProvider));
}, name: 'Manga Page Provider', );

class MangaPageNotifier extends StateNotifier<MangaPageState> {
  IMangaRepository repository;
  IFavoriteBoxRepository boxRepository;

  MangaPageNotifier(this.repository, this.boxRepository)
      : super(const MangaPageState.initial());

  getMangaPage(MangaCard mangaCard) async {
    try {
      state = const MangaPageState.loading();

      final page = await repository.getManga(mangaCard);
      final chapters = await repository.getChapters(mangaCard);

      state = MangaPageState.data(page: page, chapters: chapters);
    } catch (e) {
      state = const MangaPageState.error('Imposible cargar la pagina');
    }
  }
}
