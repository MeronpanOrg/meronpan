import 'package:freezed_annotation/freezed_annotation.dart';

part 'explore_provider_state.freezed.dart';

@freezed
class ExplorePaginatonState<T> with _$ExploreState<T> {
  const ExplorePaginatonState._();

  const factory ExplorePaginatonState.init() = _init;
  const factory ExplorePaginatonState.loading() = _loading;
  const factory ExplorePaginatonState.loadingMore() = _loadingMore;
  const factory ExplorePaginatonState.success( T data) = _success;
  const factory ExplorePaginatonState.error(final String exception) = _error;

  bool get isInit => maybeWhen(init: () => true, orElse: () => false);

  bool get isLoading =>  maybeWhen(loading: () => true, orElse: () => false);

  bool get isLoadingMore =>  maybeWhen(loading: () => true, orElse: () => false);

  bool get isSuccess => maybeMap(success: (_) => true, orElse: () => false);

  bool get isError => maybeWhen(error: (_) => true, orElse: () => false);

  T? get data => maybeWhen(success: (data) => data, orElse: () => null);
}