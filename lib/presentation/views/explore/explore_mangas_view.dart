import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/presentation/providers/explore/explore_provider.dart';
import 'package:meronpan/presentation/providers/explore/state/explore_provider_state.dart';
import 'package:meronpan/presentation/providers/selected/selected_manga_provider.dart';
import 'package:meronpan/presentation/views/explore/widgets/filter_bottom_sheet.dart';
import 'package:meronpan/presentation/views/explore/widgets/filter_fab.dart';
import 'package:meronpan/presentation/widgets/manga_cover.dart';

class ExploreMangasView extends ConsumerStatefulWidget {
  const ExploreMangasView({Key? key}) : super(key: key);

  @override
  ConsumerState<ExploreMangasView> createState() => _ExploreMangasViewState();
}

class _ExploreMangasViewState extends ConsumerState<ExploreMangasView> {
  final ScrollController _scrollController = ScrollController();

  final _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = 'Search query';

  void _onScroll() {
    if (_isBottom) {
      ref.read(exploreProvider.notifier).getPopulars();
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
              if (exploreMangas.status == ExploreStatus.failure) {
                return _buildError();
              }

              final mangas = exploreMangas.mangas;

              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 10),
                  ),
                  SliverAppBar(
                    leading: !_isSearching ? const Icon(Icons.search) : null,
                    floating: true,
                    backgroundColor: Colors.white,
                    shape: const StadiumBorder(),
                    title: _buildSearchField(),
                    actions: !_isSearching
                        ? [
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
                          ]
                        : [],
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 10),
                  ),
                  if (mangas.isEmpty) _buildLoadingSliver(),
                  if (mangas.isNotEmpty)
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
          ),
          if (exploreMangas.status == ExploreStatus.ongoing &&
              exploreMangas.mangas.isNotEmpty)
            const Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FilterFAB(
        onPressed: () {
          showModalBottomSheet(
            enableDrag: true,
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return const FilterDraggableScrollableSheet();
            },
          );
        },
      ),
    );
  }

  SliverList _buildLoadingSliver() {
    return SliverList(
      delegate: SliverChildListDelegate.fixed(
        [
          _buildLoading(),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      textInputAction: TextInputAction.search,
      decoration: const InputDecoration(
        hintText: 'Search manga...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.black38),
      ),
      style: const TextStyle(color: Colors.black, fontSize: 16.0),
      onTap: () {
        if (!_isSearching) {
          ModalRoute.of(context)
              ?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: () {
            setState(() {
              _isSearching = false;
            });
          }));
          setState(() {
            _isSearching = true;
          });
        }
      },
      onSubmitted: (query) {
        ref.read(exploreProvider.notifier).clean();
        ref.read(exploreProvider.notifier).getSearch(query);
      },
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

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.search,
      decoration: const InputDecoration(
        hintText: 'Search manga...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.black38),
      ),
      style: const TextStyle(color: Colors.black, fontSize: 16.0),
      onSubmitted: (query) {},
    );
  }
}
