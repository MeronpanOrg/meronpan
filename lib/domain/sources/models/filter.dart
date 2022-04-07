import 'package:equatable/equatable.dart';
import 'package:meronpan/domain/sources/utils/pair.dart';

enum triState { stateIgnore, stateInclude, stateExclude }

abstract class Filter<T> extends Equatable {
  final String name;
  final T state;

  const Filter({required this.name, required this.state});

  @override
  List<Object?> get props => [name, state];
}

abstract class FilterTriState extends Filter<triState> {
  const FilterTriState({required String name, required triState state})
      : super(name: name, state: state);
}

abstract class FilterGroup<V> extends Filter<List<V>> {
  const FilterGroup({required String name, required List<V> state})
      : super(name: name, state: state);
}

abstract class FilterSelection<V> extends Filter<int> {
  final List<V> values;

  const FilterSelection(
      {required String name, required this.values, required int state})
      : super(name: name, state: state);
}

abstract class PairSelection extends FilterSelection<Pair> {
  const PairSelection(
      {required String name, required List<Pair> values, required int state})
      : super(name: name, values: values, state: state);

  String toUriPart() {
    return values[state].value;
  }

  String get getName => values[state].key;

  Pair get getPair => values[state];

  List<String> getKeys() {
    return values.map((e) => e.key).toList();
  }

  List<String> getValues() {
    return values.map((e) => e.value).toList();
  }
}

abstract class FilterSort<T, V> extends Filter<T?> {
  final List<V> values;
  const FilterSort(
      {required String name, required this.values, required T? state})
      : super(name: name, state: state);
}
