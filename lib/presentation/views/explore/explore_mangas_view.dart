import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/presentation/providers/explore/explore_provider.dart';
import 'package:meronpan/presentation/providers/selected/selected_manga_provider.dart';
import 'package:meronpan/presentation/widgets/manga_cover.dart';

class ExploreMangasView extends ConsumerStatefulWidget {
  const ExploreMangasView({Key? key}) : super(key: key);

  @override
  ConsumerState<ExploreMangasView> createState() => _ExploreMangasViewState();
}

class _ExploreMangasViewState extends ConsumerState<ExploreMangasView> {
  final ScrollController _scrollController = ScrollController();

  void _onScroll() {
    if (_isBottom) {
      ref.read(exploreProvider.notifier).getMoreMangas();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exploreMangas = ref.watch(exploreProvider);

    return Scaffold(
      body: Stack(
        children: [
          Consumer(
            builder: (context, ref, child) {
              return exploreMangas.when(
                init: () => _buildLoading(),
                loading: () => _buildLoading(),
                success: (mangas) {
                  return CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverAppBar(
                        floating: true,
                        backgroundColor: Colors.white,
                        shape: const StadiumBorder(),
                        actions: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.view_list_sharp),
                          ),
                          IconButton(
                            onPressed: () {
                              ref.read(exploreProvider.notifier).refresh();
                            },
                            icon: const Icon(Icons.refresh),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_vert),
                          ),
                        ],
                      ),
                      SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return GestureDetector(
                              onTap: () {
                                print(mangas[index].toJson());
                                ref.read(selectedMangaProvider.notifier).state =
                                    mangas[index];
                                Navigator.pushNamed(context, '/manga');
                              },
                              child: GridTile(
                                child: Column(
                                  children: [
                                    MangaCover(
                                      manga: mangas[index],
                                    ),
                                    Text(
                                      mangas[index].title,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: mangas.length,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 8,
                          crossAxisCount: 3,
                          mainAxisExtent: 220,
                        ),
                      )
                    ],
                  );
                },
                error: (err) => _buildError(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError() {
    return const Center(
      child: Text('Imposible cargar mangas'),
    );
  }
}
