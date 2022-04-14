import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/presentation/providers/explore/explore_provider.dart';


class BottomSheetTopBar extends ConsumerWidget {
  const BottomSheetTopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xffaaaaaa),
          ),
        ),
      ),
      height: 130,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Populares',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Actualizados',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Reiniciar',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              SizedBox.fromSize(
                size: const Size(200, 40),
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(exploreProvider.notifier).refresh();
                    // ref.read(tmoMangasProvider.notifier).fetchMangasByFilter();
                  },
                  child: const Text(
                    'Aplicar',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
