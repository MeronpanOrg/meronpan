import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/domain/models/filter.dart';

class FilterExpansionPanel extends HookConsumerWidget {
  final String label;
  final List<FilterTriState> options;
  final Function(int, bool?) onTap;

  const FilterExpansionPanel(
      {Key? key,
      required this.label,
      required this.options,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPanelExpanded = useState<bool>(false);

    return ExpansionPanelList(
      expansionCallback: (panelIndex, isExpanded) {
        isPanelExpanded.value = !isExpanded;
      },
      children: [
        ExpansionPanel(
          isExpanded: isPanelExpanded.value,
          canTapOnHeader: true,
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
                leading: Checkbox(
                  tristate: true,
                  onChanged: (bool? newValue) {
                    onTap(index, newValue);
                  },
                  value: getValue(options[index].state),
                ),
                title: Text(options[index].name),
              );
            },
          ),
        )
      ],
    );
  }

  bool? getValue(triState state) {
    switch (state) {
      case triState.stateExclude:
        return null;
      case triState.stateInclude:
        return true;
      case triState.stateIgnore:
        return false;
    }
  }
}
