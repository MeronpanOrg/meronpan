import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meronpan/core/config/preferences/preferences_keys.dart';
import 'package:meronpan/core/config/preferences/preferences_provider.dart';

class ExploreSettingsView extends ConsumerWidget {
  const ExploreSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explorar'),
      ),
      body: ValueListenableBuilder(
        valueListenable: ref.read(preferencesProvider).listenable(),
        builder: (context, value, child) {
          return SwitchListTile(
            title: const Text('SFW'),
            value: ref.read(preferencesProvider).get(PreferencesKeys.sfw) ?? true,
            onChanged: (newValue) {
              ref.read(preferencesProvider).put(PreferencesKeys.sfw, newValue);
            },
          );
        },
      ),
    );
  }
}
