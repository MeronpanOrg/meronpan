import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show useState;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/domain/sources/utils/pair.dart';

class CheckBoxListTile extends HookConsumerWidget {
  final Pair value;

  const CheckBoxListTile({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = useState<bool?>(null);
    return ListTile(
      leading: Checkbox(
        tristate: true,
        onChanged: (bool? newValue) {
          isSelected.value = newValue;
        },
        value: isSelected.value,
      ),
      title: Text('$value'),
    );
  }
}
