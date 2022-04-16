import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show useState;
import 'package:meronpan/domain/models/chapter.dart';
import 'package:meronpan/domain/models/manga.dart';
import 'package:meronpan/presentation/providers/manga/manga_page_provider.dart';
import 'package:meronpan/presentation/providers/manga/page_state.dart';
import 'package:meronpan/presentation/views/manga/shimmer_manga_view.dart';
import 'package:meronpan/presentation/views/manga/widgets/header.dart';

class MangaView extends ConsumerWidget {
  const MangaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(mangaPageProvider);

    if (page.status == PageStatus.initial) {
      Future.microtask(
          () => ref.read(mangaPageProvider.notifier).fetchMangaDetails());
      return const ShimmerMangaView();
    }

    if (page.status == PageStatus.failure) {
      return _buildMangaError();
    }

    final manga = page.mangaDetails.manga;
    final chapters = page.mangaDetails.chapters;

    return _MangaBody(
      mangaDetails: manga,
      chaptersSliver: SliverFixedExtentList(
        itemExtent: 80,
        delegate: _buildChapters(chapters),
      ),
    );
  }

  SliverChildBuilderDelegate _buildChapters(List<Chapter> chapters) {
    if (chapters.isEmpty) {
      return SliverChildBuilderDelegate(
        (context, index) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        childCount: 1,
      );
    }

    return SliverChildBuilderDelegate(
      (context, index) {
        return ListTile(
          onTap: () {
            showAboutDialog(
                context: context, children: [Text(chapters[index].url)]);
          },
          title: Text(
            chapters[index].name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(chapters[index].scanlator),
          shape: const ContinuousRectangleBorder(
              side: BorderSide(color: Color(0xffe0e0e0))),
        );
      },
      childCount: chapters.length,
    );
  }

  Widget _buildMangaError() {
    return const ShimmerMangaView();
  }
}

class _MangaBody extends HookConsumerWidget {
  final Manga mangaDetails;
  final Widget? chaptersSliver;

  const _MangaBody({Key? key, required this.mangaDetails, this.chaptersSliver})
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Text(
                            mangaDetails.description,
                            style: const TextStyle(fontSize: 18),
                            overflow: TextOverflow.clip,
                            maxLines: isDescriptionExpanded.value ? null : 5,
                          ),
                          Container(
                            height: 40,
                          )
                        ],
                      ),
                    ),
                    if (mangaDetails.description.length > 200)
                      _buildExpandDescriptionButton(isDescriptionExpanded),
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
              ],
            ),
          ),
          if (chaptersSliver != null) chaptersSliver!
        ],
      ),
    );
  }

  Positioned _buildExpandDescriptionButton(
      ValueNotifier<bool> isDescriptionExpanded) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton.icon(
            onPressed: () {
              isDescriptionExpanded.value = !isDescriptionExpanded.value;
            },
            icon: isDescriptionExpanded.value
                ? const Icon(Icons.keyboard_arrow_up)
                : const Icon(Icons.keyboard_arrow_down),
            label: isDescriptionExpanded.value
                ? const Text('Menos')
                : const Text('Mas'),
          )
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
