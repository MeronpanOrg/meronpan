import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/sources/es/tmo/providers/tmo_mangas_provider.dart';
import 'package:meronpan/sources/es/tmo/views/explore/widgets/filter_bottom_sheet.dart';
import 'package:meronpan/sources/es/tmo/views/explore/widgets/widgets.dart';
import 'package:meronpan/ui/providers/manga/selected_manga_provider.dart';
import 'package:meronpan/ui/views/manga/manga_view.dart';
import 'package:meronpan/ui/widgets/manga_cover.dart';

class ExploreTmoView extends ConsumerStatefulWidget {
  const ExploreTmoView({Key? key}) : super(key: key);

  @override
  _ExploreTmoViewState createState() => _ExploreTmoViewState();
}

class _ExploreTmoViewState extends ConsumerState<ExploreTmoView> {
  final ScrollController _scrollController = ScrollController();

  final _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = 'Search query';

  void _onScroll() {
    final isLoadMoreDone = ref.watch(tmoMangasProvider).isLoadMoreDone;
    if (_isBottom && !isLoadMoreDone) {
      ref.read(tmoMangasProvider.notifier).fetchMoreMangas();
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
    return Scaffold(
      appBar: AppBar(
        title: _isSearching ? _buildSearchField() : _buildTitle(),
        actions: _isSearching
            ? _buildActions()
            : [
                IconButton(
                  onPressed: () {
                    ModalRoute.of(context)
                        ?.addLocalHistoryEntry(LocalHistoryEntry(
                      onRemove: () {
                        _searchQueryController.text = '';
                        setState(() {
                          _isSearching = false;
                        });
                      },
                    ));
                    setState(() {
                      _isSearching = true;
                    });
                  },
                  icon: const Icon(Icons.search),
                ),
                IconButton(
                  onPressed: () {
                    ref.read(tmoMangasProvider.notifier).refresh();
                  },
                  icon: const Icon(Icons.refresh),
                ),
              ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final isLoadMoreError = ref.watch(tmoMangasProvider).isLoadMoreError;
          final isLoadMoreDone = ref.watch(tmoMangasProvider).isLoadMoreDone;
          final isLoading = ref.watch(tmoMangasProvider).isLoading;
          final mangas = ref.watch(tmoMangasProvider).mangas;

          if (mangas == null) {
            if (isLoading == false) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Cargando mas...'),
                  _buildLoading(),
                ],
              );
            }
            return _buildLoading();
          }
 
          return Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  ref.read(tmoMangasProvider.notifier).refresh();
                },
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 8,
                    crossAxisCount: 3,
                    mainAxisExtent: 220,
                  ),
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: mangas.length + 1,
                  itemBuilder: (context, index) {
                    if (index == mangas.length) {
                      if (isLoadMoreError) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Cargando mas...'),
                            _buildLoading(),
                          ],
                        );
                      }

                      return Container();
                    }

                    return GestureDetector(
                      onTap: () {
                        print(mangas[index].toJson());
                        ref.read(selectedMangaProvider.notifier).state =
                            mangas[index];
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const MangaView();
                          },
                        ));
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
                ),
              ),
              if (isLoadMoreDone)
                const Positioned(
                  bottom: -40,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      'Done!',
                      style: TextStyle(color: Colors.green, fontSize: 20),
                    ),
                  ),
                ),
              if (isLoading)
                Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: _buildLoading(),
                )
            ],
          );
        },
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

  Text _buildTitle() => const Text('TuMangaOnline');

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      textInputAction: TextInputAction.search,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search manga...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.black38),
      ),
      style: const TextStyle(color: Colors.black, fontSize: 16.0),
      onSubmitted: (query) {
        Navigator.pop(context);
        ref.read(tmoMangasProvider.notifier).clean();
        ref.read(tmoMangasProvider.notifier).fetchMangasByTitle(query);
      },
    );
  }

  List<Widget> _buildActions() {
    return <Widget>[
      IconButton(icon: const Icon(Icons.clear), onPressed: () {}),
    ];
  }

  Center _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
