import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show useState;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/ui/providers/services/settings_box_provider.dart';

class SettingsView extends HookConsumerWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsBox = ref.read(settingsBoxProvider);

    final isTurnOn =
        useState<bool>(settingsBox.get('adultContent')?.compareTo('true') == 0);

    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      body: SingleChildScrollView(
        child: Column(children: [
          SwitchListTile(
            title: const Text('Adult content'),
            value: isTurnOn.value,
            onChanged: (newValue) {
              isTurnOn.value = newValue;
              settingsBox.put('adultContent', isTurnOn.value.toString());
            },
          )
        ]),
      ),
    );
  }
}
