import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/core/utils/pair.dart';
import 'package:meronpan/data/tmo/remote/data_sources/filters/tmo_filters.dart';


class SortByExpansionPanel extends HookConsumerWidget {
  final List<Pair> options;
  final String label;
  final Direction direction;
  final Function(int, bool) onTap;

  const SortByExpansionPanel({
    Key? key,
    required this.options,
    required this.label,
    required this.direction,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPanelExpanded = useState<bool>(false);

    return ExpansionPanelList(
      expansionCallback: (panelIndex, isExpanded) {
        isPanelExpanded.value = !isExpanded;
      },
      children: [
        ExpansionPanel(
          canTapOnHeader: true,
          isExpanded: isPanelExpanded.value,
          headerBuilder: (context, isExpanded) {
            return ListTile(
              title: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          },
          body: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: options.length,
            itemBuilder: (context, index) {
              return ListTile(
                trailing: buildIcon(direction, index),
                title: Text(options[index].key),
                onTap: () {
                  bool ascending = false;
                  if (direction.index == index && !direction.ascending) {
                    ascending = true;
                  }

                  onTap(index, ascending);
                },
              );
            },
          ),
        )
      ],
    );
  }

  Widget buildIcon(Direction direction, int index) {
    if (direction.index == index) {
      return direction.ascending
          ? const Icon(Icons.arrow_upward)
          : const Icon(Icons.arrow_downward);
    }
    return const Text('');
  }
}
