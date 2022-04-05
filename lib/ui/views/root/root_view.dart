import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/ui/providers/ui/ui_provider.dart';
import 'package:meronpan/ui/views/root/widgets/meronpan_bottom_nav_bar.dart';
import 'package:meronpan/ui/views/settings/settings_view.dart';
import 'package:meronpan/ui/views/views.dart';

class RootView extends ConsumerWidget {
  const RootView({Key? key}) : super(key: key);

  final List<Widget> pages = const [HomeView(), SourcesView(), SettingsView()];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: pages.elementAt(ref.watch<int>(uiProvider)),
      bottomNavigationBar: const MeronpanBottomNavBar(),
    );
  }
}
