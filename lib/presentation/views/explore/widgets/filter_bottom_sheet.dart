import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/data/tmo/remote/data_sources/tmo_filter_provider.dart';
import 'package:meronpan/presentation/views/explore/widgets/sort_by_expansion_panel.dart';
import 'package:meronpan/presentation/views/explore/widgets/widgets.dart';

class FilterDraggableScrollableSheet extends ConsumerWidget {
  const FilterDraggableScrollableSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final typeSelection = ref.watch(tmoFilterProvider).typeSelection;
    final statusSelection = ref.watch(tmoFilterProvider).statusSelection;
    final translationStatusSelection =
        ref.watch(tmoFilterProvider).translationStatusSelection;
    final demographySelection =
        ref.watch(tmoFilterProvider).demographySelection;
    final filterBySelection = ref.watch(tmoFilterProvider).filterBySelection;
    final sort = ref.watch(tmoFilterProvider).sort;
    final contentTypeList = ref.watch(tmoFilterProvider).contentTypeList;
    final genreList = ref.watch(tmoFilterProvider).genreList;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      minChildSize: 0.4,
      builder: (context, scrollController) {
        return Stack(
          children: [
            ListView(
              controller: scrollController,
              children: [
                FilterBySelectionField(
                  label: typeSelection.name,
                  items: typeSelection.values,
                  onChanged: (index) {
                    ref
                        .read(tmoFilterProvider.notifier)
                        .changeTypeSelectionState(index);
                  },
                  value: typeSelection.getPair,
                ),
                const Divider(),
                FilterBySelectionField(
                  title: 'Ignorado sino se filtra por tipo',
                  label: statusSelection.name,
                  items: statusSelection.values,
                  onChanged: (index) {
                    ref
                        .read(tmoFilterProvider.notifier)
                        .changeStatusSelectionState(index);
                  },
                  value: statusSelection.getPair,
                ),
                const Divider(),
                FilterBySelectionField(
                  title: 'Ignorado sino se filtra por tipo',
                  label: translationStatusSelection.name,
                  items: translationStatusSelection.values,
                  onChanged: (index) {
                    ref
                        .read(tmoFilterProvider.notifier)
                        .changeTranslationStatusSelectionState(index);
                  },
                  value: translationStatusSelection.getPair,
                ),
                const Divider(),
                FilterBySelectionField(
                  label: demographySelection.name,
                  items: demographySelection.values,
                  onChanged: (index) {
                    ref
                        .read(tmoFilterProvider.notifier)
                        .changeDemographySelectionState(index);
                  },
                  value: demographySelection.getPair,
                ),
                const Divider(),
                FilterBySelectionField(
                  label: filterBySelection.name,
                  items: filterBySelection.values,
                  onChanged: (index) {
                    ref
                        .read(tmoFilterProvider.notifier)
                        .changeFilterBySelectionState(index);
                  },
                  value: filterBySelection.getPair,
                ),
                SortByExpansionPanel(
                  label: sort.name,
                  options: sort.values,
                  direction: sort.state!,
                  onTap: (index, ascending) {
                    print(index);
                    print(ascending);
                    ref
                        .read(tmoFilterProvider.notifier)
                        .changeSortState(index, ascending);
                  },
                ),
                FilterExpansionPanel(
                  label: contentTypeList.name,
                  options: contentTypeList.content,
                  onTap: (index, check) {
                    ref
                        .read(tmoFilterProvider.notifier)
                        .changeContentTypeListState(index, check);
                  },
                ),
                FilterExpansionPanel(
                  label: genreList.name,
                  options: genreList.genres,
                  onTap: (index, check) {
                    ref
                        .read(tmoFilterProvider.notifier)
                        .changeGenreListState(index, check);
                  },
                )
              ],
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomSheetTopBar(),
            ),
          ],
        );
      },
    );
  }
}
