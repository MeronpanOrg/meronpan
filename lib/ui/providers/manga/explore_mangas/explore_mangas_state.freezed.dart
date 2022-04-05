// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'explore_mangas_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ExploreMangasStateTearOff {
  const _$ExploreMangasStateTearOff();

  _ExploreMangasState call(
      {int page = 1,
      List<MangaCard>? mangas,
      bool isLoading = true,
      bool isLoadMoreError = false,
      bool isLoadMoreDone = false}) {
    return _ExploreMangasState(
      page: page,
      mangas: mangas,
      isLoading: isLoading,
      isLoadMoreError: isLoadMoreError,
      isLoadMoreDone: isLoadMoreDone,
    );
  }
}

/// @nodoc
const $ExploreMangasState = _$ExploreMangasStateTearOff();

/// @nodoc
mixin _$ExploreMangasState {
  int get page => throw _privateConstructorUsedError;
  List<MangaCard>? get mangas => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadMoreError => throw _privateConstructorUsedError;
  bool get isLoadMoreDone => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ExploreMangasStateCopyWith<ExploreMangasState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExploreMangasStateCopyWith<$Res> {
  factory $ExploreMangasStateCopyWith(
          ExploreMangasState value, $Res Function(ExploreMangasState) then) =
      _$ExploreMangasStateCopyWithImpl<$Res>;
  $Res call(
      {int page,
      List<MangaCard>? mangas,
      bool isLoading,
      bool isLoadMoreError,
      bool isLoadMoreDone});
}

/// @nodoc
class _$ExploreMangasStateCopyWithImpl<$Res>
    implements $ExploreMangasStateCopyWith<$Res> {
  _$ExploreMangasStateCopyWithImpl(this._value, this._then);

  final ExploreMangasState _value;
  // ignore: unused_field
  final $Res Function(ExploreMangasState) _then;

  @override
  $Res call({
    Object? page = freezed,
    Object? mangas = freezed,
    Object? isLoading = freezed,
    Object? isLoadMoreError = freezed,
    Object? isLoadMoreDone = freezed,
  }) {
    return _then(_value.copyWith(
      page: page == freezed
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      mangas: mangas == freezed
          ? _value.mangas
          : mangas // ignore: cast_nullable_to_non_nullable
              as List<MangaCard>?,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadMoreError: isLoadMoreError == freezed
          ? _value.isLoadMoreError
          : isLoadMoreError // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadMoreDone: isLoadMoreDone == freezed
          ? _value.isLoadMoreDone
          : isLoadMoreDone // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$ExploreMangasStateCopyWith<$Res>
    implements $ExploreMangasStateCopyWith<$Res> {
  factory _$ExploreMangasStateCopyWith(
          _ExploreMangasState value, $Res Function(_ExploreMangasState) then) =
      __$ExploreMangasStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {int page,
      List<MangaCard>? mangas,
      bool isLoading,
      bool isLoadMoreError,
      bool isLoadMoreDone});
}

/// @nodoc
class __$ExploreMangasStateCopyWithImpl<$Res>
    extends _$ExploreMangasStateCopyWithImpl<$Res>
    implements _$ExploreMangasStateCopyWith<$Res> {
  __$ExploreMangasStateCopyWithImpl(
      _ExploreMangasState _value, $Res Function(_ExploreMangasState) _then)
      : super(_value, (v) => _then(v as _ExploreMangasState));

  @override
  _ExploreMangasState get _value => super._value as _ExploreMangasState;

  @override
  $Res call({
    Object? page = freezed,
    Object? mangas = freezed,
    Object? isLoading = freezed,
    Object? isLoadMoreError = freezed,
    Object? isLoadMoreDone = freezed,
  }) {
    return _then(_ExploreMangasState(
      page: page == freezed
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      mangas: mangas == freezed
          ? _value.mangas
          : mangas // ignore: cast_nullable_to_non_nullable
              as List<MangaCard>?,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadMoreError: isLoadMoreError == freezed
          ? _value.isLoadMoreError
          : isLoadMoreError // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadMoreDone: isLoadMoreDone == freezed
          ? _value.isLoadMoreDone
          : isLoadMoreDone // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ExploreMangasState extends _ExploreMangasState
    with DiagnosticableTreeMixin {
  const _$_ExploreMangasState(
      {this.page = 1,
      this.mangas,
      this.isLoading = true,
      this.isLoadMoreError = false,
      this.isLoadMoreDone = false})
      : super._();

  @JsonKey()
  @override
  final int page;
  @override
  final List<MangaCard>? mangas;
  @JsonKey()
  @override
  final bool isLoading;
  @JsonKey()
  @override
  final bool isLoadMoreError;
  @JsonKey()
  @override
  final bool isLoadMoreDone;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ExploreMangasState(page: $page, mangas: $mangas, isLoading: $isLoading, isLoadMoreError: $isLoadMoreError, isLoadMoreDone: $isLoadMoreDone)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ExploreMangasState'))
      ..add(DiagnosticsProperty('page', page))
      ..add(DiagnosticsProperty('mangas', mangas))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('isLoadMoreError', isLoadMoreError))
      ..add(DiagnosticsProperty('isLoadMoreDone', isLoadMoreDone));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExploreMangasState &&
            const DeepCollectionEquality().equals(other.page, page) &&
            const DeepCollectionEquality().equals(other.mangas, mangas) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality()
                .equals(other.isLoadMoreError, isLoadMoreError) &&
            const DeepCollectionEquality()
                .equals(other.isLoadMoreDone, isLoadMoreDone));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(page),
      const DeepCollectionEquality().hash(mangas),
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(isLoadMoreError),
      const DeepCollectionEquality().hash(isLoadMoreDone));

  @JsonKey(ignore: true)
  @override
  _$ExploreMangasStateCopyWith<_ExploreMangasState> get copyWith =>
      __$ExploreMangasStateCopyWithImpl<_ExploreMangasState>(this, _$identity);
}

abstract class _ExploreMangasState extends ExploreMangasState {
  const factory _ExploreMangasState(
      {int page,
      List<MangaCard>? mangas,
      bool isLoading,
      bool isLoadMoreError,
      bool isLoadMoreDone}) = _$_ExploreMangasState;
  const _ExploreMangasState._() : super._();

  @override
  int get page;
  @override
  List<MangaCard>? get mangas;
  @override
  bool get isLoading;
  @override
  bool get isLoadMoreError;
  @override
  bool get isLoadMoreDone;
  @override
  @JsonKey(ignore: true)
  _$ExploreMangasStateCopyWith<_ExploreMangasState> get copyWith =>
      throw _privateConstructorUsedError;
}
