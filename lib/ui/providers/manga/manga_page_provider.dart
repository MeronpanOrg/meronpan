import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/domain/sources/models/manga.dart';
import 'package:meronpan/domain/sources/online/http_source.dart';
import 'package:meronpan/sources/es/tmo/providers/source/tmo_source_provider.dart';
import 'package:meronpan/ui/providers/manga/manga_page_state.dart';

final mangaPageProvider =
    StateNotifierProvider.autoDispose<MangaPageNotifier, MangaPageState>(
  (ref) {
    return MangaPageNotifier(ref.watch(tmoSourceProvider));
  },
  name: 'Manga Page Provider',
);

class MangaPageNotifier extends StateNotifier<MangaPageState> {
  final HttpSource source;

  MangaPageNotifier(this.source) : super(const MangaPageState.initial());

  fetchMangaDetails(Manga mangaSelected) async {
    try {
      state = const MangaPageState.loading();

      final page = await source.fetchMangaDetails(mangaSelected);
      final manga = page!.mangas[0];
      state = MangaPageState.data(page: manga);
    } catch (e) {
      state = const MangaPageState.error('Imposible cargar la pagina');
    }
  }
}
