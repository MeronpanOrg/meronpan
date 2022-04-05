import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/domain/entities/manga_card.dart';
import 'package:meronpan/domain/entities/manga_hive.dart';
import 'package:meronpan/ui/providers/services/favorites_hive_provider.dart';
import 'package:meronpan/ui/widgets/grid_cards_view.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biblioteca'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: ValueListenableBuilder<Box<MangaHive>>(
        valueListenable: ref.read(favoritesHiveProvider).listenable(),
        builder: (context, box, widget) {
          if (box.isEmpty) {
            return const Center(
              child: Text('Sin Favoritos'),
            );
          }

          return _buildCards(
            mangaBox: box,
          );
        },
      ),
    );
  }

  Widget _buildCards({required Box<MangaHive> mangaBox}) {
    final mangaCards = mangaBox.values
        .map(
          (m) => MangaCard(
              id: m.id,
              title: m.title,
              coverPath: m.coverPath,
              mangaUrl: m.mangaUrl,
              sourceName: m.source),
        )
        .toList();

    return GridCardsView(mangas: mangaCards);
  }
}
