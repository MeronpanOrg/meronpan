import 'package:equatable/equatable.dart';

class Pair extends Equatable {
  final String key;
  final String value;

  const Pair(this.key, this.value);

  @override
  String toString() {
    return key;
  }

  @override
  List<Object?> get props => [key, value];
}
