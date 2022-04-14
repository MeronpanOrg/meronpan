import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/presentation/providers/ui/ui_provider.dart';
import 'package:meronpan/presentation/views/root/widgets/meronpan_bottom_nav_bar.dart';
import 'package:meronpan/presentation/views/views.dart';

class RootView extends ConsumerWidget {
  const RootView({Key? key}) : super(key: key);

  final List<Widget> pages = const [
    HomeView(),
    ExploreMangasView(),
    SettingsView()
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: pages.elementAt(ref.watch<int>(uiProvider)),
      bottomNavigationBar: const MeronpanBottomNavBar(),
    );
  }
}
