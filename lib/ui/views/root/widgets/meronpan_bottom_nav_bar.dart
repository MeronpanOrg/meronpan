import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/ui/providers/ui/ui_provider.dart';

class MeronpanBottomNavBar extends ConsumerWidget {
  const MeronpanBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
      currentIndex: ref.watch<int>(uiProvider),
      onTap: (newIndex) {
        ref.read(uiProvider.notifier).changeView(newIndex);
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Biblioteca'),
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explorar'),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings), label: 'Configuración'),
      ],
    );
  }
}
