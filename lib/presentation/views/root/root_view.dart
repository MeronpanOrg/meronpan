import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/presentation/providers/ui/ui_provider.dart';
import 'package:meronpan/presentation/views/root/widgets/meronpan_bottom_nav_bar.dart';
import 'package:meronpan/presentation/views/views.dart';

class RootView extends ConsumerWidget {
  const RootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int page = ref.watch(uiProvider);

    return Scaffold(
      body: _buildPage(page),
      bottomNavigationBar: const MeronpanBottomNavBar(),
    );
  }

  Widget _buildPage(int page) {
    switch (page) {
      case 0:
        return const HomeView();
      case 1:
        return const ExploreMangasView();
      case 2:
        return const SettingsView();
      default:
        return const HomeView();
    }
  }
}
