import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show useState;
import 'package:meronpan/domain/sources/models/manga.dart';
import 'package:meronpan/ui/views/manga/widgets/header.dart';

class MangaView extends ConsumerWidget {
  const MangaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();

    // return mangaPage.when(initial: () {
    //   Future.microtask(
    //       () => ref.read(mangaPageProvider.notifier).getMangaPage(mangaCard));
    //   return const ShimmerMangaView();
    // }, loading: () {
    //   return const ShimmerMangaView();
    // }, data: (manga, chapters) {
    //   final tiles = chapters.chapters.keys
    //       .map(
    //         (e) => ListTile(
    //           title: Text(e),
    //         ),
    //       )
    //       .toList();

    //   return _MangaBody(
    //     mangaDetails: manga,
    //     chaptersSliver: SliverList(delegate: SliverChildListDelegate(tiles)),
    //   );
    // }, error: (err) {
    //   return _buildMangaError();
    // });
  }

  Center buildChaptersError() =>
      const Center(child: Text('Error al cargar capitulos'));

  Scaffold buildMangaError() {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text('Error')),
    );
  }
}

class MangaBody extends HookConsumerWidget {
  final Manga mangaDetails;
  final Widget? chaptersSliver;

  const MangaBody({Key? key, required this.mangaDetails, this.chaptersSliver})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDescriptionExpanded = useState<bool>(false);

    bool isFavorited = false;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 335,
            backgroundColor: Colors.grey[50],
            flexibleSpace: FlexibleSpaceBar(
              background: Header(manga: mangaDetails),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildFavoriteButton(ref, isFavorited: isFavorited),
                  ],
                ),
                const SizedBox(height: 16),
                Stack(
                  children: [
                    Text(
                      mangaDetails.description,
                      style: const TextStyle(fontSize: 18),
                      overflow: TextOverflow.clip,
                      maxLines: isDescriptionExpanded.value ? null : 5,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.white60, Colors.white12],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                isDescriptionExpanded.value =
                                    !isDescriptionExpanded.value;
                              },
                              icon: const Icon(Icons.keyboard_arrow_down_sharp),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: const Text(
                    'Capitulos',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                if (chaptersSliver == null)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
              ],
            ),
          ),
          if (chaptersSliver != null) chaptersSliver!
        ],
      ),
    );
  }

  TextButton _buildFavoriteButton(WidgetRef ref, {bool isFavorited = false}) {
    if (!isFavorited) {
      return TextButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.favorite_outline),
        label: const Text('Añadir a biblioteca'),
      );
    }
    return TextButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.favorite),
      label: const Text('En biblioteca'),
    );
  }
}
