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
  _ExploreTmoVieweState createState() => _ExploreTmoVieweState();
}

class _ExploreTmoVieweState extends ConsumerState<ExploreTmoView> {
  final ScrollController _scrollController = ScrollController();
  int oldLength = 0;

  void _onScroll() {
    if (_isBottom) {
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
        title: const Text('TuMangaOnline'),
        actions: [
          IconButton(
            onPressed: () {},
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
              return const Center(
                child: Text('error'),
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
                        return const Center(
                          child: Text('Error'),
                        );
                      }
                      // load more but reached to the last element
                      if (isLoadMoreDone) {
                        return const Center(
                          child: Text(
                            'Done!',
                            style: TextStyle(color: Colors.green, fontSize: 20),
                          ),
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

  Center _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
