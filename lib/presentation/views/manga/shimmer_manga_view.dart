import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/presentation/providers/selected/selected_manga_provider.dart';
import 'package:meronpan/presentation/views/manga/widgets/header.dart';
import 'package:shimmer/shimmer.dart';

const shimmerGradient = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);

class ShimmerMangaView extends ConsumerWidget {
  const ShimmerMangaView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedManga = ref.watch(selectedMangaProvider);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 330,
            backgroundColor: Colors.grey[50],
            flexibleSpace: FlexibleSpaceBar(
              background: Header(manga: selectedManga),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 16),
                _buildButtons(),
                const SizedBox(height: 16),
                _buildBody(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton.icon(
          onPressed: null,
          icon: const Icon(Icons.favorite_outline),
          label: const Text('Añadir a biblioteca'),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLine(width: double.infinity, height: 16),
          const SizedBox(height: 16),
          _buildLine(width: double.infinity, height: 16),
          const SizedBox(height: 16),
          _buildLine(width: double.infinity, height: 16),
          const SizedBox(height: 16),
          _buildLine(width: double.infinity, height: 16),
          const SizedBox(height: 16),
          _buildLine(width: 250, height: 16),
        ],
      ),
    );
  }

  Widget _buildLine({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 218, 218, 218),
      highlightColor: const Color(0xFFF4F4F4),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
