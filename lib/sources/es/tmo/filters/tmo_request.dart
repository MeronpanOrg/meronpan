import 'package:meronpan/sources/es/tmo/filters/tmo_filters.dart';

class TMORequest {
  final TypeSelection typeSelection;
  final StatusSelection statusSelection;
  final TranslationStatusSelection translationStatusSelection;
  final DemographySelection demographySelection;
  final FilterBySelection filterBySelection;
  final Sort sort;
  final ContentTypeList contentTypeList;
  final GenreList genreList;

  const TMORequest({
    required this.typeSelection,
    required this.statusSelection,
    required this.translationStatusSelection,
    required this.demographySelection,
    required this.filterBySelection,
    required this.sort,
    required this.contentTypeList,
    required this.genreList,
  });

  factory TMORequest.init() {
    return TMORequest(
      typeSelection: const TypeSelection(),
      statusSelection: const StatusSelection(),
      translationStatusSelection: const TranslationStatusSelection(),
      demographySelection: const DemographySelection(),
      filterBySelection: const FilterBySelection(),
      sort: Sort(
        values: sortables,
        state: Direction(index: 0),
      ),
      contentTypeList: ContentTypeList(content: content),
      genreList: GenreList(genres: genres),
    );
  }

  TMORequest copyWith(
      {TypeSelection? typeSelection,
      StatusSelection? statusSelection,
      TranslationStatusSelection? translationStatusSelection,
      DemographySelection? demographySelection,
      FilterBySelection? filterBySelection,
      Sort? sort,
      ContentTypeList? contentTypeList,
      GenreList? genreList}) {
    return TMORequest(
      typeSelection: typeSelection ?? this.typeSelection,
      statusSelection: statusSelection ?? this.statusSelection,
      translationStatusSelection:
          translationStatusSelection ?? this.translationStatusSelection,
      demographySelection: demographySelection ?? this.demographySelection,
      filterBySelection: filterBySelection ?? this.filterBySelection,
      sort: sort ?? this.sort,
      contentTypeList: contentTypeList ?? this.contentTypeList,
      genreList: genreList ?? this.genreList,
    );
  }
}

