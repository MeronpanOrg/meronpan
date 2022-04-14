import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/presentation/providers/ui/ui_provider.dart';

class MeronpanBottomNavBar extends ConsumerWidget {
  const MeronpanBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationBar(
      selectedIndex: ref.watch<int>(uiProvider),
      onDestinationSelected: (newIndex) {
        ref.read(uiProvider.notifier).changeView(newIndex);
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.book_outlined),
          label: 'Biblioteca',
          selectedIcon: Icon(Icons.book),
        ),
        NavigationDestination(
          icon: Icon(Icons.explore_outlined),
          label: 'Explorar',
          selectedIcon: Icon(Icons.explore),
        ),
        NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          label: 'Configuración',
          selectedIcon: Icon(Icons.settings),
        ),
      ],
    );
  }
}
