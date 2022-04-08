import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meronpan/sources/es/tmo/providers/filter/tmo_filter_provider.dart';
import 'package:meronpan/sources/es/tmo/views/explore/widgets/sort_by_expansion_panel.dart';
import 'package:meronpan/sources/es/tmo/views/explore/widgets/widgets.dart';

class FilterDraggableScrollableSheet extends ConsumerWidget {
  const FilterDraggableScrollableSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final typeSelection = ref.watch(tmoRequestProvider).typeSelection;
    final statusSelection = ref.watch(tmoRequestProvider).statusSelection;
    final translationStatusSelection =
        ref.watch(tmoRequestProvider).translationStatusSelection;
    final demographySelection =
        ref.watch(tmoRequestProvider).demographySelection;
    final filterBySelection = ref.watch(tmoRequestProvider).filterBySelection;
    final sort = ref.watch(tmoRequestProvider).sort;
    final contentTypeList = ref.watch(tmoRequestProvider).contentTypeList;
    final genreList = ref.watch(tmoRequestProvider).genreList;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      minChildSize: 0.4,
      builder: (context, scrollController) {
        return ListView(
          controller: scrollController,
          children: [
            const BottomSheetTopBar(),
            FilterBySelectionField(
              label: typeSelection.name,
              items: typeSelection.values,
              onChanged: (index) {
                ref
                    .read(tmoRequestProvider.notifier)
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
                    .read(tmoRequestProvider.notifier)
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
                    .read(tmoRequestProvider.notifier)
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
                    .read(tmoRequestProvider.notifier)
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
                    .read(tmoRequestProvider.notifier)
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
                    .read(tmoRequestProvider.notifier)
                    .changeSortState(index, ascending);
              },
            ),
            FilterExpansionPanel(
              label: contentTypeList.name,
              options: contentTypeList.content,
              onTap: (index, check) {
                ref
                    .read(tmoRequestProvider.notifier)
                    .changeContentTypeListState(index, check);
              },
            ),
            FilterExpansionPanel(
              label: genreList.name,
              options: genreList.genres,
              onTap: (index, check) {
                ref
                    .read(tmoRequestProvider.notifier)
                    .changeGenreListState(index, check);
              },
            )
          ],
        );
      },
    );
  }
}
