import 'package:meronpan/core/utils/models/filter.dart';
import 'package:meronpan/core/utils/pair.dart';

class Selection extends PairSelection {
  const Selection(
      {required String name, required List<Pair> values, required int state})
      : super(name: name, values: values, state: state);

  Selection changeValue({required int state}) {
    return Selection(name: name, values: values, state: state);
  }
}

class TypeSelection extends Selection {
  const TypeSelection({int state = 0})
      : super(
            name: 'Filtrar por tipo',
            values: const [
              Pair('Ver todo', ''),
              Pair('Manga', 'manga'),
              Pair('Manhua', 'manhua'),
              Pair('Manhwa', 'manhwa'),
              Pair('Novela', 'novel'),
              Pair('One shot', 'one_shot'),
              Pair('Doujinshi', 'doujinshi'),
              Pair('Oel', 'oel')
            ],
            state: state);
  TypeSelection copyWith({int? state}) {
    return TypeSelection(state: state ?? 0);
  }
}

class StatusSelection extends Selection {
  const StatusSelection({int state = 0})
      : super(
            name: 'Filtrar por estado de serie',
            values: const [
              Pair('Ver todo', ''),
              Pair('Publicándose', 'publishing'),
              Pair('Finalizado', 'ended'),
              Pair('Cancelado', 'cancelled'),
              Pair('Pausado', 'on_hold')
            ],
            state: state);
  StatusSelection copyWith({int? state}) {
    return StatusSelection(state: state ?? this.state);
  }
}

class TranslationStatusSelection extends Selection {
  const TranslationStatusSelection({int state = 0})
      : super(
            name: 'Filtrar por estado de traducción',
            values: const [
              Pair('Ver todo', ''),
              Pair('Activo', 'publishing'),
              Pair('Finalizado', 'ended'),
              Pair('Abandonado', 'cancelled')
            ],
            state: state);
  TranslationStatusSelection copyWith({int? state}) {
    return TranslationStatusSelection(state: state ?? this.state);
  }
}

class DemographySelection extends Selection {
  const DemographySelection({int state = 0})
      : super(
            name: 'Filtrar por demografía',
            values: const [
              Pair('Ver todo', ''),
              Pair('Seinen', 'seinen'),
              Pair('Shoujo', 'shoujo'),
              Pair('Shounen', 'shounen'),
              Pair('Josei', 'josei'),
              Pair('Kodomo', 'kodomo')
            ],
            state: state);
  DemographySelection copyWith({int? state}) {
    return DemographySelection(state: state ?? this.state);
  }
}

class FilterBySelection extends Selection {
  const FilterBySelection({int state = 0})
      : super(
            name: 'Filtrar por',
            values: const [
              Pair('Título', 'title'),
              Pair('Autor', 'author'),
              Pair('Compañia', 'company')
            ],
            state: state);
  FilterBySelection copyWith({int? state}) {
    return FilterBySelection(state: state ?? this.state);
  }
}
