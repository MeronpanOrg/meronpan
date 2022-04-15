import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/domain/models/manga.dart';
import 'package:meronpan/presentation/providers/selected/selected_manga_provider.dart';
import 'package:meronpan/presentation/providers/selected/selected_mangas_provider.dart';
import 'package:meronpan/presentation/views/manga/manga_view.dart';
import 'package:meronpan/presentation/widgets/manga_cover.dart';

class GridCardsView extends ConsumerStatefulWidget {
  const GridCardsView({Key? key, required this.mangas, this.onScrollEnd})
      : super(key: key);

  final List<Manga> mangas;
  final VoidCallback? onScrollEnd;

  @override
  ConsumerState<GridCardsView> createState() => _GridCardsViewState();
}

class _GridCardsViewState extends ConsumerState<GridCardsView> {
  final ScrollController _scrollController = ScrollController();
  double pixels = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final max = _scrollController.position.maxScrollExtent;
      if (max == _scrollController.position.pixels) {
        if (widget.onScrollEnd != null) {
          setState(() {
            pixels = _scrollController.position.pixels;
          });
          widget.onScrollEnd!();
          _scrollController.position.jumpTo(pixels);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedMangas = ref.watch(selectedMangasProvider);
    final mangas = widget.mangas;

    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 8,
        crossAxisCount: 3,
        mainAxisExtent: 220,
      ),
      itemCount: mangas.length,
      itemBuilder: (context, index) {
        return GridTile(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(4),
              color: selectedMangas.contains(mangas[index]) ? Colors.red : null,
              child: Column(
                children: [
                  GestureDetector(
                    onLongPress: () {
                      if (selectedMangas.contains(mangas[index])) {
                        ref
                            .read(selectedMangasProvider.notifier)
                            .update((state) {
                          state.remove(mangas[index]);
                          return [...state];
                        });
                        return;
                      }

                      ref.read(selectedMangasProvider.notifier).update(
                          (state) => [...state, mangas.elementAt(index)]);
                      HapticFeedback.vibrate();
                    },
                    onTap: () {
                      ref.read(selectedMangaProvider.notifier).state =
                          mangas[index];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MangaView(),
                        ),
                      );
                    },
                    child: Hero(
                      tag: mangas[index].url,
                      child: MangaCover(
                        manga: mangas[index],
                      ),
                    ),
                  ),
                  Text(
                    mangas[index].title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
