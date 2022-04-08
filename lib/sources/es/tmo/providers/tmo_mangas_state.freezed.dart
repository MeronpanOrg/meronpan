// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tmo_mangas_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$TMOStateTearOff {
  const _$TMOStateTearOff();

  _TMOState call(
      {int page = 1,
      List<Manga>? mangas,
      bool isLoading = true,
      bool isLoadMoreError = false,
      bool isLoadMoreDone = false}) {
    return _TMOState(
      page: page,
      mangas: mangas,
      isLoading: isLoading,
      isLoadMoreError: isLoadMoreError,
      isLoadMoreDone: isLoadMoreDone,
    );
  }
}

/// @nodoc
const $TMOState = _$TMOStateTearOff();

/// @nodoc
mixin _$TMOState {
  int get page => throw _privateConstructorUsedError;
  List<Manga>? get mangas => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadMoreError => throw _privateConstructorUsedError;
  bool get isLoadMoreDone => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TMOStateCopyWith<TMOState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TMOStateCopyWith<$Res> {
  factory $TMOStateCopyWith(TMOState value, $Res Function(TMOState) then) =
      _$TMOStateCopyWithImpl<$Res>;
  $Res call(
      {int page,
      List<Manga>? mangas,
      bool isLoading,
      bool isLoadMoreError,
      bool isLoadMoreDone});
}

/// @nodoc
class _$TMOStateCopyWithImpl<$Res> implements $TMOStateCopyWith<$Res> {
  _$TMOStateCopyWithImpl(this._value, this._then);

  final TMOState _value;
  // ignore: unused_field
  final $Res Function(TMOState) _then;

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
              as List<Manga>?,
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
abstract class _$TMOStateCopyWith<$Res> implements $TMOStateCopyWith<$Res> {
  factory _$TMOStateCopyWith(_TMOState value, $Res Function(_TMOState) then) =
      __$TMOStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {int page,
      List<Manga>? mangas,
      bool isLoading,
      bool isLoadMoreError,
      bool isLoadMoreDone});
}

/// @nodoc
class __$TMOStateCopyWithImpl<$Res> extends _$TMOStateCopyWithImpl<$Res>
    implements _$TMOStateCopyWith<$Res> {
  __$TMOStateCopyWithImpl(_TMOState _value, $Res Function(_TMOState) _then)
      : super(_value, (v) => _then(v as _TMOState));

  @override
  _TMOState get _value => super._value as _TMOState;

  @override
  $Res call({
    Object? page = freezed,
    Object? mangas = freezed,
    Object? isLoading = freezed,
    Object? isLoadMoreError = freezed,
    Object? isLoadMoreDone = freezed,
  }) {
    return _then(_TMOState(
      page: page == freezed
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      mangas: mangas == freezed
          ? _value.mangas
          : mangas // ignore: cast_nullable_to_non_nullable
              as List<Manga>?,
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

class _$_TMOState extends _TMOState {
  const _$_TMOState(
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
  final List<Manga>? mangas;
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
  String toString() {
    return 'TMOState(page: $page, mangas: $mangas, isLoading: $isLoading, isLoadMoreError: $isLoadMoreError, isLoadMoreDone: $isLoadMoreDone)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TMOState &&
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
  _$TMOStateCopyWith<_TMOState> get copyWith =>
      __$TMOStateCopyWithImpl<_TMOState>(this, _$identity);
}

abstract class _TMOState extends TMOState {
  const factory _TMOState(
      {int page,
      List<Manga>? mangas,
      bool isLoading,
      bool isLoadMoreError,
      bool isLoadMoreDone}) = _$_TMOState;
  const _TMOState._() : super._();

  @override
  int get page;
  @override
  List<Manga>? get mangas;
  @override
  bool get isLoading;
  @override
  bool get isLoadMoreError;
  @override
  bool get isLoadMoreDone;
  @override
  @JsonKey(ignore: true)
  _$TMOStateCopyWith<_TMOState> get copyWith =>
      throw _privateConstructorUsedError;
}
