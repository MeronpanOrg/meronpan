import 'package:freezed_annotation/freezed_annotation.dart';

part 'explore_provider_state.freezed.dart';

@freezed
class ExploreState<T> with _$ExploreState<T> {
  const ExploreState._();

  const factory ExploreState.init() = _init<T>;
  const factory ExploreState.loading() = _loading;
  const factory ExploreState.success(final T data) = _success<T>;
  const factory ExploreState.error(final String exception) = _error;

  bool get isInit => maybeWhen(init: () => true, orElse: () => false);

  bool get isLoading =>  maybeWhen(loading: () => true, orElse: () => false);

  bool get isSuccess => maybeMap(success: (_) => true, orElse: () => false);

  bool get isError => maybeWhen(error: (_) => true, orElse: () => false);

  T? get data => maybeWhen(success: (data) => data, orElse: () => null);
}